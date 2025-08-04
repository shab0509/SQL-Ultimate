/* ==============================================================================
   SQL SET Operations
-------------------------------------------------------------------------------
   SQL set operations enable you to combine results from multiple queries
   into a single result set. This script demonstrates the rules and usage of
   set operations, including UNION, UNION ALL, EXCEPT, and INTERSECT.
   
   Table of Contents:
     1. SQL Operation Rules
     2. UNION
     3. UNION ALL
     4. EXCEPT
     5. INTERSECT
=================================================================================
*/

/* ==============================================================================
   RULES OF SET OPERATIONS
===============================================================================*/

/* RULE: Data Types
   The data types of columns in each query should match.
*/
SELECT
    Firstname,
    lastname ,
    country
FROM Customers
UNION
SELECT
    firstname,
    lastName
FROM employees;

/* RULE: Data Types (Example)
   The data types of columns in each query should match.
*/
Select * FROM employees

SELECT
    customerID,
    lastname
FROM customers
UNION
SELECT
    firstname,
    lastname
FROM employees;

/* RULE: Column Order
   The order of the columns in each query must be the same.
*/
SELECT
    lastname,
    customerid
FROM customers
UNION
SELECT
    employeeid,
    lastname
FROM employees;

/* RULE: Column Aliases
   The column names in the result set are determined by the column names
   specified in the first SELECT statement.
*/
SELECT
    customerid AS ID,
    lastname AS Last_Name
FROM  customers
UNION
SELECT
    employeeid,
    lastname
FROM employees;

/* RULE: Correct Columns
   Ensure that the correct columns are used to maintain data consistency.
*/
SELECT
    firstname,
    lastname
FROM customers
UNION
SELECT
    lastname,
    firstname
FROM employees;

/* ==============================================================================
   SETS: UNION, UNION ALL, EXCEPT, INTERSECT
===============================================================================*/

/* TASK 1: 
   Combine the data from Employees and Customers into one table using UNION 
*/
SELECT
    firstname,
    lastname
FROM customers
UNION
SELECT
    firstname,
    lastname
FROM employees
order by firstname;

/* TASK 2: 
   Combine the data from Employees and Customers into one table, including duplicates, using UNION ALL 
*/
SELECT
    firstname,
    lastname
FROM customers
UNION ALL
SELECT
    firstname,
    lastname
FROM employees
order by firstname;

/* TASK 3: 
   Find employees who are NOT customers using EXCEPT 
*/
SELECT
    firstname,
    lastname
FROM employees
EXCEPT
SELECT
    firstname,
    lastname
FROM customers;

/* TASK 4: 
   Find employees who are also customers using INTERSECT 
*/

SELECT
    firstname,
    lastname
FROM employees
INTERSECT
SELECT
    firstname,
    lastname
FROM customers;

/* TASK 5: 
   Combine order data from Orders and OrdersArchive into one report without duplicates 
*/
SELECT
    'Orders' AS SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
FROM orders
UNION
SELECT
    'OrdersArchive' AS SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
FROm orders_archive
ORDER BY orderid;