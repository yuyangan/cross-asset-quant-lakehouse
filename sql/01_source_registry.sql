USE CATALOG workspace;
CREATE OR REPLACE TABLE bronze.source_registry (
    source_id string,
    provider string, 
    series_id string, 
    frequency string, 
    units string, 
    quote_convention string, 
    publication_lag_days string, 
    url string
);

Insert into bronze.source_registry values
('FRED_DGS3MO','Board of Governors of the Federal Reserve System (US)','DGS3MO','daily','percent','na','1','https://fred.stlouisfed.org/series/DGS3MO'),
('FRED_DGS2','Board of Governors of the Federal Reserve System (US)','DGS2','daily','percent','na','1','https://fred.stlouisfed.org/series/DGS2'),
('FRED_DGS5','Board of Governors of the Federal Reserve System (US)','DGS5','daily','percent','na','1','https://fred.stlouisfed.org/series/DGS5'),
('FRED_DGS10','Board of Governors of the Federal Reserve System (US)','DGS10','daily','percent','na','1','https://fred.stlouisfed.org/series/DGS10'),
('FRED_DGS30','Board of Governors of the Federal Reserve System (US)','DGS30','daily','percent','na','1','https://fred.stlouisfed.org/series/DGS30'),
('FRED_SOFR','Federal Reserve Bank of New York','SOFR','daily','percent','na','1','https://fred.stlouisfed.org/series/SOFR'),
('FRED_DEXUSEU','Board of Governors of the Federal Reserve System (US)','DEXUSEU','daily','U.S. Dollars to One Euro','na','weekly release','https://fred.stlouisfed.org/series/DEXUSEU'),
('FRED_DEXUSUK','Board of Governors of the Federal Reserve System (US)','DEXUSUK','daily','U.S. Dollars to One Pound','na','weekly release','https://fred.stlouisfed.org/series/DEXUSUK'),
('FRED_DEXJPUS','Board of Governors of the Federal Reserve System (US)','DEXJPUS','daily','Japanese Yen to One U.S. Dollar','na','weekly release','https://fred.stlouisfed.org/series/DEXJPUS'),
('FRED_ECBDFR','European Central Bank','ECBDFR','daily, 7-day','percent','na','0','https://fred.stlouisfed.org/series/ECBDFR'),
('FRED_DCOILWTICO','U.S. Energy Information Administration','DCOILWTICO','daily','Dollars per Barrel','na','1','https://fred.stlouisfed.org/series/DCOILWTICO'),
('FRED_DHHNGSP','U.S. Energy Information Administration','DHHNGSP','daily','Dollars per Million BTU','na','1','https://fred.stlouisfed.org/series/DHHNGSP');

SELECT COUNT(*) AS n_rows,
       COUNT(DISTINCT source_id) AS n_unique,
       SUM(CASE WHEN units IS NULL OR publication_lag_days IS NULL THEN 1 ELSE 0 END) AS n_missing_meta,
       SUM(CASE WHEN series_id LIKE 'DEX%' AND quote_convention = 'na' THEN 1 ELSE 0 END) AS n_fx_without_quote
FROM bronze.source_registry;
