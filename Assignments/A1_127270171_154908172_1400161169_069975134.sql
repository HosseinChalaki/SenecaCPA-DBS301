-- ***********************
-- Name: TRACY NGUYEN, 
-- ID: 127270171
-- Name: Mehedi Haque,
-- ID: 154908172
-- Name: Nirav Patel,
-- ID: 140061169
-- Name: Salim Arefi
-- ID: 069975134
-- Date: OCT 2018
-- Purpose: Assignment 1 - DBS301 SGG
-- ***********************


-- Q1: Display emp #, emp full name (lname, fname - call it Full Name), 
--     job, and hire date (point to last day of month. Form: "May 31st of 1996") of all emps
--     hired in May or Nov. of any year except 1994 - 1995. 
--     Order by most recently hired.

SELECT employee_id AS "Employee Num",
        SUBSTR(last_name||', '||first_name, 0,25) AS "Full Name",
        job_id AS "JOB",
        TO_CHAR(hire_date,'fm[Month DDth "of" YYYY]')AS "Start Day"
FROM employees
WHERE EXTRACT(MONTH FROM hire_date)IN('5','11') AND 
      EXTRACT(year FROM hire_date)NOT IN('1994','1995')
ORDER BY hire_date DESC, last_name;
                                                        
-- Q2: List emp #, full name, job and modified salary for all emps
--     whose monthly earning (before increase) is outside $6000 - $11000
--     and are VPs or MGRs (PRES not counted).
--     Use wildcards, sort by top salary (before increase).
--     VPs get %30 while MGRs get %20 increase.

SELECT 'Emp# ' || employee_id || 
        ' named ' || first_name || ' ' || last_name || ' who is ' ||
        CASE job_id WHEN '%VP' THEN 1.3*salary
        ELSE 1.2*salary END
        || ' will have a new salary of $' || salary AS empInfo
    FROM employees
    WHERE salary NOT BETWEEN 6000 AND 11000
        AND (UPPER(job_id) LIKE '%VP' OR employee_id IN (SELECT manager_id FROM departments))
    ORDER BY salary DESC, last_name;
    
-- Q3: Display emp last name, salary, job, and mgr # (Manager#) of emps not earning commission
--     OR if they work in the sales dept and their monthly salary + $1000 and commission (if applicable)
--     is greater than $15000
--     Assuming all emps receive bonuses. If the emp has no manager say NONE.
--     Display the total annual salary in the form '$999,999.99' titled as "Total Income".
--     Sort by the best paid emp.

SELECT last_name, salary AS Salary, job_id, manager_id AS Manager#, 
        to_char((salary + 1000 + NVL(commission_pct, 0) * salary) * 12, '$999,999.99') AS "Total Annual Salary"
    FROM employees
    WHERE commission_pct IS NULL OR (UPPER(job_id) LIKE 'SA%' AND (salary + 1000 + NVL(commission_pct, 0) * salary > 15000))
    ORDER BY salary DESC;
    
-- Q4: Display dept id, job id, and lowest salary as "Lowest Dept/Job Pay" 
--     but only if the lowest is $6000 - $18000
--     Exclude those who work any REP job or under the IT or SALES dept.
--     Sort by dept id the job_id and DON'T use subqueries.

SELECT department_id || ', ' || job_id || ', ' || to_char(min(salary), '$999,999.99') AS "Lowest Dept/Job Pay"
    FROM employees
    WHERE salary BETWEEN 6000 AND 18000 
        AND UPPER(job_id) NOT LIKE 'IT%' 
        AND UPPER(job_id) NOT LIKE 'SA%' 
        AND UPPER(job_id) NOT LIKE '%REP'
    GROUP BY department_id, job_id
    ORDER BY department_id, job_id;

-- Q5: Display last name, salary, and job for all emps who earn more than ALL
--     lowest paid emps per dept OUTSIDE the US.
--     Exclude PRES and VP PRES. Sort by job ASC. Use subqueries and JOIN.

SELECT last_name, salary, job_id
    FROM employees JOIN departments
    USING (department_id)
    JOIN locations
    USING (location_id)
    WHERE salary > ALL (SELECT salary FROM (SELECT NVL(min(salary), 0) AS Salary, department_id 
                                                FROM employees 
                                                WHERE UPPER(job_id) NOT LIKE '%PRES' 
                                                    AND UPPER(job_id) NOT LIKE '%VP' 
                                                GROUP BY department_id))
        AND UPPER(country_id) != 'US'
    ORDER BY job_id ASC;
    
    
-- Q6: Emps (last name, salary, and job) who work in IT or MARKETING dept and
--     earn more than the least paid emp in the ACCOUNTING dept.
--     Sort by last name and use ONLY subqueries (No JOINS).

SELECT last_name, salary, job_id
    FROM employees
    WHERE (UPPER(job_id) LIKE 'IT%' OR UPPER(job_id) LIKE 'MK%')
        AND salary > (SELECT min(salary) FROM employees WHERE department_id = 110)
    ORDER BY last_name;
    
-- Q7: Alphabetically display full name (fname lname AS Employee, 25 char), job, 
--     salary (format with commas but no decimal, left-padded with '=' for 12 char AS Salary) 
--     and dept# for each emp who earns less than the 
--     best paid unionized emp (Not PRES, MGR, or VP), and works in SALES or MKing dept

SELECT SUBSTR(first_name || ' ' || last_name, 0, 25) AS Employee, job_id, 
        LPAD(TO_CHAR(SUBSTR(salary, 0, 12), '$999,999'), 12, '=') AS Salary, department_id
    FROM employees JOIN departments
    USING (department_id)
    WHERE salary < (SELECT max(salary) 
                        FROM employees 
                        WHERE UPPER(job_id) NOT LIKE '%PRES' 
                            AND UPPER(job_id) NOT LIKE '%VP'
                            AND employee_id NOT IN (SELECT NVL(manager_id, 0) FROM departments))
        AND UPPER(department_name) IN ('SALES', 'MARKETING')
        AND employee_id NOT IN (SELECT NVL(manager_id, 0) FROM departments)
        ORDER BY Employee ASC;
                            
                            
-- Q8: Display dept name, city AS City (25 char) and number of diff jobs in each dept. AS "# of Jobs"
--     If city is null, print "Not Assigned Yet"
    
    SELECT department_name, SUBSTR(NVL(city, 'Not Assigned Yet'), 0, 25) AS City, COUNT(DISTINCT(job_id)) AS "# of Jobs"
            FROM employees FULL JOIN departments
            USING (department_id)
            LEFT OUTER JOIN locations
            USING (location_id)
            GROUP BY department_name, city;
    