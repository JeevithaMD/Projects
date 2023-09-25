-- 1. 

use healthcare;

DELIMITER //
create procedure insurancePlanPerformance(IN companyName varchar(100))
BEGIN
	select IP.planName, count(t.treatmentID) as treatmentCount,
	(select D.diseaseName
	from disease D join treatment T on T.diseaseID=D.diseaseID
	join claim C on C.claimID=T.claimID
	where IP.uin = C.uin
	group by IP.uin, D.diseaseName
	ORDER BY COUNT(*) DESC
	LIMIT 1) as mostClaimedDisease
	from insurancecompany IC left join insuranceplan IP
	on  IC.companyID=IP.companyID
	left join claim C on C.uin=IP.uin
	left join treatment t on C.claimID=t.claimID
	where IC.companyName = companyName
	group by IP.planName, IP.uin
	order by treatmentCount desc;
END
//
DELIMITER ;

CALL insurancePlanPerformance("Aditya Birla Health Insurance Co. Ltd");
CALL insurancePlanPerformance("Bajaj Allianz General Insurance Co. Ltd.�");
CALL insurancePlanPerformance("United India Insurance Co.Ltd.");
CALL insurancePlanPerformance("SBI General Insurance Co.Ltd.");
CALL insurancePlanPerformance("Future Generali India Insurance Company Limited.���");


-- 2.
use healthcare;

DELIMITER //
create procedure topPhrmacy(IN disease_name varchar(100))
BEGIN
	(select pharmacyName from (select ph.pharmacyName as pharmacyName, count(t.patientID) as patientCount, 
	rank() over (order by count(t.patientID) desc) as top_rank
	from pharmacy ph join prescription pr on ph.pharmacyID=pr.pharmacyID
	join treatment t on pr.treatmentID=t.treatmentID
	join disease d on t.diseaseID=d.diseaseID
	where d.diseaseName = disease_name and YEAR(t.date) = 2021
	group by ph.pharmacyName
	order by count(t.patientID) desc) as q1 where top_rank<=3
	UNION ALL
	select pharmacyName from (select ph.pharmacyName as pharmacyName, count(t.patientID) as patientCount, 
	rank() over (order by count(t.patientID) desc) as top_rank
	from pharmacy ph join prescription pr on ph.pharmacyID=pr.pharmacyID
	join treatment t on pr.treatmentID=t.treatmentID
	join disease d on t.diseaseID=d.diseaseID
	where d.diseaseName = disease_name and YEAR(t.date) = 2022
	group by ph.pharmacyName
	order by count(t.patientID) desc) as q2 where top_rank<=3)
	order by pharmacyName;
END
//
DELIMITER ;

call topPhrmacy("Asthma");
call topPhrmacy("Psoriasis");

-- 3. 
use healthcare;

DELIMITER //
create procedure companySetup(IN req_state varchar(20))
BEGIN
	with patientcount as
	(select companyID, count(patientID) as totalPatients
	from claim join treatment using(claimID)
	join insuranceplan using(uin)
	join insurancecompany ic using(companyID)
	group by companyID),
	total_insurance_patience_ratio as
	(select companyID, (count(companyID)/sum(totalPatients)) as totalpatientcount
	from patientcount
	join insurancecompany ic using(companyID)
	join address using(addressID)
	group by(companyID))
	select count(companyID) as num_insurance_companies, sum(totalPatients) as num_patients, 
	(count(companyID)/sum(totalPatients)) as insurance_patient_ratio,
    (sum(totalpatientcount)/count(companyID)) as avg_insurance_patient_ratio,
	(CASE 
	WHEN (count(companyID)/sum(totalPatients))< (sum(totalpatientcount)/count(companyID)) THEN "RECOMMENDED"
	ELSE "NOT RECOMMENDED"
	END) as RECOMMENDATION
	from total_insurance_patience_ratio
	join patientcount using(companyID)
	join insurancecompany ic using(companyID)
	join address using(addressID)
	where state = req_state;
END
//
DELIMITER ;

select distinct state from address;
 
CALL companySetup("CA");
CALL companySetup("OK");
CALL companySetup("MA");
CALL companySetup("MD");  
CALL companySetup("AL");  
 

-- 4. 
use healthcare;


create table if not exists PlacesAdded(
		placeID int auto_increment primary key,
        placeName varchar(100),
        placeType varchar(10),
        timeAdded timestamp DEFAULT current_timestamp
    );
    
-- drop table placesAdded;

DELIMITER //
create trigger PopulatedPlacesAdded
before insert
on address
for each row
BEGIN
    IF (new.city not in (select distinct city from address)) THEN 
		insert into placesadded(placeName, placeType)
        values (new.city, "City");
	END IF;
	IF (new.state not in (select distinct state from address)) THEN 
		insert into placesadded(placeName, placeType)
		values (new.state, "State");
	END IF;
END
//
DELIMITER ;

-- drop trigger PopulatedPlacesAdded;

 -- select * from address;

insert into address values(999545,"1st Block Koramangala", "Bangalore","KA","560034");
select * from PlacesAdded;
insert into address values(999546,"Great Road, Downlane", "Britain","CT","6048");
select * from PlacesAdded;

-- 5.
use healthcare;

create table if not exists Keep_Log(
id int auto_increment primary key,
medicineID int,
quantity int
);

delimiter //
create trigger updatekeeplog
before update
on keep
for each row
BEGIN
	IF old.quantity <> new.quantity THEN
		insert into Keep_Log(medicineID,quantity)
        values(old.medicineID, new.quantity - old.quantity);
    END IF;
END
//
delimiter ;

-- select * from keep;

select * from Keep_Log;

update keep
set quantity = quantity-200
where pharmacyID=3287 and medicineID=21182;

select * from Keep_Log;

update keep
set quantity = quantity+800
where pharmacyID=2060 and medicineID=16517;

select * from Keep_Log;

