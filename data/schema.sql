-- ============================================
-- Air Quality Data Warehouse Schema
-- Star Schema (Fact + Dimensions)
-- ============================================

-- Drop tables in correct order
DROP TABLE IF EXISTS air_quality_measurements;
DROP TABLE IF EXISTS pollutants;
DROP TABLE IF EXISTS locations;

-- ============================================
-- Dimension: Locations
-- ============================================

CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    latitude FLOAT,
    longitude FLOAT,
    CONSTRAINT unique_location UNIQUE (city, country)
);

-- ============================================
-- Dimension: Pollutants
-- ============================================

CREATE TABLE pollutants (
    pollutant_id SERIAL PRIMARY KEY,
    parameter TEXT NOT NULL UNIQUE,
    unit TEXT
);

-- ============================================
-- Fact table: Measurements
-- ============================================

CREATE TABLE air_quality_measurements (
    measurement_id SERIAL PRIMARY KEY,
    location_id INT NOT NULL REFERENCES locations(location_id),
    pollutant_id INT NOT NULL REFERENCES pollutants(pollutant_id),
    measurement_time TIMESTAMP NOT NULL,
    value FLOAT NOT NULL
);

-- ============================================
-- Indexes for analytics performance
-- ============================================

CREATE INDEX idx_measurements_time
    ON air_quality_measurements(measurement_time);

CREATE INDEX idx_measurements_location
    ON air_quality_measurements(location_id);

CREATE INDEX idx_measurements_pollutant
    ON air_quality_measurements(pollutant_id);

-- ============================================
-- Initial dimension data
-- ============================================

-- Location: Dijon
INSERT INTO locations (city, country, latitude, longitude)
VALUES ('Dijon', 'FR', 47.3220, 5.0415)
ON CONFLICT DO NOTHING;

-- Pollutants
INSERT INTO pollutants (parameter, unit) VALUES
('PM10',  'µg/m³'),
('PM2.5', 'µg/m³'),
('NO2',   'µg/m³'),
('O3',    'µg/m³'),
('CO',    'µg/m³')
ON CONFLICT DO NOTHING;
