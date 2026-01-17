
DROP TABLE IF EXISTS air_quality_measurements;
DROP TABLE IF EXISTS pollutants;
DROP TABLE IF EXISTS locations;



CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    latitude FLOAT,
    longitude FLOAT,
    CONSTRAINT unique_location UNIQUE (city, country)
);



CREATE TABLE pollutants (
    pollutant_id SERIAL PRIMARY KEY,
    parameter TEXT NOT NULL UNIQUE,
    unit TEXT
);



CREATE TABLE air_quality_measurements (
    measurement_id SERIAL PRIMARY KEY,
    location_id INT NOT NULL REFERENCES locations(location_id),
    pollutant_id INT NOT NULL REFERENCES pollutants(pollutant_id),
    measurement_time TIMESTAMP NOT NULL,
    value FLOAT NOT NULL
);



CREATE INDEX idx_measurements_time
    ON air_quality_measurements(measurement_time);

CREATE INDEX idx_measurements_location
    ON air_quality_measurements(location_id);

CREATE INDEX idx_measurements_pollutant
    ON air_quality_measurements(pollutant_id);




INSERT INTO locations (city, country, latitude, longitude)
VALUES ('Dijon', 'FR', 47.3220, 5.0415)
ON CONFLICT DO NOTHING;


INSERT INTO pollutants (parameter, unit) VALUES
('PM10',  'µg/m³'),
('PM2.5', 'µg/m³'),
('NO2',   'µg/m³'),
('O3',    'µg/m³'),
('CO',    'µg/m³')
ON CONFLICT DO NOTHING;
