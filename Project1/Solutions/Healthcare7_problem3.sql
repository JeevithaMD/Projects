with report as (SELECT ip.planName, count(*) as claim_count,
	ROW_NUMBER() OVER(ORDER BY count(*) DESC) as most_claimed_rank,
    ROW_NUMBER() OVER(ORDER BY count(*)) as least_claimed_rank
	FROM insurancecompany ic
	JOIN insuranceplan ip USING (companyid)
	JOIN claim USING (uin)
    WHERE companyName = 'Bajaj Allianz General Insuarnce Co. Ltd'
    GROUP BY ip.planName)
SELECT r.planname as most_claimed,r1.planname as least_claimed from report r join report r1 on r.most_claimed_rank = r1.least_claimed_rank
where r.most_claimed_rank <=3 or r1.least_claimed_rank <=3
    
DELIMITER //
CREATE PROCEDURE most_least_plans(IN companyID INT)
BEGIN
	WITH plans_report AS(
	SELECT ip.planName,
		COUNT(*) as claim_count,
		ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) AS most_claimed,
		ROW_NUMBER() OVER(ORDER BY COUNT(*)) AS least_claimed
	FROM insurancecompany ic
	JOIN insuranceplan ip USING (companyid)
	JOIN claim USING (uin)
	WHERE ic.companyid = companyID
	GROUP BY ip.planName )
    
	SELECT r.planName AS most_claimed, r1.planName AS least_claimed
	FROM plans_report r JOIN plans_report r1 on r.most_claimed=r1.least_claimed
	WHERE r.most_claimed <=3 or r1.least_claimed <=3;
END //
DELIMITER ;

call most_least_plans(6403);
