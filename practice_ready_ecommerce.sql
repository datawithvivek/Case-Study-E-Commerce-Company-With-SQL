use ecommerce_company

-- Problem statement
-- You can analyze all the tables by describing their contents.
-- Task: Describe the Tables:
-- Customers
-- Products
-- Orders
-- OrderDetails

Select * from customers
Select * from orderdetails
Select * from orders
Select * from products
1
SELECT 
    location, COUNT(*) AS number_of_customers
FROM
    Customers
GROUP BY location
ORDER BY number_of_customers DESC
LIMIT 3

2
WITH CustomerOrders AS (
    SELECT customer_id, COUNT(order_id) AS NumberOfOrders
    FROM Orders
    GROUP BY customer_id
)
SELECT NumberOfOrders, COUNT(*) AS CustomerCount
FROM CustomerOrders
GROUP BY NumberOfOrders
ORDER BY NumberOfOrders ASC;

3

Select Product_id, avg(quantity) as AvgQuantity, sum(quantity*price_per_unit) as TotalRevenue
from OrderDetails
Group by Product_id
having avg(quantity)=2
Order By  sum(quantity*price_per_unit) desc

4

Select p.category , Count(distinct o.customer_id) as Unique_customers
from Products P 
Join Orderdetails od 
on p.Product_id=od.Product_id
join Orders o 
on o.Order_id=od.Order_id
group by p.category
Order by  Count(distinct o.customer_id) desc

5

WITH temp_table AS (
    SELECT 
        DATE_FORMAT(STR_TO_DATE(order_date, '%Y-%m-%d'), '%Y-%m') AS month,
        SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY DATE_FORMAT(STR_TO_DATE(order_date, '%Y-%m-%d'), '%Y-%m')
    ORDER BY month
)

SELECT 
    month,
    total_sales,
    ROUND(
        ((total_sales - LAG(total_sales) OVER (ORDER BY month)) / 
          LAG(total_sales) OVER (ORDER BY month)) * 100, 2
    ) AS percent_change
FROM temp_table;

6

WITH MonthlyOrderValues AS ( SELECT DATE_FORMAT(order_date, '%Y-%m') AS Month,
AVG(total_amount) AS AvgOrderValue FROM Orders GROUP BY Month )
SELECT Month, AvgOrderValue, ROUND((AvgOrderValue - LAG(AvgOrderValue) OVER (ORDER BY Month)), 2) AS ChangeInValue
FROM MonthlyOrderValues
order by changeInValue desc;

7

SELECT 
    product_id, COUNT(order_id) AS SalesFrequency
FROM
    OrderDetails
GROUP BY product_id
ORDER BY COUNT(order_id) DESC
LIMIT 5;







