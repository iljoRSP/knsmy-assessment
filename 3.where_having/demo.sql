-- initialise our tables

CREATE TABLE PRODUCTS (
    product_id int,
    name varchar(255),
    unit_price float,
    rem_stock int,
    PRIMARY KEY (product_id)
);

CREATE TABLE ORDERS (
    order_id int,
    product_id int,
    quantity int,
    buyer_id int,
    PRIMARY KEY (order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
    -- FOREIGN KEY (buyer_id) REFERENCES BUYERS(buyer_id)    (irrelevant to current discussion)
);


-- some dummy data

INSERT INTO PRODUCTS
    VALUES 
    (1, "Coffee Mug", 8.5, 9),
    (2, "Snowglobe", 12.4, 30),
    (3, "Telescope", 32.0, 40),
    (4, "Mag Glass", 10.0, 6),
    (5, "Mirror", 60.0, 17);


INSERT INTO ORDERS
    VALUES
    (01, 2, 4, 34),
    (02, 2, 3, 56),
    (03, 3, 4, 56),
    (04, 1, 6, 34),
    (05, 3, 5, 12),
    (06, 4, 7, 56),
    (07, 1, 5, 96),
    (08, 4, 3, 10),
    (09, 4, 1, 25),
    (10, 5, 2, 30);


-- lets say these 10 orders were made today, and have to be processed

-- now, lets say that for inventory management, 
-- we want to check the total amount of stock by purchase
-- to calculate remaining stock after the orders are fulfilled.


SELECT PRODUCTS.name as product_name, SUM(ORDERS.quantity) as total_ordered, PRODUCTS.rem_stock as remaining_stock 
    FROM ORDERS JOIN PRODUCTS 
        ON ORDERS.product_id = PRODUCTS.product_id
    GROUP BY ORDERS.product_id;
    
-- returns:

--  product_name	total_ordered	remaining_stock
--  Coffee Mug	    11	            9
--  Snowglobe	    7	            30
--  Telescope	    9	            40
--  Mag Glass	    11	            6
--  Mirror	        2	            17


-- Here, we can see a few products are understocked for the total orders of today.


-- To see these more clearly, we can add a HAVING clause to our query above.
-- Here, HAVING is used because we want to filter by the aggregate total_ordered, rather than WHERE's row-by-row filtering.


SELECT PRODUCTS.name as product_name, SUM(ORDERS.quantity) as total_ordered, PRODUCTS.rem_stock as remaining_stock 
    FROM ORDERS JOIN PRODUCTS 
        ON ORDERS.product_id = PRODUCTS.product_id
    GROUP BY ORDERS.product_id
    HAVING SUM(ORDERS.quantity) > PRODUCTS.rem_stock;  -- note this new HAVING clause
    
--  returns:

--  product_name	total_ordered	remaining_stock
--  Coffee Mug	    11	            9
--  Mag Glass	    11	            6


-- Let's say now, that to solve this problem, we will cancel orders of coffee mugs and magnifying glasses that have a quantity above 5.
-- Now, we wish to find rows in ORDERS where quantity > 5; this is by-row and therefore will use the WHERE clause. 
-- These will be the orders that are to-be-cancelled (TBC).

SELECT ORDERS.order_id as order_id_TBC, PRODUCTS.name as product_name, ORDERS.quantity, ORDERS.buyer_id
    FROM ORDERS JOIN PRODUCTS
        ON ORDERS.product_id = PRODUCTS.product_id
    WHERE quantity > 5;
    
--  returns:

--  order_id_TBC	product_name	quantity	buyer_id
--  4	            Coffee Mug	    6	        34
--  6	            Mag Glass	    7	        56


-- To see the impact of these cancelled orders, we can combine both clauses. Since WHERE occurs before GROUPING, we can use it to filter out the orders TBC,
-- before we calculate the total_ordered. Then, we can further filter these to find any products with total_ordered greater than rem_stock.

SELECT PRODUCTS.name as product_name, SUM(ORDERS.quantity) as total_ordered, PRODUCTS.rem_stock as remaining_stock 
    FROM ORDERS JOIN PRODUCTS
        ON ORDERS.product_id = PRODUCTS.product_id
    WHERE quantity <= 5  -- keep "valid" orders only
    GROUP BY ORDERS.product_id
    HAVING SUM(ORDERS.quantity) > PRODUCTS.rem_stock;
    

-- returns:

-- nothing! This shows that if we choose to cancel the two orders (order #4 and #6),
-- these two previously problematic products are no longer under stocked.
