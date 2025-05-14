create database banking_project;
CREATE TABLE cleaned_banking_data (
    State_Abbr VARCHAR(10),
    State_Name VARCHAR(100),
    Account_ID VARCHAR(50),
    Bank_Name VARCHAR(100),
    Branch_Name VARCHAR(100),
    BH_name varchar(100),
    BH_CODE VARCHAR(20),
    Age varchar(20),
    Caste VARCHAR(20),
    Center_ID VARCHAR(20),
    City VARCHAR(50),
    Client_ID VARCHAR(50),
    Client_Name VARCHAR(100),
    Close_Client VARCHAR(10),
    Closed_Date VARCHAR(20),
    Credit_Officer_Name VARCHAR(100),
    Date_of_Birth varchar(20),
    Disb_By VARCHAR(100),
    Disbursement_Date VARCHAR(20),
    Disbursement_Year VARCHAR(20),
    Gender_ID VARCHAR(10),
    Home_Ownership VARCHAR(20),
    Loan_Status VARCHAR(50),
    Product_Code VARCHAR(20),
    Grade VARCHAR(10),
    Product_ID VARCHAR(20),
    Purpose_Category VARCHAR(100),
    Region_Name VARCHAR(100),
    Religion VARCHAR(50),
    Verification_Status VARCHAR(50),
    Is_Delinquent_Loan VARCHAR(10),
    Is_Default_Loan VARCHAR(10),
    AGE_T VARCHAR(20),
    Delinq_2_Yrs varchar(20),
    Application_Type VARCHAR(20),
    Loan_Amount varchar(50),
    Funded_Amount varchar(50),
    Funded_Amount_Investor VARCHAR(50),
    Term VARCHAR(20),
    Int_Rate VARCHAR(50),
    Total_Fees VARCHAR(50),
    Total_rec_late_Fees varchar(50),
    Total_Recoveries varchar(50),
    Total_collection_recovery_Fees varchar(50),
    Total_payment varchar(50),
    Total_payment_inv varchar(50),
  TOTAL_RECOVERED_PRINCIPAL VARCHAR(50),
  TOTAL_RECEIVED_INTEREST VARCHAR(50)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CLEANED_BANK_DATA.csv'
INTO TABLE cleaned_banking_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
describe cleaned_banking_data;
select*from cleaned_banking_data;
select count(*) from cleaned_banking_data;
select distinct closed_date from cleaned_banking_data;
select distinct loan_amount from cleaned_banking_data;
select distinct int_rate from cleaned_banking_data;
## cleaning of data ##
UPDATE cleaned_banking_data SET State_Abbr = UPPER(TRIM(State_Abbr));
select distinct state_abbr from cleaned_banking_data ;
UPDATE cleaned_banking_data SET State_Name = TRIM(State_Name);
select distinct state_abbr,state_name from cleaned_banking_data ;
select distinct account_id from cleaned_banking_data ;
UPDATE cleaned_banking_data SET Account_ID = TRIM(Account_ID);
UPDATE cleaned_banking_data SET Account_ID = UPPER(Account_ID);
SELECT count( * )FROM cleaned_banking_data WHERE Account_ID IS NULL OR Account_ID = '';#count the null value or blank space
select distinct bank_name from cleaned_banking_data ;
select distinct branch_name from cleaned_banking_data ;
UPDATE cleaned_banking_data SET Branch_Name = UPPER(TRIM(Branch_Name));
select distinct bh_name from cleaned_banking_data ;
select distinct bh_code from cleaned_banking_data ;
select count(*) from cleaned_banking_data where age is null or age="" ;
ALTER TABLE cleaned_banking_data ADD Age_Int INT;
update cleaned_banking_data set age= upper(trim(age));
select caste from cleaned_banking_data ;
update cleaned_banking_data set caste= upper(trim(caste));
alter table cleaned_banking_data modify column center_id INT;
UPDATE cleaned_banking_data SET center_id = NULL WHERE TRIM(center_id) = '' OR center_id REGEXP '[^0-9]';
select CITY from cleaned_banking_data ;
UPDATE cleaned_banking_data SET City = UPPER(TRIM(City));
select CLIENT_ID from cleaned_banking_data ;
alter table cleaned_banking_data modify column CLIENT_ID INT;
select CLIENT_NAME from cleaned_banking_data ;
UPDATE cleaned_banking_data SET CLIENT_NAME = UPPER(TRIM(CLIENT_NAME));
select CLOSE_CLIENT from cleaned_banking_data ;
UPDATE cleaned_banking_data SET CLOSE_CLIENT = UPPER(TRIM(CLOSE_CLIENT));
select CLOSED_DATE from cleaned_banking_data ;
ALTER TABLE cleaned_banking_data ADD COLUMN closed_date_clean DATE;
UPDATE cleaned_banking_data SET closed_date_clean = STR_TO_DATE(CLOSED_DATE, '%d-%m-%Y');
ALTER TABLE cleaned_banking_data DROP COLUMN CLOSED_DATE;
ALTER TABLE cleaned_banking_data CHANGE closed_date_clean CLOSED_DATE DATE;
select CREDIT_OFFICER_NAME from cleaned_banking_data ;
select DATE_OF_BIRTH_cleaned from cleaned_banking_data LIMIT 100;
UPDATE cleaned_banking_data SET Date_of_Birth = REPLACE(Date_of_Birth, '/', '-');
ALTER TABLE cleaned_banking_data ADD COLUMN DATE_OF_BIRTH_CLEANED DATE;
SELECT DISTINCT Date_of_Birth FROM cleaned_banking_data WHERE Date_of_Birth NOT REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';
UPDATE cleaned_banking_data SET date_of_birth_cleaned = STR_TO_DATE(Date_of_Birth, '%d-%m-%Y') WHERE Date_of_Birth_cleaned REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';
UPDATE cleaned_banking_data SET DATE_OF_BIRTH_CLEANED = STR_TO_DATE(DATE_OF_BIRTH, '%d-%m-%Y');
alter table cleaned_banking_data drop column date_of_birth;
select disb_by from cleaned_banking_data;
select disbursement_date from cleaned_banking_data;
UPDATE cleaned_banking_data SET disbursement_date = REPLACE(disbursement_date, '/', '-');
SELECT DISTINCT disbursement_date FROM cleaned_banking_data WHERE disbursement_date  NOT REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';
UPDATE cleaned_banking_data SET disbursement_date = STR_TO_DATE(disbursement_date, '%d-%m-%Y') WHERE disbursement_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';
ALTER TABLE cleaned_banking_data modify disbursement_date DATE;
select disbursement_year from cleaned_banking_data;
select distinct gender_id from cleaned_banking_data;
select home_ownership from cleaned_banking_data;
select loan_status from cleaned_banking_data ;
select product_code from cleaned_banking_data ;
select count(*) from cleaned_banking_data where grade ="unknown";
select distinct grade from cleaned_banking_data;
UPDATE cleaned_banking_data
SET grade = 'UNKNOWN' WHERE grade IS NULL OR TRIM(grade) = '';
select distinct product_id from cleaned_banking_data;
select count(*) from cleaned_banking_data where product_id is null or trim(product_id)="";
select count(*)  from cleaned_banking_data where purpose_category is null or trim(purpose_category)="";
select purpose_category from cleaned_banking_data;
update  cleaned_banking_data set  purpose_category=upper(trim(purpose_category));
select count(*) from cleaned_banking_data where region_name is null or trim(region_name);
select count(*) from cleaned_banking_data where religion is null or trim(religion)="";
UPDATE cleaned_banking_data
SET religion= 'UNKNOWN' WHERE religion IS NULL OR upper(TRIM(religion)) = '';
select distinct religion from cleaned_banking_data;
select distinct verification_status from cleaned_banking_data;
select count(*) from cleaned_banking_data where verification_status is null or trim(verification_status)="";
UPDATE cleaned_banking_data
SET verification_status= 'UNKNOWN' WHERE verification_status IS NULL OR upper(TRIM(verification_status)) = '';
select distinct is_delinquent_loan from cleaned_banking_data;
select count(*) from cleaned_banking_data where is_delinquent_loan is null or trim(is_delinquent_loan)="";
select distinct is_default_loan from cleaned_banking_data;
select count(*) from cleaned_banking_data where is_default_loan is null or trim(is_default_loan)="";
select distinct age_t from cleaned_banking_data;
select count(*) from cleaned_banking_data where age_t is null or age_t="";
alter table cleaned_banking_data drop column age_t;
select distinct delinq_2_yrs from cleaned_banking_data;
select count(*) from cleaned_banking_data where  delinq_2_yrs is null or  delinq_2_yrs="";
select  application_type from cleaned_banking_data;
alter table cleaned_banking_data drop column application_type;
select loan_amount from cleaned_banking_data;
UPDATE cleaned_banking_data
SET loan_amount = REPLACE(REPLACE(loan_amount, '₹', ''), ',', '');
ALTER TABLE cleaned_banking_data MODIFY COLUMN Loan_Amount int;
desc cleaned_banking_data;
select Funded_Amount from cleaned_banking_data;
UPDATE cleaned_banking_data
SET funded_amount = REPLACE(REPLACE(funded_amount, '₹', ''), ',', '');
ALTER TABLE cleaned_banking_data MODIFY COLUMN Funded_Amount int;
select count(*)Funded_Amount_Investor from cleaned_banking_data where Funded_Amount_Investor is null or Funded_Amount_Investor ="" ;
UPDATE cleaned_banking_data
SET Funded_Amount_Investor = REPLACE(REPLACE(Funded_Amount_Investor, '₹', ''), ',', '');
ALTER TABLE cleaned_banking_data MODIFY COLUMN Funded_Amount int;
select term from cleaned_banking_data;
select Int_Rate from cleaned_banking_data;
alter table cleaned_banking_data modify column Int_Rate decimal(5,4);
select Total_Fees from cleaned_banking_data;
update cleaned_banking_data set total_fees = replace(total_fees,'₹','');
alter table cleaned_banking_data modify column Total_Fees decimal(6,2);
select count(*)Total_Fees from cleaned_banking_data where total_fees is null or total_fees="";
select Total_rec_late_Fees from cleaned_banking_data;
update cleaned_banking_data set total_rec_late_fees= replace(total_rec_late_fees,'₹','');
alter table cleaned_banking_data modify column total_rec_late_fees decimal(6,2);
select Total_Recoveries  from cleaned_banking_data;
SELECT Total_Recoveries  FROM cleaned_banking_data WHERE Total_Recoveries NOT REGEXP '^[0-9]+(\.[0-9]{1,2})?$';
UPDATE cleaned_banking_data SET Total_Recoveries = TRIM(REPLACE(REPLACE(Total_Recoveries, '₹', ''), ',', ''))
WHERE Total_Recoveries IS NOT NULL;
UPDATE cleaned_banking_data SET Total_Recoveries = NULL WHERE Total_Recoveries = '';
ALTER TABLE cleaned_banking_data MODIFY COLUMN Total_Recoveries DECIMAL(10,2);
UPDATE cleaned_banking_data SET Total_Recoveries = 0 WHERE Total_Recoveries IS NULL;
select Total_collection_recovery_Fees from cleaned_banking_data;
SELECT Total_collection_recovery_Fees  FROM cleaned_banking_data WHERE Total_collection_recovery_Fees NOT REGEXP '^[0-9]+(\.[0-9]{1,2})?$';
UPDATE cleaned_banking_data SET Total_collection_recovery_Fees = TRIM(REPLACE(REPLACE(Total_collection_recovery_Fees, '₹', ''), ',', ''))
WHERE Total_collection_recovery_Fees IS NOT NULL;
UPDATE cleaned_banking_data SET Total_collection_recovery_Fees = NULL WHERE Total_collection_recovery_Fees = '';
ALTER TABLE cleaned_banking_data MODIFY COLUMN Total_collection_recovery_Fees DECIMAL(10,2);
UPDATE cleaned_banking_data SET Total_collection_recovery_Fees = 0 WHERE Total_collection_recovery_Fees IS NULL;
select Total_payment from cleaned_banking_data;
SELECT  Total_payment  FROM cleaned_banking_data WHERE  Total_payment NOT REGEXP '^[0-9]+(\.[0-9]{1,2})?$';
UPDATE cleaned_banking_data SET  Total_payment = TRIM(REPLACE(REPLACE( Total_payment, '₹', ''), ',', ''))
WHERE  Total_payment IS NOT NULL;
ALTER TABLE cleaned_banking_data MODIFY COLUMN Total_collection_recovery_Fees DECIMAL(10,2);
UPDATE cleaned_banking_data SET Total_Recoveries = 0 WHERE Total_collection_recovery_Fees IS NULL;
select Total_payment_inv from cleaned_banking_data;
SELECT  Total_payment_inv  FROM cleaned_banking_data WHERE  Total_payment_inv NOT REGEXP '^[0-9]+(\.[0-9]{1,2})?$';
UPDATE cleaned_banking_data SET  Total_payment_inv = TRIM(REPLACE(REPLACE( Total_payment_inv, '₹', ''), ',', ''))
WHERE  Total_payment_inv IS NOT NULL;
ALTER TABLE cleaned_banking_data MODIFY COLUMN Total_payment_inv DECIMAL(10,2);
UPDATE cleaned_banking_data SET Total_payment_inv = 0 WHERE Total_payment_inv IS NULL;
select TOTAL_RECOVERED_PRINCIPAL from cleaned_banking_data;
SELECT  TOTAL_RECOVERED_PRINCIPAL  FROM cleaned_banking_data WHERE  TOTAL_RECOVERED_PRINCIPAL  NOT REGEXP '^[0-9]+(\.[0-9]{1,2})?$';
UPDATE cleaned_banking_data SET  TOTAL_RECOVERED_PRINCIPAL  = TRIM(REPLACE(REPLACE( TOTAL_RECOVERED_PRINCIPAL , '₹', ''), ',', ''))
WHERE TOTAL_RECOVERED_PRINCIPAL  IS NOT NULL;
ALTER TABLE cleaned_banking_data MODIFY COLUMN TOTAL_RECOVERED_PRINCIPAL  DECIMAL(20,2);
UPDATE cleaned_banking_data SET Total_payment_inv = 0 WHERE Total_payment_inv IS NULL;
select TOTAL_RECEIVED_INTERESt from cleaned_banking_data;
SELECT  TOTAL_RECEIVED_INTERESt  FROM cleaned_banking_data WHERE TOTAL_RECEIVED_INTERESt  NOT REGEXP '^[0-9]+(\.[0-9]{1,2})?$';
UPDATE cleaned_banking_data SET TOTAL_RECEIVED_INTERESt = TRIM(REPLACE(REPLACE(TOTAL_RECEIVED_INTERESt , '₹', ''), ',', ''))
WHERE TOTAL_RECEIVED_INTERESt IS NOT NULL;
ALTER TABLE cleaned_banking_data MODIFY COLUMN TOTAL_RECEIVED_INTERESt  DECIMAL(20,2);
UPDATE cleaned_banking_data SET TOTAL_RECEIVED_INTERESt = 0 WHERE TOTAL_RECEIVED_INTERESt IS NULL;
select age_int from cleaned_banking_data;
ALTER TABLE cleaned_banking_data drop COLUMN age_int  ;
select age from cleaned_banking_data;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

## KPI 1 TOTAL LOAN AMOUNT FUNDED:

select concat(round(sum(FUNDED_AMOUNT)/1000000,2),'' "M") AS TOTAL_LOAN_AMOUNT_FUNDED from cleaned_banking_data;

## KPI 2 TOTAL LOANS

SELECT count(ACCOUNT_ID) AS TOTAL_LOANS FROM cleaned_banking_data;

## KPI 3 TOTAL COLLECTION

SELECT CONCAT(ROUND(sum(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_COLLECTION FROM cleaned_banking_data;

## KPI 4 TOTAL INTEREST

SELECT CONCAT(ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_INTEREST FROM CLEANED_BANKING_DATA;

## KPI 5 TOP 10 AND BOTTOM 10 BRANCH WISE PERFORMANCE

SELECT BRANCH_NAME FROM cleaned_banking_data;
SELECT BRANCH_NAME AS BRANCH,COUNT(*) AS TOTAL_LOANS, CONCAT(ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT(ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT(ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT(ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data group by Branch_Name ORDER	BY COUNT(*) DESC LIMIT 10;

SELECT BRANCH_NAME AS BRANCH,COUNT(*) AS TOTAL_LOANS, CONCAT(ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT(ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT(ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT(ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data group by Branch_Name ORDER	BY COUNT(*) ASC LIMIT 10;

## KPI 6 TOP 10 AND BOTTOM 10 STATE WISE LOAN

SELECT State_Name AS STATE,COUNT(*) AS TOTAL_LOANS, CONCAT(ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT(ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT(ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT(ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data group by State_Name ORDER	BY COUNT(*) DESC LIMIT 10;

SELECT State_Name AS STATE,COUNT(*) AS TOTAL_LOANS, CONCAT(ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT(ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT(ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT(ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data group by State_Name ORDER	BY COUNT(*) ASC LIMIT 10;

## KPI 7 RELIGION WISE LOAN

SELECT RELIGION ,COUNT(*) AS TOTAL_LOANS, CONCAT(ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT(ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT(ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT(ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data group by RELIGION ORDER	BY COUNT(*) DESC ;

## KPI 8 PRODUCT GROUP WISE LOAN

SELECT Purpose_Category FROM cleaned_banking_data;
SELECT Purpose_Category AS PRODUCT_GROUP,COUNT(*) AS TOTAL_LOANS, CONCAT(ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT(ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT(ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT(ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data group by Purpose_Category ORDER	BY COUNT(*) desc;

## KPI 9 DISBURSEMENT TREND

SELECT DISBURSEMENT_YEAR FROM cleaned_banking_data;
SELECT Disbursement_Year AS FINANCIAL_YEAR ,COUNT(*) AS TOTAL_LOANS, CONCAT(ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT(ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT(ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT(ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE 
FROM cleaned_banking_data GROUP BY Disbursement_Year ORDER BY Disbursement_Year;

## KPI 10 GRADE WISE LOAN

SELECT Grade,COUNT(*) AS TOTAL_LOANS, CONCAT(ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT(ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT(ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT(ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data group by GRADE ORDER BY GRADE;

## KPI 11 DEFAULT LOAN COUNT

SELECT CONCAT(ROUND(SUM(Loan_Amount)/1000000,2),"" "M") AS DEFAULT_LOAN_AMOUNT,COUNT(*) AS DEFAULT_LOAN_COUNT FROM cleaned_banking_data WHERE Is_Default_Loan = "Y" ;

## KPI 12 DELINQUENT CLIENT COUNT
SELECT CONCAT(ROUND(SUM(Loan_Amount)/1000000,2),"" "M") AS DELINQUENT_LOAN_AMOUNT,COUNT(*) AS DELINQUENT_LOAN_COUNT FROM cleaned_banking_data WHERE Is_Delinquent_Loan = "Y" ;

## KPI 13 DELINQUENT LOAN RATE
SELECT 
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT FROM cleaned_banking_data;

## KPI 14  DEFAULT LOAN RATE
SELECT CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE FROM cleaned_banking_data;

## KPI 15 LOAN STATUS WISE LOAN
SELECT LOAN_STATUS FROM cleaned_banking_data;
SELECT Loan_Status ,COUNT(*) AS TOTAL_LOANS, CONCAT('₹',ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT('₹' ,ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT('₹' ,ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT('₹' ,ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data group by Loan_Status ORDER	BY COUNT(*) DESC LIMIT 10;

## KPI 16 AGE GROUP WISE LOAN
SELECT AGE AS AGE_GROUP ,count(*) AS TOTAL_LOANS, CONCAT('₹',ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,
CONCAT('₹' ,ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M")AS TOTAL_LOAN_AMOUNT,CONCAT('₹' ,ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT('₹' ,ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data group by AGE ORDER	BY COUNT(*) DESC ;

## KPI 17 LOAN MATURITY
SELECT TERM FROM cleaned_banking_data;

SELECT 
CASE
WHEN TERM <= 12 THEN "SHORT-TERM"
WHEN TERM BETWEEN 12 AND 36 THEN "MEDIUM-TERM"
WHEN TERM BETWEEN 36 AND 60 THEN "LONG-TERM"
ELSE "VERY LONG-TERM" END AS MATURITY_CATEGORY, YEAR(disbursement_date) AS DIS_YEARS,LOAN_STATUS,COUNT(*) AS LOAN_COUNT, 
CONCAT('₹',ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,CONCAT('₹',ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M") AS TOTAL_LOAN_AMOUNT,
CONCAT('₹' ,ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT('₹' ,ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE
FROM cleaned_banking_data GROUP BY MATURITY_CATEGORY,LOAN_STATUS,DIS_YEARS,TERM  ORDER BY Loan_Status LIMIT 10;

## KPI 18 NO VERIFIED LOANS
SELECT VERIFICATION_STATUS,TERM,LOAN_STATUS,COUNT(*) AS LOAN_COUNT, 
CONCAT('₹',ROUND(SUM(FUNDED_AMOUNT)/1000000,2),"" "M")AS TOTAL_FUNDED_AMOUNT,CONCAT('₹',ROUND(SUM(LOAN_AMOUNT)/1000000,2),"" "M") AS TOTAL_LOAN_AMOUNT,
CONCAT('₹' ,ROUND(SUM(TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M")AS TOTAL_INTEREST,
CONCAT('₹' ,ROUND(SUM(TOTAL_RECOVERED_PRINCIPAL+TOTAL_RECEIVED_INTEREST)/1000000,2),"" "M") AS TOTAL_COLLECTION,
CONCAT(ROUND(COUNT(CASE WHEN IS_DELINQUENT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%") AS DELINQUENT_LOAN_PERCENT,
CONCAT(ROUND(count(CASE WHEN IS_DEFAULT_LOAN="Y" THEN 1 END)*100/COUNT(*),2),"%")AS DEFAULT_LOAN_RATE FROM cleaned_banking_data GROUP BY Verification_Status,TERM,Loan_Status;





