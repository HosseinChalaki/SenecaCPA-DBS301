-----------------------------------------------------------------------
-- NAME: Tracy Nguyen
-- ID: 127270171
-- DATE: September 20, 2018
-- Purpose: Lab #3 DBS301 SGG
-----------------------------------------------------------------------

-- Q1: Query that will display tomorrow's date.
--     ADVANCED: Assign tomorrow's date to a variable.

DEFINE tomorrow = to_char(sysdate + 1, 'YYYY-MM-DD');

SELECT to_char(sysdate + 1, 'Month DD"st of year" YYYY') AS Tomorrow
    FROM dual;
        
UNDEFINE tomorrow;
        
-- Q2: Display the last name, first name, salary, and salary increased
--     by 5% as a whole number (Labelled 'Good Salary') 
--     of employees in dept 20, 50, and 60.
--     Add a column called "Annual Pay Increase" where old salaries are
--     subtracted from new ones then multiplied by 12.

SELECT last_name, first_name, 
        to_char(salary, '$999,999.99') AS salary, 
        to_char(cast(salary * 1.05 AS int), '$999,999.99') AS "Good Salary", 
        to_char(cast(((salary*1.05-salary)*12) AS int), '$999,999.99') AS "Annual Pay Increase"
    FROM employees
    WHERE department_id IN(20, 50, 60);
        
-- Q3: Display an employee's name and job title as follows: DAVIES, CURTIS is ST_CLERK
--     where their last name ends with a 'S' and first name starts with a 'C' or 'K'.
--     Label the column as 'Person' and 'Job'. Sort by last names.

SELECT upper(last_name || ', ' || first_name) AS Person, 'is ' || job_id AS Job
    FROM employees
    WHERE upper(last_name) LIKE '%S' 
        AND upper(first_name) LIKE 'C%' 
        OR upper(first_name) LIKE 'K%'
    ORDER BY last_name;
    
-- Q4: Disply the last name, hire date, time of employment in years 
--     for any employees hired before 1992. Labels the time as "Years worked"
--     and sort it by those years. Round to the next closest whole number.

SELECT last_name, hire_date, extract(YEAR FROM sysdate) - extract(YEAR FROM hire_date) AS "Years worked"
    FROM employees
    WHERE hire_date < to_date('92-01-01', 'RR-MM-DD')
    ORDER BY "Years worked";

-- Q5: Display city names, country codes, and state provinces
--     where the city name begins with 'S' and has at least 8 characters.
--     If there's no province put 'Unknown Province' but be case sensitive!

SELECT city, country_id, nvl(state_province, 'Unknown Province') AS STATE_PROVINCE
    FROM locations
    WHERE upper(city) LIKE 'S%' AND length(city) >= 8;
    
-- Q6: Display an employee's last name, hire date, and salary review date (first Thurs after a year)
--     for employee's hired before 1997. Label it as 'Review Day', sort by the date, and display as follows:
--      THURSDAY, August the Thirty-First of year 1998

SELECT last_name, hire_date, 
        to_char(next_day(hire_date + 365, 'Thursday'), 'fmDAY, Month" the "fmDdspth" of the year "fmYYYY') AS "Review Day"
    FROM employees
    WHERE hire_date > to_date('97-12-12 23:59', 'RR-MM-DD HH24:MI:SS')
    ORDER BY "Review Day";