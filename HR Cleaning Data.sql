CREATE DATABASE projects;

USE projects;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20);

DESCRIBE hr;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d') 
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

SELECT birthdate FROM hr;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d') 
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

SELECT hire_date FROM hr;

UPDATE hr
SET termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%sUTC'))
WHERE termdate IS NOT NULL AND termdate != '';

UPDATE hr 
SET termdate = '1970-01-01' 
WHERE termdate = '0000-00-00' OR termdate IS NULL;

SET GLOBAL sql_mode = '';

UPDATE hr 
SET termdate = NULL	 
WHERE termdate = '1970-01-01' OR termdate IS NULL;

SELECT termdate FROM hr;

UPDATE hr 
SET termdate = '0000-00-00'
WHERE termdate IS NULL;

ALTER TABLE hr
ADD COLUMN age INT;

SELECT * FROM hr;

UPDATE hr
SET age = timestampdiff(YEAR,birthdate,CURDATE());	

SELECT birthdate,age FROM hr;

SELECT 
	min(age),
    max(age)
FROM hr;
	
SELECT count(*) FROM hr
WHERE age<18;
    
