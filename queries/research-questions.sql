-- what is the incidence rate of the top 5 diseases in the past 10 years? (2015-2025) -- bar chart

SELECT AVG(a.Incidence_Rate), b.Disease_Name, a.Year
FROM StagingHealthData a
JOIN Top_Diseases b
ON a.Disease_Name = b.Disease_Name
WHERE a.Year BETWEEN 2015 AND 2025
GROUP BY b.Disease_Name, a.Year
ORDER BY b.Disease_Name, a.Year ASC
;

-- Mortality rate for top 5 diseases, which disease has the highest?
SELECT AVG(a.Mortality_Rate) AS Avg_Mortality_Rate, b.Disease_Name
FROM StagingHealthData a
JOIN Top_Diseases b 
ON a.Disease_Name = b.Disease_Name
GROUP BY a.Disease_Name
ORDER BY Avg_Mortality_Rate DESC
;

    -- has there been an increase in mortality over the last 10 years or decrease? -- line chart
SELECT AVG(a.Mortality_Rate) AS Avg_Mortality_Rate, b.Disease_Name, a.Year
FROM StagingHealthData a
JOIN Top_Diseases b 
ON a.Disease_Name = b.Disease_Name
WHERE a.Year BETWEEN 2015 AND 2025
GROUP BY a.Disease_Name, a.Year 
ORDER BY b.Disease_Name, a.Year ASC
;
