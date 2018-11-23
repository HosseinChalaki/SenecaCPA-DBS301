-----------------------------------------------------------------------
-- NAME: Tracy Nguyen
-- ID: 127270171
-- DATE: November 8, 2018
-- Purpose: Lab #8 DBS301 SGG
-----------------------------------------------------------------------

-- Q1: Display emp names whose salary 
--     is equal to the lowest salaried emp of any dept
SELECT first_name, last_name
    FROM employees e1 JOIN (SELECT min(salary) AS salary
                                FROM employees) e2
ON e1.salary = e2.salary;
    
  
-- Q2: Display emp names whose salary IS the lowest in the dept.
SELECT first_name, last_name
    FROM employees e1 JOIN (SELECT min(salary) AS salary, department_id
                                FROM employees
                                GROUP BY department_id) e2
ON e1.salary = e2.salary AND e1.department_id = e2.department_id;

--Q3: Give each emp from Q2 a $100 bonus
SELECT first_name, last_name, e1.salary + 100 AS Salary
    FROM employees e1 JOIN (SELECT min(salary) AS salary, department_id
                                FROM employees
                                GROUP BY department_id) e2
ON e1.salary = e2.salary AND e1.department_id = e2.department_id;

-- Q4: Create a view named ALLEMPS with emp id, lname, salary,
--     dept id, dept name, city, and country (if applicable)
CREATE OR REPLACE VIEW allemps AS
    SELECT employee_id, last_name, salary, department_id, department_name, city, country_name
        FROM countries JOIN locations
        USING (country_id)
        JOIN departments
        USING (location_id)
        -- Removed RIGHT JOIN to allow updates and insertion
        JOIN employees
        USING (department_id);
        
-- Q5: Use the ALLEMPS view to 
-- a. display the emp id, lname, salary, and city for all emps
SELECT employee_id, last_name, salary, city
    FROM allemps;
    
-- b. display total salary of all emps by city
SELECT sum(salary) AS "Total Salary", city
    FROM allemps
    GROUP BY city;
    
-- c. increase salary of lowest paid emp by dept by $100
SELECT min(salary) AS Salary, department_id
    FROM allemps
    GROUP BY department_id;

UPDATE allemps
    SET salary = salary + 100
    WHERE salary IN (SELECT salary FROM (SELECT min(salary) AS salary, department_id
    FROM allemps GROUP BY department_id))
    AND department_id IN (SELECT department_id FROM (SELECT min(salary) AS Salary, department_id
    FROM allemps GROUP BY department_id));

-- d. try to insert emp by providing values for all columns for the view
--INSERT INTO allemps
--    VALUES(207, 'lastName', 5000, 50, 'Shipping', 'South San Francisco', 'United States of America');
-- Insertion doesn't work. This may be because of the dependencies between the tables.

-- e. delete Vargas. Prove if it worked or not.
DELETE FROM allemps
    WHERE UPPER(last_name) = 'VARGAS';

SELECT last_name
    FROM allemps
    WHERE UPPER(last_name) = 'VARGAS';
    

-- Q6: Create view call ALLDEPTS with dept id, dept name, city, and country
CREATE OR REPLACE VIEW alldepts AS
    SELECT department_id, department_name, city, country_name
        FROM departments JOIN locations
        USING (location_id)
        JOIN countries
        USING (country_id);
        
-- Q7: With ALLDEPTS...
-- a. Display all dept ids and cities
SELECT department_id, city
    FROM alldepts;
    
-- b. Display # of depts by city if it has any
SELECT count(department_id) AS Depts, city
    FROM alldepts
    GROUP BY city
    HAVING count(department_id) > 0;
    
-- Q8: Create a view called ALLDEPTSUMM that has dept id, dept name.
--     For each dept have the num of emps, num of salaried emps, 
--     and total salary of all emps.
--     Num of salaried can be diff from num of emps (Some get commission).
CREATE OR REPLACE VIEW alldeptsumm AS
    SELECT department_id, department_name, emp_total, salaried_emps, total_salary
    FROM departments JOIN
    (SELECT count(commission_pct) AS salaried_emps, sum(salary) AS total_salary, count(employee_id) AS emp_total, department_id FROM employees GROUP BY department_id)
    USING (department_id);
    
-- Q9: With ALLDEPTSUMM, display dept name, and num of emps by dept
--     where it's greater than the avg num of emps
SELECT department_name, emp_total
    FROM alldeptsumm
    WHERE emp_total > (SELECT avg(emp_total) FROM alldeptsumm);
    
-- Q10: Use GRANT to allow another student/Neptune acc to retrieve
--     data from your emps table and allow them to retrieve, insert,
--     update data in your depts table. Show proof.
GRANT SELECT ON employees TO dbs301_183g08;
GRANT SELECT, INSERT, UPDATE ON departments TO dbs301_183g08;

SELECT * FROM USER_TAB_PRIVS;

-- Use REVOKE to remove INSERT and UPDATE permission from your depts table
    
REVOKE INSERT, UPDATE ON departments FROM dbs301_183g08;

SELECT * FROM USER_TAB_PRIVS;
    

