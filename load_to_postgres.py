import pandas as pd
from sqlalchemy import create_engine, text


engine = create_engine(
    "postgresql://air:air@localhost:5432/airquality"
)


df = pd.read_csv("data_transformed.csv")

with engine.begin() as conn:

    
    location_id = conn.execute(
        text("""
            SELECT location_id
            FROM locations
            WHERE city = 'Dijon' AND country = 'FR'
        """)
    ).scalar()

    
    pollutants = conn.execute(
        text("""
            SELECT pollutant_id, parameter
            FROM pollutants
        """)
    ).fetchall()

    pollutant_map = {p.parameter: p.pollutant_id for p in pollutants}

    
    df["location_id"] = location_id
    df["pollutant_id"] = df["parameter"].map(pollutant_map)

   
    df = df[
        ["location_id", "pollutant_id", "timestamp", "value"]
    ]

    df.columns = [
        "location_id",
        "pollutant_id",
        "measurement_time",
        "value"
    ]

    
    df.to_sql(
        "air_quality_measurements",
        conn,
        if_exists="append",
        index=False
    )

print(" Data loaded uwu")
