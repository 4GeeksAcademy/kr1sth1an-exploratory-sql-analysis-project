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
SELECT
  region_id,
  COUNT(*) AS total_obs
FROM observations
GROUP BY region_id
ORDER BY total_obs DESC, region_id ASC
LIMIT 1;


-- MISSION 7
-- 7. ¿Cuáles son los 5 species_id más frecuentes?;
SELECT
  species_id,
  COUNT(*) AS total_obs
FROM observations
GROUP BY species_id
ORDER BY total_obs DESC
LIMIT 5;


-- MISSION 8
-- 8. ¿Qué especies (species_id) tienen menos de 5 registros?;
SELECT
  species_id,
  COUNT(*) AS total_obs
FROM observations
GROUP BY species_id
HAVING COUNT(*) < 5
ORDER BY total_obs ASC, species_id ASC;

-- MISSION 9
-- 9. ¿Qué observadores (observer) registraron más observaciones?;
SELECT
  observer,
  COUNT(*) AS total_obs
FROM observations
GROUP BY observer
ORDER BY total_obs DESC
LIMIT 10;

