import psycopg2
from db_config import *

connection = psycopg2.connect(databse=PROJECT_DBNAME,
                              host=PROJECT_HOSTNAME,
                              user=PROJECT_USERNAME,
                              password=PROJECT_PASSWORD,
                              port=PROJECT_PORT)
cursor = connection.cursor()

# get contents of characters
cursor.execute("SELECT * FROM characters")
print(cursor.fetchall())

