-- Create some indexes for the ids in the customers, orders and books tables
CREATE INDEX customers_customer_id_idx
ON customers(customer_id);

CREATE INDEX orders_order_id_idx
ON orders(order_id);

CREATE INDEX books_book_id_idx
ON books(book_id);

-- Check the indexes above were created correctly
SELECT *
FROM pg_indexes
WHERE tablename = 'customers'
  OR tablename = 'orders'
  OR tablename = 'books';

-- Check the runtime of the following statement
EXPLAIN ANALYZE 
SELECT original_language, 
  title, 
  sales_in_millions
FROM books
WHERE original_language = 'French';
-- Plannign time: 0.151 ms
-- Execution time: 0.029 m

-- Get the size of the books table
SELECT pg_size_pretty
(pg_total_relation_size('books'));
-- 72 kB

-- Create an index for language, book titles and coppies sold on the books table
CREATE INDEX books_original_language_title_sales_in_millions_idx
ON books(original_language, title, sales_in_millions);

-- Check the index in the previous statement was created
SELECT *
FROM pg_indexes
WHERE tablename = 'books';

-- Check the runtime after the new index was created
EXPLAIN ANALYZE 
SELECT original_language, 
  title, 
  sales_in_millions
FROM books
WHERE original_language = 'French';
-- Planning time: 0.070 ms
-- Execution time: 0.024 ms

-- Check the new size of the table
SELECT pg_size_pretty
(pg_total_relation_size('books'));
-- 104 kB

-- Remove the index as it was not benificial for a DB of this size
DROP INDEX books_original_language_title_sales_in_millions_idx;


-- CREATE multi-column index for customers.first_name and customers.last_name
-- and compare the speeds of queries before and after
CREATE INDEX customers_first_name_email_address_idx
ON customers(first_name, email_address);

EXPLAIN ANALYZE
SELECT first_name, 
  email_address
FROM customers
LIMIT 1000;
-- Planning time: 0.133 ms
-- Execution time: 0.253 ms

SELECT pg_size_pretty
(pg_total_relation_size('customers'));
-- 20 MB

DROP INDEX customers_first_name_email_address_idx;

EXPLAIN ANALYZE
SELECT first_name, 
  email_address
FROM customers
LIMIT 1000;
-- Planning time: 0.086 ms
-- Execution time: 0.254 ms

SELECT pg_size_pretty
(pg_total_relation_size('customers'));
-- 15 MB