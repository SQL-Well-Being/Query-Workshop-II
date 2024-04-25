USE municipios;
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