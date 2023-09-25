SELECT companyname, 
	COUNT(*) as count_of_ranitidina 
FROM medicine
WHERE substancename LIKE '%raniti%'
GROUP BY companyname 
ORDER BY count_of_ranitidina DESC
LIMIT 3;