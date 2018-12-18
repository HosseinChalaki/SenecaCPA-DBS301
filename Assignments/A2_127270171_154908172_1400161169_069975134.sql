-- ***********************
-- Name: TRACY NGUYEN, 
-- ID: 127270171
-- Name: Mehedi Haque,
-- ID: 154908172
-- Name: Nirav Patel,
-- ID: 140061169
-- Name: Salim Arefi
-- ID: 069975134
-- Date: DEC 2018
-- Purpose: Assignment 2 - DBS301 SGG
-- ***********************

-- Creation
CREATE TABLE Agency(
    AgencyID INT PRIMARY KEY,
    AgencyName VARCHAR2(40),
    AgencyPhoneNum NUMBER
);

CREATE TABLE Area (
    AreaID  INT PRIMARY KEY,
    AreaName VARCHAR2(40), 
    AreaComments VARCHAR2(256)
);

CREATE TABLE Outlet (
    OutletID INT PRIMARY KEY,
    OutletName VARCHAR2(40),
    OutletPhone NUMBER
);

CREATE TABLE PropertyLocation(
LocationID INT PRIMARY KEY,
Country VARCHAR2(40),
Province VARCHAR2(40),
City VARCHAR2(50),
Postal VARCHAR2(6),
Address VARCHAR2 (40),
AddressNumber NUMBER
);

CREATE TABLE School (
    SchoolID INT PRIMARY KEY,
    SchoolName VARCHAR2(40),
    SchoolType VARCHAR2(40),
    AreaID INT,
    CONSTRAINT AreaID_School_FK FOREIGN KEY(AreaID) REFERENCES Area(AreaID)
);
  
CREATE TABLE Clients (
    ClientID NUMBER PRIMARY KEY,
    FirstName varchar2(25),
    LastName varchar2(25),
    Phone int,
    Email varchar2(25),
    Status varchar2(25),
    Ownership_pct varchar2(25)
); 
  
    
    CREATE TABLE Property (
    PropertyID NUMBER PRIMARY KEY,
    AgencyID NUMBER,
    ClientID NUMBER,
    LocationID NUMBER,
    AreaID NUMBER,
    PropertyType VARCHAR2(40),
    Bedrooms NUMBER,
    Bathrooms NUMBER,
    SquareFeet NUMBER,
    LandSize NUMBER,
    MaintFee NUMBER,
    ParkingType VARCHAR2(40),
    ParkingSpace NUMBER,
    PropertyPrice NUMBER,
    CONSTRAINT AgencyID_Property_FK FOREIGN KEY(AgencyID) REFERENCES Agency(AgencyID),
    CONSTRAINT ClientsID_Property_FK FOREIGN KEY(ClientID) REFERENCES Clients(ClientID),
    CONSTRAINT LocationID_Property_FK FOREIGN KEY(LocationID) REFERENCES PropertyLocation(LocationID),
    CONSTRAINT AreaID_Property_FK FOREIGN KEY(AreaID) REFERENCES Area(AreaID)
    );
    

CREATE TABLE Advertisement (
AdvertID INT PRIMARY KEY,
OutletID INT,
PropertyID INT,
Date_Placed DATE,
AdvertCost INT,
CONSTRAINT OutletID_Advertisement_FK FOREIGN KEY(OutletID) REFERENCES Outlet(OutletID),
CONSTRAINT PropertyID_Advertisement_FK FOREIGN KEY(PropertyID) REFERENCES Property(PropertyID)
);


CREATE TABLE SoldProperty(
    SoldPropertyID INT PRIMARY KEY,
    PropertyID INT,
    ClientID INT,
    DateSold DATE,
    PriceSold NUMBER,
    ReferralID INT,
    CONSTRAINT PropertyID_SoldProperty_FK FOREIGN KEY(PropertyID) REFERENCES Property(PropertyID),
    CONSTRAINT ClientID_SoldProperty_FK FOREIGN KEY(ClientID) REFERENCES Clients(ClientID),
    CONSTRAINT ReferralID_SoldProperty_FK FOREIGN KEY (ReferralID) REFERENCES Clients(ClientID)
    );


-- Insertion
INSERT ALL
INTO Agency VALUES (100,'John Wick',9056666969)
INTO Agency VAlUES (101,'ReMax Ltd.',4163205209)
INTO Agency VALUES (102,'Good Homes Ltd.',4376612307)
INTO Agency VALUES (103,'Better Than Good Homes Ltd.',2893300080)
SELECT * FROM dual; 

