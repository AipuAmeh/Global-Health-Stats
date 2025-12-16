-- what is the incidence rate of the top 5 diseases in the past 10 years? (2015-2025) -- bar chart

SELECT AVG(a.Incidence_Rate), b.Disease_Name, a.Year
FROM StagingHealthData a
JOIN Top_Diseases b
ON a.Disease_Name = b.Disease_Name
WHERE a.Year BETWEEN 2014 AND 2024
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

    -- has there been an increase in mortality from top 5 diseases over the last 10 years or decrease? -- line chart
SELECT AVG(a.Mortality_Rate) AS Avg_Mortality_Rate, b.Disease_Name, a.Year
FROM StagingHealthData a
JOIN Top_Diseases b 
ON a.Disease_Name = b.Disease_Name
WHERE a.Year BETWEEN 2014 AND 2024
GROUP BY a.Disease_Name, a.Year 
ORDER BY b.Disease_Name, a.Year ASC
;

-- What countries had the highest decrease of mortality?
-- define mortality trend to see the max mortality rate in 2015 and max rate in 2025 -- heat map?
WITH MortalityTrends AS (
    SELECT a.Country, a.Disease_Name, 
        MAX(CASE WHEN a.Year = 2015 THEN a.Mortality_Rate END) AS Rate_2015,
        MAX(CASE WHEN a.Year = 2025 THEN a.Mortality_Rate END) AS Rate_2025
    FROM StagingHealthData a
    JOIN Top_Diseases b
    ON a.Disease_Name = b.Disease_Name
    WHERE a.Year IN (2015, 2025)
    GROUP BY a.Country, a.Disease_Name
)
SELECT 
    Country, Disease_Name, Rate_2015, Rate_2025, (((Rate_2015 - Rate_2025)/100)*100) AS Total_Rate_Decrease
FROM MortalityTrends
WHERE Rate_2015 IS NOT NULL AND Rate_2025 IS NOT NULL
ORDER BY Total_Rate_Decrease
LIMIT 10;

