-- Create a "users" table
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a "products" table
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create an "orders" table
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  order_date DATE,
  total DECIMAL(10,2),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create a "order_items" table
CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert sample users
INSERT INTO users (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');

-- Insert sample products
INSERT INTO products (name, price) VALUES
('Laptop', 999.99),
('Phone', 499.99),
('Mouse', 29.99);

-- Insert sample order
INSERT INTO orders (user_id, order_date, total) VALUES
(1, '2024-04-01', 1029.98);

-- Insert sample order items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), -- Laptop
(1, 3, 1); -- Mouse
