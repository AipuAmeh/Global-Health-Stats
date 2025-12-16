import pandas as pd
import sqlite3

# link to db
db_path = 'new-db.db'
conn = sqlite3.connect(db_path)
# create python script that reflects information that should be retrieved by sql statement
# after, create jupyter notebook with visualizations and plotly
# after create tableau visualization using sql statement to outline what i should be looking for


## step 1: get data
staging_table = """
SELECT * 
FROM StagingHealthData
;
"""

top_dis_table = """
SELECT *
FROM Top_Diseases
;
"""

df_staging = pd.read_sql(staging_table, conn)
df_top_diseases = pd.read_sql(top_dis_table, conn)

## question 1
# The final resulting DataFrame
df_q1_result = (
    # 1. JOIN (equivalent to SQL JOIN)
    # Merge the two DataFrames on the common column 'Disease_Name'
    df_staging.merge(
        df_top_diseases, 
        on='Disease_Name', 
        how='inner' # Use 'inner' for a standard JOIN
    )   
    # 2. WHERE (equivalent to SQL WHERE)
    # Filter the data to include only the specified years (2015 through 2025)
    .query('2015 <= Year <= 2025')    
    # 3. GROUP BY and AVG (equivalent to SQL GROUP BY and AVG(Incidence_Rate))
    # Group by both Disease_Name and Year, then calculate the mean (AVG) of Incidence_Rate
    .groupby(['Disease_Name', 'Year'])['Incidence_Rate']
    .mean()   
    # Reset the index to turn 'Disease_Name' and 'Year' back into regular columns
    .reset_index(name='Average_Incidence_Rate')    
    # 4. ORDER BY (equivalent to SQL ORDER BY)
    # Sort the final result by the calculated average rate
    .sort_values(by=['Disease_Name', 'Year'], ascending=[True, True])
)
# print(df_q1_result)
## question 2
df_q2_result = (
    df_staging.merge(
        df_top_diseases,
        on = 'Disease_Name',
        how='inner'
    )
    .query('2015 <= Year <= 2025')
    .groupby(['Disease_Name', 'Year'])['Mortality_Rate']
    .mean()
    .reset_index(name='Average_Mortality_Rate')
    .sort_values(by=['Disease_Name', 'Year'], ascending=[True, True])
)
# print(df_q2_result)
## question 3
cte_query = """
    SELECT 
        a.Country, 
        a.Disease_Name, 
        a.Year, 
        MAX(CASE WHEN a.Year = 2014 THEN a.Mortality_Rate END) AS Rate_2014,
        MAX(CASE WHEN a.Year = 2024 THEN a.Mortality_Rate END) AS Rate_2024
    FROM StagingHealthData a
    JOIN Top_Diseases b
    ON a.Disease_Name = b.Disease_Name
    WHERE a.Year IN (2014,2024)
    GROUP BY a.Country, a.Disease_Name, a.Year
    ORDER BY a.Country, a.Year ASC
    ;
"""
q3_df = pd.read_sql_query(cte_query, conn)
q3_pivot = q3_df.pivot_table(
    index=['Country', 'Disease_Name'],
    columns='Year',
    values=['Rate_2014', 'Rate_2024'],
).reset_index()

q3_pivot['Total_Rate_Decrease'] = ((q3_pivot['Rate_2014'] - q3_pivot['Rate_2024']))
# /q3_pivot['Rate_2014'])*100
top_improvers = q3_pivot.sort_values(by='Total_Rate_Decrease', ascending=False)
print(top_improvers[['Country', 'Disease_Name','Total_Rate_Decrease']].head(10))




# Close the connection
conn.close()

# Print the resulting DataFrame
# print(df_staging.head(5))