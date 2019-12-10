-- Con usuario sys y desde ventana SQL en base de datos Oracle12c creada

--DROP USER STAGE CASCADE;

CREATE USER lab IDENTIFIED BY lab;
GRANT CONNECT, RESOURCE, DBA TO lab;
GRANT UNLIMITED TABLESPACE TO lab;