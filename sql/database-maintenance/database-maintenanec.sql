-- Return the table size, individual index sizes and total size of all relations
SELECT
  pg_size_pretty(pg_table_size('sensors.observations')) AS tbl_size, 
  pg_size_pretty(pg_total_relation_size('sensors.observations_pkey')) AS observations_pkey_idx_size,
  pg_size_pretty(pg_total_relation_size('sensors.observations_location_id_datetime_idx')) AS observations_location_id_datetime_idx_size,
  pg_size_pretty(pg_total_relation_size('sensors.observations')) AS total_size;

-- Implement a large UPDATE on the table. Convert distance to feet
UPDATE sensors.observations
SET distance = (distance * 3.281)
WHERE TRUE;

-- Check the table and index sizes again after updates-- Return the table size, individual index sizes and total size of all relations
SELECT pg_size_pretty(pg_table_size('sensors.observations')) AS tbl_size, 
  pg_size_pretty(pg_total_relation_size('sensors.observations_pkey')) AS observations_pkey_idx_size,
  pg_size_pretty(pg_total_relation_size('sensors.observations_location_id_datetime_idx')) AS observations_location_id_datetime_idx_size,
  pg_size_pretty(pg_total_relation_size('sensors.observations')) AS total_size;
-- The size has almost doubled

-- Run a VACUUM on the table and check it's size
VACUUM sensors.observations;

SELECT pg_size_pretty(pg_table_size('sensors.observations')) as total_size; -- Table size was reduced to 2352kB from 4576kB




-- Add new observation data for dogs, motorbikes and trucks
\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './additional_obs_types.csv' WITH DELIMITER ',' CSV HEADER;

-- Check the table size again
SELECT pg_size_pretty(pg_table_size('sensors.observations')) as total_size; -- The size is the same as before the data was added


-- Run a VAUUM FULL to return any excess space the table is consuming and compare the size
VACUUM FULL sensors.observations;

SELECT pg_size_pretty(pg_table_size('sensors.observations')) as total_size; -- The table size was reduced from 2352kB to 1272kB


-- Remove data from certain sensors
DELETE FROM sensors.observations
WHERE location_id > 24;

-- Check the table size again
SELECT pg_size_pretty(pg_table_size('sensors.observations')) as total_size; -- (size remains at 1272kB)


-- TRUNCATE the table to clear the deleted values
TRUNCATE sensors.observations;

-- Check the table size again
SELECT pg_size_pretty(pg_table_size('sensors.observations')) as total_size; -- (size reducecd to 8192 bytes)
