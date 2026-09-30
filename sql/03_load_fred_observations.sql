-- Load FRED observations from the uploaded CSV into Bronze (guide Step 1.2).
USE CATALOG workspace;
CREATE VOLUME IF NOT EXISTS bronze.raw_files;

COPY INTO bronze.fred_observations
FROM (
  SELECT
    series_id,
    try_cast(observation_date as date) as observation_date,
    raw_value,
    try_cast(raw_value as double) as source_value,
    try_cast(ingestion_ts as timestamp) as ingestion_ts,
    CAST(NULL AS timestamp) AS available_at,
    CAST(NULL AS DATE)      AS vintage_date,
    source_url
  FROM '/Volumes/workspace/bronze/raw_files/fred_observations.csv'
)
FILEFORMAT = CSV
FORMAT_OPTIONS ('header' = 'true');

-- Verification
SELECT
  COUNT(*)                                          AS n_rows,
  COUNT(DISTINCT series_id)                         AS n_series,
  COUNT(DISTINCT series_id, observation_date)       AS n_unique_keys,
  SUM(CASE WHEN observation_date IS NULL THEN 1 ELSE 0 END) AS n_bad_dates,
  SUM(CASE WHEN source_value IS NULL THEN 1 ELSE 0 END)     AS n_null_values,
  MIN(observation_date) AS min_date,
  MAX(observation_date) AS max_date
FROM bronze.fred_observations;
