
SELECT
    l.city,
    DATE(aqm.measurement_time) AS day,
    p.parameter,
    AVG(aqm.value) AS avg_value
FROM air_quality_measurements aqm
JOIN locations l
    ON aqm.location_id = l.location_id
JOIN pollutants p
    ON aqm.pollutant_id = p.pollutant_id
GROUP BY
    l.city,
    day,
    p.parameter
ORDER BY
    day,
    p.parameter;



SELECT
    l.city,
    DATE_TRUNC('month', aqm.measurement_time) AS month,
    p.parameter,
    AVG(aqm.value) AS avg_pollution
FROM air_quality_measurements aqm
JOIN locations l
    ON aqm.location_id = l.location_id
JOIN pollutants p
    ON aqm.pollutant_id = p.pollutant_id
GROUP BY
    l.city,
    month,
    p.parameter
ORDER BY
    month,
    p.parameter;


SELECT
    l.city,
    p.parameter,
    MAX(aqm.value) AS max_value
FROM air_quality_measurements aqm
JOIN locations l
    ON aqm.location_id = l.location_id
JOIN pollutants p
    ON aqm.pollutant_id = p.pollutant_id
GROUP BY
    l.city,
    p.parameter
ORDER BY
    max_value DESC;



SELECT
    aqm.measurement_time,
    p.parameter,
    aqm.value
FROM air_quality_measurements aqm
JOIN pollutants p
    ON aqm.pollutant_id = p.pollutant_id
ORDER BY
    aqm.measurement_time;


SELECT
    p.parameter,
    COUNT(*) AS total_measurements
FROM air_quality_measurements aqm
JOIN pollutants p
    ON aqm.pollutant_id = p.pollutant_id
GROUP BY
    p.parameter
ORDER BY
    total_measurements DESC;
