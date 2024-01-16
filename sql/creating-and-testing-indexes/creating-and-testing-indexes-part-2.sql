-- See what indexes are applied to existing tables
SELECT *
FROM pg_indexes
WHERE tablename = 'customers'
    OR tablename = 'books'
    OR tablename = 'orders';

-- The marketting team wants to know how many books sell over 18 units
-- Check how long the statement takes without an index
EXPLAIN ANALYZE
SELECT customer_id, 
    quantity 
FROM orders
WHERE quantity > 18;
-- Planning time: 0.020 ms
-- Execution time: 11.510 ms

-- Build a partial Index for the query
CREATE INDEX orders_quantity_customer_id_high_sales_idx
ON orders(quantity, customer_id)
WHERE quantity > 18;

-- Check how long the statement with an index
EXPLAIN ANALYZE
SELECT customer_id, 
    quantity 
FROM orders
WHERE quantity > 18;
-- Planning time: 0.108 ms
-- Execution time: 4.021 ms



-- The customers table has no primary key
-- Run a statement to check the speed of a query on the table before a primary key
EXPLAIN ANALYZE
SELECT customer_id
FROM customers
WHERE customer_id > 3000;
-- Planning time: 0.030 ms
-- Execution time: 20.212 ms

-- Create primary key
ALTER TABLE customers
ADD CONSTRAINT customers_pkey
PRIMARY KEY(customer_id);

-- Run the search again to test the primary key and speed
EXPLAIN ANALYZE
SELECT customer_id
FROM customers
WHERE customer_id > 3000;
-- Planning time: 0.158 ms
-- Execution time: 24.988 ms

-- Use the new primary key to cluster the customers table
CLUSTER customers USING customers_pkey;

-- Selet from the customers table to check the cluster worked
SELECT * FROM customers LIMIT 10;



-- Build multi-column index on the orders table
CREATE INDEX orders_customer_id_book_id_idx
ON orders(customer_id, book_id);

-- Drop previous index and update it to include quantity as it would be more useful
DROP INDEX orders_customer_id_book_id_idx;

CREATE INDEX orders_customer_id_book_id_quantity_idx
ON orders(customer_id, book_id, quantity);

-- Create index to search for books by author and title
CREATE INDEX books_author_title_idx
ON books(author, title);



-- Test the speed of calculating the total price on orders
EXPLAIN ANALYZE
SELECT * 
FROM orders
WHERE ((quantity * price_base)) > 100;
-- Planning time: 0.108 ms
-- Execution time: 33.956 ms

-- Write an index for the above search
CREATE INDEX orders_quantity_price_base_idx
ON orders(quantity, price_base)
WHERE ((quantity * price_base)) > 100;

-- Test the speed after the creation of the new index
EXPLAIN ANALYZE
SELECT * 
FROM orders
WHERE ((quantity * price_base)) > 100;
-- Planning time: 0.150 ms
-- Execution time: 13.557 ms