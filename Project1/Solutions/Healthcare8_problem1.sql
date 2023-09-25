SELECT
    TIMESTAMPDIFF(YEAR, dob, NOW()) AS age,
    COUNT(*) AS numTreatments
FROM person pr
JOIN patient p ON p.patientID = pr.personID
JOIN treatment t ON t.patientID = p.patientID
GROUP BY age
ORDER BY numTreatments DESC;
