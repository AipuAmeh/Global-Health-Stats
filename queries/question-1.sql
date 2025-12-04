-- what is the incidence rate of the top 5 diseases in the past 10 years? (2015-2025)

SELECT a.Incidence_Rate, b.Disease_Name
FROM StagingHealthData
JOIN Top_Diseases b
ON a.Disease_Name = b.Disease_Name
WHERE a.Year = '2015'
GROUP BY b.Disease_Name
ORDER BY a.Incidence_Rate
;