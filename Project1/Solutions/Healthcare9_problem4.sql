SELECT ph.pharmacyName, d.diseaseName, count(*) as count
FROM treatment t
LEFT JOIN prescription p USING (treatmentID)
LEFT JOIN pharmacy ph USING (pharmacyID)
LEFT JOIN disease d USING (diseaseID)
WHERE t.date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY ph.pharmacyName, d.diseaseName WITH ROLLUP
ORDER BY ph.pharmacyName, count DESC;