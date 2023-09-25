SELECT diseaseName, high_claimed,high_claimed_count, least_claimed,least_claimed_count  FROM (
SELECT
        diseaseName,
        FIRST_VALUE(planName) OVER (PARTITION BY diseaseName ORDER BY COUNT(*) DESC) AS high_claimed,
        FIRST_VALUE(count(*)) OVER(PARTITION BY diseaseName ORDER BY COUNT(*) DESC) AS high_claimed_count,
		LAST_VALUE(planName) OVER (PARTITION BY diseaseName ORDER BY COUNT(*) DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS least_claimed,
        LAST_VALUE(count(*)) OVER (PARTITION BY diseaseName ORDER BY COUNT(*) DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS least_claimed_count
    from insuranceplan ip
	join claim c using(uin)
	join treatment t using(claimID)
	join disease d using(diseaseID)
    GROUP BY d.diseaseName, ip.planName
) AS subq
GROUP BY diseaseName, high_claimed,high_claimed_count, least_claimed,least_claimed_count