-- what is the incidence rate of the top 5 diseases in the past 10 years? (2015-2025)

SELECT AVG(a.Incidence_Rate), b.Disease_Name, a.Year
FROM StagingHealthData a
JOIN Top_Diseases b
ON a.Disease_Name = b.Disease_Name
WHERE a.Year BETWEEN 2015 AND 2025
GROUP BY b.Disease_Name, a.Year
ORDER BY a.Incidence_Rate
;