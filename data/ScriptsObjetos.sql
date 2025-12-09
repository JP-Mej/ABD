CREATE OR REPLACE FUNCTION FN_DNI_EXISTE(p_dni CHAR)
RETURN NUMBER IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Beneficiary
    WHERE dni_b = p_dni;

    RETURN v_count;
END;
/
CREATE OR REPLACE FUNCTION FN_TOTAL_FUNDING_OK(p_funding_id NUMBER)
RETURN NUMBER IS
    v_total_aportes NUMBER;
    v_total_funding NUMBER;
BEGIN
    SELECT SUM(contribution_amount)
    INTO v_total_aportes
    FROM Funding_Partner
    WHERE funding_id = p_funding_id;

    SELECT total_amount
    INTO v_total_funding
    FROM Funding
    WHERE funding_id = p_funding_id;

    IF v_total_aportes = v_total_funding THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;
/
CREATE OR REPLACE FUNCTION FN_PROMEDIO_SALARIO_EMPLEADOS
RETURN NUMBER
IS
    v_promedio NUMBER;
BEGIN
    SELECT AVG(salary)
    INTO v_promedio
    FROM Employee;

    RETURN NVL(v_promedio, 0);
END;
/
CREATE OR REPLACE FUNCTION FN_PROMEDIO_SALARIO_EMPLEADOS
RETURN NUMBER
IS
    v_promedio NUMBER;
BEGIN
    SELECT AVG(salary)
    INTO v_promedio
    FROM Employee;

    RETURN NVL(v_promedio, 0);
END;
/
CREATE OR REPLACE FUNCTION FN_TOTAL_BENEFICIARIOS_PROYECTO(p_project_id NUMBER)
RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM Project_Beneficiary
    WHERE project_id = p_project_id;

    RETURN v_total;
END;
/
CREATE OR REPLACE FUNCTION FN_PORCENTAJE_FINANCIAMIENTO_PARTNER(
    p_funding_id NUMBER,
    p_partner_id NUMBER
) RETURN NUMBER
IS
    v_porcentaje NUMBER;
BEGIN
    SELECT contribution_porcentage
    INTO v_porcentaje
    FROM Funding_Partner
    WHERE funding_id = p_funding_id
      AND partner_id = p_partner_id;

    RETURN v_porcentaje;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/


CREATE OR REPLACE PROCEDURE PR_REGISTRAR_BENEFICIARIO(
    p_id NUMBER, p_dni CHAR, p_inst NUMBER, p_gen CHAR,
    p_nom VARCHAR2, p_ape VARCHAR2, p_nac DATE,
    p_ocu VARCHAR2, p_tel CHAR, p_mail VARCHAR2
) IS
BEGIN
    INSERT INTO Beneficiary VALUES (
        p_id, p_dni, p_inst, p_gen,
        p_nom, p_ape, p_nac, p_ocu,
        p_tel, p_mail
    );
END;
/
CREATE OR REPLACE PROCEDURE PR_REGISTRAR_PROYECTO(
    p_id NUMBER, p_act NUMBER, p_fund NUMBER, p_ind NUMBER, p_loc NUMBER,
    p_nom VARCHAR2, p_desc VARCHAR2, p_pres NUMBER, p_area VARCHAR2,
    p_ini DATE, p_fin DATE, p_estado VARCHAR2
) IS
BEGIN
    INSERT INTO Project VALUES (
        p_id, p_act, p_fund, p_ind, p_loc,
        p_nom, p_desc, p_pres, p_area,
        p_ini, p_fin, p_estado
    );
END;
/
CREATE OR REPLACE PROCEDURE PR_ASIGNAR_VOLUNTARIO(
    p_act NUMBER, p_vol NUMBER, p_fecha DATE, p_fin DATE,
    p_horas NUMBER, p_rol VARCHAR2
) IS
BEGIN
    INSERT INTO Volunteer_Activity VALUES (
        p_act, p_vol, p_fecha, p_fin, p_horas, p_rol
    );
END;
/
CREATE OR REPLACE PROCEDURE PR_TOP_5_PROYECTOS_PRESUPUESTO AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('ID | NOMBRE | PRESUPUESTO | ESTADO');
    FOR rec IN (
        SELECT project_id, name_p, budget_amount, status
        FROM Project
        ORDER BY budget_amount DESC
        FETCH FIRST 5 ROWS ONLY
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.project_id || ' | ' ||
                             rec.name_p || ' | ' ||
                             rec.budget_amount || ' | ' ||
                             rec.status);
    END LOOP;
END;
/
CREATE OR REPLACE PROCEDURE PR_VOLUNTARIOS_ACTIVOS AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('ID | NOMBRE | ACTIVIDADES | ESTADO');
    FOR rec IN (
        SELECT v.volunteer_id,
               v.first_name_v || ' ' || v.last_name_v AS nombre,
               COUNT(va.activity_id) AS actividades,
               v.employment_status
        FROM Volunteer v
        LEFT JOIN Volunteer_Activity va ON v.volunteer_id = va.volunteer_id
        WHERE v.employment_status = 'Active'
        GROUP BY v.volunteer_id, v.first_name_v, v.last_name_v, v.employment_status
        ORDER BY actividades DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.volunteer_id || ' | ' ||
                             rec.nombre || ' | ' ||
                             rec.actividades || ' | ' ||
                             rec.employment_status);
    END LOOP;
