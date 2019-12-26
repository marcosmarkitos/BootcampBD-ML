-- Generado por Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   en:        2019-12-23 19:23:56 CET
--   sitio:      Oracle Database 12c
--   tipo:      Oracle Database 12c



DROP TABLE medico CASCADE CONSTRAINTS;

DROP TABLE paciente CASCADE CONSTRAINTS;

DROP TABLE receta CASCADE CONSTRAINTS;

DROP TABLE visita CASCADE CONSTRAINTS;

CREATE TABLE medico (
    num_med        NUMBER(10) NOT NULL,
    nom_med        VARCHAR2(100) NOT NULL,
    especialidad   VARCHAR2(100) NOT NULL,
    direccion      VARCHAR2(100),
    ciudad         VARCHAR2(100) NOT NULL,
    telefono       NUMBER(10),
    sueldo         NUMBER(10) NOT NULL,
    dni            VARCHAR2(10) NOT NULL
);

ALTER TABLE medico
    ADD CONSTRAINT med_sueldo_positivo CHECK ( ( ( sueldo > 0 ) ) );

ALTER TABLE medico ADD CONSTRAINT med_pk PRIMARY KEY ( num_med );

ALTER TABLE medico ADD CONSTRAINT med_dni_unico UNIQUE ( dni );

CREATE TABLE paciente (
    num_pac     NUMBER(10) NOT NULL,
    nom_pac     VARCHAR2(100) NOT NULL,
    direccion   VARCHAR2(100),
    ciudad      VARCHAR2(100) NOT NULL,
    dni         VARCHAR2(10) NOT NULL
);

ALTER TABLE paciente ADD CONSTRAINT pac_pk PRIMARY KEY ( num_pac );

ALTER TABLE paciente ADD CONSTRAINT pac_dni_unico UNIQUE ( dni );

CREATE TABLE receta (
    num_rec        NUMBER(10) NOT NULL,
    medicamento    VARCHAR2(100) NOT NULL,
    num_med        NUMBER(10) NOT NULL,
    num_pac        NUMBER(10) NOT NULL,
    fecha_visita   VARCHAR2(10) NOT NULL
);

ALTER TABLE receta ADD CONSTRAINT rec_pk PRIMARY KEY ( num_rec );

CREATE TABLE visita (
    num_med        NUMBER(10) NOT NULL,
    num_pac        NUMBER(10) NOT NULL,
    fecha_visita   VARCHAR2(10) NOT NULL,
    importe        INTEGER NOT NULL
);

ALTER TABLE visita
    ADD CONSTRAINT vis_pk PRIMARY KEY ( num_med,
                                        num_pac,
                                        fecha_visita );

ALTER TABLE receta
    ADD CONSTRAINT rec_visita_fk FOREIGN KEY ( num_med,
                                               num_pac,
                                               fecha_visita )
        REFERENCES visita ( num_med,
                            num_pac,
                            fecha_visita );

ALTER TABLE visita
    ADD CONSTRAINT visita_num_med_fkey FOREIGN KEY ( num_med )
        REFERENCES medico ( num_med );

ALTER TABLE visita
    ADD CONSTRAINT visita_num_pac_fkey FOREIGN KEY ( num_pac )
        REFERENCES paciente ( num_pac );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                             10
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
