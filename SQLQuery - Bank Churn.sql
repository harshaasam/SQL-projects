USE PRACTICE
SELECT * FROM BANK_CHURN

/* 1.Find the average balance of customers who have more than the average number of products and are active members.*/

SELECT AVG(BALANCE) AVERAGE_BALANCE 
FROM BANK_CHURN 
WHERE IS_ACTIVE_MEMBER = 1 AND 
NUM_OF_PRODUCTS >(SELECT AVG(NUM_OF_PRODUCTS) FROM BANK_CHURN)


/* 2.Identify the top 3 most common Geography-Gender combinations among customers who have churned.*/

SELECT TOP 3 GEOGRAPHY,GENDER, COUNT(*) COUNT 
FROM BANK_CHURN 
GROUP BY GEOGRAPHY, GENDER 
ORDER BY COUNT(*) DESC


/* 3.For each Geography, determine the churn rate (percentage of customers who churned)*/

SELECT GEOGRAPHY, 
CEILING(SUM(CASE WHEN CHURN = 1 THEN 1 ELSE 0 END)*100.0/COUNT(*)) CHURN_PERCENT 
FROM BANK_CHURN 
GROUP BY GEOGRAPHY 


/* 4.Which age group (e.g., 20–30, 31–40, 41–50, etc.) has the highest churn rate?*/

WITH CTE AS (
SELECT *, CASE WHEN AGE >=10 AND AGE <=20 THEN '10-20'
			   WHEN AGE >=21 AND AGE <=30 THEN '21-30'
			   WHEN AGE >=31 AND AGE <=40 THEN '31-40'
			   WHEN AGE >=41 AND AGE <=50 THEN '41-50'
			   WHEN AGE >=51 AND AGE <=60 THEN '51-60'
			   WHEN AGE >=61 AND AGE <=70 THEN '61-70'
			   WHEN AGE >=71 AND AGE <=80 THEN '71-80'
			   WHEN AGE >=81 AND AGE <=90 THEN '81-90'
			   WHEN AGE >=91 AND AGE <=100 THEN '91-100' END AGE_GROUPS
			   FROM BANK_CHURN)
SELECT AGE_GROUPS, FLOOR(SUM(CASE WHEN CHURN = 1 THEN 1 ELSE 0 END)*100.0/COUNT(*)) CHURN_RATE 
FROM CTE 
GROUP BY AGE_GROUPS 
ORDER BY CHURN_RATE DESC


/* 5.Find the average tenure of customers who have a balance of 0 and have churned. Is it different from those who didn't churn with balance = 0? */

SELECT AVG(CASE WHEN BALANCE = 0 AND CHURN = 1 THEN TENURE END)AVG_CHURN_TENURE,
AVG(CASE WHEN BALANCE = 0 AND CHURN = 0 THEN TENURE END) AVG_DIDNT_CHURN_TENURE
FROM BANK_CHURN


/* 6.For each number of products (Num Of Products), find the churn percentage, and identify the number of products that leads to the highest churn rate. */

SELECT NUM_OF_PRODUCTS, 
ROUND(SUM(CASE WHEN CHURN = 1 THEN 1 ELSE 0 END)*100.0/COUNT(*),2) CHURN_RATE
FROM BANK_CHURN 
GROUP BY NUM_OF_PRODUCTS 
ORDER BY CHURN_RATE DESC


/* 7.List customers who have a credit score above the average for their own country (Geography) but have still churned. */

WITH CTE AS (
SELECT GEOGRAPHY,AVG(CREDITSCORE) AVG_CREDIT_SCORE FROM BANK_CHURN GROUP BY GEOGRAPHY)
SELECT B.Surname,B.CREDITSCORE,A.GEOGRAPHY,A.AVG_CREDIT_SCORE
FROM CTE A INNER JOIN BANK_CHURN B
ON A.GEOGRAPHY = B.GEOGRAPHY 
WHERE A.AVG_CREDIT_SCORE < B.CREDITSCORE


/* 8.Among customers with 2 or more products, find how many have never used a credit card and still remained active members.*/

SELECT COUNT(*) NO_OF_CUSTOMERS FROM BANK_CHURN WHERE NUM_OF_PRODUCTS >=2 AND HAS_CREDIT_CARD = 0 AND IS_ACTIVE_MEMBER = 1



/* 9.Find customers whose estimated salary is above the 75th percentile and who also have a credit card but are not active members.*/
SELECT * FROM Bank_churn WHERE ESTIMATED_SALARY>(
SELECT DISTINCT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY ESTIMATED_SALARY) OVER() FROM BANK_CHURN)




