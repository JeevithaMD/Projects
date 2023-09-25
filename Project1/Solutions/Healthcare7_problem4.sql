WITH patient_category AS(
	SELECT patientid,
	CASE 
		WHEN p.dob >= '2005-01-01' AND pr.gender = "male" THEN "YoungMale"
		WHEN p.dob >= '2005-01-01' AND pr.gender = "female" THEN "YoungFemale"
		WHEN p.dob >= '1985-01-01' AND pr.gender = "male" THEN "AdultMale"
		WHEN p.dob >= '1985-01-01' AND pr.gender = "female" THEN "Adultfemale"
		WHEN p.dob >= '1970-01-01' AND pr.gender = "male" THEN "MidAgeMale"
		WHEN p.dob >= '1970-01-01' AND pr.gender = "female" THEN "MidAgeFemale"
		WHEN pr.gender = "male" THEN "ElderMale"
		WHEN pr.gender = "female" THEN "ElderFemale"
	END AS patient_category
	FROM patient p 
	JOIN person pr ON p.patientID = pr.personID
),
patients_labeled AS (
	select d.diseasename,pc.patient_category,count(*) as patient_count,
	rank() over(partition by d.diseaseName order by count(*) desc) as categoryrank
	from disease d 
	join treatment t using(diseaseid)
	join patient_category pc using(patientid)
	group by d.diseaseName,pc.patient_category
)
select diseasename,patient_category,patient_count
from patients_labeled;