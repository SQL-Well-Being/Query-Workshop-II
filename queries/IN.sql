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
	(SELECT ca_id, nom FROM municipio
	WHERE LOWER(nom) LIKE '%x') AS tab1
    INNER JOIN comunidad ON tab1.ca_id = comunidad.ca_id;