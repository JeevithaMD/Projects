WITH state_ranks AS (SELECT companyID, companyName, state, count(*) as claimCount,
	RANK() OVER(PARTITION BY companyID ORDER BY count(*) DESC) as rank_
FROM treatment t
JOIN claim c USING (claimID)
JOIN insuranceplan ip USING (uin)
JOIN insurancecompany ic USING (companyID)
JOIN address a USING(addressID)
GROUP BY companyID
ORDER BY companyID, companyName)

SELECT companyName, state AS majorityState, claimCount FROM state_ranks WHERE rank_ = 1;