END;
/
CREATE OR REPLACE PROCEDURE PR_CERTIFICADOS_VENCIDOS AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('ID CERT | BENEFICIARIO | RECURSO | FECHA VENCIMIENTO');
    FOR rec IN (
        SELECT c.cert_id,
               b.first_name_b || ' ' || b.last_name_b AS beneficiario,
               r.title AS recurso,
               c.expiry_date
        FROM Certification c
        JOIN Beneficiary b ON c.beneficiary_id = b.beneficiary_id
        JOIN Resources r ON c.resource_id = r.resource_id
        WHERE c.expiry_date < SYSDATE
        ORDER BY c.expiry_date DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.cert_id || ' | ' ||
                             rec.beneficiario || ' | ' ||
                             rec.recurso || ' | ' ||
                             TO_CHAR(rec.expiry_date, 'DD/MM/YYYY'));
    END LOOP;
END;
/



CREATE OR REPLACE TRIGGER TR_PROJECT_BUDGET
BEFORE INSERT OR UPDATE ON Project
FOR EACH ROW
BEGIN
    IF :NEW.status = 'Ongoing' AND :NEW.budget_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Proyecto activo requiere presupuesto mayor a cero');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_PROJECT_FECHAS
BEFORE INSERT OR UPDATE ON Project
FOR EACH ROW
BEGIN
    IF :NEW.start_date_p > :NEW.end_date_p THEN
        RAISE_APPLICATION_ERROR(-20002, 'Fecha inicio no puede ser mayor a fecha fin');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_PROJECT_FINANCIAMIENTO
AFTER INSERT ON Project
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Funding
    WHERE funding_id = :NEW.funding_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Proyecto sin financiamiento registrado');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_DNI_UNICO
BEFORE INSERT ON Beneficiary
FOR EACH ROW
BEGIN
    IF FN_DNI_EXISTE(:NEW.dni_b) > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'DNI ya registrado');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_NO_DOBLE_INSCRIPCION
BEFORE INSERT ON Project_Beneficiary
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Project_Beneficiary
    WHERE project_id = :NEW.project_id
      AND beneficiary_id = :NEW.beneficiary_id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Beneficiario ya inscrito en este proyecto');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_MAX_HORAS_VOLUNTARIO
BEFORE INSERT OR UPDATE ON Volunteer_Activity
FOR EACH ROW
BEGIN
    IF :NEW.hours_committed > 40 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Voluntario no puede superar 40 horas semanales');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_EMPLEADO_VIGENTE
BEFORE INSERT ON Employee_Activity
FOR EACH ROW
DECLARE
    v_end_date DATE;
BEGIN
    SELECT end_date_e INTO v_end_date
    FROM Employee
    WHERE employee_id = :NEW.employee_id;

    IF v_end_date IS NOT NULL AND v_end_date < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20007, 'Empleado con contrato vencido');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_CONTRATO_OBLIGATORIO
BEFORE INSERT ON Funding_Partner
FOR EACH ROW
BEGIN
    IF :NEW.contract_reference IS NULL THEN
        RAISE_APPLICATION_ERROR(-20008, 'Contrato obligatorio');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_TOTAL_FUNDING
AFTER INSERT OR UPDATE ON Funding_Partner
FOR EACH ROW
BEGIN
    IF FN_TOTAL_FUNDING_OK(:NEW.funding_id) = 0 THEN
        RAISE_APPLICATION_ERROR(-20009, 'Total de aportes no coincide con Funding');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_GASTO_NO_SUPERA_PRESUPUESTO
BEFORE INSERT ON Resource_Project
FOR EACH ROW
DECLARE
    v_presupuesto NUMBER;
    v_total_gasto NUMBER;
BEGIN
    SELECT budget_amount INTO v_presupuesto
    FROM Project WHERE project_id = :NEW.project_id;

    SELECT NVL(SUM(usage_type),0)
    INTO v_total_gasto
    FROM Resource_Project
    WHERE project_id = :NEW.project_id;

    IF v_total_gasto > v_presupuesto THEN
        RAISE_APPLICATION_ERROR(-20010, 'Gasto excede presupuesto');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_VALIDAR_EDAD_EMPLOYEE
BEFORE INSERT OR UPDATE OF birth_date_e ON Employee
FOR EACH ROW
DECLARE
    v_edad NUMBER;
BEGIN
    v_edad := FLOOR(MONTHS_BETWEEN(SYSDATE, :NEW.birth_date_e) / 12);

    IF v_edad < 18 THEN
        RAISE_APPLICATION_ERROR(-20011, 'El empleado debe tener al menos 18 años.');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_VALIDAR_FECHA_NAC_BENEFICIARIO
BEFORE INSERT OR UPDATE OF birth_date_b ON Beneficiary
FOR EACH ROW
BEGIN
    IF :NEW.birth_date_b > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20012, 'Fecha de nacimiento futura no permitida.');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TR_VALIDAR_FECHA_PUBLICACION_RECURSO
BEFORE INSERT OR UPDATE OF publish_date ON Resources
FOR EACH ROW
BEGIN
    IF :NEW.publish_date > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20013, 'Fecha de publicación futura no permitida.');
    END IF;
END;
/









