CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(255),
    isbn VARCHAR(13) UNIQUE,
    availability BOOLEAN DEFAULT TRUE
);


CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20)
);


CREATE TABLE IF NOT EXISTS Borrow_Log (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE IF NOT EXISTS Overdue_Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    borrow_id INT,
    fine_amount DECIMAL(10, 2),
    FOREIGN KEY (borrow_id) REFERENCES Borrow_Log(borrow_id)
);

