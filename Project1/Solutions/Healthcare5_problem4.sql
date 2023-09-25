SELECT ph.pharmacyName, d.diseaseName,
	SUM(CASE WHEN t.date BETWEEN '2021-01-01' AND '2021-12-01' THEN 1 END) AS count_2021,
    SUM(CASE WHEN t.date BETWEEN '2022-01-01' AND '2022-12-01' THEN 1 END) AS count_2022
FROM treatment t
JOIN disease d USING (diseaseID)
JOIN prescription pr USING (treatmentID)
JOIN pharmacy ph USING (pharmacyID)
WHERE t.date BETWEEN '2021-01-01' AND '2022-12-01'
GROUP BY ph.pharmacyName, d.diseaseName
ORDER BY ph.pharmacyName, count_2021 DESC, count_2022 DESC;