import pandas as pd

df = pd.read_csv("data_raw.csv")

# -----------------------
# 1. Basic structure
# -----------------------

expected_columns = [
    "timestamp",
    "pm10",
    "pm2_5",
    "no2",
    "o3",
    "co"
]

for col in expected_columns:
    assert col in df.columns, f"Missing column: {col}"

# -----------------------
# 2. Timestamp validation
# -----------------------

df["timestamp"] = pd.to_datetime(df["timestamp"], errors="coerce")
assert df["timestamp"].notnull().all()

# -----------------------
# 3. Numeric validation
# -----------------------

pollutants = ["pm10", "pm2_5", "no2", "o3", "co"]

for p in pollutants:
    assert df[p].dropna().ge(0).all(), f"Negative values in {p}"

# -----------------------
# 4. Remove fully empty rows
# -----------------------

df = df.dropna(how="all")

# -----------------------
# 5. Save validated data
# -----------------------

df.to_csv("data_validated.csv", index=False)

print("Validation successful")
print("Rows:", len(df))
