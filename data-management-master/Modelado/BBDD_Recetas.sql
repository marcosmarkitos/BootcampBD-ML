---------------------------------------------
--
-- Configuración de la sesión e inicio
--
---------------------------------------------

SET datestyle = YMD;        -- Formato de fecha día-mes-año
SET TRANSACTION READ WRITE;  

BEGIN WORK;

---------------------------------------------
--
-- Eliminar las tablas (si existen)
--
---------------------------------------------

--DROP TABLE receta;
--DROP TABLE visita;
--DROP TABLE paciente;
--DROP TABLE medico;

---------------------------------------------
--
-- Creación de la tabla de médicos
--
---------------------------------------------

CREATE TABLE medico ( 
   num_med      INTEGER  CONSTRAINT med_pk PRIMARY KEY, 
   nom_med      CHAR(30) NOT NULL, 
   especialidad CHAR(30) NOT NULL, 
   direccion    CHAR(30),
   ciudad       CHAR(30) NOT NULL, 
   telefono     INTEGER, 
   sueldo       INTEGER  NOT NULL CONSTRAINT med_sueldo_positivo CHECK (sueldo > 0),
   dni          INTEGER  NOT NULL CONsTRAINT med_dni_unico       UNIQUE
);
 
INSERT INTO medico VALUES ( 1, 'Severino Martín'   , 'Atención Primaria', NULL                            , 'Barcelona'     , 938597565, 45000, 99658965);
INSERT INTO medico VALUES ( 2, 'Marisa Senín'      , 'Atención Primaria', 'Rambla Catalunya 27'           , 'Tarragona'     , 655899714, 35000, 55632659);
INSERT INTO medico VALUES ( 3, 'Pawel Pikorski'    , 'Cardiología'      , 'Paseo Cracovia 23'             , 'Girona'        , 652356981, 27000, 55889655);
INSERT INTO medico VALUES ( 4, 'Emilia Rodriguez'  , 'Radiología'       , 'El Pelín 189'                  , 'Mataró'        ,      NULL, 38000, 88957854);
INSERT INTO medico VALUES ( 5, 'Ana María López'   , 'Traumatología'    , NULL                            , 'Barcelona'     ,      NULL, 98000, 44125485);
INSERT INTO medico VALUES ( 6, 'Conrado Pitarque'  , 'Cirugía Plástica' , 'Las Hermosas 78-15a'           , 'Tarragona'     , 938567435, 46000, 99658412);
INSERT INTO medico VALUES ( 7, 'Andrés Libertad'   , 'Atención Primaria', 'Avenida de las Marinas 2'      , 'Penedés'       ,      NULL, 38000, 35663233);
INSERT INTO medico VALUES ( 8, 'Celestino Pose'    , 'Odontología'      , NULL                            , 'Barcelona'     , 656489235, 77500, 88569996);
INSERT INTO medico VALUES ( 9, 'Elena Rodriguez'   , 'Atención Primaria', 'Las Sombras 56'                , 'L''Hospitalet' , 934526895, 66500, 74585221);
INSERT INTO medico VALUES (10, 'Mateo Austríaco'   , 'Traumatología'    , 'Urb. Cancelas Apt 45'          , 'Premiá de Mar' ,      NULL, 23000, 96569785);
INSERT INTO medico VALUES (11, 'Minerva Guerra'    , 'Oncología'        , 'Las Azores 90-6C'              , 'Barcelona'     , 986570808, 89600, 78545485);
INSERT INTO medico VALUES (12, 'Pedro Ramírez'     , 'Cardiología'      , 'C/Primera a la Derecha 3'      , 'Barcelona'     ,      NULL, 59500, 55896569);
INSERT INTO medico VALUES (13, 'Roberto Juárez'    , 'Radiología'       , 'Las Cuartillas 36'             , 'Barcelona'     , 636985216, 64250, 88599658);
INSERT INTO medico VALUES (14, 'Fernando Fernández', 'Atención Primaria', 'Paseo Cracovia 56'             , 'Girona'        , 653698523, 36525, 44125553);

---------------------------------------------
--
-- Creación de la tabla de pacientes
--
---------------------------------------------

CREATE TABLE paciente ( 
   num_pac    INTEGER  CONSTRAINT pac_pk PRIMARY KEY, 
   nom_pac    CHAR(30) NOT NULL, 
   direccion  CHAR(30), 
   ciudad     CHAR(30) NOT NULL,
   dni        INTEGER  NOT NULL CONSTRAINT pac_dni_unico UNIQUE
);
 
