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
-- limit 5
SELECT 
    Disease_Name, 
	AVG(Population_Affected) AS avg_pop_affected, 
	AVG(Prevalence_Rate) as avg_prevalence_rate, 
	AVG(incidence_rate) as avg_incidence_Rate, 
	Pop_Total,
FROM StagingHealthData
GROUP BY Disease_Name
ORDER BY Disease_Name, Population_Affected DESC
LIMIT 5
;


