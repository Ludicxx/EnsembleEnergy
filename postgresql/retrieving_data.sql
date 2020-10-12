SELECT * FROM directors;

SELECT first_name FROM directors;

SELECT first_name, last_name FROM directors;


-- Retrieving data with the where clause
/*
SELECT columnname FROM tablename
WHERE columnname ='value';
*/

SELECT * FROM movies
WHERE age_certificate = '15';

SELECT * FROM movies
WHERE age_certificate = '15'
AND movie_lang = 'Chinese';

SELECT * FROM movies
WHERE age_certificate = '15'
OR movie_lang = 'Chinese';


-- Using logical operators (>, >=, <, <=)

SELECT movie_name, movie_length FROM movies
WHERE movie_length > 120;

SELECT movie_name, movie_length FROM movies
WHERE movie_length < 120
AND movie_length > 100;

SELECT * FROM movies
WHERE release_date > '1999-12-31'; 

-- Using IN and NOT IN

/*

SELECT columnname1, columnname2 FROM tablename
WHERE columnname3 IN ('value','value2');

SELECT columnname1, columnname2 FROM tablename
WHERE columnname3 NOT IN ('value','value2');


*/

SELECT first_name, last_name FROM actors
WHERE first_name IN ('Bruce', 'John');

SELECT first_name, last_name FROM actors
WHERE first_name NOT IN ('Bruce', 'John');

SELECT actor_id, first_name, last_name FROM actors
WHERE actor_id IN (2,3,4,5,6,8);

SELECT actor_id, first_name, last_name FROM actors
WHERE actor_id NOT IN (2,3,4,5,6,8);


-- Using LIKE with % and _

/*

SELECT columnname FROM table
WHERE columnname LIKE '%patterns';

SELECT columnname FROM table
WHERE columnname LIKE '_pattern_';

*/


SELECT * FROM actors
WHERE first_name LIKE 'P%';

SELECT * FROM actors
WHERE first_name LIKE 'Pe_';

SELECT * FROM actors
WHERE first_name LIKE '%r%';

SELECT * FROM actors
WHERE first_name LIKE '__rl_';



-- selecting data where a column is between 2 values

/*

SELECT columnname1, columnname2 FROM tablename
WHERE columnname3 BETWEEN value1 AND value2;

*/

SELECT * FROM movies
WHERE release_date BETWEEN '1995-01-01' AND '1999-12-31';

SELECT * FROM movies
WHERE movie_length BETWEEN 90 AND 120
AND movie_lang = 'English';



-- Ordering the results returned

/*

SELECT columnname1, columnname2 FROM tablename
ORDER BY columnname3;

*/

SELECT * FROM actors
ORDER BY first_name;

SELECT * FROM actors
WHERE gender = 'F'
ORDER BY date_of_birth DESC;



-- Limiting the number of records returned

/*

SELECT columnname1, columnname2 FROM tablename
LIMIT N;

*/

SELECT * FROM movie_revenues
ORDER BY domestic_takings
LIMIT 3;



-- Using Fetch

/*
SELECT column1 FROM table1
FETCH FIRST 1 ROW ONLY;
*/

SELECT * FROM movies
FETCH FIRST 10 ROW ONLY;

SELECT * FROM movies
OFFSET 8 ROWS
FETCH FIRST 10 ROW ONLY;



-- Distinct values

/*

SELECT DISTINCT columnname FROM tablename;

*/

SELECT DISTINCT * FROM movies;


-- Dealing iwth NULL values

/*
SELECT * FROM tablename
WHERE columnname in NULL;

SELECT * FROM tablename
WHERE columnname IS NOT NULL;
*/

SELECT * FROM actors
WHERE date_of_birth IS NULL;

SELECT * FROM movie_revenues
WHERE domestic_takings IS NOT NULL
ORDER BY domestic_takings DESC;

SELECT * FROM movie_revenues
WHERE international_takings IS NULL;


-- Setting a column name alias
/*
SELECT columnname AS new_columnname FROM tablename;
*/

SELECT last_name AS surname FROM directors;

-- Using concatenate

/*
SELECT 'string1' || 'string2' AS new_string;

SELECT CONCAT(column1, column2) AS new_column FROM tablename;

SELECT CONCAT_WS('', column1, column2) AS new_column FROM tablename;
*/

SELECT 'concat' || 'together' AS new_string;

SELECT CONCAT(first_name,' ', last_name) AS full_name FROM actors;

SELECT CONCAT_WS(' ', first_name, last_name) AS full_name FROM actors;










































































































































