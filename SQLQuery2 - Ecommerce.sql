USE PRACTICE
SELECT * FROM ECOMMERCE
 /* 1. CALCULATE ON-TIME DELIVERY RATE PER WAREHOUSE */

 SELECT Warehouse_block, COUNT(*) FROM ecommerce WHERE Reached_on_Time_Y_N = 1 GROUP BY Warehouse_block

 SELECT Warehouse_block, COUNT(*) FROM ecommerce WHERE Reached_on_Time_Y_N = 0 GROUP BY Warehouse_block

 SELECT Warehouse_block, 
 CEILING(COUNT(CASE WHEN Reached_on_Time_Y_N = 1 THEN 1 END)*100.0/COUNT(*)) COUNTER 
 FROM ecommerce 
 GROUP BY Warehouse_block
 ORDER BY COUNTER DESC

 /* 2. Most efficient mode of shipment */
 

 SELECT Mode_of_Shipment, 
 (COUNT(CASE WHEN Reached_on_Time_Y_N = 1 THEN 1 END)*100/COUNT(*)) ON_TIME_DELIVERY_PERCENTAGE,
 AVG(Cost_of_the_Product) AVERAGE_COST,
 AVG(WEIGHT_IN_GMS) AVERAGE_WEIGHT,
 AVG(CUSTOMER_RATING) AVG_CUSTOMER_RATING
 FROM ecommerce 
 GROUP BY Mode_of_Shipment

 /* 3. CUSTOMER BEHAVIOUR INSIGHTS */

 SELECT Customer_rating,
 COUNT(CASE WHEN Reached_on_Time_Y_N = 1 THEN 1 END)*100/COUNT(*) ON_TIME_DELIVERY_PERCENTAGE,
 AVG(CUSTOMER_CARE_CALLS) AVG_CUSTOMER_CARE_CALLS,
 AVG(Discount_offered) AVG_DISCOUNT_OFFERED
 FROM ecommerce
 GROUP BY Customer_rating
 ORDER BY Customer_rating DESC


 /* 4. PRODUCT IMPORTANCE BY DELIVERY SUCCESS */

 SELECT Product_importance,
 COUNT(CASE WHEN Reached_on_Time_Y_N = 1 THEN 1 END)*100/COUNT(*) ON_TIME_DELIVERY_PERCENTAGE 
 FROM ECOMMERCE
 GROUP BY Product_importance
 ORDER BY Product_importance

  SELECT Product_importance,Warehouse_block, 
 COUNT(CASE WHEN Reached_on_Time_Y_N = 1 THEN 1 END)*100/COUNT(*) ON_TIME_DELIVERY_PERCENTAGE 
 FROM ECOMMERCE
 GROUP BY Product_importance,Warehouse_block
 ORDER BY Product_importance,Warehouse_block


 SELECT Product_importance,Warehouse_block,MODE_OF_SHIPMENT, 
 COUNT(CASE WHEN Reached_on_Time_Y_N = 1 THEN 1 END)*100/COUNT(*) ON_TIME_DELIVERY_PERCENTAGE 
 FROM ECOMMERCE
 GROUP BY Product_importance,Warehouse_block,MODE_OF_SHIPMENT
 ORDER BY Product_importance,Warehouse_block,MODE_OF_SHIPMENT

 SELECT Product_importance,AVG(WEIGHT_IN_GMS) AVG_WEIGHT,
 COUNT(CASE WHEN Reached_on_Time_Y_N = 1 THEN 1 END)*100/COUNT(*) ON_TIME_DELIVERY_PERCENTAGE
 FROM ECOMMERCE
 GROUP BY Product_importance
 ORDER BY Product_importance

 SELECT * FROM ecommerce