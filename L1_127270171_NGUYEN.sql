-----------------------------------------------------------------------
-- NAME: Tracy Nguyen
-- ID: 127270171
-- DATE: September 6, 2018
-- Purpose: Lab #1 DBS301 SGG
-----------------------------------------------------------------------

-- Q1: Run the following 3 statements. Which table is the widest and/or longest?
-- Solution:

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM job_history;

-- Of the following 3 statements, EMPLOYEES produces the longest and widest table.


-- Q2: What should be done to the following statements if it weren't successfully running so that it is successful?
--     SELECT last_name “LName”, job_id “Job Title”, 
--     Hire Date “Job Start”
--     FROM employees;

-- Solution: Between every column name and its replacement name, there should be an "AS".


-- Q3: Find 3 errors in the following statement
--     SELECT employee_id, last name, commission_pct Emp Comm,
--     FROM employees;

-- Solution: 1. "last name" should have an underscore in place of the space
--           2. "Emp Comm" should be in double quotes
--           3.  There's an "AS" missing between "commission_pct" and "Emp Comm"


-- Q4: What command will show the structure of the LOCATIONS table?

-- Solution: desc locations;

-- Q5: Write a query that will output the text below:
--     City# 		City 			Province with Country Code 
--  -----------------------------------------------------------------------------
--       1000 	Roma 			IN THE IT 
--       1100 	Venice 			IN THE IT

-- Solution: 
select location_id as City#, city, (state_province || ' IN THE ' || country_id) as "Province with Country Code" 
from locations
where country_id = 'IT';


-- END OF FILE --