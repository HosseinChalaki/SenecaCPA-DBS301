-----------------------------------------------------------------------
-- NAME: Tracy Nguyen
-- ID: 127270171
-- DATE: November 17, 2018
-- Purpose: Lab #9 DBS301 SGG
-----------------------------------------------------------------------

-- Q1: Create SALESREP table loaded with EMPLOYEES data. 
--     Only use equivalent columns for dept 80. Should have 3 rows.
CREATE TABLE salesrep (
repid number(6),
fname varchar2(20),
lname varchar2(25),
phone# varchar2(20),
salary number(8,2),
commission number(2,2),
CONSTRAINT salesrep_repid_pk PRIMARY KEY (repid)
);

INSERT INTO salesrep
    SELECT employee_id, first_name, last_name, phone_number, salary, commission_pct 
        FROM employees
        WHERE department_id = 80;
    
-- Q2: Create CUST table and insert data
CREATE TABLE cust (
cust# number(6),
custname varchar2(30),
city varchar2(20),
rating char(1),
comments varchar2(200),
salesrep# number(7),
CONSTRAINT cust_cust#_pk PRIMARY KEY (Cust#),
CONSTRAINT cust_custname_city_uk UNIQUE (CustName, City),
CONSTRAINT cust_rating_ck CHECK (Rating IN ('A', 'B', 'C', 'D')),
CONSTRAINT cust_salesrep#_fk FOREIGN KEY (SalesRep#)
    REFERENCES salesrep (repid));
    
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(501, 'ABC LTD.', 'Montreal', 'C', 149);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(502, 'Black Giant', 'Ottawa', 'B', 174);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(503, 'Mother Goose', 'London', 'B', 174);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(701, 'BLUE SKY LTD', 'Vancouver', 'B', 176);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(702, 'MIKE and SAM LTD', 'Kingston', 'A', 174);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(703, 'RED PLANET', 'Missisauga', 'C', 174);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(717, 'BLUE SKY LTD', 'Regina', 'D', 176);

-- Q3: Create GOODCUST table and load with CUST where
--     the rating is A or B

CREATE TABLE goodcust (
custid NUMBER(6),
"name" VARCHAR2(30),
"location" VARCHAR2(20),
repid NUMBER(7));

INSERT INTO goodcust
    SELECT cust#, custname, city, salesrep#
        FROM cust
        WHERE UPPER(rating) IN ('A', 'B');


-- Q4: Add a new column to SALESREP called JobCode that will be
--     of variable character type with max len of 12. 
ALTER TABLE salesrep
    ADD JobCode VARCHAR2(12);
    

-- Q5: Declare a Salary column in SALESREP as mandatory and
--     change fname length in SALESREP to 37
ALTER TABLE salesrep
    MODIFY (salary NUMBER(8, 2) NOT NULL,
            lname VARCHAR2(25) NOT NULL,
            repid NUMBER(6) NOT NULL,
            fname VARCHAR2(37));




-- Q6: Remove JobCode column from SALESREP so it doesn't affect daily performance
ALTER TABLE salesrep
    DROP COLUMN jobcode;
    
-- Q7: Make PK for RepID and CustID
ALTER TABLE salesrep
ADD CONSTRAINT salesrep_repid_pk PRIMARY KEY (repid);

ALTER TABLE goodcust
ADD CONSTRAINT goodcust_custid_pk PRIMARY KEY (custid);


-- Q8: Make UK for Phone# and Name
ALTER TABLE salesrep
    ADD CONSTRAINT salesrep_phone#_uk UNIQUE (phone#);

ALTER TABLE goodcust
    ADD CONSTRAINT goodcust_name_uk UNIQUE ("name");
    
    
-- Q9: Restrict Salary to 6000 - 12000 and
--     Commission =< 50%
ALTER TABLE salesrep
    ADD CONSTRAINT salesrep_salary_ck CHECK(salary >= 6000 AND salary <= 12000)
    ADD CONSTRAINT salesrep_commission_ck CHECK(commission <= .50);
    

-- Q10: Ensure that valid repIDs from SALESREP may be entered
--      into GOODCUST. Why did this fail?
--INSERT INTO goodcust (repid)
--   SELECT repid FROM salesrep;
-- It failed because there was nothing to insert for custID.
-- Otherwise it would've been successful
    
-- Q11: Note the values for RepID in GOODCUST then make them blank.
--     Redo Q10, was it successful?
-- Yes

-- Q12: Disable the FK and enter the old values for RepID. 
--      Enable the FK. What happened?
-- The FK was enabled

-- Q13: Get rid of the FK then modify the CK from Q9
--      and allow Salary to range from 5000 to 15000
ALTER TABLE salesrep
    DROP CONSTRAINT salesrep_salary_ck;

ALTER TABLE salesrep
    ADD CONSTRAINT salesrep_salary_ck CHECK(salary >= 5000 AND salary <= 15000);

-- Q14: Describe SALESREP and GOODCUST
SELECT  constraint_name, constraint_type, search_condition, table_name
FROM user_constraints
WHERE UPPER(table_name) IN ('SALESREP', 'GOODCUST')
ORDER BY 4,2;
            

