SELECT d.diseaseName, COUNT(*) as claims_count
FROM disease d
JOIN treatment t USING (diseaseID)
JOIN claim c USING (claimID)
WHERE d.diseaseName LIKE '%p%'
GROUP BY d.diseaseName;