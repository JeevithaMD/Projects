SELECT p.personName AS patient_name, timestampdiff(YEAR,pt.dob,CURDATE()) AS age, count(*) AS no_of_treatments
FROM treatment t
JOIN person p ON t.patientID = p.personID
JOIN patient pt USING (patientID)
GROUP BY p.personID;


