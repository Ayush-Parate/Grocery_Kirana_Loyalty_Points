-- ============================================================
-- GROCERY KIRANA STORE LOYALTY POINTS DATABASE
-- PostgreSQL Mini Project / Case Study 133
-- Student Name : Ayush Parate
-- Roll No      : 150096726005
-- ============================================================

-- CASE STUDY 133: Grocery Kirana Store Loyalty Points
-- PostgreSQL / DBMS Semester III
-- Student: Sandeep Parate
-- Roll No: 150096726005
DROP TABLE IF EXISTS points_redeemed, points_earned, bills, customers CASCADE;

CREATE TABLE customers (
    id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, city VARCHAR(60) NOT NULL,
    points_balance INTEGER NOT NULL DEFAULT 0 CHECK (points_balance >= 0),
    attributes JSONB NOT NULL DEFAULT '{}'::jsonb, tags TEXT[] NOT NULL DEFAULT '{}'::text[]
);
CREATE TABLE bills (
    id SERIAL PRIMARY KEY, customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
    bill_amount_rs NUMERIC(10,2) NOT NULL CHECK (bill_amount_rs > 0), bill_date DATE NOT NULL
);
CREATE TABLE points_earned (
    id SERIAL PRIMARY KEY, bill_id INTEGER NOT NULL UNIQUE REFERENCES bills(id) ON DELETE CASCADE,
    customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
    points_awarded INTEGER NOT NULL CHECK (points_awarded > 0), earned_date DATE NOT NULL
);
CREATE TABLE points_redeemed (
    id SERIAL PRIMARY KEY, customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE RESTRICT,
    points_used INTEGER NOT NULL CHECK (points_used > 0), redemption_date DATE NOT NULL,
    reward_description VARCHAR(200) NOT NULL
);

