-----------------------------------------------------------------------
-- NAME: Tracy Nguyen
-- ID: 127270171
-- DATE: October 9, 2018
-- Purpose: Lab #6 DBS301 SGG
-----------------------------------------------------------------------

-- Q1: Set autocommit on
SET AUTOCOMMIT ON;

-- Q2: Make an INSERT statement. Add yourself as a emp
--     w/ NULL salary, 0.2 commission, in dept 90, and manger 100
--     You started today.

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, commission_pct, manager_id, department_id)
    VALUES (300, 'TRACY', 'NGUYEN', 'TNGUYEN', sysdate, 'IT_PROG', 0.2, 100, 90);
    
-- Q3: UPDATE emp salary of emp w/ last name of
--     of Matos and Whalen to 2500

UPDATE employees
    SET salary = 2500
    WHERE last_name IN('Matos', 'Whalen');
    
-- Q4: Display last names of emps who're
--     in the same dept as Abel

SELECT last_name
    FROM employees
    WHERE (SELECT department_id 
                FROM employees 
                WHERE last_name = 'Abel')
        = department_id;

-- Question 4 with JOIN
SELECT e1.last_name
    FROM employees e1 JOIN employees e2
    ON e1.department_id = e2.department_id
    WHERE e2.last_name = 'Abel';
        
-- Q5: Display last name of lowest paid emp(s)

SELECT last_name
    FROM employees
    WHERE (SELECT min(salary)
                FROM employees)
        = salary;
    
-- Q6: Display city location of lowest paid emp(s)
            
SELECT city
    FROM locations 
    JOIN departments
        USING (location_id)
    JOIN employees
        USING (department_id)
    WHERE (SELECT min(salary)
                        FROM employees)
                = salary;
                
-- Q7: Display last_name, dept id, salary
--     of lowest paid emp in each dept
--     Sort by dept. Watch out for dept 60
    
SELECT last_name, tbl.department_id, tbl.salary
    FROM (SELECT department_id, min(salary) AS Salary
            FROM employees
            GROUP BY department_id) tbl JOIN employees e
            ON tbl.department_id = e.department_id AND tbl.salary = e.salary
            ORDER BY department_id;
            
            
    
-- Q8: Display last name of lowest paid emp(s) for each city

SELECT last_name, tbl.city
    FROM (SELECT min(salary) AS Salary, city
            FROM employees
            JOIN departments
                USING (department_id)
            JOIN locations
                USING (location_id)
            GROUP BY city) tbl JOIN employees e
            ON tbl.salary = e.salary
    ORDER BY tbl.city;

-- Q9: Display last name and salary for emps who earn
--     less than the lowest salary of any dept. 
--     Sort by top salaries then last name.

            FROM employees
-- Basically anything less than the greatest lowest salary of a dept.
SELECT last_name, salary
    FROM employees
    WHERE salary < (SELECT max(tbl.salary)
                            FROM (SELECT department_id, min(salary) AS Salary
                                    FROM employees
                                    GROUP BY department_id) tbl JOIN employees e
                                    ON tbl.department_id = e.department_id AND tbl.salary = e.salary)
    ORDER BY salary DESC, last_name;

-- Without MAX function, using ANY
SELECT last_name, salary
    FROM employees
    WHERE salary < ANY (SELECT tbl.salary
                            FROM (SELECT department_id, min(salary) AS Salary
                                    FROM employees
                                    GROUP BY department_id) tbl JOIN employees e
                                    ON tbl.department_id = e.department_id AND tbl.salary = e.salary)
    ORDER BY salary DESC, last_name;
    
-- Q10: Display last name, job title, and salary for all emps
--      whose salaries match any from the IT dept.
--      DON'T USE JOIN. Sort by salary ascending then last name.

SELECT last_name, job_id, salary
    FROM employees
    WHERE salary IN (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG')
    ORDER BY salary ASC, last_name;
