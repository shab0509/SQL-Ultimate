/* ==============================================================================
   SQL Data Manipulation Language (DML)
-------------------------------------------------------------------------------
   This gucustomeride covers the essential DML commands used for inserting, updating, 
   and deleting data in database tables.

   Table of Contents:
     1. INSERT - Adding Data to Tables
     2. UPDATE - Modifying Existing Data
     3. DELETE - Removing Data from Tables
=================================================================================
*/

/* ============================================================================== 
   INSERT
=============================================================================== */
/* #1 Method: Manual INSERT using VALUES */
-- Insert new records into the customers table
INSERT INTO customers (customerid, firstname, country, score)
VALUES 
    (6, 'Anna', 'USA', NULL),
    (7, 'Sam', NULL, 100)

-- Incorrect column order 
INSERT INTO customers (customerid, firstname, country, score)
VALUES 
    (8, 'Max', 'USA', NULL)
    
-- Incorrect data type in values
INSERT INTO customers (customerid, firstname, country, score)
VALUES 
	('Max', 9, 'Max', NULL)

-- Insert a new record with full column values
INSERT INTO customers (customerid, firstname, country, score)
VALUES (8, 'Max', 'USA', 368)

-- Insert a new record without specifying column names (not recommended)
INSERT INTO customers 
VALUES 
    (9, 'Andreas', 'Germany', NULL)
    
-- Insert a record with only customerid and firstname (other columns will be NULL or default values)
INSERT INTO customers (customerid, firstname)
VALUES 
    (10, 'Sahra')

/* #2 Method: INSERT DATA USING SELECT - Moving Data From One Table to Another */
-- Copy data from the 'customers' table into 'persons'
INSERT INTO persons (customerid, person_name, birth_date, phone)
SELECT
    customerid,
    firstname,
    NULL,
    'Unknown'
FROM customers

/* ============================================================================== 
   UPDATE
=============================================================================== */

-- Change the score of customer with customerid 6 to 0
UPDATE customers
SET score = 0
WHERE customerid = 6

-- Change the score of customer with customerid 10 to 0 and update the country to 'UK'
UPDATE customers
SET score = 0,
    country = 'UK'
WHERE customerid = 10

-- Update all customers with a NULL score by setting their score to 0
UPDATE customers
SET score = 0
WHERE score IS NULL

-- Verify the update
SELECT *
FROM customers
WHERE score IS NULL

/* ============================================================================== 
   DELETE
=============================================================================== */

-- Select customers with an customerid greater than 5 before deleting
SELECT *
FROM customers
WHERE customerid > 5

-- Delete all customers with an customerid greater than 5
DELETE FROM customers
WHERE customerid > 5

-- Delete all data from the persons table
DELETE FROM persons


/* ============================================================================== 
   TRUNCATE
=============================================================================== */

-- Faster method to delete all rows, especially useful for large tables
TRUNCATE TABLE persons