-- Seed customers: 35 rows with flexible JSONB attributes and PostgreSQL array tags.
INSERT INTO customers (name, city, points_balance, attributes, tags) VALUES
('Customer - Deshpande', 'Lucknow', 0, '{"email": "customer1@example.com", "preferred_payment": "UPI", "membership_tier": "Silver", "home_delivery": false}'::jsonb, '{regular,upi,local}'),
('Customer - Joshi', 'Indore', 0, '{"email": "customer2@example.com", "preferred_payment": "Cash", "membership_tier": "Silver", "home_delivery": true}'::jsonb, '{regular,bulk,upi}'),
('Customer - Naik', 'Surat', 0, '{"email": "customer3@example.com", "preferred_payment": "Card", "membership_tier": "Standard", "home_delivery": false}'::jsonb, '{family,upi}'),
('Customer - Bhagat', 'Lucknow', 0, '{"email": "customer4@example.com", "preferred_payment": "UPI", "membership_tier": "Silver", "home_delivery": true}'::jsonb, '{regular,upi,local}'),
('Customer - Ghorpade', 'Nashik', 0, '{"email": "customer5@example.com", "preferred_payment": "Cash", "membership_tier": "Standard", "home_delivery": false}'::jsonb, '{local,monthly}'),
('Customer - Solanki', 'Indore', 0, '{"email": "customer6@example.com", "preferred_payment": "Card", "membership_tier": "Silver", "home_delivery": true}'::jsonb, '{regular,bulk,upi}'),
('Customer - Patil', 'Pune', 0, '{"email": "customer7@example.com", "preferred_payment": "UPI", "membership_tier": "Silver", "home_delivery": false}'::jsonb, '{regular,upi,monthly}'),
('Customer - Sharma', 'Delhi', 0, '{"email": "customer8@example.com", "preferred_payment": "Cash", "membership_tier": "Gold", "home_delivery": true}'::jsonb, '{family,premium}'),
('Customer - Verma', 'Kanpur', 0, '{"email": "customer9@example.com", "preferred_payment": "Card", "membership_tier": "Silver", "home_delivery": false}'::jsonb, '{regular,local}'),
('Customer - Kulkarni', 'Pune', 0, '{"email": "customer10@example.com", "preferred_payment": "UPI", "membership_tier": "Silver", "home_delivery": true}'::jsonb, '{regular,upi,monthly}'),
('Customer - Singh', 'Lucknow', 0, '{"email": "customer11@example.com", "preferred_payment": "Cash", "membership_tier": "Silver", "home_delivery": false}'::jsonb, '{regular,upi,local}'),
('Customer - Mishra', 'Varanasi', 0, '{"email": "customer12@example.com", "preferred_payment": "Card", "membership_tier": "Standard", "home_delivery": true}'::jsonb, '{monthly,family}'),
('Customer - Gupta', 'Jaipur', 0, '{"email": "customer13@example.com", "preferred_payment": "UPI", "membership_tier": "Gold", "home_delivery": false}'::jsonb, '{premium,upi}'),
('Customer - Yadav', 'Agra', 0, '{"email": "customer14@example.com", "preferred_payment": "Cash", "membership_tier": "Standard", "home_delivery": true}'::jsonb, '{family,local}'),
('Customer - Rao', 'Hyderabad', 0, '{"email": "customer15@example.com", "preferred_payment": "Card", "membership_tier": "Standard", "home_delivery": false}'::jsonb, '{bulk,upi}'),
('Customer - Iyer', 'Chennai', 0, '{"email": "customer16@example.com", "preferred_payment": "UPI", "membership_tier": "Gold", "home_delivery": true}'::jsonb, '{premium,monthly}'),
('Customer - Mehta', 'Ahmedabad', 0, '{"email": "customer17@example.com", "preferred_payment": "Cash", "membership_tier": "Standard", "home_delivery": false}'::jsonb, '{business,upi}'),
('Customer - Shah', 'Surat', 0, '{"email": "customer18@example.com", "preferred_payment": "Card", "membership_tier": "Standard", "home_delivery": true}'::jsonb, '{family,upi}'),
('Customer - More', 'Nashik', 0, '{"email": "customer19@example.com", "preferred_payment": "UPI", "membership_tier": "Standard", "home_delivery": false}'::jsonb, '{local,monthly}'),
('Customer - Jadhav', 'Pune', 0, '{"email": "customer20@example.com", "preferred_payment": "Cash", "membership_tier": "Silver", "home_delivery": true}'::jsonb, '{regular,upi,monthly}'),
('Customer - Pawar', 'Mumbai', 0, '{"email": "customer21@example.com", "preferred_payment": "Card", "membership_tier": "Gold", "home_delivery": false}'::jsonb, '{premium,upi}'),
('Customer - Khan', 'Bhopal', 0, '{"email": "customer22@example.com", "preferred_payment": "UPI", "membership_tier": "Silver", "home_delivery": true}'::jsonb, '{regular,family}'),
('Customer - Ansari', 'Lucknow', 0, '{"email": "customer23@example.com", "preferred_payment": "Cash", "membership_tier": "Silver", "home_delivery": false}'::jsonb, '{regular,upi,local}'),
('Customer - Das', 'Kolkata', 0, '{"email": "customer24@example.com", "preferred_payment": "Card", "membership_tier": "Standard", "home_delivery": true}'::jsonb, '{family,monthly}'),
('Customer - Roy', 'Kolkata', 0, '{"email": "customer25@example.com", "preferred_payment": "UPI", "membership_tier": "Standard", "home_delivery": false}'::jsonb, '{family,monthly}'),
('Customer - Nair', 'Kochi', 0, '{"email": "customer26@example.com", "preferred_payment": "Cash", "membership_tier": "Gold", "home_delivery": true}'::jsonb, '{premium,local}'),
('Customer - Reddy', 'Hyderabad', 0, '{"email": "customer27@example.com", "preferred_payment": "Card", "membership_tier": "Standard", "home_delivery": false}'::jsonb, '{bulk,upi}'),
('Customer - Joshi Senior', 'Indore', 0, '{"email": "customer28@example.com", "preferred_payment": "UPI", "membership_tier": "Silver", "home_delivery": true}'::jsonb, '{regular,bulk,upi}'),
('Customer - Chavan', 'Pune', 0, '{"email": "customer29@example.com", "preferred_payment": "Cash", "membership_tier": "Silver", "home_delivery": false}'::jsonb, '{regular,upi,monthly}'),
('Customer - Bansal', 'Delhi', 0, '{"email": "customer30@example.com", "preferred_payment": "Card", "membership_tier": "Gold", "home_delivery": true}'::jsonb, '{family,premium}'),
('Customer - Kapoor', 'Delhi', 0, '{"email": "customer31@example.com", "preferred_payment": "UPI", "membership_tier": "Gold", "home_delivery": false}'::jsonb, '{family,premium}'),
('Customer - Sethi', 'Chandigarh', 0, '{"email": "customer32@example.com", "preferred_payment": "Cash", "membership_tier": "Gold", "home_delivery": true}'::jsonb, '{premium,upi}'),
('Customer - Tripathi', 'Kanpur', 0, '{"email": "customer33@example.com", "preferred_payment": "Card", "membership_tier": "Silver", "home_delivery": false}'::jsonb, '{regular,local}'),
('Customer - Thakur', 'Dehradun', 0, '{"email": "customer34@example.com", "preferred_payment": "UPI", "membership_tier": "Standard", "home_delivery": true}'::jsonb, '{local,monthly}'),
('Customer - Jain', 'Jaipur', 0, '{"email": "customer35@example.com", "preferred_payment": "Cash", "membership_tier": "Gold", "home_delivery": false}'::jsonb, '{premium,upi}');

