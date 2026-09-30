"""Pull FRED series observations to a local CSV for Bronze loading (guide Step 1.2)."""
import csv
import datetime as dt
import os
import requests
from dotenv import load_dotenv

load_dotenv()
API_KEY = os.environ["FRED_API_KEY"]  # match the variable name in .env

SERIES = [
    "DGS3MO", "DGS2", "DGS5", "DGS10", "DGS30", "SOFR",
    "DEXUSEU", "DEXUSUK", "DEXJPUS", "ECBDFR",
    "DCOILWTICO", "DHHNGSP",
]
START_DATE = "2015-01-01"
OUT_PATH = "data/fred_observations.csv"


def ingest_fred(series_id, start_date):
    """Return raw observation rows for one series, with ingestion metadata appended."""
    url = "https://api.stlouisfed.org/fred/series/observations"
    params = {
        "series_id": series_id,
        "api_key": API_KEY,
        "file_type": "json",
        "observation_start": start_date,
    }
    resp = requests.get(url, params=params, timeout=30)
    resp.raise_for_status()
    ingestion_ts = dt.datetime.now(dt.timezone.utc).isoformat()
    rows = []
    for obs in resp.json()["observations"]:
        rows.append({
            "series_id": series_id,
            "observation_date": obs["date"],
            "raw_value": obs["value"],          # kept as-is; "." means missing
            "ingestion_ts": ingestion_ts,
            "source_url": f"https://fred.stlouisfed.org/series/{series_id}",
        })
    return rows


if __name__ == "__main__":
    all_rows = []
    for s in SERIES:
        rows = ingest_fred(s, START_DATE)
        print(f"{s}: {len(rows)} rows")
        all_rows.extend(rows)
    with open(OUT_PATH, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=list(all_rows[0].keys()))
        writer.writeheader()
        writer.writerows(all_rows)
    print(f"total: {len(all_rows)} rows -> {OUT_PATH}")
