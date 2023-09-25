USE healthcare;

select pharmacyID, count(*)as total_units, round(sum(maxPrice),2) as total_max_retail_price, round(sum(maxPrice-((discount/100)*maxPrice)),2) as total_price_after_discount
from keep
join medicine using (medicineID)
group by pharmacyID
order by pharmacyID;


