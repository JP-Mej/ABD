ALTER SESSION SET CONTAINER = XEPDB1;
CREATE ROLE rol_admin;
CREATE ROLE rol_operativo;
CREATE ROLE rol_auditor;

GRANT CONNECT, RESOURCE TO rol_admin;
GRANT CREATE VIEW, CREATE PROCEDURE, CREATE TRIGGER TO rol_admin;

GRANT CONNECT TO rol_operativo;

GRANT CONNECT TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Project TO rol_operativo;
GRANT SELECT ON Project TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Funding TO rol_admin;
GRANT SELECT ON Funding TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Funding_Partner TO rol_admin;
GRANT SELECT ON Funding_Partner TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Beneficiary TO rol_operativo;
GRANT SELECT ON Beneficiary TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Certification TO rol_operativo;
GRANT SELECT ON Certification TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Project_Beneficiary TO rol_operativo;
GRANT SELECT ON Project_Beneficiary TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Volunteer TO rol_operativo;
GRANT SELECT ON Volunteer TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Activity TO rol_operativo;
GRANT SELECT ON Activity TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Volunteer_Activity TO rol_operativo;
GRANT SELECT ON Volunteer_Activity TO rol_auditor;

GRANT SELECT ON Partner TO rol_operativo;
GRANT SELECT ON Partner TO rol_auditor;

GRANT SELECT, INSERT, UPDATE ON Indicator TO rol_operativo;
GRANT SELECT ON Indicator TO rol_auditor;


CREATE USER ft_admin IDENTIFIED BY admin123;
CREATE USER ft_operador IDENTIFIED BY operador123;
CREATE USER ft_auditor IDENTIFIED BY auditor123;


GRANT rol_admin TO ft_admin;
GRANT rol_operativo TO ft_operador;
GRANT rol_auditor TO ft_auditor;

ALTER USER ft_admin ACCOUNT UNLOCK;
ALTER USER ft_operador ACCOUNT UNLOCK;
ALTER USER ft_auditor ACCOUNT UNLOCK;



GRANT CREATE SESSION TO ft_admin;
GRANT CREATE SESSION TO ft_operador;
GRANT CREATE SESSION TO ft_auditor;


SELECT * FROM dba_roles WHERE role LIKE 'ROL_%';

SELECT * FROM dba_role_privs 
WHERE grantee IN ('FT_ADMIN', 'FT_OPERADOR', 'FT_AUDITOR');

SELECT * FROM dba_tab_privs 
WHERE grantee IN ('ROL_ADMIN', 'ROL_OPERATIVO', 'ROL_AUDITOR');


