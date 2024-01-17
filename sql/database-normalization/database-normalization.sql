-- Select some salmple data from Fred's current store DB
SELECT * 
FROM store
LIMIT 10;

-- Create customers table and fill it using the data from the stores table and add primary key
CREATE TABLE customers AS
SELECT DISTINCT customer_id AS id,
  customer_phone AS phone,
  customer_email AS email
FROM store;

ALTER TABLE customers
ADD PRIMARY KEY (id);

/*
Create items table containing rows for each ordered item from the store table.
Union the columns from sture for items 1, 2 and 3.
*/
CREATE TABLE items AS 
SELECT DISTINCT item_1_id as item_id,
  item_1_name AS item_name,
  item_1_price AS item_price
FROM store
UNION
SELECT DISTINCT item_2_id as item_id,
  item_2_name AS item_name,
  item_2_price AS item_price
FROM store
WHERE item_2_id IS NOT NULL
UNION
SELECT DISTINCT item_3_id as item_id,
  item_3_name AS item_name,
  item_3_price AS item_price
FROM store
WHERE item_3_id IS NOT NULL;

ALTER TABLE items
ADD PRIMARY KEY (item_id);

-- Create table orders_items as there is a many to many relationship between orders and items
CREATE TABLE orders_items AS
SELECT order_id, 
  item_1_id AS item_id
FROM store
UNION ALL
SELECT order_id,
  item_2_id AS item_id
FROM store
WHERE item_2_id IS NOT NULL
UNION ALL
SELECT order_id,
  item_3_id
FROM store
WHERE item_3_id IS NOT NULL;

-- Create orders table from the order data in the store table
CREATE TABLE orders AS
SELECT order_id,
  order_date,
  customer_id
FROM store;

ALTER TABLE orders
ADD PRIMARY KEY (order_id),
ADD FOREIGN KEY (customer_id) REFERENCES customers(id);

-- Add foreign keys for for orders_items
ALTER TABLE orders_items
ADD FOREIGN KEY (item_id) REFERENCES items(item_id),
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);


-- COMPARING QUERIES BETWEEN OLD AND NEW DATABASES
-- Query the old store database for orders more recent than '2019-07-25'
SELECT customer_email, 
  order_date
FROM store
WHERE order_date > '2019-07-25';

-- Query the new databse for orders more recent than '2019-07-25'
SELECT customers.email,
  orders.order_date
FROM customers, orders
WHERE customers.id = orders.customer_id
AND order_date > '2019-07-25';

-- Query the original store table to return the number of orders containing each unique item (for example, two orders contain item 1, two orders contain item 2, four orders contain item 3, etc.)
WITH all_items AS (
  SELECT item_1_id AS item_id
  FROM store
  UNION ALL
  SELECT item_2_id AS item_id
  FROM store
  WHERE item_2_id IS NOT NULL
  UNION ALL
  SELECT item_3_id AS item_id
  FROM store
  WHERE item_3_id IS NOT NULL
)
SELECT item_id,
  COUNT(*)
FROM all_items
GROUP BY item_id;

-- Query the new/normalized database for the same info
SELECT item_id,
  COUNT(*)
FROM orders_items
GROUP BY item_id;