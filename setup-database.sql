-- Face Recognition System - Database Setup Script
-- Run this script in MySQL to create the required database and tables

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS face_recognition;

-- Use the database
USE face_recognition;

-- Drop existing users table if it exists (optional - comment out if you want to keep existing data)
-- DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    UserName VARCHAR(30),
    Email VARCHAR(50),
    Phone VARCHAR(10),
    Password VARCHAR(20)
);

-- Display table structure
DESCRIBE users;

-- Display success message
SELECT 'Database setup completed successfully!' AS Status;

-- Show all tables in the database
SHOW TABLES;
