-- QUERIES TALLER II
-- Es necesario correr la creación de base de datos, municipio

-- SQL IN --

-- Punto 1 --
SELECT * FROM comunidad 
	WHERE ca_id IN (SELECT ca_id FROM municipio 
	WHERE (poblacion2003 >= 300000) AND (poblacion2001 >= 300000) AND (poblacion1996 >= 300000) AND (poblacion1991 >= 300000));
    
-- Punto 2 --
SELECT * FROM comunidad
	WHERE ca_id IN (SELECT ca_id FROM municipio
	WHERE (superficie >= 1000) AND (superficie <= 3000));
    
-- Punto 3 --
SELECT * FROM comunidad
	WHERE ca_id IN (SELECT ca_id FROM municipio
	WHERE LOWER(nom) LIKE '%x');

-- Punto 4 --
SELECT DISTINCT comunidad.ca_id, comunidad.nom FROM 
	(SELECT ca_id FROM municipio
	WHERE LOWER(nom) LIKE '%x') AS tab1
    INNER JOIN comunidad ON tab1.ca_id = comunidad.ca_id;
    

-- HAVING SECTION

-- Punto 1 --
SELECT comunidad.nom, COUNT(comunidad.nom) FROM comunidad INNER JOIN municipio ON comunidad.ca_id = municipio.ca_id GROUP BY comunidad.nom HAVING COUNT(comunidad.nom) > 1000;

-- Punto 2 --
SELECT comunidad.nom, AVG(municipio.superficie) FROM comunidad INNER JOIN municipio ON comunidad.ca_id = municipio.ca_id GROUP BY comunidad.nom HAVING COUNT(comunidad.nom) >= 500 AND COUNT(comunidad.nom) <= 1000;

-- Punto 3 --
SELECT comunidad.nom, SUM(municipio.poblacion2003) / SUM(municipio.superficie) AS densidad FROM comunidad INNER JOIN municipio ON comunidad.ca_id = municipio.ca_id GROUP BY comunidad.nom HAVING SUM(municipio.poblacion2003) / SUM(municipio.superficie) > 1000;

-- UPDATE SECTION

-- Punto 1
DROP TABLE IF EXISTS municipio2;
create table municipio2
(
	m_id integer(4),
	nom varchar(70),
	poblacion2003 integer(7),
	poblacion2001 integer(7),
	poblacion1996 integer(7),
	poblacion1991 integer(7),
	superficie DECIMAL(20,2),
	ca_id integer(2),

	PRIMARY KEY(m_id),
	CONSTRAINT fk_municipio2_comunidad
		FOREIGN KEY (ca_id)
		REFERENCES comunidad(ca_id)
);

INSERT INTO municipio2 (m_id, nom, poblacion2003, poblacion2001, poblacion1996, poblacion1991, superficie, ca_id)
(
	SELECT m_id, nom, poblacion2003, poblacion2001, poblacion1996, poblacion1991, superficie, ca_id FROM municipio
);

-- Punto 2
UPDATE municipio2 SET municipio2.poblacion1991 = 0 WHERE municipio2.nom LIKE 'a%' AND m_id > 0;
-- Punto 3
UPDATE municipio2 SET municipio2.poblacion2003 = municipio2.poblacion2003 / 2 WHERE municipio2.poblacion2003 > 1000 AND m_id > 0;

-- Punto 4
DROP TABLE IF EXISTS municipio_ca;
create table municipio_ca
(
	m_id integer(4),
	nom varchar(70),
	poblacion2003 integer(7),
	poblacion2001 integer(7),
	poblacion1996 integer(7),
	poblacion1991 integer(7),
	superficie DECIMAL(20,2),
	ca_id integer(2),

	PRIMARY KEY(m_id),
	CONSTRAINT fk_municipio_ca_comunidad
		FOREIGN KEY (ca_id)
		REFERENCES comunidad(ca_id)
);

INSERT INTO municipio_ca (m_id, nom, poblacion2003, poblacion2001, poblacion1996, poblacion1991, superficie, ca_id)
(
	SELECT m_id, municipio.nom, poblacion2003, poblacion2001, poblacion1996, poblacion1991, superficie, municipio.ca_id
    FROM municipio
    INNER JOIN comunidad ON municipio.ca_id = comunidad.ca_id
    WHERE comunidad.nom = 'Catalunya'
);

SELECT * FROM municipio_ca;

-- DELETE SECTION
-- Primero es necesario correr UPDATE

-- Punto 1
DELETE FROM municipio2 WHERE nom = 'Adra' AND m_id > 0;
SELECT m_id, nom FROM municipio2;

-- Punto 2
SELECT m_id, nom, poblacion2003 FROM municipio2 WHERE poblacion2003 = 0;
DELETE FROM municipio2 WHERE poblacion2003 = 0 AND m_id > 0;
SELECT m_id, nom, poblacion2003 FROM municipio2 WHERE poblacion2003 = 0;

-- SQL Derivate Data --

DROP TABLE IF EXISTS comunitat2;
CREATE TABLE comunitat2 LIKE comunidad;
INSERT INTO comunitat2 (SELECT * FROM comunidad);

-- a --
ALTER TABLE comunitat2 ADD COLUMN poblacion INT;

-- b --
ALTER TABLE comunitat2 ADD COLUMN superficie DECIMAL(10,2);

-- c --
UPDATE 
	comunitat2
    INNER JOIN (SELECT ca_id, SUM(poblacion2003) AS 'poblacion' FROM municipio GROUP BY ca_id) AS tab1 ON comunitat2.ca_id = tab1.ca_id
SET
	comunitat2.poblacion = tab1.poblacion
WHERE comunitat2.ca_id = tab1.ca_id;

-- d --
UPDATE 
	comunitat2
    INNER JOIN (SELECT ca_id, ROUND(SUM(superficie),2) AS 'superficie' FROM municipio GROUP BY ca_id) AS tab1 ON comunitat2.ca_id = tab1.ca_id
SET
	comunitat2.superficie = tab1.superficie
WHERE comunitat2.ca_id = tab1.ca_id;

