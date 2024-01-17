# Normalizing a database for Fred's Furniture in PostgreSQL
This project was completed as part of the Codecademy Back-End Engineering course.

## Purpose
The purpose of this project was to normalize a databse for the growing business Fred's Furniture - and compare the complexity of database queries before and after the normalization.

The structure of the old database (filled with sample data) is as below:

![Database before normalization](https://github.com/MelindaH26/practice-projects/blob/main/sql/database-normalization/img/freds-db.PNG)

You can see this table has a lot of columns and could be organised into multiple tables to make storing data more efficient.

The database was to be normalized based on the database schema in the image below:

![Database schema after normalization](https://github.com/MelindaH26/practice-projects/blob/main/sql/database-normalization/img/freds-normalized-db-schema.PNG?raw=true)

## Outcomes
At the end of the ``database-normalization.sql`` file you can see that normalization can make searches on the database either more simple or complex depending on the situation. Overall though, it is clear that the normalized version of the database is much more manageable and has better scalability than the previous version.
