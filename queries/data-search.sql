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


