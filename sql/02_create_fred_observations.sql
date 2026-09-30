-- Bronze contract for FRED observations (guide Step 1.3).
-- Grain: one row per series per observation date.
-- Natural key: (series_id, observation_date).
-- raw_value keeps the source text ("." on holidays); source_value is the parsed DOUBLE.
-- available_at and vintage_date are NULL at load; populated in Phase 5.
USE CATALOG workspace;
CREATE OR REPLACE TABLE bronze.fred_observations (
    series_id        STRING,
    observation_date DATE,
    raw_value        STRING,
    source_value     DOUBLE,
    ingestion_ts     TIMESTAMP,
    available_at     TIMESTAMP,
    vintage_date     DATE,
    source_url       STRING
);
