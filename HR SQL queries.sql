USE projects;

-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?

SELECT gender,count(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT race,count(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY race
ORDER BY count DESC;

-- 3. What is the age distribution of employees in the company?

SELECT 
	min(age),
    max(age)
FROM hr
WHERE age>=18 AND termdate IS NULL;

SELECT CASE
	WHEN age>= 18 and age<=24 THEN '18-24'
    WHEN age>= 25 and age<=34 THEN '25-34'
    WHEN age>= 35 and age<=44 THEN '35-44'
    WHEN age>= 45 and age<=54 THEN '45-54'
    WHEN age>= 55 and age<=64 THEN '55-64'
    ELSE '65+'
END AS age_group,
	count(*) AS count,gender
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY age_group,gender
ORDER BY age_group,gender;

-- 4. How many employees work at headquarters versus remote locations?

SELECT location, count(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY location;
    
-- 5. What is the average length of employment who have been terminated?

SELECT 
	round(avg(datediff(termdate,hire_date))/365,0) AS avg_length_employment
FROM hr
Where termdate <= curdate() AND termdate IS NOT NULL AND age>= 18;

-- 6. How does the gender distribution vary across departments and job titles?

SELECT department,gender,COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY department,gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?

SELECT jobtitle,COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the higher turnover rate?

SELECT department,
	   total_count,
       termination_count,
       termination_count/total_count AS termination_rate
FROM (
	SELECT department,
		   COUNT(*) AS total_count,
           SUM(CASE WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 ELSE 0 END) AS termination_count
    FROM hr
    WHERE age >=18
    GROUP BY department
    ) AS subquery
ORDER BY termination_rate DESC;

-- 9. What is the distributions of employees across locations by city and state?

SELECT location_state,COUNT(*) AS count
FROM hr
WHERE age>=18 AND termdate IS NULL
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's emplooyees count changed over time based on hire and term dates?

SELECT
	year,
    hires,
    termination,
    hires-termination AS net_change,
	round((hires-termination)/hires*100,2) AS net_change_percentage
FROM(
	SELECT 
		YEAR(hire_date) AS year,
        COUNT(*) AS hires,
        SUM(CASE WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 ELSE 0 END) AS termination
	FROM hr
    WHERE age >= 18
    GROUP BY YEAR(hire_date)
    ) AS subquery
ORDER BY year;

-- 11. What is the tenure distribution for each department?

SELECT department,round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr
WHERE termdate <= curdate() AND termdate IS NOT NULL AND age>=18	
GROUP BY department;



        