/* ==============================================================================
   SQL Date & Time Functions
-------------------------------------------------------------------------------
   This script demonstrates various date and time functions in SQL.
   It covers functions such as GETDATE, DATETRUNC, DATENAME, DATEPART,
   YEAR, MONTH, DAY, EOMONTH, FORMAT, CONVERT, CAST, DATEADD, DATEDIFF,
   and ISDATE.
   
   Table of Contents:
     1. GETDATE | Date Values
     2. Date Part Extractions (DATETRUNC, DATENAME, DATEPART, YEAR, MONTH, DAY)
     3. DATETRUNC
     4. EOMONTH
     5. Date Parts
     6. FORMAT
     7. CONVERT
     8. CAST
     9. DATEADD / DATEDIFF
    10. ISDATE
===============================================================================
*/

/* ==============================================================================
   GETDATE() | DATE VALUES
===============================================================================*/

/* TASK 1:
   Display OrderID, CreationTime, a hard-coded date, and the current system date.
*/
SELECT
    OrderID,
    CreationTime,
    '2025-08-20' AS HardCoded,
    CURRENT_DATE() AS Today
FROM orders;

/* ==============================================================================
   DATE PART EXTRACTIONS
   (DATETRUNC, DATENAME, DATEPART, YEAR, MONTH, DAY)
===============================================================================*/

/* TASK 2:
   Extract various parts of CreationTime using DATETRUNC, DATENAME, DATEPART,
   YEAR, MONTH, and DAY.
*/
SELECT
    orderid,
    CreationTime,
    -- DATETRUNC Examples
    YEAR(CreationTime) AS Year_dt,
    DAY(CreationTime) AS Day_dt,
    MINUTE(CreationTime) AS Minute_dt,
  
    -- DATENAME Examples
    month(CreationTime) AS Month_dn,
    weekday(CreationTime) AS Weekday_dn,
    day(CreationTime) AS Day_dn,
    year(CreationTime) AS Year_dn,
    
    
    -- DATEPART Examples
	year(CreationTime) AS Year_dp, 
	month(CreationTime) AS Month_dp,
	day(CreationTime) AS Day_dp,
	hour(CreationTime) AS Hour_dp,
	quarter(CreationTime) AS Quarter_dp,
	week(CreationTime) AS Week_dp,
	YEAR(CreationTime) AS Year,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
	FROM orders;
 


/* ==============================================================================
   DATETRUNC() DATA AGGREGATION
===============================================================================*/

/* TASK 3:
   Aggregate orders by year using DATETRUNC on CreationTime.
*/
SELECT
    year(CreationTime) AS Creation,
    COUNT(*) AS OrderCount
FROM orders
GROUP BY Creation;

/* ==============================================================================
   EOMONTH()
===============================================================================*/

/* TASK 4:
   Display OrderID, CreationTime, and the end-of-month date for CreationTime.
*/
SELECT
    OrderID,
    CreationTime,
    endofmonth(CreationTime) AS EndOfMonth
FROM orders;

/* ==============================================================================
   DATE PARTS | USE CASES
===============================================================================*/

/* TASK 5:
   How many orders were placed each year?
*/
SELECT 
    YEAR(OrderDate) AS OrderYear, 
    COUNT(*) AS TotalOrders
FROM orders
GROUP BY OrderYear;

/* TASK 6:
   How many orders were placed each month?
*/
SELECT 
    MONTH(OrderDate) AS OrderMonth, 
    COUNT(*) AS TotalOrders
FROM orders
GROUP BY OrderMonth;

/* TASK 7:
   How many orders were placed each month (using friendly month names)?
*/
SELECT 
    month(OrderDate) AS OrderMonth, 
    COUNT(*) AS TotalOrders
FROM orders
GROUP BY OrderMonth;

/* TASK 8:
   Show all orders that were placed during the month of February.
*/
SELECT
    *
FROM orders
WHERE MONTH(OrderDate) = 2;

/* ==============================================================================
   FORMAT()
===============================================================================*/

