SELECT personName, gender, dob,
	CASE
		WHEN gender = "male" THEN
				CASE WHEN dob >= '2005-01-01' THEN 'YoungMale'
					 WHEN dob >= '1985-01-01' THEN 'AdultMale'
                     WHEN dob >= '1970-01-01' THEN 'MidAgeMale'
                     WHEN dob < '1970-01-01' THEN 'ElderMale'
				END
		WHEN gender = "female" THEN
				CASE WHEN dob >= '2005-01-01' THEN 'YoungFemale'
					 WHEN dob >= '1985-01-01' THEN 'AdultFemale'
                     WHEN dob >= '1970-01-01' THEN 'MidAgeFemale'
                     WHEN dob < '1970-01-01' THEN 'ElderFemale'
				END
	END AS category
FROM person p
JOIN patient pt ON p.personID = pt.patientID;