-- Seed bills: 88 rows.
INSERT INTO bills (id, customer_id, bill_amount_rs, bill_date) VALUES
(1,1,50.00,'2024-01-08'),
(2,1,3010.00,'2024-01-19'),
(3,2,4490.00,'2024-02-02'),
(4,3,3898.00,'2024-02-14'),
(5,3,1974.00,'2024-02-27'),
(6,4,1678.00,'2024-03-05'),
(7,5,3750.00,'2024-03-16'),
(8,5,1678.00,'2024-03-28'),
(9,4,2654.00,'2024-01-06'),
(10,4,2511.00,'2024-03-15'),
(11,5,2691.00,'2024-02-13'),
(12,5,2140.00,'2024-04-22'),
(13,5,405.00,'2024-02-06'),
(14,6,3436.00,'2024-03-20'),
(15,6,4475.00,'2024-01-04'),
(16,7,3815.00,'2024-04-27'),
(17,7,1646.00,'2024-02-11'),
(18,7,1089.00,'2024-04-20'),
(19,8,2691.00,'2024-01-09'),
(20,8,1575.00,'2024-03-18'),
(21,9,408.00,'2024-02-16'),
(22,9,3683.00,'2024-04-25'),
(23,9,3002.00,'2024-02-09'),
(24,10,4984.00,'2024-03-23'),
(25,10,1834.00,'2024-01-07'),
(26,11,2728.00,'2024-04-05'),
(27,11,923.00,'2024-02-14'),
(28,11,5081.00,'2024-04-23'),
(29,12,1402.00,'2024-01-12'),
(30,12,1311.00,'2024-03-21'),
(31,13,2999.00,'2024-02-19'),
(32,13,1046.00,'2024-04-03'),
(33,13,3040.00,'2024-02-12'),
(34,14,2429.00,'2024-03-26'),
(35,14,4398.00,'2024-01-10'),
(36,15,910.00,'2024-04-08'),
(37,15,936.00,'2024-02-17'),
(38,15,4479.00,'2024-04-26'),
(39,16,3626.00,'2024-01-15'),
(40,16,4407.00,'2024-03-24'),
(41,17,2250.00,'2024-02-22'),
(42,17,1835.00,'2024-04-06'),
(43,17,2416.00,'2024-02-15'),
(44,18,1192.00,'2024-03-04'),
(45,18,3562.00,'2024-01-13'),
(46,19,4396.00,'2024-04-11'),
(47,19,4233.00,'2024-02-20'),
(48,19,2550.00,'2024-04-04'),
(49,20,3638.00,'2024-01-18'),
(50,20,4796.00,'2024-03-27'),
(51,21,4848.00,'2024-02-25'),
(52,21,644.00,'2024-04-09'),
(53,21,5088.00,'2024-02-18'),
(54,22,3591.00,'2024-03-07'),
(55,22,3803.00,'2024-01-16'),
(56,23,3648.00,'2024-04-14'),
(57,23,4856.00,'2024-02-23'),
(58,23,1829.00,'2024-04-07'),
(59,24,3959.00,'2024-01-21'),
(60,24,2633.00,'2024-03-05'),
(61,25,2260.00,'2024-02-03'),
(62,25,3565.00,'2024-04-12'),
(63,25,3832.00,'2024-02-21'),
(64,26,2512.00,'2024-03-10'),
(65,26,3602.00,'2024-01-19'),
(66,27,4179.00,'2024-04-17'),
(67,27,3361.00,'2024-02-26'),
(68,27,4703.00,'2024-04-10'),
(69,28,592.00,'2024-01-24'),
(70,28,2367.00,'2024-03-08'),
(71,29,5045.00,'2024-02-06'),
(72,29,2286.00,'2024-04-15'),
(73,29,3376.00,'2024-02-24'),
(74,30,1530.00,'2024-03-13'),
(75,30,656.00,'2024-01-22'),
(76,31,1174.00,'2024-04-20'),
(77,31,1792.00,'2024-02-04'),
(78,31,396.00,'2024-04-13'),
(79,32,506.00,'2024-01-27'),
(80,32,1138.00,'2024-03-11'),
(81,33,1998.00,'2024-02-09'),
(82,33,1960.00,'2024-04-18'),
(83,33,3064.00,'2024-02-27'),
(84,34,2344.00,'2024-03-16'),
(85,34,4396.00,'2024-01-25'),
(86,35,1681.00,'2024-04-23'),
(87,35,2650.00,'2024-02-07'),
(88,35,3051.00,'2024-04-16');

