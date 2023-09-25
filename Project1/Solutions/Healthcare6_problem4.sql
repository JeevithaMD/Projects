SELECT a.city, 
	COUNT(pr.personid) as persons, 
    count(p.patientid) as patients,
    round(count(p.patientid)*100/count(pr.personid),2) as percentage_of_patients
FROM person pr
left join patient p on pr.personid = p.patientid
join address a  using(addressid)
group by a.city
order by 
percentage_of_patients desc;