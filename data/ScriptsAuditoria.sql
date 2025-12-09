--Auditoria
CREATE TABLE Audit_Project (
    audit_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_id     NUMBER(8),
    usuario        VARCHAR2(50),
    tipo_operacion VARCHAR2(10),
    fecha_evento   DATE,
    dato_anterior  VARCHAR2(4000),
    dato_nuevo     VARCHAR2(4000)
);

CREATE OR REPLACE TRIGGER trg_audit_project
AFTER INSERT OR UPDATE OR DELETE ON Project
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO Audit_Project 
        (project_id, usuario, tipo_operacion, fecha_evento, dato_nuevo)
        VALUES 
        (:NEW.project_id, USER, 'INSERT', SYSDATE, :NEW.name_p);

    ELSIF UPDATING THEN
        INSERT INTO Audit_Project 
        (project_id, usuario, tipo_operacion, fecha_evento, dato_anterior, dato_nuevo)
        VALUES 
        (:OLD.project_id, USER, 'UPDATE', SYSDATE, :OLD.name_p, :NEW.name_p);

    ELSIF DELETING THEN
        INSERT INTO Audit_Project 
        (project_id, usuario, tipo_operacion, fecha_evento, dato_anterior)
        VALUES 
        (:OLD.project_id, USER, 'DELETE', SYSDATE, :OLD.name_p);
    END IF;
END;
/

CREATE TABLE Audit_Funding (
    audit_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    funding_id     NUMBER(8),
    usuario        VARCHAR2(50),
    tipo_operacion VARCHAR2(10),
    fecha_evento   DATE,
    monto_anterior NUMBER(12,2),
    monto_nuevo    NUMBER(12,2)
);


CREATE OR REPLACE TRIGGER trg_audit_funding
AFTER INSERT OR UPDATE OR DELETE ON Funding
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO Audit_Funding
        (funding_id, usuario, tipo_operacion, fecha_evento, monto_nuevo)
        VALUES
        (:NEW.funding_id, USER, 'INSERT', SYSDATE, :NEW.total_amount);

    ELSIF UPDATING THEN
        INSERT INTO Audit_Funding
        (funding_id, usuario, tipo_operacion, fecha_evento, monto_anterior, monto_nuevo)
        VALUES
        (:OLD.funding_id, USER, 'UPDATE', SYSDATE, 
         :OLD.total_amount, :NEW.total_amount);

    ELSIF DELETING THEN
        INSERT INTO Audit_Funding
        (funding_id, usuario, tipo_operacion, fecha_evento, monto_anterior)
        VALUES
        (:OLD.funding_id, USER, 'DELETE', SYSDATE, :OLD.total_amount);
    END IF;
END;
/

CREATE TABLE Audit_Beneficiary (
    audit_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    beneficiary_id NUMBER(8),
    usuario         VARCHAR2(50),
    tipo_operacion  VARCHAR2(10),
    fecha_evento    DATE,
    nombre_ant      VARCHAR2(50),
    nombre_nuevo    VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER trg_audit_beneficiary
AFTER INSERT OR UPDATE OR DELETE ON Beneficiary
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO Audit_Beneficiary
        (beneficiary_id, usuario, tipo_operacion, fecha_evento, nombre_nuevo)
        VALUES
        (:NEW.beneficiary_id, USER, 'INSERT', SYSDATE, :NEW.first_name_b);

    ELSIF UPDATING THEN
        INSERT INTO Audit_Beneficiary
        (beneficiary_id, usuario, tipo_operacion, fecha_evento, nombre_ant, nombre_nuevo)
        VALUES
        (:OLD.beneficiary_id, USER, 'UPDATE', SYSDATE,
         :OLD.first_name_b, :NEW.first_name_b);

    ELSIF DELETING THEN
        INSERT INTO Audit_Beneficiary
        (beneficiary_id, usuario, tipo_operacion, fecha_evento, nombre_ant)
        VALUES
        (:OLD.beneficiary_id, USER, 'DELETE', SYSDATE, :OLD.first_name_b);
    END IF;
END;
/

SELECT * FROM Audit_Project ORDER BY fecha_evento DESC;
SELECT * FROM Audit_Funding ORDER BY fecha_evento DESC;
SELECT * FROM Audit_Beneficiary ORDER BY fecha_evento DESC;





