USE project1;

--Problem Statement 1:  Some complaints have been lodged by patients that they have been prescribed hospital-exclusive medicine that they can’t find elsewhere and facing problems due to that. Joshua, from the pharmacy management, wants to get a report of which pharmacies have prescribed hospital-exclusive medicines the most in the years 2021 and 2022. Assist Joshua to generate the report so that the pharmacies who prescribe hospital-exclusive medicine more often are advised to avoid such practice if possible.   

select ph.pharmacyName, count(m.hospitalExclusive) as no_of_hospital_exclusive
from Medicine as m
join Contain as c on m.medicineID=c.medicineID
join Prescription as pr on c.prescriptionID=pr.prescriptionID
join Pharmacy as ph on pr.pharmacyID=ph.pharmacyID
join Treatment as t on pr.treatmentID=t.treatmentID
where m.hospitalExclusive='S' and t.date between '2021-01-01' and '2022-12-31'
group by ph.pharmacyName
order by no_of_hospital_exclusive desc;


--Problem Statement 2: Insurance companies want to assess the performance of their insurance plans. Generate a report that shows each insurance plan, the company that issues the plan, and the number of treatments the plan was claimed for.

select ip.planName, ic.companyName, count(t.diseaseID) as claim_count
from InsuranceCompany as ic 
join InsurancePlan as ip on ic.companyID=ip.companyID
join Claim as c on ip.uin=c.uin
join Treatment as t on c.claimID=t.claimID
group by ip.planName, ic.companyName
order by ic.companyName desc


--Problem Statement 3: Insurance companies want to assess the performance of their insurance plans. Generate a report that shows each insurance company's name with their most and least claimed insurance plans.

select distinct ic.companyName,
concat(first_value(ip.planName) over(partition by ic.companyName order by count(t.diseaseID)), '(', num.min_c, ')') as least_claimed,
concat(last_value(ip.planName) over(partition by ic.companyName order by count(t.diseaseID) range between unbounded preceding and unbounded following), '(', num.max_c, ')') as most_claimed
from InsuranceCompany as ic 
join InsurancePlan as ip on ic.companyID=ip.companyID
join Claim as c on ip.uin=c.uin
join Treatment as t on c.claimID=t.claimID
join (select sub.companyName, min(sub.claim_count) as min_c, max(sub.claim_count) as max_c
	from
	(
	select ip.planName, ic.companyName, count(t.diseaseID) as claim_count
	from InsuranceCompany as ic 
	join InsurancePlan as ip on ic.companyID=ip.companyID
	join Claim as c on ip.uin=c.uin
	join Treatment as t on c.claimID=t.claimID
	group by ip.planName, ic.companyName
	) as sub
	group by sub.companyName
	) as num on num.companyName=ic.companyName
group by ip.planName, ic.companyName, num.max_c, num.min_c
order by ic.companyName


--Problem Statement 4:  The healthcare department wants a state-wise health report to assess which state requires more attention in the healthcare sector. Generate a report for them that shows the state name, number of registered people in the state, number of registered patients in the state, and the people-to-patient ratio. sort the data by people-to-patient ratio. 

select a.state, 
count(p.personID) as no_of_peoples, 
count(pa.patientID) as no_of_patient,
(count(p.personID)*1.0/count(pa.patientID)) as ratio
from Address as a 
join Person as p on a.addressID=p.addressID
left join Patient as pa on p.personID=pa.patientID
group by a.state
order by ratio desc

--Problem Statement 5:  Jhonny, from the finance department of Arizona(AZ), has requested a report that lists the total quantity of medicine each pharmacy in his state has prescribed that falls under Tax criteria I for treatments that took place in 2021. Assist Jhonny in generating the report. 

select ph.pharmacyName, sum(c.quantity) as cont
from Treatment as t
join Prescription as p on t.treatmentID=p.treatmentID
join Contain as c on p.prescriptionID=c.prescriptionID
join Medicine as m on c.medicineID=m.medicineID
join Pharmacy as ph on p.pharmacyID=ph.pharmacyID
join Address as a on ph.addressID=a.addressID
where a.state='AZ' and t.date between '2021-01-01' and '2021-12-31' and m.taxCriteria='I'
group by ph.pharmacyName



select * from Medicine













