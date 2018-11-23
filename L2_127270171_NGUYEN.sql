-----------------------------------------------------------------------
-- NAME: Tracy Nguyen
-- ID: 127270171
-- DATE: September 13, 2018
-- Purpose: Lab #2 DBS301 SGG
-----------------------------------------------------------------------

-- Q1: Display employee ID, last name, and salary of employees with a
--     salary within the of $9000 to $11000. Sort by salaries then last name

SELECT employee_id, last_name, to_char(salary, '$999,999.99')
    FROM employees
    WHERE salary BETWEEN 9000 AND 11000
    ORDER BY salary DESC, last_name;

-- Q2: Modify the query from Q1 so it only displays employees who
--     are Porgrammers or Sales Reps

SELECT employee_id, last_name, to_char(salary, '$999,999.99')
    FROM employees
    WHERE salary BETWEEN 9000 AND 11000
        AND job_id IN ('IT_PROG', 'SA_REP')
    ORDER BY salary DESC, last_name;
    
-- Q3: Modify the Q2 query so that it displays job titles of
--     those outside the Q1 salary range

SELECT employee_id, last_name, to_char(salary, '$999,999.99')  
    FROM employees
    WHERE (salary < 9000 OR salary > 11000)
        AND job_id IN ('IT_PROG', 'SA_REP')
    ORDER BY salary DESC, last_name;
    
-- Q4: Display employee last names, job IDs, and salaries for those
--     employed before 1998. List by most recent

SELECT last_name, job_id, salary
    FROM employees
    WHERE hire_date <= to_date('98-01-01', 'RR-MM-DD')
    ORDER BY hire_date;

-- Q5: Modify Q4 query to show employees earning $10,000. 
--     Sort job title alphabetically then by highest paid

SELECT last_name, job_id, salary
    FROM employees
    WHERE hire_date < to_date('01/01/98', 'MM/DD/YY')
    ORDER BY hire_date DESC;
    
-- Q6: Show job titles and full names where the first name contains
--     an 'e' or 'E'

SELECT job_id AS "Job Title", first_name || ' ' || last_name AS "Full Name"
    FROM employees
    WHERE REGEXP_LIKE (first_name, '*[Ee]*');