INSERT INTO paciente VALUES ( 1, 'Manuel Enfermín' , 'C/María 98'          , 'Barcelona'    , 44089798);
INSERT INTO paciente VALUES ( 2, 'María Através'   , 'Recanto de Hoces 88' , 'Badalona'     , 66523789);
INSERT INTO paciente VALUES ( 3, 'José Antón'      , 'Rúa Pitiminí 76-2D'  , 'Mataró'       , 85213457);
INSERT INTO paciente VALUES ( 4, 'Celestino Pose'  , NULL                  , 'Barcelona'    , 88569996);
INSERT INTO paciente VALUES ( 5, 'Fernanda Santos' , 'El Ézaro 27-4B'      , 'Manzanares'   , 36526487);
INSERT INTO paciente VALUES ( 6, 'María Suárez'    , 'Calle Leicures 7'    , 'Girona'       , 35355698);
INSERT INTO paciente VALUES ( 7, 'Ileón Sánchez'   , 'C/La Pilarina 98'    , 'Tarragona'    , 89625563);
INSERT INTO paciente VALUES ( 8, 'Sinforosa López' , 'Paseo Gracia 28'     , 'Premiá de Mar', 85655595);
INSERT INTO paciente VALUES ( 9, 'Roberto Martínez', 'Avenida Mayor 98-3'  , 'Barcelona'    , 92154282);
INSERT INTO paciente VALUES (10, 'Ramón Tirán'     , NULL                  , 'Mataró'       , 12358452);
INSERT INTO paciente VALUES (11, 'José Pérez'      , 'Av. Valles n6-13'    , 'Barcelona'    , 32568559);
INSERT INTO paciente VALUES (12, 'Pawel Pikorski'  , 'Paseo Cracovia 23'   , 'Girona'       , 55889655);
INSERT INTO paciente VALUES (13, 'Renata Emailova' , NULL                  , 'Barcelona'    , 55236996);
INSERT INTO paciente VALUES (14, 'Josefa Enfermín' , 'C/María 98'          , 'Madrid'       , 53689524);
INSERT INTO paciente VALUES (15, 'María Pérez'     , 'Av. Valles n6-13'    , 'Barcelona'    , 32568557);
INSERT INTO paciente VALUES (16, 'Camila Pérez'    , 'Av. Valles n6-13'    , 'Barcelona'    , 32568558);


---------------------------------------------
--
-- Creación de la tabla de visitas
--
---------------------------------------------

CREATE TABLE visita (
   num_med      INTEGER NOT NULL REFERENCES medico   (num_med), 
   num_pac      INTEGER NOT NULL REFERENCES paciente (num_pac), 
   fecha_visita DATE, 
   importe      INTEGER NOT NULL, 
   CONSTRAINT vis_pk PRIMARY KEY (num_med, num_pac, fecha_visita)
); 

INSERT INTO visita VALUES ( 1, 14, '2013-05-31',   50);
INSERT INTO visita VALUES ( 1, 14, '2013-06-01',   25);
INSERT INTO visita VALUES ( 1, 14, '2013-06-12',   30);
INSERT INTO visita VALUES (13, 14, '2013-06-12',  180);
INSERT INTO visita VALUES ( 3,  6, '2013-04-02', 1500);
INSERT INTO visita VALUES ( 9,  6, '2013-04-04',  500);
INSERT INTO visita VALUES ( 5,  6, '2013-04-02',  300);
INSERT INTO visita VALUES ( 2, 11, '2013-01-12',   20);
INSERT INTO visita VALUES ( 5, 12, '2013-07-25',  123);
INSERT INTO visita VALUES ( 5,  7, '2013-02-22',  450);
INSERT INTO visita VALUES ( 4,  7, '2013-02-17',   25);
INSERT INTO visita VALUES ( 4,  1, '2013-01-18',  225);
INSERT INTO visita VALUES ( 2,  1, '2013-01-19',   22);
INSERT INTO visita VALUES ( 7,  1, '2013-01-20',   30);
INSERT INTO visita VALUES ( 8,  1, '2013-01-24',   22);
INSERT INTO visita VALUES ( 5, 10, '2013-04-12',   15);
INSERT INTO visita VALUES ( 2, 10, '2013-06-09',  145);
INSERT INTO visita VALUES ( 9, 10, '2013-11-13',  235);
INSERT INTO visita VALUES (12, 10, '2013-12-31',  100);
INSERT INTO visita VALUES ( 3,  4, '2013-02-12',   30);
INSERT INTO visita VALUES (10,  4, '2013-08-09',  120);
INSERT INTO visita VALUES (10,  5, '2013-02-19',  110);
INSERT INTO visita VALUES (10,  5, '2013-03-29',  100);
INSERT INTO visita VALUES (10,  3, '2013-03-29',   10);
INSERT INTO visita VALUES ( 1,  3, '2013-04-18',   20);
INSERT INTO visita VALUES (13,  3, '2013-10-01',  120);
INSERT INTO visita VALUES (13,  9, '2013-01-02', 1200);
INSERT INTO visita VALUES ( 5,  9, '2013-04-10',   80);
INSERT INTO visita VALUES ( 4,  9, '2013-08-31',   45);
INSERT INTO visita VALUES ( 8,  9, '2013-10-18',   65);
INSERT INTO visita VALUES (13,  9, '2013-12-10',   65);
INSERT INTO visita VALUES (14, 13, '2013-07-13',  105);

