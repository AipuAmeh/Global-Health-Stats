import pandas as pd
import sqlite3

# link to db
db_path = 'new-db.db'
conn = sqlite3.connect(db_path)
# create python script that reflects information that should be retrieved by sql statement
# after, create jupyter notebook with visualizations and plotly
# after create tableau visualization using sql statement to outline what i should be looking for


## step 1: get data
sql_query_one = """
SELECT * 
FROM StagingHealthData
;
"""

df_result = pd.read_sql(sql_query_one, conn)

# 4. Close the connection
conn.close()

# Print the resulting DataFrame
print(df_result.head(5))