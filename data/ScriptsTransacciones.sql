--TRANSACCIONES

CREATE OR REPLACE PROCEDURE prc_registrar_proyecto_completo(
    p_project_id      IN NUMBER,
    p_name_p          IN VARCHAR2,
    p_budget          IN NUMBER,
    p_activity_id     IN NUMBER,
    p_funding_id      IN NUMBER,
    p_funding_type    IN VARCHAR2,
    p_total_amount    IN NUMBER,
    p_currency        IN VARCHAR2,
    p_partner_id      IN NUMBER,
    p_porcentaje      IN NUMBER
) AS
BEGIN
    -- 1. Registrar financiamiento
    INSERT INTO Funding(funding_id, funding_type, total_amount, final_currency, funding_date)
    VALUES (p_funding_id, p_funding_type, p_total_amount, p_currency, SYSDATE);

    -- 2. Registrar proyecto
    INSERT INTO Project(
        project_id, activity_id, funding_id, indicator_id, location_id,
        name_p, description_p, budget_amount, strategic_area,
        start_date_p, end_date_p, status
    )
    VALUES (
        p_project_id, p_activity_id, p_funding_id, 8000001, 10000001,
        p_name_p, 'Proyecto registrado por transacción',
        p_budget, 'Educación',
        SYSDATE, ADD_MONTHS(SYSDATE, 6), 'Planned'
    );

    -- 3. Registrar aporte del partner
    INSERT INTO Funding_Partner(
        funding_id, partner_id, contribution_role,
        contribution_porcentage, contribution_amount, currency,
        contribution_date, contract_reference
    )
    VALUES (
        p_funding_id, p_partner_id, 'Co-Funder',
        p_porcentaje,
        p_total_amount * (p_porcentaje / 100),
        p_currency,
        SYSDATE,
        'CONT-' || p_funding_id || '-' || p_partner_id
    );

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20010, 'Error en transacción de proyecto y financiamiento');
END;
/

CREATE OR REPLACE PROCEDURE prc_registrar_beneficiario_proyecto(
    p_beneficiary_id   IN NUMBER,
    p_dni              IN CHAR,
    p_institution_id   IN NUMBER,
    p_gender           IN CHAR,
    p_first_name       IN VARCHAR2,
    p_last_name        IN VARCHAR2,
    p_birth_date       IN DATE,
    p_occupation       IN VARCHAR2,
    p_phone            IN CHAR,
    p_email            IN VARCHAR2,
    p_project_id       IN NUMBER
) AS
BEGIN
    -- 1. Insertar beneficiario
    INSERT INTO Beneficiary(
        beneficiary_id, dni_b, institution_id, gender,
        first_name_b, last_name_b, birth_date_b,
        occupation, phone_b, email_b
    )
    VALUES (
        p_beneficiary_id, p_dni, p_institution_id, p_gender,
        p_first_name, p_last_name, p_birth_date,
        p_occupation, p_phone, p_email
    );

    -- 2. Inscribirlo al proyecto
    INSERT INTO Project_Beneficiary(
        project_id, beneficiary_id, enroliment_date, role_in_project
    )
    VALUES (
        p_project_id, p_beneficiary_id, SYSDATE, 'Participante'
    );

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20020, 'Error al registrar beneficiario en proyecto');
END;
/

CREATE OR REPLACE PROCEDURE prc_asignar_voluntario(
    p_activity_id     IN NUMBER,
    p_volunteer_id    IN NUMBER,
    p_role            IN VARCHAR2,
    p_hours           IN NUMBER,
    p_end_date        IN DATE
) AS
BEGIN
    INSERT INTO Volunteer_Activity(
        activity_id, volunteer_id,
        assignment_date, end_date,
        hours_committed, role
    )
    VALUES (
        p_activity_id, p_volunteer_id,
        SYSDATE, p_end_date,
        p_hours, p_role
    );

    -- Validación de negocio
    IF p_end_date < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20030, 'La fecha final no puede ser menor a hoy');
    END IF;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20031, 'Error en asignación de voluntario');
END;
/

