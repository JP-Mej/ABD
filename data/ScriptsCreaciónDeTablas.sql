CREATE TABLE Location (
    location_id NUMBER(8) PRIMARY KEY,
    department  VARCHAR2(20) NOT NULL,
    province    VARCHAR2(20) NOT NULL,
    district    VARCHAR2(20) NOT NULL,
    country     VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_location_id_range CHECK (location_id BETWEEN 10000001 AND 10999999)
) TABLESPACE fundacion_referencia;


CREATE TABLE Indicator (
    indicator_id      NUMBER(8)     PRIMARY KEY,
    description_i     VARCHAR2(50)  NOT NULL,
    code              VARCHAR2(20)  NOT NULL,
    value             NUMBER        NOT NULL,
    measurement_date  DATE          NOT NULL,
    type              VARCHAR2(20)  NOT NULL,
    CONSTRAINT chk_indicator_type CHECK (type IN ('Quantitative', 'Qualitative')),
    CONSTRAINT chk_indicator_id_range CHECK (indicator_id BETWEEN 8000001 AND 8999999)
) TABLESPACE fundacion_referencia;


CREATE TABLE Resources (
    resource_id    NUMBER(8)      PRIMARY KEY,
    title          VARCHAR2(30)   NOT NULL,
    resource_type  VARCHAR2(20)   NOT NULL,
    author         VARCHAR2(50)   NOT NULL,
    publish_date   DATE           NOT NULL,
    url            VARCHAR2(200)  NOT NULL,
    language       VARCHAR2(20)   NOT NULL,
    CONSTRAINT chk_resource_type CHECK (resource_type IN ('Book', 'Article', 'Video', 'Guide', 'Dataset')),
    CONSTRAINT chk_resource_id_range CHECK (resource_id BETWEEN 9000001 AND 9999999)
) TABLESPACE fundacion_referencia;


CREATE TABLE Institution (
    institution_id    NUMBER(8)     PRIMARY KEY,
    location_id       NUMBER(8)     NOT NULL,
    name_i            VARCHAR2(50)  NOT NULL,
    institution_type  VARCHAR2(30)  NOT NULL,
    address_i         VARCHAR2(50)  NOT NULL,
    contact_email_i   VARCHAR2(35)  NOT NULL,
    CONSTRAINT fk_institution_location FOREIGN KEY (location_id) REFERENCES Location(location_id),
    CONSTRAINT chk_institution_id_range CHECK (institution_id BETWEEN 11000001 AND 11999999)
) TABLESPACE fundacion_referencia;


CREATE TABLE Employee (
    employee_id      NUMBER(8)     PRIMARY KEY,
    first_name_e     VARCHAR2(50)  NOT NULL,
    last_name_e      VARCHAR2(50)  NOT NULL,
    birth_date_e     DATE          NOT NULL,
    email_e          VARCHAR2(35)  NOT NULL,
    phone_e          CHAR(9)       NOT NULL,
    address_e        VARCHAR2(50)  NOT NULL,
    employment_type  VARCHAR2(20)  NOT NULL,
    salary           NUMBER(8,2)   NOT NULL,
    start_date_e     DATE          NOT NULL,
    end_date_e       DATE,
    CONSTRAINT chk_emp_salary CHECK (salary >= 0),
    CONSTRAINT chk_emp_type CHECK (employment_type IN ('Full-Time', 'Part-Time', 'Contract')),
    CONSTRAINT chk_employee_id_range CHECK (employee_id BETWEEN 1000001 AND 1999999)
) TABLESPACE fundacion_operativo;


CREATE TABLE Volunteer (
    volunteer_id      NUMBER(8)     PRIMARY KEY,
    first_name_v      VARCHAR2(50)  NOT NULL,
    last_name_v       VARCHAR2(50)  NOT NULL,
    birth_date_v      DATE          NOT NULL,
    email_v           VARCHAR2(35)  NOT NULL,
    phone_v           CHAR(9)       NOT NULL,
    employment_status VARCHAR2(10)  NOT NULL,
    CONSTRAINT chk_vol_status CHECK (employment_status IN ('Active', 'Inactive')),
    CONSTRAINT chk_volunteer_id_range CHECK (volunteer_id BETWEEN 2000001 AND 2999999)
) TABLESPACE fundacion_operativo;


