/* ==============================================================================
   SQL Joins 
-------------------------------------------------------------------------------
   This document provides an overview of SQL joins, which allow combining data
   from multiple tables to retrieve meaningful insights.

   Table of Contents:
     1. Basic Joins
        - INNER JOIN
        - LEFT JOIN
        - RIGHT JOIN
        - FULL JOIN
     2. Advanced Joins
        - LEFT ANTI JOIN
        - RIGHT ANTI JOIN
        - ALTERNATIVE INNER JOIN
        - FULL ANTI JOIN
        - CROSS JOIN
     3. Multiple Table Joins (4 Tables)
=================================================================================
*/

/* ============================================================================== 
   BASIC JOINS 
=============================================================================== */

-- No Join
/* Retrieve all data from customers and orders as separate results */
SELECT * FROM customers;
SELECT * FROM orders;

Select count(*) from customers ;
Select count(*) from orders;

-- INNER JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */

SELECT   
   c.customerid,
    c.firstname,
    o.orderid,
    o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.customerid = o.customerid


-- LEFT JOIN
/* Get all customers along with their orders, 
   including those without orders */
SELECT
    c.customerid,
    c.firstname,
    o.orderid,
    o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.customerid = o.customerid

-- RIGHT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */

SELECT
    c.customerid,
    c.firstname,
    o.orderid,
    o.customerid,
    o.sales
FROM customers AS c 
RIGHT JOIN orders AS o 
ON c.customerid = o.customerid

-- Alternative to RIGHT JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
    c.customerid,
    c.firstname,
    o.orderid,
    o.sales
FROM orders AS o 
LEFT JOIN customers AS c
ON c.customerid = o.customerid

-- FULL JOIN
/* Get all customers and all orders, even if there’s no match */
SELECT
    c.customerid,
    c.firstname,
    o.orderid,
    o.customerid,
    o.sales
FROM customers AS c 
FULL JOIN orders AS o 
ON c.customerid = o.customerid

/* ============================================================================== 
   ADVANCED JOINS
=============================================================================== */

-- LEFT ANTI JOIN
/* Get all customers who haven't placed any order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.customerid = o.customerid
WHERE o.customerid IS NULL

-- RIGHT ANTI JOIN
/* Get all orders without matching customers */
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customerid = o.customerid
WHERE c.customerid IS NULL

-- Alternative to RIGHT ANTI JOIN using LEFT JOIN
/* Get all orders without matching customers */
SELECT *
FROM orders AS o 
LEFT JOIN customers AS c
ON c.customerid = o.customerid
WHERE c.customerid IS NULL

-- Alternative to INNER JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.customerid = o.customerid
WHERE o.customerid IS NOT NULL

-- FULL ANTI JOIN
/* Find customers without orders and orders without customers */
SELECT
    c.customerid,
    c.firstname,
    o.orderid,
    o.customerid,
    o.sales
FROM customers AS c 
FULL JOIN orders AS o 
ON c.customerid = o.customerid
WHERE o.customerid IS NULL OR c.customerid IS NULL

-- CROSS JOIN
/* Generate all possible combinations of customers and orders */
SELECT *
FROM customers
CROSS JOIN orders

/* ============================================================================== 
   MULTIPLE TABLE JOINS (4 Tables)
=============================================================================== */

/* Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

USE SalesDB

 SELECT 
    o.OrderID,
    o.Sales,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    p.Product AS ProductName,
    p.Price,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName
FROM orders AS o
LEFT JOIN customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Employees AS e
ON o.SalesPersonID = e.EmployeeID