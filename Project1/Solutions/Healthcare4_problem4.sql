SELECT medicineID,
	CASE 
		WHEN maxPrice < 0.5*(SELECT AVG(maxPrice) FROM medicine) THEN "Affordable"
        WHEN maxPrice > 2*(SELECT AVG(maxPrice) FROM medicine) THEN "Costly"
	END AS category
FROM medicine
WHERE hospitalExclusive = 'S' AND
(maxPrice < 0.5*(SELECT AVG(maxPrice) FROM medicine) OR maxPrice > 2*(SELECT AVG(maxPrice) FROM medicine));
