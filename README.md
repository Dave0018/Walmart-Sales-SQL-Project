# Walmart-Sales-SQL-Project
Walmart Sales Data — Cleaning & Analysis (SQL Project)
So I got this Walmart sales dataset in Excel and decided to work through the whole thing in SQL Server from importing the raw file all the way to pulling actual business insights out of it.
First thing I did was bring the data in through the SSMS Import Wizard. Sounds simple but the data came in messy , unit prices had dollar signs stuck in them, dates were stored as plain text, ratings were strings instead of numbers. Basically nothing was ready to work with straight away.
So I got to cleaning. I used a CTE with ROW_NUMBER() to hunt down and delete duplicate rows. Then I went column by column stripped the $ signs from unit prices and converted them to proper numbers, turned the text dates into actual DATE values, cast ratings and profit margins to FLOAT, and dropped all the original dirty columns once the clean versions were ready. I also added a few extra columns while I was at it — time of day (Morning / Afternoon / Evening), day name, month name, and a Revenue column calculated straight from price × quantity.
Once the data was clean, I ran queries to answer real questions: which city made the most revenue, what payment method customers used most, which product category performed best, which branch had the highest profit margin, and what time of day saw the most transactions.
Honestly the cleaning part took longer than the analysis which is pretty much always how it goes in real data work. But it was a good exercise in being methodical and not rushing to query dirty data.
Tools: SQL Server, SSMS, Excel.
## Screenshots

![Raw Data](Rough.PNG)
![Clean Table](main table.PNG)
![Query Result](nbb.PNG)
