SELECT TOP (1000) [invoice_id]
      ,[Branch]
      ,[City]
      ,[category]
      ,[unit_price]
      ,[quantity]
      ,[date]
      ,[time]
      ,[payment_method]
      ,[rating]
      ,[profit_margin]
  FROM [Portfolioproject].[dbo].[walt]

  select*
   FROM [Portfolioproject].[dbo].[walt]

   WITH row_kte AS (
    SELECT *, ROW_NUMBER() OVER(
        PARTITION BY invoice_id, Branch, City, category,
        unit_price, quantity, date, time, payment_method
        ORDER BY invoice_id
    ) AS row_num
    FROM [Portfolioproject].[dbo].[walt]
)
SELECT * FROM row_kte WHERE row_num > 1


WITH row_kte AS (
    SELECT *, ROW_NUMBER() OVER(
        PARTITION BY invoice_id, Branch, City, category,
        unit_price, quantity, date, time, payment_method
        ORDER BY invoice_id
    ) AS row_num
    FROM [Portfolioproject].[dbo].[walt]
)
DELETE FROM row_kte WHERE row_num > 1


SELECT * FROM [Portfolioproject].[dbo].[walt]
WHERE unit_price IS NULL
OR unit_price = ''
OR unit_price = '$'
OR quantity IS NULL

DELETE FROM [Portfolioproject].[dbo].[walt]
WHERE unit_price IS NULL
OR unit_price = ''
OR unit_price = '$'
OR quantity IS NULL


ALTER TABLE [Portfolioproject].[dbo].[walt]
ADD unit_price_clean FLOAT

UPDATE [Portfolioproject].[dbo].[walt]
SET unit_price_clean = CAST(REPLACE(unit_price, '$', '') AS FLOAT)

SELECT FORMAT(unit_price_clean, 'C', 'en-US') AS unit_price
FROM [Portfolioproject].[dbo].[walt]


SELECT TOP 10 date,
CONVERT(DATE, date, 103) AS clean_date
FROM [Portfolioproject].[dbo].[walt]

ALTER TABLE [Portfolioproject].[dbo].[walt]
ADD clean_date DATE

UPDATE [Portfolioproject].[dbo].[walt]
SET clean_date = CONVERT(DATE, date, 103)

SELECT * FROM [Portfolioproject].[dbo].[walt]

SELECT TOP 10 time,
CASE 
    WHEN CAST(time AS TIME) BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
    WHEN CAST(time AS TIME) BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
    ELSE 'Evening'
END AS time_of_day
FROM [Portfolioproject].[dbo].[walt]

ALTER TABLE [Portfolioproject].[dbo].[walt]
ADD time_of_day NVARCHAR(20)

UPDATE [Portfolioproject].[dbo].[walt]
SET time_of_day = 
CASE 
    WHEN CAST(time AS TIME) BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
    WHEN CAST(time AS TIME) BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
    ELSE 'Evening'
END

SELECT TOP 10 date,
DATENAME(WEEKDAY, CONVERT(DATE, date, 103)) AS day_name
FROM [Portfolioproject].[dbo].[walt]


ALTER TABLE [Portfolioproject].[dbo].[walt]
ADD day_name NVARCHAR(20)

UPDATE [Portfolioproject].[dbo].[walt]
SET day_name = DATENAME(WEEKDAY, CONVERT(DATE, date, 103))

SELECT * FROM [Portfolioproject].[dbo].[walt]


SELECT TOP 10 date,
DATENAME(MONTH, CONVERT(DATE, date, 103)) AS month_name
FROM [Portfolioproject].[dbo].[walt]

ALTER TABLE [Portfolioproject].[dbo].[walt]
ADD month_name NVARCHAR(20)

UPDATE [Portfolioproject].[dbo].[walt]
SET month_name = DATENAME(MONTH, CONVERT(DATE, date, 103))


SELECT * FROM [Portfolioproject].[dbo].[walt]
WHERE CAST(rating AS FLOAT) < 1 
OR CAST(rating AS FLOAT) > 10


SELECT TOP 10 rating, CAST(rating AS FLOAT) AS clean_rating
FROM [Portfolioproject].[dbo].[walt]


ALTER TABLE [Portfolioproject].[dbo].[walt]
ADD rating_clean FLOAT


UPDATE [Portfolioproject].[dbo].[walt]
SET rating_clean = CAST(rating AS FLOAT)

ALTER TABLE [Portfolioproject].[dbo].[walt]
DROP COLUMN unit_price

ALTER TABLE [Portfolioproject].[dbo].[walt]
DROP COLUMN date

ALTER TABLE [Portfolioproject].[dbo].[walt]
DROP COLUMN rating


SELECT * FROM [Portfolioproject].[dbo].[walt]


SELECT count(*)
FROM [Portfolioproject].[dbo].[walt]

SELECT distinct city
FROM [Portfolioproject].[dbo].[walt]