-- Seed points earned: 1 point per completed ₹10 of bill value.
INSERT INTO points_earned (bill_id, customer_id, points_awarded, earned_date) VALUES
(1,1,5,'2024-01-08'),
(2,1,301,'2024-01-19'),
(3,2,449,'2024-02-02'),
(4,3,389,'2024-02-14'),
(5,3,197,'2024-02-27'),
(6,4,167,'2024-03-05'),
(7,5,375,'2024-03-16'),
(8,5,167,'2024-03-28'),
(9,4,265,'2024-01-06'),
(10,4,251,'2024-03-15'),
(11,5,269,'2024-02-13'),
(12,5,214,'2024-04-22'),
(13,5,40,'2024-02-06'),
(14,6,343,'2024-03-20'),
(15,6,447,'2024-01-04'),
(16,7,381,'2024-04-27'),
(17,7,164,'2024-02-11'),
(18,7,108,'2024-04-20'),
(19,8,269,'2024-01-09'),
(20,8,157,'2024-03-18'),
(21,9,40,'2024-02-16'),
(22,9,368,'2024-04-25'),
(23,9,300,'2024-02-09'),
(24,10,498,'2024-03-23'),
(25,10,183,'2024-01-07'),
(26,11,272,'2024-04-05'),
(27,11,92,'2024-02-14'),
(28,11,508,'2024-04-23'),
(29,12,140,'2024-01-12'),
(30,12,131,'2024-03-21'),
(31,13,299,'2024-02-19'),
(32,13,104,'2024-04-03'),
(33,13,304,'2024-02-12'),
(34,14,242,'2024-03-26'),
(35,14,439,'2024-01-10'),
(36,15,91,'2024-04-08'),
(37,15,93,'2024-02-17'),
(38,15,447,'2024-04-26'),
(39,16,362,'2024-01-15'),
(40,16,440,'2024-03-24'),
(41,17,225,'2024-02-22'),
(42,17,183,'2024-04-06'),
(43,17,241,'2024-02-15'),
(44,18,119,'2024-03-04'),
(45,18,356,'2024-01-13'),
(46,19,439,'2024-04-11'),
(47,19,423,'2024-02-20'),
(48,19,255,'2024-04-04'),
(49,20,363,'2024-01-18'),
(50,20,479,'2024-03-27'),
(51,21,484,'2024-02-25'),
(52,21,64,'2024-04-09'),
(53,21,508,'2024-02-18'),
(54,22,359,'2024-03-07'),
(55,22,380,'2024-01-16'),
(56,23,364,'2024-04-14'),
(57,23,485,'2024-02-23'),
(58,23,182,'2024-04-07'),
(59,24,395,'2024-01-21'),
(60,24,263,'2024-03-05'),
(61,25,226,'2024-02-03'),
(62,25,356,'2024-04-12'),
(63,25,383,'2024-02-21'),
(64,26,251,'2024-03-10'),
(65,26,360,'2024-01-19'),
(66,27,417,'2024-04-17'),
(67,27,336,'2024-02-26'),
(68,27,470,'2024-04-10'),
(69,28,59,'2024-01-24'),
(70,28,236,'2024-03-08'),
(71,29,504,'2024-02-06'),
(72,29,228,'2024-04-15'),
(73,29,337,'2024-02-24'),
(74,30,153,'2024-03-13'),
(75,30,65,'2024-01-22'),
(76,31,117,'2024-04-20'),
(77,31,179,'2024-02-04'),
(78,31,39,'2024-04-13'),
(79,32,50,'2024-01-27'),
(80,32,113,'2024-03-11'),
(81,33,199,'2024-02-09'),
(82,33,196,'2024-04-18'),
(83,33,306,'2024-02-27'),
(84,34,234,'2024-03-16'),
(85,34,439,'2024-01-25'),
(86,35,168,'2024-04-23'),
(87,35,265,'2024-02-07'),
(88,35,305,'2024-04-16');