---------------------------------------------
--
-- Creación de la tabla de recetas
--
---------------------------------------------

CREATE TABLE receta ( 
   num_rec      INTEGER  CONSTRAINT rec_pk PRIMARY KEY,
   medicamento  CHAR(50) NOT NULL, 
   num_med      INTEGER  NOT NULL, 
   num_pac      INTEGER  NOT NULL, 
   fecha_visita DATE     NOT NULL, 
   CONSTRAINT rec_visita_fk FOREIGN KEY (num_med, num_pac, fecha_visita) REFERENCES visita (num_med, num_pac, fecha_visita)
);

INSERT INTO receta VALUES (  1, 'OMEPRAZOL 2MG'       , 1, 14, '2013-05-31');
INSERT INTO receta VALUES (  2, 'NUROFEN 10MG'        , 1, 14, '2013-05-31');
INSERT INTO receta VALUES (  3, 'PANADOL 1000MG'      , 1, 14, '2013-05-31');
INSERT INTO receta VALUES (  4, 'DR. ANDREU 1MG'      , 1, 14, '2013-06-12');
INSERT INTO receta VALUES (  5, 'PANADOL 1000MG'      , 1, 14, '2013-06-12');
INSERT INTO receta VALUES (  6, 'STREPSILS 20P'       ,13, 14, '2013-06-12');
INSERT INTO receta VALUES (  7, 'VICKS VAPORUB'       ,13, 14, '2013-06-12');
INSERT INTO receta VALUES (  8, 'ARGININE'            ,13, 14, '2013-06-12');
INSERT INTO receta VALUES (  9, 'IBUPROFENO 600'      , 3,  6, '2013-04-02');
INSERT INTO receta VALUES ( 10, 'PANADOL 1000MG'      , 3,  6, '2013-04-02');
INSERT INTO receta VALUES ( 11, 'ATORVASTATIN 1ML'    , 3,  6, '2013-04-02');
INSERT INTO receta VALUES ( 12, 'PANADOL 1000MG'      , 9,  6, '2013-04-04');
INSERT INTO receta VALUES ( 13, 'DR. ANDREU 1MG'      , 5,  6, '2013-04-02');
INSERT INTO receta VALUES ( 14, 'NUROFEN 10MG'        , 5,  6, '2013-04-02');
INSERT INTO receta VALUES ( 15, 'OMEPRAZOL 2MG'       , 2, 11, '2013-01-12');
INSERT INTO receta VALUES ( 16, 'JARABE PARA TOS'     , 2, 11, '2013-01-12');
INSERT INTO receta VALUES ( 17, 'OFLOXACIN 1G'        , 5, 12, '2013-07-25');
INSERT INTO receta VALUES ( 18, 'MORFINA 10ML'        , 5, 12, '2013-07-25');
INSERT INTO receta VALUES ( 19, 'PANADOL 1000MG'      , 5,  7, '2013-02-22');
INSERT INTO receta VALUES ( 20, 'ATORVASTATIN 1ML'    , 5,  7, '2013-02-22');
INSERT INTO receta VALUES ( 21, 'VENTOLIN 2ML'        , 5,  7, '2013-02-22');
INSERT INTO receta VALUES ( 22, 'IBUPROFENO 600'      , 4,  7, '2013-02-17');
INSERT INTO receta VALUES ( 23, 'PANADOL 1000MG'      , 4,  7, '2013-02-17');
INSERT INTO receta VALUES ( 24, 'VENTOLIN 2ML'        , 4,  7, '2013-02-17');
INSERT INTO receta VALUES ( 25, 'ATORVASTATIN 1ML'    , 4,  7, '2013-02-17');
INSERT INTO receta VALUES ( 26, 'NUROFEN 10MG'        , 4,  1, '2013-01-18');
INSERT INTO receta VALUES ( 27, 'VENTOLIN 2ML'        , 2,  1, '2013-01-19');
INSERT INTO receta VALUES ( 28, 'ARGININE'            , 2,  1, '2013-01-19');
INSERT INTO receta VALUES ( 29, 'JARABE PARA TOS'     , 2,  1, '2013-01-19');
INSERT INTO receta VALUES ( 30, 'PANADOL 1000MG'      , 7,  1, '2013-01-20'); 
INSERT INTO receta VALUES ( 31, 'VENTOLIN 2ML'        , 8,  1, '2013-01-24'); 
INSERT INTO receta VALUES ( 32, 'ARGININE'            , 8,  1, '2013-01-24');
INSERT INTO receta VALUES ( 33, 'NUROFEN 10MG'        , 8,  1, '2013-01-24');
INSERT INTO receta VALUES ( 34, 'OFLOXACIN 1G'        , 5, 10, '2013-04-12'); 
INSERT INTO receta VALUES ( 35, 'VICKS VAPORUB'       , 5, 10, '2013-04-12');
INSERT INTO receta VALUES ( 36, 'IBUPROFENO 600'      , 5, 10, '2013-04-12');
INSERT INTO receta VALUES ( 37, 'JARABE PARA TOS'     , 5, 10, '2013-04-12');
INSERT INTO receta VALUES ( 38, 'PANADOL 1000MG'      , 5, 10, '2013-04-12');
INSERT INTO receta VALUES ( 39, 'NUROFEN 10MG'        , 2, 10, '2013-06-09');
INSERT INTO receta VALUES ( 40, 'ATORVASTATIN 1ML'    , 2, 10, '2013-06-09');
INSERT INTO receta VALUES ( 41, 'DR. ANDREU 1MG'      ,12, 10, '2013-12-31');
INSERT INTO receta VALUES ( 42, 'VENTOLIN 2ML'        ,12, 10, '2013-12-31');
INSERT INTO receta VALUES ( 43, 'JARABE PARA TOS'     , 3,  4, '2013-02-12');
INSERT INTO receta VALUES ( 44, 'PANADOL 1000MG'      ,10,  4, '2013-08-09');
INSERT INTO receta VALUES ( 45, 'DR. ANDREU 1MG'      ,10,  4, '2013-08-09');
INSERT INTO receta VALUES ( 46, 'VENTOLIN 2ML'        ,10,  5, '2013-03-29');
INSERT INTO receta VALUES ( 47, 'CALMANTE VITAMINADO' ,10,  5, '2013-03-29');
INSERT INTO receta VALUES ( 48, 'TRANQUIMAZÍN'        ,10,  5, '2013-03-29');
INSERT INTO receta VALUES ( 49, 'REVIROX 10ML'        ,10,  3, '2013-03-29');
INSERT INTO receta VALUES ( 50, 'NIVEA CREMA SOLAR'   ,10,  3, '2013-03-29');
INSERT INTO receta VALUES ( 51, 'TRANQUIMAZÍN'        , 1,  3, '2013-04-18');
INSERT INTO receta VALUES ( 52, 'PANADOL 1000MG'      ,13,  3, '2013-10-01');
INSERT INTO receta VALUES ( 53, 'NIVEA CREMA SOLAR'   ,13,  3, '2013-10-01');
INSERT INTO receta VALUES ( 54, 'PANADOL 1000MG'      , 5,  9, '2013-04-10');
INSERT INTO receta VALUES ( 55, 'REVIROX 10ML'        , 5,  9, '2013-04-10');
INSERT INTO receta VALUES ( 56, 'JARABE PARA TOS'     , 5,  9, '2013-04-10');
INSERT INTO receta VALUES ( 57, 'ATORVASTATIN 1ML'    , 4,  9, '2013-08-31');
INSERT INTO receta VALUES ( 58, 'TRANQUIMAZÍN'        , 4,  9, '2013-08-31');
INSERT INTO receta VALUES ( 59, 'TIRITAS DEDOS'       , 4,  9, '2013-08-31');
INSERT INTO receta VALUES ( 60, 'VENTOLIN 2ML'        , 4,  9, '2013-08-31');
INSERT INTO receta VALUES ( 61, 'ATORVASTATIN 1ML'    ,13,  9, '2013-12-10');
INSERT INTO receta VALUES ( 62, 'DR. ANDREU 1MG'      ,13,  9, '2013-12-10');

---------------------------------------------
--
-- Fin
--
---------------------------------------------

COMMIT;