SELECT distinct payment_method
FROM [Portfolioproject].[dbo].[walt]


SELECT TOP 1 payment_method, COUNT(*) AS usage_count
FROM [Portfolioproject].[dbo].[walt]
GROUP BY payment_method
ORDER BY usage_count DESC;

select *
FROM [Portfolioproject].[dbo].[walt]


SELECT Branch, COUNT(*) AS usage_count
FROM [Portfolioproject].[dbo].[walt]
GROUP BY Branch
ORDER BY usage_count desc ;
SELECT TOP 1 rating_clean
FROM [Portfolioproject].[dbo].[walt]
GROUP BY rating_clean
ORDER BY rating_clean DESC;


SELECT TOP 1 city, SUM(total) AS total_sales
FROM [Portfolioproject].[dbo].[walt]
GROUP BY city
ORDER BY total_sales DESC;


SELECT TOP 1 city, SUM(unit_price_clean) AS total_sales
FROM [Portfolioproject].[dbo].[walt]
GROUP BY city
ORDER BY total_sales DESC;






SELECT TOP 1 rating_clean, COUNT(*) AS frequency
FROM [Portfolioproject].[dbo].[walt]
GROUP BY rating_clean
ORDER BY frequency DESC;

SELECT *
FROM [Portfolioproject].[dbo].[walt]
WHERE rating_clean = (
    SELECT MAX(rating_clean)
    FROM [Portfolioproject].[dbo].[walt]
);

WITH RankedTransactions AS (
    SELECT *,
          DENSE_RANK () OVER (ORDER BY rating_clean DESC) AS rank_num
    FROM [Portfolioproject].[dbo].[walt]
)
SELECT *
FROM RankedTransactions
WHERE rank_num = 1;

SELECT TOP 1 city, SUM(Revenue) AS total_sales
FROM [Portfolioproject].[dbo].[walt]
GROUP BY city
ORDER BY total_sales DESC;


select *
FROM [Portfolioproject].[dbo].[walt]


select unit_price_clean * quantity as revenue
FROM [Portfolioproject].[dbo].[walt]


ALTER TABLE [Portfolioproject].[dbo].[walt]
ADD Revenue  int


UPDATE [Portfolioproject].[dbo].[walt]
SET Revenue = unit_price_clean * quantity



SELECT TOP 1 category, SUM(Revenue) AS total_Revenue
FROM [Portfolioproject].[dbo].[walt]
GROUP BY category
ORDER BY total_Revenue DESC;

SELECT  category, Avg(rating_clean)  AS Avg_rating
FROM [Portfolioproject].[dbo].[walt]
GROUP BY category
ORDER BY Avg_rating DESC;



SELECT TOP 1 time_of_day, COUNT(*) AS usage_count 
FROM [Portfolioproject].[dbo].[walt]
GROUP BY time_of_day
ORDER BY usage_count  DESC;




SELECT TOP 1 day_name, sum(revenue) AS usage 
FROM [Portfolioproject].[dbo].[walt]
GROUP BY day_name
ORDER BY usage DESC;



SELECT TOP 1 Branch, AVG(profit_margin) AS top_profit_margin
FROM [Portfolioproject].[dbo].[walt]
GROUP BY Branch
ORDER BY top_profit_margin DESC

SELECT TOP 10 profit_margin, CAST(profit_margin AS FLOAT) AS clean_margin
FROM [Portfolioproject].[dbo].[walt]

ALTER TABLE [Portfolioproject].[dbo].[walt]
ADD profit_margin_clean FLOAT


UPDATE [Portfolioproject].[dbo].[walt]
SET profit_margin_clean = CAST(profit_margin AS FLOAT)


ALTER TABLE [Portfolioproject].[dbo].[walt]
DROP COLUMN profit_margin

SELECT TOP 1 Branch, AVG(profit_margin_clean) AS top_profit_margin
FROM [Portfolioproject].[dbo].[walt]
GROUP BY Branch
ORDER BY top_profit_margin DESC


select *
FROM [Portfolioproject].[dbo].[walt]


SELECT TOP 1 month_name, SUM(Revenue) AS total_revenue
FROM [Portfolioproject].[dbo].[walt]
GROUP BY month_name
ORDER BY total_revenue DESC


SELECT category, 
FORMAT(AVG(unit_price_clean), 'C', 'en-US') AS avg_unit_price
FROM [Portfolioproject].[dbo].[walt]
GROUP BY category
ORDER BY AVG(unit_price_clean) DESC

SELECT TOP 1 City, AVG(rating_clean) AS Avg_city_rating
FROM [Portfolioproject].[dbo].[walt]
GROUP BY city
ORDER BY Avg_city_rating DESC

SELECT City, payment_method, COUNT(*) AS total_transactions
FROM [Portfolioproject].[dbo].[walt]
GROUP BY City, payment_method
ORDER BY City, total_transactions DESC


select *
FROM [Portfolioproject].[dbo].[walt]

