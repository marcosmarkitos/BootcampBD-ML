-- Generado por Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   en:        2019-12-13 17:36:20 CET
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c



DROP TABLE privilegios CASCADE CONSTRAINTS;

DROP TABLE rel_rol_priv CASCADE CONSTRAINTS;

DROP TABLE roles CASCADE CONSTRAINTS;

DROP TABLE usuarios CASCADE CONSTRAINTS;

CREATE TABLE privilegios (
    priv_id    NUMBER NOT NULL,
    priv_nom   VARCHAR2(20) NOT NULL
);

ALTER TABLE privilegios ADD CONSTRAINT privilegios_pk PRIMARY KEY ( priv_id );

CREATE TABLE rel_rol_priv (
    roles_rol_id          NUMBER NOT NULL,
    privilegios_priv_id   NUMBER NOT NULL
);

ALTER TABLE rel_rol_priv ADD CONSTRAINT rel_rol_priv_pk PRIMARY KEY ( roles_rol_id,
                                                                      privilegios_priv_id );

CREATE TABLE roles (
    rol_id    NUMBER NOT NULL,
    rol_nom   VARCHAR2(20) NOT NULL
);

ALTER TABLE roles ADD CONSTRAINT roles_pk PRIMARY KEY ( rol_id );

CREATE TABLE usuarios (
    usu_id         NUMBER NOT NULL,
    usu_nombre     VARCHAR2(20) NOT NULL,
    usu_pss        VARCHAR2(20) NOT NULL,
    roles_rol_id   NUMBER NOT NULL
);

ALTER TABLE usuarios ADD CONSTRAINT usuarios_pk PRIMARY KEY ( usu_id );

ALTER TABLE rel_rol_priv
    ADD CONSTRAINT rel_rol_priv_privilegios_fk FOREIGN KEY ( privilegios_priv_id )
        REFERENCES privilegios ( priv_id );

ALTER TABLE rel_rol_priv
    ADD CONSTRAINT rel_rol_priv_roles_fk FOREIGN KEY ( roles_rol_id )
        REFERENCES roles ( rol_id );

ALTER TABLE usuarios
    ADD CONSTRAINT usuarios_roles_fk FOREIGN KEY ( roles_rol_id )
        REFERENCES roles ( rol_id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
