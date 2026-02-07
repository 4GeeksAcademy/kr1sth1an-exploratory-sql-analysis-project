SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1
-- 1. ¿Cuáles son las primeras 10 observaciones registradas?;
SELECT *
FROM observations
ORDER BY id
LIMIT 10;


-- MISSION 2
-- 2. ¿Qué identificadores de región (region_id) aparecen en los datos?;
SELECT DISTINCT region_id
FROM observations
ORDER BY region_id;


-- MISSION 3
-- 3. ¿Cuántas especies distintas (species_id) se han observado?;
SELECT COUNT(DISTINCT species_id) AS especies_distintas
FROM observations;


-- MISSION 4
-- 4. ¿Cuántas observaciones hay para la región con region_id = 2?;
SELECT COUNT(*) AS observaciones_region_2
FROM observations
WHERE region_id = 2;


-- MISSION 5
-- 5. ¿Cuántas observaciones se registraron el día 1998-08-08?;
SELECT COUNT(*) AS observaciones_1998_08_08
FROM observations
WHERE observation_date = '1998-08-08';


-- MISSION 6
-- 6. ¿Cuál es el region_id con más observaciones?;
SELECT region_id, COUNT(*) AS total_observaciones
FROM observations
GROUP BY region_id
ORDER BY total_observaciones DESC
LIMIT 1;


-- MISSION 7
-- 7. ¿Cuáles son los 5 species_id más frecuentes?;
SELECT species_id, COUNT(*) AS mas_frecuentes
FROM observations
GROUP BY species_id
ORDER BY mas_frecuentes DESC
LIMIT 5;


-- MISSION 8
-- 8. ¿Qué especies (species_id) tienen menos de 5 registros?;
SELECT species_id, COUNT(*) AS menos_registros
FROM observations
GROUP BY species_id
HAVING COUNT(*) < 5
ORDER BY menos_registros ASC, species_id ASC;


-- MISSION 9
-- 9. ¿Qué observadores (observer) registraron más observaciones?;
SELECT observer, COUNT(*) AS mas_observaciones
FROM observations
GROUP BY observer
ORDER BY mas_observaciones DESC
LIMIT 10;


-- MISSION 10
-- 10. Muestra el nombre de la región (regions.name) para cada observación;
SELECT obs.id, obs.observation_date, obs.observer, obs.region_id, reg.name AS region_name
FROM observations AS obs JOIN regions AS reg 
ON reg.id = obs.region_id
ORDER BY obs.id LIMIT 10;


-- MISSION 11
-- 11. Muestra el nombre científico de cada especie registrada (species.scientific_name);
SELECT obs.id, obs.observation_date, obs.observer, obs.species_id, sp.scientific_name, sp.common_name
FROM observations AS obs JOIN species AS sp ON sp.id = obs.species_id
ORDER BY obs.id LIMIT 10;


-- MISSION 12
-- 12. ¿Cuál es la especie más observada por cada región?;
WITH conteos AS (
  SELECT obs.region_id, obs.species_id, COUNT(*) AS total_obs
  FROM observations AS obs
  GROUP BY obs.region_id, obs.species_id),
max_por_region AS (
  SELECT region_id, MAX(total_obs) AS max_obs
  FROM conteos
  GROUP BY region_id)
SELECT reg.name AS region_name, sp.scientific_name, sp.common_name, c.total_obs
FROM conteos AS c
JOIN max_por_region AS m ON m.region_id = c.region_id AND m.max_obs = c.total_obs
JOIN regions AS reg ON reg.id = c.region_id
JOIN species AS sp ON sp.id = c.species_id
ORDER BY reg.name;

"He pensado mucho la forma de abordar esta pregunta y vi que en muchas regiones se observan 
varias especies con la misma cantidad de observaciones, por lo que decidi mostrar todas las 
especies que tengan el mismo numero maximo de observaciones por region y las he ordenado 
alfabeticamente por region."