/* TASK 9:
   Format CreationTime into various string representations.
*/
SELECT
    OrderID,
    CreationTime,
    FORMAT(CreationTime, 'MM-dd-yyyy') AS USA_Format,
    FORMAT(CreationTime, 'dd-MM-yyyy') AS EURO_Format,
    FORMAT(CreationTime, 'dd') AS dd,
    FORMAT(CreationTime, 'ddd') AS ddd,
    FORMAT(CreationTime, 'dddd') AS dddd,
    FORMAT(CreationTime, 'MM') AS MM,
    FORMAT(CreationTime, 'MMM') AS MMM,
    FORMAT(CreationTime, 'MMMM') AS MMMM
FROM orders;

/* TASK 10:
   Display CreationTime using a custom format:
   Example: Day Wed Jan Q1 2025 12:34:56 PM
*/
SELECT
    OrderID,
    CreationTime,
    'Day ' + FORMAT(CreationTime, 'ddd MMM') +
    ' Q' + (quarter(CreationTime)) + ' ' +
    FORMAT(CreationTime, 'yyyy hh:mm:ss tt') AS CustomFormat
FROM orders;

/* TASK 11:
   How many orders were placed each year, formatted by month and year (e.g., "Jan 25")?
*/
SELECT
    FORMAT(CreationTime, 'MMM yy') AS OrderDate,
    COUNT(*) AS TotalOrders
FROM orders
GROUP BY FORMAT(CreationTime, 'MMM yy');

/* ==============================================================================
   CONVERT()
===============================================================================*/

/* TASK 12:
   Demonstrate conversion using CONVERT.
*/
SELECT
    CONVERT(INT, '123') AS [String to Int CONVERT],
    CONVERT(DATE, '2025-08-20') AS [String to Date CONVERT],
    CreationTime,
    CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
    CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style:32],
    CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std. Style:34]
FROM orders;

/* ==============================================================================
   CAST()
===============================================================================*/

/* TASK 13:
   Convert data types using CAST.
*/
SELECT
    CAST('123' AS INT) AS [String to Int],
    CAST(123 AS VARCHAR) AS [Int to String],
    CAST('2025-08-20' AS DATE) AS [String to Date],
    CAST('2025-08-20' AS DATETIME2) AS [String to Datetime],
    CreationTime,
    CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM orders;

/* ==============================================================================
   DATEADD() / DATEDIFF()
===============================================================================*/

/* TASK 14:
   Perform date arithmetic on OrderDate.
*/
SELECT
    OrderID,
    OrderDate,
    DATE_ADD(OrderDate,  INTERVAL 10 DAY) AS TenDaysBefore,
    DATE_ADD(OrderDate,INTERVAL 90 DAY) AS ThreeMonthsLater,
    DATE_ADD(OrderDate,INTERVAL 730 DAY) AS TwoYearsLater
FROM orders;

/* TASK 15:
   Calculate the age of employees.
*/
SELECT
    employeeid,
    birthdate,
    Round((DATEDIFF( CURRENT_DATE(),birthdate) )/365 )AS Age
FROM employees;

/* TASK 16:
   Find the average shipping duration in days for each month.
*/

Select * from orders
SELECT
    MONTH(orderdate) AS OrderMonth,
    AVG(DATEDIFF(shipdate,orderdate)) AS AvgShip
FROM orders
GROUP BY MONTH(orderdate);

/* TASK 17:
   Time Gap Analysis: Find the number of days between each order and the previous order.
*/
SELECT
    orderid,
    orderdate AS CurrentOrderDate,
    LAG(orderdate) OVER (ORDER BY orderdate) AS LAG_PreviousOrderDate,
    DATEDIFF(LAG_PreviousOrderDate, orderdate) OVER () AS NrOfDays
FROM orders;

/* ==============================================================================
   ISDATE()
===============================================================================*/

/* TASK 18:
   Validate OrderDate using ISDATE and convert valid dates.
*/
SELECT
    OrderDate,
    ISDATE(OrderDate) AS IsValidDate,
    CASE 
        WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
        ELSE '9999-01-01'
    END AS NewOrderDate
FROM (
    SELECT '2025-08-20' AS OrderDate UNION
    SELECT '2025-08-21' UNION
    SELECT '2025-08-23' UNION
    SELECT '2025-08'
) AS t
-- WHERE ISDATE(OrderDate) = 0