CREATE TABLE Activity (
    activity_id     NUMBER(8)      PRIMARY KEY,
    name_a          VARCHAR2(50)   NOT NULL,
    activity_type   VARCHAR2(30)   NOT NULL,
    activity_date   DATE           NOT NULL,
    CONSTRAINT chk_activity_id_range CHECK (activity_id BETWEEN 5000001 AND 5999999)
) TABLESPACE fundacion_operativo;


CREATE TABLE Funding (
    funding_id      NUMBER(8)     PRIMARY KEY,
    funding_type    VARCHAR2(20)  NOT NULL,
    total_amount    NUMBER(8,2)   NOT NULL,
    final_currency  VARCHAR2(3)   NOT NULL,
    funding_date    DATE          NOT NULL,
    CONSTRAINT chk_funding_amount CHECK (total_amount > 0),
    CONSTRAINT chk_funding_currency CHECK (final_currency IN ('USD', 'EUR', 'PEN')),
    CONSTRAINT chk_funding_id_range CHECK (funding_id BETWEEN 7000001 AND 7999999)
) TABLESPACE fundacion_proyecto;


CREATE TABLE Partner (
    partner_id       NUMBER(8)     PRIMARY KEY,
    name_partner     VARCHAR2(50)  NOT NULL,
    partner_type     VARCHAR2(20)  NOT NULL,
    country          VARCHAR2(10)  NOT NULL,
    contact_email_p  VARCHAR2(35)  NOT NULL,
    CONSTRAINT chk_partner_type CHECK (partner_type IN ('Public', 'Private', 'NGO', 'Academic')),
    CONSTRAINT chk_partner_id_range CHECK (partner_id BETWEEN 3000001 AND 3999999)
) TABLESPACE fundacion_proyecto;


CREATE TABLE Project (
    project_id      NUMBER(8)      PRIMARY KEY,
    activity_id     NUMBER(8)      NOT NULL,
    funding_id      NUMBER(8)      NOT NULL,
    indicator_id    NUMBER(8)      NOT NULL,
    location_id     NUMBER(8)      NOT NULL,
    name_p          VARCHAR2(50)   NOT NULL,
    description_p   VARCHAR2(200)  NOT NULL,
    budget_amount   NUMBER(12,2)   NOT NULL,
    strategic_area  VARCHAR2(50)   NOT NULL,
    start_date_p    DATE           NOT NULL,
    end_date_p      DATE           NOT NULL,
    status          VARCHAR2(20)   NOT NULL,
    CONSTRAINT fk_project_activity FOREIGN KEY (activity_id) REFERENCES Activity(activity_id),
    CONSTRAINT fk_project_funding FOREIGN KEY (funding_id) REFERENCES Funding(funding_id),
    CONSTRAINT fk_project_indicator FOREIGN KEY (indicator_id) REFERENCES Indicator(indicator_id),
    CONSTRAINT fk_project_location FOREIGN KEY (location_id) REFERENCES Location(location_id),
    CONSTRAINT chk_project_budget CHECK (budget_amount >= 0),
    CONSTRAINT chk_project_dates CHECK (end_date_p >= start_date_p),
    CONSTRAINT chk_project_status CHECK (status IN ('Planned', 'Ongoing', 'Completed', 'Cancelled')),
    CONSTRAINT chk_project_id_range CHECK (project_id BETWEEN 6000001 AND 6999999)
) TABLESPACE fundacion_proyecto;


CREATE TABLE Funding_Partner (
    funding_id               NUMBER(8)     NOT NULL,
    partner_id               NUMBER(8)     NOT NULL,
    contribution_role        VARCHAR2(20)  NOT NULL,
    contribution_porcentage  NUMBER(5,2)   NOT NULL,
    contribution_amount      NUMBER(12,2)  NOT NULL,
    currency                 VARCHAR2(5)   NOT NULL,
    contribution_date        DATE          NOT NULL,
    contract_reference       VARCHAR2(50)  NOT NULL,
    CONSTRAINT pk_funding_partner PRIMARY KEY (funding_id, partner_id),
    CONSTRAINT fk_funpart_funding FOREIGN KEY (funding_id) REFERENCES Funding(funding_id),
    CONSTRAINT fk_funpart_partner FOREIGN KEY (partner_id) REFERENCES Partner(partner_id)
) TABLESPACE fundacion_proyecto;


CREATE TABLE Employee_Activity (
    employee_id    NUMBER(8)     NOT NULL,
    activity_id    NUMBER(8)     NOT NULL,
    responsibility VARCHAR2(20)  NOT NULL,
    CONSTRAINT pk_employee_activity PRIMARY KEY (employee_id, activity_id),
    CONSTRAINT fk_empact_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    CONSTRAINT fk_empact_activity FOREIGN KEY (activity_id) REFERENCES Activity(activity_id)
) TABLESPACE fundacion_operativo;


