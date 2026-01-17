import requests
import pandas as pd

url = "https://air-quality-api.open-meteo.com/v1/air-quality"

params = {
    "latitude": 47.3220,
    "longitude": 5.0415,
    "hourly": [
        "pm10",
        "pm2_5",
        "nitrogen_dioxide",
        "ozone",
        "carbon_monoxide"
    ],
    "start_date": "2024-01-01",
    "end_date": "2024-12-31",
    "timezone": "Europe/Paris"
}

response = requests.get(url, params=params)
response.raise_for_status()

data = response.json()

df = pd.DataFrame({
    "timestamp": data["hourly"]["time"],
    "pm10": data["hourly"]["pm10"],
    "pm2_5": data["hourly"]["pm2_5"],
    "no2": data["hourly"]["nitrogen_dioxide"],
    "o3": data["hourly"]["ozone"],
    "co": data["hourly"]["carbon_monoxide"]
})

df.to_csv("data_raw.csv", index=False)

print("Rows collected:", len(df))
