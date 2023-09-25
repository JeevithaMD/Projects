USE healthcare;

SELECT pr.gender,
SUM(CASE WHEN t.treatmentID IS NOT NULL THEN 1 END) / SUM(CASE WHEN t.claimID IS NOT NULL THEN 1 END) as treatment_to_claim_ratio
FROM treatment t
JOIN patient p USING (patientID)
JOIN person pr ON p.patientID = pr.personID
GROUP BY pr.gender;