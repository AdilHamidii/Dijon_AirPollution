import pandas as pd

df = pd.read_csv("data_validated.csv")


df_long = df.melt(
    id_vars=["timestamp"],
    value_vars=["pm10", "pm2_5", "no2", "o3", "co"],
    var_name="parameter",
    value_name="value"
)

mapping = {
    "pm10": "PM10",
    "pm2_5": "PM2.5",
    "no2": "NO2",
    "o3": "O3",
    "co": "CO"
}

df_long["parameter"] = df_long["parameter"].map(mapping)



df_long["city"] = "Dijon"
df_long["country"] = "FR"
df_long["latitude"] = 47.3220
df_long["longitude"] = 5.0415

df_long["timestamp"] = pd.to_datetime(df_long["timestamp"])


df_long = df_long[
    [
        "timestamp",
        "city",
        "country",
        "latitude",
        "longitude",
        "parameter",
        "value"
    ]
]

df_long.to_csv("data_transformed.csv", index=False)

print("Transformation completed")
print("Rows:", len(df_long))
