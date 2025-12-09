--CONTROL CONCURRENCIA
CREATE OR REPLACE PROCEDURE prc_bloquear_proyecto_edicion(
    p_project_id IN NUMBER,
    p_nuevo_presupuesto IN NUMBER
) AS
    v_id NUMBER;
BEGIN
    -- Bloquea el proyecto (si otro usuario lo tiene, falla)
    SELECT project_id
    INTO v_id
    FROM Project
    WHERE project_id = p_project_id
    FOR UPDATE NOWAIT;

    -- Si logra bloquear, actualiza
    UPDATE Project
    SET budget_amount = p_nuevo_presupuesto
    WHERE project_id = p_project_id;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20040, 'El proyecto está siendo editado por otro usuario');
END;
/

CREATE OR REPLACE PROCEDURE prc_control_beneficiario_espera(
    p_beneficiary_id IN NUMBER,
    p_nuevo_telefono IN CHAR
) AS
    v_id NUMBER;
BEGIN
    -- Espera hasta 10 segundos a que el registro quede libre
    SELECT beneficiary_id
    INTO v_id
    FROM Beneficiary
    WHERE beneficiary_id = p_beneficiary_id
    FOR UPDATE WAIT 10;

    -- Si logra bloquear, entonces actualiza
    UPDATE Beneficiary
    SET phone_b = p_nuevo_telefono
    WHERE beneficiary_id = p_beneficiary_id;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20051, 'El beneficiario está siendo usado por otro proceso');
END;
/

CREATE OR REPLACE PROCEDURE prc_asignar_recurso_sin_conflictos(
    p_project_id IN NUMBER,
    p_usage_type IN VARCHAR2
) AS
    v_resource_id NUMBER;
BEGIN
    -- Selecciona SOLO recursos libres
    SELECT resource_id
    INTO v_resource_id
    FROM Resources
    WHERE ROWNUM = 1
    FOR UPDATE SKIP LOCKED;

    -- Asignación segura
    INSERT INTO Resource_Project(project_id, resource_id, use_date, usage_type)
    VALUES (p_project_id, v_resource_id, SYSDATE, p_usage_type);

    COMMIT;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20052, 'No hay recursos disponibles');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