-- Seed points redeemed.
INSERT INTO points_redeemed (customer_id, points_used, redemption_date, reward_description) VALUES
(1,40,'2024-04-11','₹40 off next bill'),
(2,40,'2024-04-12','₹40 off next bill'),
(3,40,'2024-04-13','₹40 off next bill'),
(5,40,'2024-04-15','₹40 off next bill'),
(6,40,'2024-04-16','₹40 off next bill'),
(8,40,'2024-04-18','₹40 off next bill'),
(9,40,'2024-04-19','₹40 off next bill'),
(11,40,'2024-04-21','₹40 off next bill'),
(12,40,'2024-04-10','₹40 off next bill'),
(14,40,'2024-04-12','₹40 off next bill'),
(15,40,'2024-04-13','₹40 off next bill'),
(17,40,'2024-04-15','₹40 off next bill'),
(18,40,'2024-04-16','₹40 off next bill'),
(20,40,'2024-04-18','₹40 off next bill'),
(21,40,'2024-04-19','₹40 off next bill'),
(23,40,'2024-04-21','₹40 off next bill'),
(24,40,'2024-04-10','₹40 off next bill'),
(26,40,'2024-04-12','₹40 off next bill'),
(27,40,'2024-04-13','₹40 off next bill'),
(29,40,'2024-04-15','₹40 off next bill'),
(30,40,'2024-04-16','₹40 off next bill'),
(32,40,'2024-04-18','₹40 off next bill'),
(33,40,'2024-04-19','₹40 off next bill'),
(35,40,'2024-04-21','₹40 off next bill');

UPDATE customers c SET points_balance =
    COALESCE((SELECT SUM(pe.points_awarded) FROM points_earned pe WHERE pe.customer_id=c.id),0)
    - COALESCE((SELECT SUM(pr.points_used) FROM points_redeemed pr WHERE pr.customer_id=c.id),0);

CREATE INDEX idx_bills_customer ON bills(customer_id);
CREATE INDEX idx_bills_date ON bills(bill_date);
CREATE INDEX idx_customers_attributes_gin ON customers USING GIN(attributes);
CREATE INDEX idx_customers_tags_gin ON customers USING GIN(tags);

