-----------------------------------------------------------------------
-- NAME: Tracy Nguyen
-- ID: 127270171
-- DATE: October 5, 2018
-- Purpose: Lab #5 DBS301 SGG
-----------------------------------------------------------------------

-- Q1: Display dept name, city, address and postal code for depts.
--     Sort by city and dept name

SELECT department_name, city, street_address, postal_code
    FROM departments, locations
    WHERE departments.location_id = locations.location_id
    ORDER BY city, department_name;
    
-- Q2: Display emp's full name as one field (last, first), hire date, 
--     salary, dept name, and city but only for depts starting with 'A' or 'S'.
--     Sort by dept name and emp name

SELECT last_name || ' ' || first_name AS full_name, 
        hire_date, salary, department_name
    FROM employees, departments
    WHERE employees.department_id = departments.department_id
        AND (UPPER(department_name) LIKE 'A%' OR UPPER(department_name) LIKE 'S%')
    ORDER BY department_name, full_name;
    
-- Q3: Display manager's full name in states/provinces of Ont., Cali., Washington
--     and dept name, city, postal code and province name
--     Sort by city and dept name

SELECT first_name || ' ' || last_name AS full_name,
        department_name, city, postal_code, state_province
        FROM employees, departments, locations
        WHERE employees.employee_id = departments.manager_id
            AND locations.location_id = departments.location_id
            AND UPPER(state_province) IN ('ONTARIO', 'CALIFORNIA', 'WASHINGTON')
        ORDER BY city, department_name;
        
-- Q4: Display employee's last name, emp's id, manager's last name, and manager's id
--     Label the columns as Employee, Emp#, Manager, and Mgr#

SELECT last_name AS Employee, employee_id AS Emp#, last_name AS Manager, departments.manager_id AS Mgr#
    FROM employees, departments
    WHERE employees.manager_id = departments.manager_id;
    
----------------- Using JOIN statement ---------------------

-- Q5: Display dept name, city, address, postal code, and country for all depts.
--     Use JOIN and USING. Sort by dept name descending

SELECT department_name, city, street_address, postal_code, country_name
    FROM departments
    JOIN locations
    USING (location_id)
    JOIN countries
    USING (country_id)
    ORDER BY department_name DESC;
    
-- Q6: Display emp's full name (First/Last), hire date, salary and dept name
--     Only select depts starting with 'A' or 'S'
--     Use JOIN and ON then sort by dept name and last name

SELECT first_name || '/' || last_name AS full_name, hire_date, salary, department_name
    FROM employees JOIN departments
    ON employees.department_id = departments.department_id
    WHERE UPPER(department_name) LIKE 'A%' OR UPPER(department_name) LIKE 'S%'
    ORDER BY department_name, last_name;
    
-- Q7: Display manager's full name (Last, First) for each dept in 
--     Ont., Cali, and Washington, 
--     dept name, city, postal code, and province name.
--     Use JOIN and ON. Sort by city then dept name.

SELECT last_name || ', ' || first_name AS full_name, department_name, city, postal_code, state_province
    FROM employees e
    JOIN departments d
    ON e.employee_id = d.manager_id 
    JOIN locations l
    ON l.location_id = d.location_id
    WHERE UPPER(state_province) IN ('ONTARIO', 'CALIFORNIA', 'WASHINGTON')
    ORDER BY city, department_name;
    
-- Q8: Display dept name and highest(High), lowest(Low), avg(Avg) pay per dept.
--     Use JOIN and ON. Sort by highest salary.

SELECT department_name, max(salary) AS High, min(salary) AS Low, to_char(avg(salary), '$999,999.99') AS Avg
    FROM departments JOIN employees
    ON departments.department_id = employees.department_id
    GROUP BY department_name
    ORDER BY High;
    
-- Q9: Display emp last name, emp id, manager last name, and manager id.
--     Label it Employee, Emp#, Manager and Mgr#
--     Include emp's w/o managers and emp's who don't supervise anyone

SELECT emp.last_name AS Employee, emp.employee_id AS Emp#, empMgr.last_name AS Manager, emp.manager_id AS manager_id
    FROM employees empMgr JOIN employees emp
    ON empMgr.employee_id = emp.manager_id
    OR (emp.manager_id IS NULL AND emp.employee_id = empMgr.employee_id);