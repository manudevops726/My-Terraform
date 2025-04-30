-- Create a database (optional, if not already created)
CREATE DATABASE IF NOT EXISTS manasa_db;

-- Use the database
USE manasa_db;

-- Create a table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some data
INSERT INTO users (username, email) VALUES 
('manasa', 'manasa@example.com'),
('aws', 'aws@example.com'),
('devops', 'devops@example.com');

-- Query the table
SELECT * FROM users;