SELECT companyName ,productName ,description ,maxPrice ,
CASE 
	WHEN maxprice > 1000 THEN "pricey"
	WHEN maxprice < 5 THEN "affordable"
	ELSE "moderate"
END AS price_category
FROM medicine 
WHERE maxPrice > 1000 OR maxPrice < 5
ORDER BY maxPrice DESC;