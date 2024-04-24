USE municipios;

-- Punto 1 --
SELECT comunidad.nom, COUNT(comunidad.nom) FROM comunidad INNER JOIN municipio ON comunidad.ca_id = municipio.ca_id GROUP BY comunidad.nom HAVING COUNT(comunidad.nom) > 1000;

-- Punto 2 --
SELECT comunidad.nom, AVG(municipio.superficie) FROM comunidad INNER JOIN municipio ON comunidad.ca_id = municipio.ca_id GROUP BY comunidad.nom HAVING COUNT(comunidad.nom) >= 500 AND COUNT(comunidad.nom) <= 1000;

-- Punto 3 --
SELECT comunidad.nom, SUM(municipio.poblacion2003) / SUM(municipio.superficie) AS densidad FROM comunidad INNER JOIN municipio ON comunidad.ca_id = municipio.ca_id GROUP BY comunidad.nom HAVING SUM(municipio.poblacion2003) / SUM(municipio.superficie) > 1000;