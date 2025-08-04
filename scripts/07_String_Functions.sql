/* ============================================================================== 
   SQL String Functions
-------------------------------------------------------------------------------
   This document provides an overview of SQL string functions, which allow 
   manipulation, transformation, and extraction of text data efficiently.

   Table of Contents:
     1. Manipulations
        - CONCAT
        - LOWER
        - UPPER
	- TRIM
	- REPLACE
     2. Calculation
        - LEN
     3. Substring Extraction
        - LEFT
        - RIGHT
        - SUBSTRING
=================================================================================
*/

/* ============================================================================== 
   CONCAT() - String Concatenation
=============================================================================== */

-- Concatenate first name and country into one column
SELECT 
    CONCAT(firstname, '-', country) AS full_info
FROM customers

/* ============================================================================== 
   LOWER() & UPPER() - Case Transformation
=============================================================================== */

-- Convert the first name to lowercase
SELECT 
    LOWER(firstname) AS lower_case_name
FROM customers

-- Convert the first name to uppercase
SELECT 
    UPPER(firstname) AS upper_case_name
FROM customers
	
/* ============================================================================== 
   TRIM() - Remove White Spaces
=============================================================================== */

-- Find customers whose first name contains leading or trailing spaces

SELECT 
    firstname,
	length(firstname) len_name,
	length(TRIM(firstname)) len_trim_name,
	length(firstname) - length(TRIM(firstname)) flag
FROM customers
WHERE length(firstname)  != length(TRIM(firstname))
-- WHERE firstname != TRIM(firstname)

/* ============================================================================== 
   REPLACE() - Replace or Remove old value with new one
=============================================================================== */
-- Remove dashes (-) from a phone number
SELECT
'123-456-7890' AS phone,
REPLACE('123-456-7890', '-', '/') AS clean_phone

-- Replace File Extence from txt to csv
SELECT
'report.txt' AS old_filename,
REPLACE('report.txt', '.txt', '.csv') AS new_filename
	
/* ============================================================================== 
   LEN() - String Length & Trimming
=============================================================================== */

-- Calculate the length of each customer's first name
SELECT 
    firstname, 
    length(firstname) AS name_length
FROM customers
	
/* ============================================================================== 
   LEFT() & RIGHT() - Substring Extraction
=============================================================================== */

-- Retrieve the first two characters of each first name
SELECT 
    firstname,
    LEFT(TRIM(firstname), 2) AS first_2_chars
FROM customers

-- Retrieve the last two characters of each first name
SELECT 
    firstname,
    RIGHT(firstname, 2) AS last_2_chars
FROM customers
	
/* ============================================================================== 
   SUBSTRING() - Extracting Substrings
=============================================================================== */

-- Retrieve a list of customers' first names after removing the first character
SELECT 
    firstname,
    substr(TRIM(firstname), 2, length(firstname)) AS trimmed_name
FROM customers	

/* ==============================================================================
   NESTING FUNCTIONS
===============================================================================*/

-- Nesting
SELECT
firstname, 
UPPER(LOWER(firstname)) AS nesting
FROM customers
