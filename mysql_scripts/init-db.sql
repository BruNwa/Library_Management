CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    year_published INT NOT NULL,
    genre VARCHAR(255),
    isbn VARCHAR(60) UNIQUE,
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


INSERT INTO Books (title, author, year_published, genre, isbn, availability)
VALUES
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction', '978-0-06-112008-4', TRUE),
('1984', 'George Orwell', 1949, 'Dystopian', '978-0-452-28423-4',FALSE),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Fiction', '978-0-7432-7356-5', TRUE),
('The Catcher in the Rye', 'J.D. Salinger', 1951, 'Fiction', '978-0-316-76948-0', TRUE),
('Moby Dick', 'Herman Melville', 1851, 'Adventure', '978-0-14-243724-7',FALSE),
('Pride and Prejudice', 'Jane Austen', 1813, 'Romance', '978-0-19-953556-9', TRUE),
('The Hobbit', 'J.R.R. Tolkien', 1937, 'Fantasy', '978-0-618-00221-3',FALSE),
('War and Peace', 'Leo Tolstoy', 1869, 'Historical', '978-0-19-923276-5', TRUE),
('The Odyssey', 'Homer', -700, 'Epic', '978-0-14-026886-7', TRUE),
('Crime and Punishment', 'Fyodor Dostoevsky', 1866, 'Philosophical', '978-0-14-305814-4',FALSE),
('The Brothers Karamazov', 'Fyodor Dostoevsky', 1880, 'Philosophical', '978-0-375-75894-8', TRUE),
('Brave New World', 'Aldous Huxley', 1932, 'Dystopian', '978-0-06-085052-4', TRUE),
('Jane Eyre', 'Charlotte Brontë', 1847, 'Gothic Fiction', '978-0-14-243720-9',FALSE),
('Wuthering Heights', 'Emily Brontë', 1847, 'Gothic Fiction', '978-0-14-143955-6', TRUE),
('The Lord of the Rings', 'J.R.R. Tolkien', 1954, 'Fantasy', '978-0-618-00222-0',FALSE),
('The Alchemist', 'Paulo Coelho', 1988, 'Adventure', '978-0-06-112241-4', TRUE),
('The Divine Comedy', 'Dante Alighieri', 1320, 'Epic Poetry', '978-0-14-044895-5',FALSE),
('One Hundred Years of Solitude', 'Gabriel García Márquez', 1967, 'Magical Realism', '978-0-06-088328-5', TRUE),
('Les Misérables', 'Victor Hugo', 1862, 'Historical Fiction', '978-0-14-044430-8',FALSE),
('Anna Karenina', 'Leo Tolstoy', 1877, 'Fiction', '978-0-19-953606-1', TRUE),
('The Iliad', 'Homer', -800, 'Epic', '978-0-14-027536-0', TRUE),
('Don Quixote', 'Miguel de Cervantes', 1605, 'Adventure', '978-0-06-093434-5',FALSE),
('The Picture of Dorian Gray', 'Oscar Wilde', 1890, 'Philosophical Fiction', '978-0-14-143957-0', TRUE),
('Frankenstein', 'Mary Shelley', 1818, 'Science Fiction', '978-0-14-143947-1',FALSE),
('The Grapes of Wrath', 'John Steinbeck', 1939, 'Fiction', '978-0-14-303943-3', TRUE),
('Dracula', 'Bram Stoker', 1897, 'Horror', '978-0-14-143984-6',FALSE),
('A Tale of Two Cities', 'Charles Dickens', 1859, 'Historical Fiction', '978-0-14-143960-0', TRUE),
('The Count of Monte Cristo', 'Alexandre Dumas', 1844, 'Adventure', '978-0-14-044926-6', TRUE),
('The Kite Runner', 'Khaled Hosseini', 2003, 'Fiction', '978-1-59448-000-3',FALSE),
('Slaughterhouse-Five', 'Kurt Vonnegut', 1969, 'Science Fiction', '978-0-385-33384-9', TRUE),
('The Road', 'Cormac McCarthy', 2006, 'Post-Apocalyptic', '978-0-307-38789-9', TRUE),
('Gone with the Wind', 'Margaret Mitchell', 1936, 'Historical Fiction', '978-0-7432-9736-3',FALSE),
('The Old Man and the Sea', 'Ernest Hemingway', 1952, 'Fiction', '978-0-684-80122-3', TRUE),
('The Adventures of Huckleberry Finn', 'Mark Twain', 1884, 'Adventure', '978-0-14-243717-9', TRUE),
('The Shining', 'Stephen King', 1977, 'Horror', '978-0-385-12167-5',FALSE),
('Beloved', 'Toni Morrison', 1987, 'Historical Fiction', '978-1-4000-3341-6', TRUE),
('The Stranger', 'Albert Camus', 1942, 'Philosophical Fiction', '978-0-679-72020-1',FALSE),
('Heart of Darkness', 'Joseph Conrad', 1899, 'Novella', '978-0-14-144167-2', TRUE),
('Catch-22', 'Joseph Heller', 1961, 'Satire', '978-0-684-83339-2',FALSE),
('Lolita', 'Vladimir Nabokov', 1955, 'Fiction', '978-0-679-72316-5', TRUE),
('The Sun Also Rises', 'Ernest Hemingway', 1926, 'Fiction', '978-0-7432-9736-3', TRUE),
('A Clockwork Orange', 'Anthony Burgess', 1962, 'Dystopian', '978-0-393-07451-9',FALSE),
('The Wind-Up Bird Chronicle', 'Haruki Murakami', 1994, 'Magical Realism', '978-0-679-77554-6', TRUE),
('The Little Prince', 'Antoine de Saint-Exupéry', 1943, 'Fable', '978-0-15-601219-5', TRUE),
('The Handmaid’s Tale', 'Margaret Atwood', 1985, 'Dystopian', '978-0-385-49081-9',FALSE),
('The Metamorphosis', 'Franz Kafka', 1915, 'Fiction', '978-0-14-243754-4', TRUE),
('Fahrenheit 451', 'Ray Bradbury', 1953, 'Dystopian', '978-0-7432-4722-2', TRUE),
('The Book Thief', 'Markus Zusak', 2005, 'Historical Fiction', '978-0-375-84220-0',FALSE),
('The Secret Garden', 'Frances Hodgson Burnett', 1911, 'Children’s Fiction', '978-0-19-283596-3', TRUE),
('The Name of the Rose', 'Umberto Eco', 1980, 'Historical Mystery', '978-0-15-600131-1',FALSE),
('The Girl with the Dragon Tattoo', 'Stieg Larsson', 2005, 'Mystery', '978-0-307-45454-6', TRUE),
('Life of Pi', 'Yann Martel', 2001, 'Adventure', '978-0-15-602732-8',FALSE),
('The Shadow of the Wind', 'Carlos Ruiz Zafón', 2001, 'Mystery', '978-0-14-303490-3', TRUE),
('The Hunger Games', 'Suzanne Collins', 2008, 'Dystopian', '978-0-439-02348-1', TRUE),
("Harry Potter and the Sorcerer's Stone'", 'J.K. Rowling', 1997, 'Fantasy', '978-0-590-35340-3',FALSE),
('The Da Vinci Code', 'Dan Brown', 2003, 'Thriller', '978-0-385-50420-1', TRUE),
('The Giver', 'Lois Lowry', 1993, 'Dystopian', '978-0-440-23768-6',FALSE),
('The Maze Runner', 'James Dashner', 2009, 'Dystopian', '978-0-385-73794-6', TRUE),
('The Fault in Our Stars', 'John Green', 2012, 'Romance', '978-0-525-47881-2',FALSE),
('Dune', 'Frank Herbert', 1965, 'Science Fiction', '978-0-441-17271-9', TRUE),
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 2011, 'Non-Fiction', '978-0-06-231609-7',FALSE),
('The Power of Now', 'Eckhart Tolle', 1997, 'Self-Help', '978-1-57731-480-6', TRUE),
('Educated', 'Tara Westover', 2018, 'Memoir', '978-0-399-59050-4', TRUE),
('Becoming', 'Michelle Obama', 2018, 'Memoir', '978-1-5247-6313-8',FALSE),
('Atomic Habits', 'James Clear', 2018, 'Self-Help', '978-0-7352-1129-6', TRUE),
('Thinking, Fast and Slow', 'Daniel Kahneman', 2011, 'Psychology', '978-0-374-53355-7',FALSE),
('Outliers', 'Malcolm Gladwell', 2008, 'Non-Fiction', '978-0-316-01792-6', TRUE),
('The Lean Startup', 'Eric Ries', 2011, 'Business', '978-0-307-88791-8', TRUE),
('Steve Jobs', 'Walter Isaacson', 2011, 'Biography', '978-1-4516-4853-9',FALSE),
("The Innovator's Dilemma", 'Clayton M. Christensen', 1997, 'Business', '978-0-06-206024-2', TRUE),
('Born a Crime', 'Trevor Noah', 2016, 'Memoir', '978-0-399-58817-4',FALSE),
('Quiet: The Power of Introverts', 'Susan Cain', 2012, 'Self-Help', '978-0-307-35215-6',TRUE),
('The Subtle Art of Not Giving a F*ck', 'Mark Manson', 2016, 'Self-Help', '978-0-06-245771-4',FALSE),
('How to Win Friends and Influence People', 'Dale Carnegie', 1936, 'Self-Help', '978-0-671-02703-2',TRUE),
("Man's Search for Meaning", 'Viktor E. Frankl', 1946, 'Psychology', '978-0-8070-1426-4',TRUE),
('The Four Agreements', 'Don Miguel Ruiz', 1997, 'Self-Help', '978-1-878424-31-0',FALSE),
('Grit', 'Angela Duckworth', 2016, 'Self-Help', '978-1-5011-1110-5',TRUE),
('Lean In', 'Sheryl Sandberg', 2013, 'Non-Fiction', '978-0-385-34994-1',FALSE),
('Good to Great', 'Jim Collins', 2001, 'Business', '978-0-06-662099-4',TRUE),
('The 7 Habits of Highly Effective People', 'Stephen R. Covey', 1989, 'Self-Help', '978-0-7432-6951-4',FALSE),
('Start with Why', 'Simon Sinek', 2009, 'Business', '978-1-59184-280-4',TRUE),
('The 48 Laws of Power', 'Robert Greene', 1998, 'Self-Help', '978-0-670-88146-8',TRUE);