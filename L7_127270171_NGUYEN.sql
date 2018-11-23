-----------------------------------------------------------------------
-- NAME: Tracy Nguyen
-- ID: 127270171
-- DATE: November 1, 2018
-- Purpose: Lab #7 DBS301 SGG
-----------------------------------------------------------------------

-- Quiz (Answers are found in Oracle 11g txtbook section 1)
-- Which are part of the SET operators guidelines...
-- Q1: have same # of records between SELECTs 
-- Q2: Parentheses can't alter sequence of execution 
-- Q3: Data type of 2nd query must match data type of corresponding in first 
-- Q4: ORDER BY can only be used once in the compound query unless it's UNION ALL 
-- Answer: 1, 3

-- Q1: Make a list of dept IDs for depts that don't have the job ID "ST_CLERK"

SELECT department_id
    FROM departments

    INTERSECT

SELECT department_id
    FROM employees
    WHERE UPPER(job_id) != 'ST_CLERK';
    
-- Q2: Make a list of countries with no depts located in them. 
--     Display the country ID and country name.

SELECT country_id, country_name
    FROM (SELECT country_id
            FROM countries
    
            MINUS

          SELECT country_id
            FROM locations) 
        JOIN countries
        USING (country_id);

-- Q3: List the jobs under depts 10, 50, 20 in that order.
--     ORDER BY field(col_name, num sequence)

SELECT job_id, department_id
FROM (SELECT department_id
            FROM departments
            WHERE department_id IN(10, 50, 20) 
            
            INTERSECT
            
            SELECT department_id
                FROM employees) 
JOIN (SELECT job_id, department_id 
        FROM employees 
        
        UNION 
        
        SELECT job_id, department_id 
            FROM employees)
                USING (department_id)
    ORDER BY
        CASE department_id
            WHEN 10 THEN 1
            WHEN 50 THEN 2
            WHEN 20 THEN 3
        END;

-- Q4: List empIDs and jobIDs of emps who have the job as when they started

SELECT employee_id, job_id
FROM (SELECT employee_id
        FROM employees
    
        MINUS
    
      SELECT employee_id
        FROM job_history) 
    JOIN employees
    USING(employee_id)
ORDER BY employee_id;

-- Q5: Make a SINGLE report of lnames and deptIDs of all emps whether they have a dept or not
--     AND deptIDs and dept names of all depts whether they have emps or not.

SELECT last_name, department_id, department_name
FROM (SELECT department_id
    FROM employees
    
    UNION
    
SELECT department_id
    FROM departments)
    FULL OUTER JOIN employees
    USING (department_id)
    FULL OUTER JOIN departments
    USING (department_id);