INSERT ALL
INTO Area VALUES (100,'Etobicoke','close to lakeshore')
INTO Area VAlUES (101,'Milton North','Blank')
INTO Area VALUES (102,'Woodbridge','developing TRAFFIC')
INTO Area VALUES (103,'North York','has YorkU and SENECA')
INTO Area VALUES (104,'Scaraborough','')
INTO Area VALUES (105,'Bramalea','has a mall')
INTO Area VALUES (106,'Erin Mills','Blank')
INTO Area VALUES (107,'Downtown','Developed')
SELECT * FROM dual;

INSERT ALL
    INTO outlet VALUES(100, 'Tracy Advertising Ltd.', 4164004444)
    INTO outlet VALUES(101, 'Reko Ads Ltd.', 4160181207)
    INTO outlet VALUES(102, 'Metro Corp.', 9058842735)
    INTO outlet VALUES(103, 'Booster Ltd.', 6477121324)
SELECT * FROM dual;

 INSERT ALL
    INTO PropertyLocation VALUES(100, 'Canada', 'ON', 'TOR', 'M9W 2T4', 'York Lanez', 991)
    INTO PropertyLocation VALUES(101, 'Canada', 'ON', 'VAU', 'L4H 3K4', 'Buttonville', 18)
    INTO PropertyLocation VALUES(102, 'Canada', 'ON', 'MIL', 'L0P 1J0', 'Bay Mills', 666)
    INTO PropertyLocation VALUES(103, 'Canada', 'ON', 'MISS', 'L4T 0A4', 'Harmonia', 69)
    INTO PropertyLocation VALUES(104, 'Canada', 'ON', 'BRAMP', 'L5N 7K4', 'Elmhurst', 420)
    INTO PropertyLocation VALUES(105, 'Canada', 'ON', 'TOR', 'M9V 3R5', 'Spadina', 520)
    INTO PropertyLocation VALUES(106, 'Canada', 'ON', 'TOR', 'M4B 1B3', 'Dundas', 620)
    INTO PropertyLocation VALUES(107, 'Canada', 'ON', 'TOR', 'M5A 1T3', 'Queens', 720)
    INTO PropertyLocation VALUES(108, 'Canada', 'ON', 'TOR', 'M4C 1C5', 'Victoria Blvd', 820)
    INTO PropertyLocation VALUES(109, 'Canada', 'ON', 'TOR', 'M9M 4R3', 'Dufferin', 920)
    SELECT * FROM dual;   

    
INSERT ALL
    INTO School VALUES(100, 'Woodbridge Collegiate', 'HS', 102)
    INTO School VALUES(101, 'Riverdale Public', 'PS', 100)
    INTO School VALUES(102, 'Woodbridge PS', 'PS', 102)
    INTO School VALUES(103, 'Kent PS', 'MS', 103)
    INTO School VALUES(104, 'Sir Clint MacDonald', 'HS', 105)
    SELECT * FROM dual;
    
INSERT ALL 
INTO Clients VALUES(100,'Tracy','Nguyen',4164168008,'t.nguyen@grazi.com','buy',100)
INTO Clients VALUES(101,'Mehedi','Haque',6478889058,'m.haque@grazi.com','buy',30)
INTO Clients VALUES(102,'Salim','Arefi',9057878888,'arefi12@grazi.com','sell',100)
INTO Clients VALUES(103,'Nirav', 'Patel', 2897888585, 'patel.nirav@grazi.com', 'sell',60)
INTO Clients VALUES(104,'Jordan', 'Witley', 6457586363,'witly21@grazi.com','sell', 50)
INTO Clients VALUES(105,'Clint', 'McDonald', 6477777525, 'macdonald.farm@grazi.com', 'buy', 80)
INTO Clients VALUES(106,'Marcus','Papen',2897854562,'mrpapen@grazi.com','sell',100)
INTO Clients VALUES(107,'Danny','Nguyen',4165858588,'dannyyy@grazi.com','buy',70)
INTO Clients VALUES(108,'Ilin' ,'Haque', 9058589632, 'satansoffspring@grazi.com','buy',40)
INTO Clients VALUES(109,'Masoumeh','Babaee',2895224466,'masoumeh212@grazi.com','buy',100)
SELECT * FROM dual;

