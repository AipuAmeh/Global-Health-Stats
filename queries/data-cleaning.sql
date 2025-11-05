CREATE TABLE StagingHealthData as SELECT * 
FROM GlobalHealthStatistics;

UPDATE StagingHealthData SET Disease_Category = 'Parasitic' WHERE Disease_Name = 'Malaria';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'Ebola';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'COVID-19';
UPDATE StagingHealthData SET Disease_Category = 'Neurological' WHERE Disease_Name = 'Parkinson's Disease'';
UPDATE StagingHealthData SET Disease_Category = 'Bacterial' WHERE Disease_Name = 'Tuberculosis';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'Dengue';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'Rabies';
UPDATE StagingHealthData SET Disease_Category = 'Bacterial' WHERE Disease_Name = 'Cholera';
UPDATE StagingHealthData SET Disease_Category = 'Bacterial' WHERE Disease_Name = 'Leprosy';
UPDATE StagingHealthData SET Disease_Category = 'Genetic' WHERE Disease_Name = 'Cancer';
UPDATE StagingHealthData SET Disease_Category = 'Chronic' WHERE Disease_Name = 'Diabetes';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'Measles';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'Zika';
UPDATE StagingHealthData SET Disease_Category = 'Neurological' WHERE Disease_Name = 'Alzheimer's Disease'';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'Polio';
UPDATE StagingHealthData SET Disease_Category = 'Cardiovascular' WHERE Disease_Name = 'Hypertension';
UPDATE StagingHealthData SET Disease_Category = 'Respiratory' WHERE Disease_Name = 'Asthma';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'HIV/AIDS';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'Influenza';
UPDATE StagingHealthData SET Disease_Category = 'Viral' WHERE Disease_Name = 'Hepatitis';

