SELECT a.state, d.diseaseName, count(*) as count
FROM treatment t
LEFT JOIN disease d USING (diseaseID)
LEFT JOIN person p ON t.patientID = p.personID
LEFT JOIN address a USING (addressID)
WHERE t.date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY a.state, d.diseaseName WITH ROLLUP
ORDER BY a.state,count DESC;