INSERT ALL    
 INTO Property VALUES(1000,100,104,100,100,'House',4,3,1200,1600,0,'Garage',4,800000)
 INTO Property VALUES(1001,100,102,101,102,'House',7,5,2400,3000,0,'Garage',6,1200000)
 INTO Property VALUES(1002,101,103,102,101,'Town House',3,2,950,1200,350,'Outside',2,500000)
 INTO Property VALUES(1003,100,106,103,106,'House',4,2,1240,2000,0,'Garage',3,650000)
 INTO Property VALUES(1004,102,102,104,105,'House',6,4,2000,2500,0,'Garage',3,750000)
 INTO Property VALUES(1005,100,104,105,104,'Condo',3,2,900,0,1000,'Underground',1,450000)
 INTO Property VALUES(1006,103,106,106,106,'House',3,2,1200,1600,0,'Roadside',0,800000)
 INTO property VALUES(1007, 100, 103, 107, 107, 'Condo', 2, 1, 600, 0, 560, 'Underground', 1, 380000)
 INTO property VALUES(1008, 102, 102, 108, 100, 'House', 4, 2, 1300, 1500, 0, 'Roadside', 0, 5000000)
 INTO property VALUES(1009, 103, 104, 109, 107, 'Condo', 1, 1, 250, 0, 260, 'Underground', 1, 280000)
 SELECT * FROM dual;

INSERT ALL
    INTO advertisement VALUES(1000, 100, 1000, TO_DATE('2017-12-01', 'YYYY-MM-DD'), 2000)
    INTO advertisement VALUES(1001, 103, 1001, TO_DATE('2018-01-01', 'YYYY-MM-DD'), 2500)
    INTO advertisement VALUES(1002, 100, 1002, TO_DATE('2018-02-15', 'YYYY-MM-DD'), 1800)
    INTO advertisement VALUES(1003, 100, 1003, TO_DATE('2018-06-01', 'YYYY-MM-DD'), 1700)
    INTO advertisement VALUES(1004, 101, 1004, TO_DATE('2018-06-06', 'YYYY-MM-DD'), 2000)
    INTO advertisement VALUES(1005, 102, 1005, TO_DATE('2018-07-10', 'YYYY-MM-DD'), 2000)
    INTO advertisement VALUES(1006, 101, 1006, TO_DATE('2018-07-27', 'YYYY-MM-DD'), 2500)
    INTO advertisement VALUES(1007, 100, 1007, TO_DATE('2018-08-19', 'YYYY-MM-DD'), 1500)
    INTO advertisement VALUES(1008, 101, 1008, TO_DATE('2018-09-06', 'YYYY-MM-DD'), 1600)
    INTO advertisement VALUES(1009, 103, 1009, TO_DATE('2018-11-07', 'YYYY-MM-DD'), 500)
SELECT * FROM dual;



INSERT ALL
    INTO SoldProperty VALUES(100, 1000, 100, TO_DATE('20181010', 'yyyymmdd'), 810000, NULL)
    INTO SoldProperty VALUES(101, 1008, 108, TO_DATE('20180913', 'yyyymmdd'), 480000, 105)
    INTO SoldProperty VALUES(102, 1005, 105, TO_DATE('20181128', 'yyyymmdd'), 440000, NULL)
    INTO SoldProperty VALUES(103, 1003, 109, TO_DATE('20180606', 'yyyymmdd'), 700000, NULL)
    INTO SoldProperty VALUES(104, 1004, 101, TO_DATE('20180615', 'yyyymmdd'), 735000, NULL)
    SELECT * FROM dual;


-- Views
CREATE OR REPLACE VIEW StateOfBusiness AS
    SELECT pricesold*0.025 AS Profits, SUM(advertcost) + COUNT(referralid)*500 AS Costs, (pricesold*0.025) - (SUM(advertcost) + COUNT(referralid)*500) AS Revenue
        FROM soldproperty JOIN advertisement
        USING(propertyid)
        GROUP BY pricesold*0.025, propertyid;

CREATE OR REPLACE VIEW PropertyForSale AS
    SELECT addressnumber || ' ' || address AS Address, postal, city, propertyid
        FROM propertylocation JOIN property
        USING(locationid)
        
        MINUS
        
    SELECT addressnumber || ' ' || address AS Address, postal, city, propertyid
        FROM soldproperty JOIN property
        USING (propertyid)
        JOIN propertylocation
        USING(locationid);
        
CREATE OR REPLACE VIEW ClientList AS
    SELECT clientid AS "Client ID", first_name AS "First Name", last_name AS "Last Name"
    FROM clients;

CREATE OR REPLACE VIEW YearlySalesReport AS
    SELECT SUM(pricesold) AS "Monthly Sales", SUM(advertcost) + COUNT(referralid)*500 AS "Monthly Costs", (TO_CHAR(datesold, 'MM')) AS "Month Sold"
        FROM soldproperty JOIN advertisement
        USING(propertyid)
        WHERE to_char(datesold, 'yyyy') = &input
        GROUP BY  (TO_CHAR(datesold, 'MM'));

    