CREATE TABLE Volunteer_Activity (
    activity_id      NUMBER(8)     NOT NULL,
    volunteer_id     NUMBER(8)     NOT NULL,
    assignment_date  DATE          NOT NULL,
    end_date         DATE,
    hours_committed  NUMBER(8,2),
    role             VARCHAR2(20)  NOT NULL,
    CONSTRAINT pk_volunteer_activity PRIMARY KEY (activity_id, volunteer_id),
    CONSTRAINT fk_volact_activity FOREIGN KEY (activity_id) REFERENCES Activity(activity_id),
    CONSTRAINT fk_volact_volunteer FOREIGN KEY (volunteer_id) REFERENCES Volunteer(volunteer_id)
) TABLESPACE fundacion_operativo;


CREATE TABLE Beneficiary (
    beneficiary_id  NUMBER(8)     PRIMARY KEY,
    dni_b           CHAR(8)       NOT NULL,
    institution_id  NUMBER(8)     NOT NULL,
    gender          CHAR(1)       NOT NULL,
    first_name_b    VARCHAR2(50)  NOT NULL,
    last_name_b     VARCHAR2(50)  NOT NULL,
    birth_date_b    DATE          NOT NULL,
    occupation      VARCHAR2(20)  NOT NULL,
    phone_b         CHAR(9)       NOT NULL,
    email_b         VARCHAR2(35)  NOT NULL,
    CONSTRAINT fk_beneficiary_institution FOREIGN KEY (institution_id) REFERENCES Institution(institution_id),
    CONSTRAINT chk_beneficiary_gender CHECK (gender IN ('M', 'F')),
    CONSTRAINT chk_beneficiary_dni CHECK (LENGTH(dni_b) = 8),
    CONSTRAINT chk_beneficiary_id_range CHECK (beneficiary_id BETWEEN 4000001 AND 4999999)
) TABLESPACE fundacion_beneficiario;


CREATE TABLE Project_Beneficiary (
    project_id       NUMBER(8)     NOT NULL,
    beneficiary_id   NUMBER(8)     NOT NULL,
    enroliment_date  DATE          NOT NULL,
    role_in_project  VARCHAR2(20)  NOT NULL,
    CONSTRAINT pk_project_beneficiary PRIMARY KEY (project_id, beneficiary_id),
    CONSTRAINT fk_proben_project FOREIGN KEY (project_id) REFERENCES Project(project_id),
    CONSTRAINT fk_proben_beneficiary FOREIGN KEY (beneficiary_id) REFERENCES Beneficiary(beneficiary_id)
) TABLESPACE fundacion_beneficiario;


CREATE TABLE Resource_Project (
    project_id   NUMBER(8)     NOT NULL,
    resource_id  NUMBER(8)     NOT NULL,
    use_date     DATE,
    usage_type   VARCHAR2(20)  NOT NULL,
    CONSTRAINT pk_resource_project PRIMARY KEY (project_id, resource_id),
    CONSTRAINT fk_resproj_project FOREIGN KEY (project_id) REFERENCES Project(project_id),
    CONSTRAINT fk_resproj_resource FOREIGN KEY (resource_id) REFERENCES Resources(resource_id)
) TABLESPACE fundacion_referencia;


CREATE TABLE Certification (
    cert_id        NUMBER(8)     PRIMARY KEY,
    beneficiary_id NUMBER(8)     NOT NULL,
    resource_id    NUMBER(8)     NOT NULL,
    issue_date     DATE          NOT NULL,
    expiry_date    DATE          NOT NULL,
    grade          VARCHAR2(2)   NOT NULL,
    CONSTRAINT fk_cert_beneficiary FOREIGN KEY (beneficiary_id) REFERENCES Beneficiary(beneficiary_id),
    CONSTRAINT fk_cert_resource FOREIGN KEY (resource_id) REFERENCES Resources(resource_id),
    CONSTRAINT chk_cert_dates CHECK (expiry_date > issue_date),
    CONSTRAINT chk_cert_grade CHECK (grade IN ('A','B','C','D','E','F')),
    CONSTRAINT chk_cert_id_range CHECK (cert_id BETWEEN 12000001 AND 12999999)
) TABLESPACE fundacion_beneficiario;
