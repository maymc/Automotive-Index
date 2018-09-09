--Create a new postgres user named indexed_cars_user
CREATE USER indexed_cars_user;
--Create a new database named indexed_cars owned by indexed_cars_user
CREATE DATABASE indexed_cars;
ALTER DATABASE indexed_cars OWNER TO indexed_cars_user;

--Run the provided scripts/car_models.sql script on the indexed_cars database
--Run the provided scripts/car_model_data.sql script on the indexed_cars database 10 times there should be 223380 rows in car_models

--Run a query to get a list of all make_title values from the car_models table where the make_code is 'LAM', without any duplicate rows, and note the time somewhere. (should have 1 result)
--SELECT DISTINCT eliminates duplicate rows from the result. SELECT DISTINCT ON eliminates rows that match on all the specified expressions. SELECT ALL (the default) will return all candidate rows, including duplicates
--(25ms)
SELECT DISTINCT make_title FROM car_models WHERE make_code = 'LAM';

--Run a query to list all model_title values where the make_code is 'NISSAN', and the model_code is 'GT-R'without any duplicate rows, and note the time somewhere. (should have 1 result)
--(23ms)
SELECT DISTINCT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R';

--Run a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM', and note the time somewhere. (should have 1360 rows)
--(31ms)
SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM';

--Run a query to list all fields from all car_models in years between 2010 and 2015, and note the time somewhere (should have 78840 rows)
--(223ms)
SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015;

--Run a query to list all fields from all car_models in the year of 2010, and note the time somewhere (should have 13140 rows)
--(59ms)
SELECT * FROM car_models WHERE year = 2010;


--------INDEXING------------
--Create a query to get a list of all make_title values from the car_models table where the make_code is 'LAM', without any duplicate rows, and note the time somewhere. (should have 1 result)
--(3ms)
CREATE INDEX indexMakeCode
	ON car_models (make_code) WHERE make_code = 'LAM';
	
SELECT DISTINCT make_title FROM car_models WHERE make_code = 'LAM';

--Create a query to list all model_title values where the make_code is 'NISSAN', and the model_code is 'GT-R'without any duplicate rows, and note the time somewhere. (should have 1 result)
--(3ms)
CREATE INDEX indexMakeCodeModelCode
	ON car_models (make_code, model_code) WHERE make_code = 'NISSAN' AND model_code = 'GT-R';
	
SELECT DISTINCT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R';

--Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM', and note the time somewhere. (should have 1360 rows)
--(11ms)
CREATE INDEX indexMakeCodeModelCodeModelTitleYear
	ON car_models (make_code, model_code, model_title, year) WHERE make_code = 'LAM';

SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM';


--Create a query to list all fields from all car_models in years between 2010 and 2015, and note the time somewhere (should have 78840 rows)
--(238ms)
CREATE INDEX indexAllFields
	ON car_models (make_code, make_title, model_code, model_title, year) WHERE year BETWEEN 2010 AND 2015;
	
DROP INDEX indexAllFields;
SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015;

--Create a query to list all fields from all car_models in the year of 2010, and note the time somewhere (should have 13140 rows)
--(46ms)
CREATE INDEX indexAllFields2010
	ON car_models (make_code, make_title, model_code, model_title, year) WHERE year = 2010;
SELECT * FROM car_models WHERE year = 2010;


