-----------------------------------------------------------------------
-- NAME: Tracy Nguyen
-- ID: 127270171
-- DATE: September 27, 2018
-- Purpose: Lab #4 DBS301 SGG
-----------------------------------------------------------------------

-- Q1: Display the difference between average and lowest pay. 
--     Name it "Real Amount" and format to 2 decimals.

SELECT to_char((avg(salary) - min(salary)), '$999,999.99') AS "Real Amount"
    FROM employees;
    
-- Q2: Display dept. #, highest, lowest, and avg pay for each dept.
--     Name it 'High', 'Low', and 'Avg'. Sort by highest avg salary.
--     Format the output as currency.

SELECT department_id, 
        to_char(max(salary), '$999,999.99') AS "High", 
        to_char(min(salary), '$999,999.99') AS "Low", 
        to_char(avg(salary), '$999,999.99') AS "Avg"
    FROM employees
    GROUP BY department_id
    ORDER BY "Avg" DESC;
    
-- Q3: Display how many work the same job in the same dept. 
--     Name it Dept#, Job and How Many. Include only jobs that
--     have more than one person. Sort by # of people, descending.

SELECT department_id AS "Dept#", job_id AS "Job", count(job_id) AS "How Many"
    FROM employees
    GROUP BY department_id, job_id
    HAVING count(job_id) > 1
    ORDER BY "How Many" DESC;
    
-- Q4: For each job, display the title and total amount paid each
--     month. Exclude AD_PRES, AD_VP and only show jobs that
--     require more than $12,000. Sort by the most paid.

SELECT job_id, to_char(sum(salary), '$999,999.99') AS "Total Salary"
    FROM employees
    WHERE salary > 12000 AND job_id NOT IN ('AD_PRES', 'AD_VP')
    GROUP BY job_id
    ORDER BY "Total Salary";
    
-- Q5: For each manager ID, display the # of employees they supervise.
--     Exclude the IDs 100, 101, 102 and those supervising 2 or less.
--     Sort by manager IDs with most supervised persons first.

-- Subtract one in count to exclude manager
SELECT manager_id, count(employee_id) - 1 AS "# of Employees"
    FROM employees
    WHERE manager_id NOT IN (100, 101, 102)
    GROUP BY manager_id, department_id
    HAVING (count(employee_id) - 1) > 2
    ORDER BY "# of Employees";
    
-- Q6: For each dept. show the latest and earliest hire date.
--     Exclude dept 10, 20, and depts. where the last person was
--     hired this century. Sort by most recent dates.

SELECT department_id, min(hire_date) "Earliest Hire Date", max(hire_date) AS "Latest Hire Date"
    FROM employees
    WHERE department_id NOT IN (10, 20)
    GROUP BY department_id
    HAVING max(hire_date) < to_date('01-01-2001', 'DD-MM-YYYY')
    ORDER BY max(hire_date) DESC;