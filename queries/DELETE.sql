USE municipios;
-- DELETE SECTION
-- Primero es necesario correr UPDATE

-- Punto 1
DELETE FROM municipio2 WHERE nom = 'Adra' AND m_id > 0;
SELECT m_id, nom FROM municipio2;

-- Punto 2
SELECT m_id, nom, poblacion2003 FROM municipio2 WHERE poblacion2003 = 0;
DELETE FROM municipio2 WHERE poblacion2003 = 0 AND m_id > 0;
SELECT m_id, nom, poblacion2003 FROM municipio2 WHERE poblacion2003 = 0;
