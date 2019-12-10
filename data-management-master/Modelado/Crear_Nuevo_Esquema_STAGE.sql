-- Con usuario sys y desde ventana SQL en base de datos Oracle12c creada

--DROP USER STAGE CASCADE;


CREATE USER stage IDENTIFIED BY stage;
GRANT CONNECT, RESOURCE, DBA TO stage;
GRANT UNLIMITED TABLESPACE TO stage;