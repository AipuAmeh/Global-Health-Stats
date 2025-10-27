-- look at all the types of disease names (20)
SELECT DISTINCT Disease_Name
FROM StagingHealthData;

-- look at different disease categories 
SELECT DISTINCT Disease_Category, Disease_Name
FROM StagingHealthData;

-- Create new table with categories for infectious diseases and NCDs
DROP TABLE IF EXISTS DiseaseNameAndCategories;

CREATE TABLE DiseaseNameAndCategories(
    Disease_Name TEXT PRIMARY KEY,
    Main_Disease_Categories TEXT
);

INSERT INTO DiseaseNameAndCategories (Disease_Name, Main_Disease_Categories)
    SELECT DISTINCT Disease_Name,
CASE 
    WHEN Disease_Category = 'Parasitic' OR Disease_Category = 'Bacterial' OR Disease_Category = 'Viral'
    THEN 'infectious_diseases'
    ELSE 'ncds' 
    END AS main_disease_categories
FROM StagingHealthData
;

-- what category of diseases affects men vs women?
-- select 
-- SUM( CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) end as num_males,
-- repeat for females
-- count(disease_category)
SELECT  
	Disease_Category, 
	SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) as num_males, 
	SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) as num_females
FROM StagingHealthData
GROUP BY Disease_Category
;

-- what are the top 5 most common diseases or health conditions globally?
-- select disease name, population affected, prevalence rate, incidence rate
-- from staginghealthdata
-- order by desc
SELECT 
    Disease_Name, 
	AVG(Population_Affected) AS avg_pop_affected, 
	AVG(Prevalence_Rate) as avg_prevalence_rate, 
	AVG(incidence_rate) as avg_incidence_Rate
FROM StagingHealthData
GROUP BY Disease_Name
ORDER BY avg_pop_affected, avg_prevalence_rate, avg_incidence_Rate DESC
LIMIT 5
;

-- which country has the highest prevalence of these top 5 diseases?
DROP VIEW IF EXISTS Top_Diseases;

CREATE VIEW Top_Diseases AS
SELECT 
    Disease_Name, 
	AVG(Population_Affected) AS avg_pop_affected, 
	AVG(Prevalence_Rate) as avg_prevalence_rate, 
	AVG(incidence_rate) as avg_incidence_Rate
FROM StagingHealthData
GROUP BY Disease_Name
ORDER BY avg_pop_affected, avg_prevalence_rate, avg_incidence_Rate DESC
LIMIT 5
;

SELECT 
a.Country,
a.Disease_Name,
a.Population_Affected,
a.Prevalence_Rate,
a.incidence_rate
FROM StagingHealthData a
JOIN Top_Diseases b
ON a.Disease_Name = b.Disease_Name
ORDER BY b.Prevalence_Rate DESC

-- drill down on Argentina
SELECT 
Country,
Disease_Name,
MAX(Prevalence_Rate)
FROM StagingHealthData
WHERE Country = 'Argentina'
ORDER BY Prevalence_Rate DESC;

-- age group of men and women affected by top 5 diseases?
SELECT 
a.Age_Group,
a.Disease_Name,
SUM(CASE WHEN a.Gender = 'Male' THEN 1 ELSE 0 END) AS num_of_males,
SUM(CASE WHEN a.Gender = 'Female' THEN 1 ELSE 0 END) AS num_of_females,
SUM(CASE WHEN a.Gender = 'Other' THEN 1 ELSE 0 END) AS other
FROM StagingHealthData a
JOIN Top_Diseases b
ON a.Disease_Name = b.Disease_Name
GROUP BY 
a.Age_Group,
a.Disease_Name;

-- number of infectious diseases vs ncd globally? in africa?
-- population affected 
-- num of people affected by infectious diseases
-- vs num of people affected by ncds
SELECT COUNT(CASE WHEN Main_Disease_Category = 'infectious_diseases' THEN 1 ELSE 0 END) AS num_of_infectious_diseases