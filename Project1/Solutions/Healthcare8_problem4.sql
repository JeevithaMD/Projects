WITH avg_total_quantity AS (
    SELECT AVG(totalQuantity) AS avg_quantity
    FROM (
        SELECT
            ph.pharmacyID,
            pr.prescriptionID,
            SUM(quantity) AS total_quantity
        FROM
            pharmacy ph
            JOIN prescription pr USING (pharmacyID)
            JOIN contain c USING (prescriptionID)
            JOIN treatment t USING (treatmentID)
        WHERE
            t.date BETWEEN '2022-01-01' AND '2022-12-31'
        GROUP BY
            ph.pharmacyID, pr.prescriptionID
    ) AS subq
)

SELECT
    ph.pharmacyID,
    pr.prescriptionID,
    SUM(quantity) AS total_quantity
FROM
    pharmacy ph
    JOIN prescription pr USING (pharmacyID)
	JOIN contain c USING (prescriptionID)
	JOIN treatment t USING (treatmentID)
WHERE
    t.date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY
    ph.pharmacyID, pr.prescriptionID
HAVING
    SUM(quantity) > (SELECT avg_quantity FROM avg_total_quantity);