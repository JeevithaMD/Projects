SELECT ic.companyName, ip.planName, year(t.date), COUNT(*) as count 
FROM treatment t
LEFT JOIN claim c USING (claimID)
LEFT JOIN insuranceplan ip USING (uin)
LEFT JOIN insurancecompany ic USING (companyID)
WHERE ic.companyName IS NOT NULL AND YEAR(t.date) <> 2019
GROUP BY ic.companyName, ip.planName,year(t.date) WITH ROLLUP;