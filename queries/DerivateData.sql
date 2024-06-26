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
WHERE comunitat2.ca_id = tab1.ca_id AND comunitat2.ca_id > 0 AND tab1.ca_id > 0;

-- d --
UPDATE 
	comunitat2
    INNER JOIN (SELECT ca_id, ROUND(SUM(superficie),2) AS 'superficie' FROM municipio GROUP BY ca_id) AS tab1 ON comunitat2.ca_id = tab1.ca_id
SET
	comunitat2.superficie = tab1.superficie
WHERE comunitat2.ca_id = tab1.ca_id AND comunitat2.ca_id > 0 AND tab1.ca_id > 0;