-- ===============================================================
-- QUERY 1: Extract one JSONB key for every customer
--Name - Ayush Parate
SELECT id, name, attributes ->> 'membership_tier' AS membership_tier FROM customers ORDER BY id;

-- QUERY 2: Find customers whose JSON attribute matches a value
--Name - Ayush Parate
SELECT id, name, city, attributes ->> 'preferred_payment' AS preferred_payment FROM customers
WHERE attributes ->> 'preferred_payment' = 'UPI' ORDER BY id;

-- QUERY 3: Find customers with a chosen array tag
--Name - Ayush Parate
SELECT id, name, city, tags FROM customers WHERE 'premium' = ANY(tags) ORDER BY id;

-- QUERY 4: Days ago relative to the most recent bill date
--Name - Ayush Parate
SELECT id, customer_id, bill_date, (SELECT MAX(bill_date) FROM bills) - bill_date AS days_ago
FROM bills ORDER BY bill_date, id;

-- QUERY 5: Group bills by month and total bill amount
--Name - Ayush Parate
SELECT DATE_TRUNC('month', bill_date)::date AS bill_month, COUNT(*) AS bill_count,
SUM(bill_amount_rs) AS total_bill_amount_rs FROM bills
GROUP BY DATE_TRUNC('month', bill_date) ORDER BY bill_month;

-- QUERY 6: Relational city report; this becomes more verbose if city moves to JSONB
--Name - Ayush Parate
SELECT city, COUNT(*) AS customers, ROUND(AVG(points_balance),2) AS avg_points FROM customers
GROUP BY city HAVING COUNT(*) >= 2 ORDER BY customers DESC, city;

-- QUERY 7: Filtering plus JOIN
--Name - Ayush Parate
SELECT c.id, c.name, b.id AS bill_id, b.bill_amount_rs, b.bill_date
FROM customers c JOIN bills b ON b.customer_id=c.id
WHERE b.bill_amount_rs > 4000 ORDER BY b.bill_amount_rs DESC, b.id;

-- QUERY 8: GROUP BY/HAVING customer spending report
--Name - Ayush Parate
SELECT c.id, c.name, COUNT(b.id) AS bill_count, SUM(b.bill_amount_rs) AS total_spent
FROM customers c JOIN bills b ON b.customer_id=c.id
GROUP BY c.id,c.name HAVING SUM(b.bill_amount_rs)>=8000 ORDER BY total_spent DESC;

-- QUERY 9: Correlated/nested subquery: compare each customer with their city average
--Name - Ayush Parate
SELECT c.id, c.name, c.city,
(SELECT COALESCE(SUM(b.bill_amount_rs),0) FROM bills b WHERE b.customer_id=c.id) AS total_spent
FROM customers c
WHERE (SELECT COALESCE(SUM(b.bill_amount_rs),0) FROM bills b WHERE b.customer_id=c.id) >
(SELECT AVG(customer_total) FROM (SELECT c2.id, COALESCE(SUM(b2.bill_amount_rs),0) AS customer_total
 FROM customers c2 LEFT JOIN bills b2 ON b2.customer_id=c2.id
 WHERE c2.city=c.city GROUP BY c2.id) city_totals)
ORDER BY c.city, total_spent DESC;

-- QUERY 10: Validate stored balance against the loyalty ledger
--Name - Ayush Parate
SELECT c.id, c.name, c.points_balance, COALESCE(e.earned,0) AS earned_points,
COALESCE(r.redeemed,0) AS redeemed_points,
COALESCE(e.earned,0)-COALESCE(r.redeemed,0) AS calculated_balance
FROM customers c
LEFT JOIN (SELECT customer_id,SUM(points_awarded) earned FROM points_earned GROUP BY customer_id) e ON e.customer_id=c.id
LEFT JOIN (SELECT customer_id,SUM(points_used) redeemed FROM points_redeemed GROUP BY customer_id) r ON r.customer_id=c.id
ORDER BY c.id;