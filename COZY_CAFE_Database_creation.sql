CREATE DATABASE CozyBook;
USE CozyBook;
 
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    membership ENUM('Regular', 'Member') DEFAULT 'Regular'
);
 
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    genre VARCHAR(50),
    copies_available INT DEFAULT 0
);
 
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    is_paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
 
CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100),
    event_date DATE
);
 
CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    event_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    amount_paid DECIMAL(10,2),
    payment_method VARCHAR(50),
    is_paid BOOLEAN,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

 
use CozyBook;
 
INSERT INTO Customers (full_name, email, phone, membership) VALUES
('Arjit singh', 'Arjitn@example.com', '9823457571', 'Member'),
('Roshan shah', 'Roshan@example.com', '9818943268', 'Regular'),
('Niraj singh', 'Niraj@example.com', '9856183205', 'Member');
 
select * from Customers;
 
 
use CozyBook;
 
INSERT INTO Books (title, author, genre, copies_available) VALUES
('Whispers of War', 'Narayan Wagle', 'Mystery', 3),
('Echoes of the Hills', 'Amar Neupane', 'Historical Fiction', 3),
('The Flower Beyond Time', 'Parijat', 'Classic Literature', 7),
('River Songs', 'Buddhisagar', 'Fiction', 4),
('The Sacred Flame', 'Krishna Dharabasi', 'Mythological Fiction', 6);

 
select * from Books;
 
use CozyBook;
 
INSERT INTO Events (event_name, event_date) VALUES
('Book Reading', '2025-07-20'),
('Writing Workshop', '2025-07-25');
 
select * from Events;
 
use CozyBook;
 
INSERT INTO Reservations (customer_id, event_id) VALUES
(1, 1),
(3, 1),
(2, 2);
 
select * from Reservations;
 
use CozyBook;
 
INSERT INTO Orders (customer_id, order_date, total_amount, is_paid) VALUES
(1, CURDATE(), 50.00, TRUE),
(2, CURDATE(), 40.00, FALSE),
(3, CURDATE() - INTERVAL 8 DAY, 60.00, TRUE),
(1, CURDATE() - INTERVAL 5 DAY, 20.00, FALSE);
 
select * from Orders;

use CozyBook; 

INSERT INTO Payments (order_id, payment_date, amount_paid, payment_method, is_paid) VALUES
(1, '2025-07-15', 12.50, 'Cash', TRUE),
(2, NULL, 0.00, NULL, FALSE),
(3, '2025-07-20', 15.75, 'Card', TRUE);

select * from Payments;


use cozyBook;
 
SELECT DISTINCT c.*
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.is_paid = FALSE;
 
 
SELECT title, copies_available
FROM Books
WHERE genre = 'Fiction'
ORDER BY title DESC;
 
 
SELECT COUNT(*) AS mystery_books_count
FROM Books
WHERE genre = 'Mystery';
 
 
SELECT DISTINCT c.*
FROM Customers c
JOIN Reservations r ON c.customer_id = r.customer_id
JOIN Events e ON r.event_id = e.event_id
WHERE e.event_name = 'Book Reading';
 
-- 7. Query: Update genre from 'Classic Literature' to 'Modern Classics'
UPDATE Books
SET genre = 'Modern Classics'
WHERE genre = 'Classic Literature';
 
 
SELECT c.full_name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 3;
 
-- 9. Query: Orders from last 7 days with customer name and total
SELECT c.full_name, o.order_date, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 7 DAY;
 