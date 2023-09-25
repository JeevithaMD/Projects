SELECT state, COUNT(*) AS total_treatments,
	SUM(CASE WHEN claimID IS NULL THEN 1 END) AS no_claim_treatments,
    ROUND((SUM(CASE WHEN claimID IS NULL THEN 1 END)/COUNT(*))*100,2) as percentage_of_noClaim
FROM treatment
JOIN patient p USING (patientID)
JOIN person pr ON p.patientID = pr.personID
JOIN address USING (addressID)
GROUP BY state
