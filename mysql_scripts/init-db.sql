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
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE
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
('Gone with the Wind', 'Margaret Mitchell', 1936, 'Historical Fiction', '978-0-7432-9636-3',FALSE),
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

INSERT INTO Users (first_name, last_name, email, phone) 
VALUES 
('Brod', 'Cadden', 'bcadden0@mapquest.com', '9141748285'),
('Cassius', 'Kennicott', 'ckennicott1@g.co', '3448821784'),
('Berkeley', 'Ickeringill', 'bickeringill2@furl.net', '9423565594'),
('Maddie', 'Rymill', 'mrymill3@t-online.de', '2877898537'),
('Joyce', 'Copelli', 'jcopelli4@yale.edu', '7387404258'),
('Siusan', 'Dan', 'sdan5@flickr.com', '1733765013'),
('Ilyssa', 'Bentame', 'ibentame6@github.io', '4633226560'),
('Karen', 'Souza', 'ksouza7@hubpages.com', '5409371693'),
('Elmo', 'Maypother', 'emaypother8@addtoany.com', '3583707546'),
('Udale', 'Tomczykiewicz', 'utomczykiewicz9@topsy.com', '3397312064'),
('Thorstein', 'Whitters', 'twhittersa@wp.com', '1245778925'),
('Ami', 'Pleasaunce', 'apleasaunceb@usgs.gov', '6598517590'),
('Marsha', 'Edwicke', 'medwickec@pcworld.com', '7028655029'),
('Cody', 'Heyworth', 'cheyworthd@themeforest.net', '8767096777'),
('Rachel', 'Brooks', 'rbrookse@ucoz.com', '9607470803'),
('Vale', 'Ghidotti', 'vghidottif@sun.com', '1108482190'),
('Marlie', 'L'' Anglois', 'mlangloisg@blinklist.com', '1741608822'),
('Emeline', 'Hassen', 'ehassenh@mayoclinic.com', '8504377822'),
('Zandra', 'Masserel', 'zmassereli@technorati.com', '7439880819'),
('Terrijo', 'Pauwel', 'tpauwelj@sogou.com', '3307544489'),
('Marcelo', 'Hedylstone', 'mhedylstonek@stumbleupon.com', '3761538887'),
('Gladi', 'Prowse', 'gprowsel@nbcnews.com', '9631128678'),
('Ann-marie', 'Rhymes', 'arhymesm@hibu.com', '3731191142'),
('Riannon', 'Dinwoodie', 'rdinwoodien@nsw.gov.au', '2153654805'),
('Mort', 'Fussen', 'mfusseno@bloglines.com', '9409512262'),
('Ludovika', 'Lopez', 'llopezp@aboutads.info', '4571019405'),
('Artus', 'Puddicombe', 'apuddicombeq@shareasale.com', '1258772250'),
('Clarissa', 'Crichmer', 'ccrichmerr@loc.gov', '2289390036'),
('Nance', 'Hoodlass', 'nhoodlasss@deviantart.com', '4506603464'),
('Gaylor', 'Vosper', 'gvospert@is.gd', '9333009306'),
('Nataline', 'Ormston', 'normstonu@smugmug.com', '3587719447'),
('Nataline', 'Noddle', 'nnoddlev@barnesandnoble.com', '7665245192'),
('Corrine', 'Durbin', 'cdurbinw@mozilla.org', '9301487981'),
('Cly', 'Fann', 'cfannx@desdev.cn', '2503448215'),
('Raynell', 'Saunders', 'rsaundersy@indiatimes.com', '1056656186'),
('Nomi', 'Southcombe', 'nsouthcombez@netvibes.com', '6052094548'),
('Isabelle', 'McAline', 'imcaline10@over-blog.com', '8372303652'),
('Ariadne', 'Wyatt', 'awyatt11@slashdot.org', '2993741181'),
('Sophi', 'Letten', 'sletten12@bbc.co.uk', '3953173961'),
('Octavia', 'Glentworth', 'oglentworth13@ask.com', '7754893657'),
('Lea', 'Melburg', 'lmelburg14@newsvine.com', '8012668400'),
('Rosaline', 'Trenaman', 'rtrenaman15@newyorker.com', '6531340659'),
('Leann', 'MacTerrelly', 'lmacterrelly16@washington.edu', '2129917838'),
('Alard', 'Twede', 'atwede17@shareasale.com', '5612962206'),
('Lorianne', 'Cuniam', 'lcuniam18@github.io', '3935440211'),
('Herbert', 'Camble', 'hcamble19@businessinsider.com', '6288347212'),
('Cassandra', 'Coulbeck', 'ccoulbeck1a@craigslist.org', '8942030491'),
('Christal', 'Ochterlony', 'cochterlony1b@wufoo.com', '3613511637'),
('Lyda', 'Brizland', 'lbrizland1c@tripadvisor.com', '8629229508'),
('Charlotte', 'Vinson', 'cvinson1d@youku.com', '4533458906'),
('Dominick', 'Coggon', 'dcoggon1e@apple.com', '9428786096'),
('Erina', 'Linster', 'elinster1f@themeforest.net', '4149473430'),
('Gerrie', 'Dalman', 'gdalman1g@networkadvertising.org', '7572832608'),
('Krissie', 'Ondracek', 'kondracek1h@360.cn', '2768844697'),
('Wilt', 'Strond', 'wstrond1i@4shared.com', '4456536774'),
('Franz', 'Jee', 'fjee1j@yandex.ru', '3643903039'),
('Waneta', 'Ping', 'wping1k@twitter.com', '1875416645'),
('Kiersten', 'Moule', 'kmoule1l@xrea.com', '9378711095'),
('Ringo', 'Pervew', 'rpervew1m@sciencedaily.com', '6089026049'),
('Sashenka', 'Waddy', 'swaddy1n@oakley.com', '7622321376'),
('Vlad', 'McOmish', 'vmcomish1o@mail.ru', '9355416104'),
('Greggory', 'Jonas', 'gjonas1p@furl.net', '5208972553'),
('Karee', 'Jeratt', 'kjeratt1q@businessinsider.com', '4639999350'),
('Hamel', 'Bellis', 'hbellis1r@tuttocitta.it', '3116354903'),
('Willette', 'Hopkynson', 'whopkynson1s@nymag.com', '5305894299'),
('Allayne', 'Hanse', 'ahanse1t@ning.com', '8666865464'),
('Eliot', 'Iglesias', 'eiglesias1u@mail.ru', '5551236014'),
('Crissie', 'Ovell', 'covell1v@aol.com', '4469926347'),
('Lucienne', 'Thatcham', 'lthatcham1w@odnoklassniki.ru', '8182097649'),
('Porter', 'Nuemann', 'pnuemann1x@businessweek.com', '7186913651'),
('Mattheus', 'Menendes', 'mmenendes1y@blogspot.com', '6079237208'),
('Carla', 'Hamm', 'chamm1z@google.com', '8156843342'),
('Abran', 'Geroldo', 'ageroldo20@imdb.com', '8314324367'),
('Noellyn', 'Wreford', 'nwreford21@tmall.com', '9205962807'),
('Yvonne', 'Islep', 'yislep22@behance.net', '1837401612'),
('Mathias', 'Readhead', 'mreadhead23@latimes.com', '9926372111'),
('Brandyn', 'Boydle', 'bboydle24@google.com.hk', '6486238950'),
('Hamnet', 'Webber', 'hwebber25@webs.com', '1814496059'),
('Leyla', 'Nolin', 'lnolin26@google.es', '3198105311'),
('Augustine', 'Novill', 'anovill27@chicagotribune.com', '4701877290'),
('Stevena', 'Cherrison', 'scherrison28@youku.com', '4219655740'),
('Blisse', 'Carrane', 'bcarrane29@slashdot.org', '3786101690'),
('Michal', 'Goroni', 'mgoroni2a@youtu.be', '5465559680'),
('Baron', 'Chant', 'bchant2b@ask.com', '8564825407'),
('Kellia', 'Etridge', 'ketridge2c@usnews.com', '4269153433'),
('Hilda', 'Frise', 'hfrise2d@xing.com', '1924000098'),
('Vite', 'Rothman', 'vrothman2e@virginia.edu', '9838064905'),
('Kelby', 'Lechmere', 'klechmere2f@digg.com', '1557987630'),
('Leonie', 'Delieu', 'ldelieu2g@mozilla.com', '8174723673'),
('Cindi', 'Toffel', 'ctoffel2h@instagram.com', '6132376748'),
('Adrea', 'De Normanville', 'adenormanville2i@ocn.ne.jp', '2948040286'),
('Beck', 'Brady', 'bbrady2j@lulu.com', '1826895192'),
('Paolo', 'Stetlye', 'pstetlye2k@ycombinator.com', '1243391273'),
('Kathryn', 'Gye', 'kgye2l@ucoz.com', '2106255915'),
('Winni', 'Schlagtmans', 'wschlagtmans2m@addthis.com', '7088953211'),
('Devon', 'Wellum', 'dwellum2n@mysql.com', '8877465857'),
('Lionel', 'Lownsbrough', 'llownsbrough2o@aol.com', '5308586938'),
('Teodoro', 'Waddie', 'twaddie2p@who.int', '2472766693'),
('Merrill', 'Ioan', 'mioan2q@imdb.com', '8347886565'),
('Hugh', 'Rowbottom', 'hrowbottom2r@issuu.com', '5374196023');

INSERT INTO Borrow_Log (book_id, user_id, borrow_date, due_date, return_date) VALUES
(2, 1, '2024-09-01', '2024-09-15', NULL), -- Overdue
(5, 2, '2024-09-10', '2024-09-25', NULL), -- Overdue
(8, 3, '2024-09-20', '2024-10-05', NULL), -- Overdue
(12, 4, '2024-10-01', '2024-10-15', NULL), -- Not overdue
(20, 5, '2024-10-05', '2024-10-20', NULL); -- Not overdue