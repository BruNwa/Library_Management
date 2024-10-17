#!/bin/bash

# Database name variable (add this if not already defined)
DB_NAME="library_db"

while true; do
    echo " ================================ "
    echo " |      Borrow & Return Menu     |"
    echo " ================================ "
    echo " | 1. Borrow a Book              | "
    echo " | 2. Return a Book              | "
    echo " | 3. View Borrowed Books        | "
    echo " | 4. View Available Books       | "
    echo " | 5. View User's Borrowed Books | "
    echo " | 6. Exit                       | "
    echo " --------------------------------- "
    echo 
    read -p "Choose an option: " option

    case $option in
        1)  # Borrow a Book
            read -p "Enter User ID: " user_id
            read -p "Enter Book ID: " book_id
            availability=$(mysql -D $DB_NAME -sse \
            "SELECT availability FROM Books WHERE book_id=$book_id;")
            if [ "$availability" = "1" ]; then
                borrow_date=$(date +%Y-%m-%d)
                read -p "Enter Return Date (YYYY-MM-DD): " due_date

                # Validate the due date format
                if ! date -d "$due_date" >/dev/null 2>&1; then
                    echo "Invalid date format. Please enter a valid date in YYYY-MM-DD format."
                else
                    mysql -D $DB_NAME -e \
                    "INSERT INTO Borrow_Log (book_id, user_id, borrow_date, due_date) VALUES ($book_id, $user_id, '$borrow_date', '$due_date');"
                    mysql -D $DB_NAME -e \
                    "UPDATE Books SET availability=FALSE WHERE book_id=$book_id;"
                    echo "Book borrowed successfully! The book is due on $due_date."
                fi
            else
                echo "Book is not available."
            fi
            ;;
        2)  # Return a Book
            read -p "Enter Borrow ID: " borrow_id
            read -p "Enter Book ID: " book_id
            return_date=$(date +%Y-%m-%d)
            
            #--- Overdue check ---#
            overdue_info=$(mysql -D $DB_NAME -e \
<<<<<<< HEAD
    		"SELECT OFN.fine_amount 
    		FROM Overdue_Fines OFN 
    		JOIN Borrow_Log BL ON OFN.borrow_id = BL.borrow_id 
    		WHERE BL.borrow_id = $borrow_id AND BL.book_id = $book_id;")
	    fine_amount=$(echo "$overdue_info" | awk 'NR==2 {print $1}')
		if [[ -n $fine_amount && $(echo "$fine_amount" | grep -E '^[0-9]+(\.[0-9]{1,2})?$') ]]; then
		    echo "There is an outstanding fine of: \$${fine_amount}."
		    echo "The book cannot be returned until the fine is settled."
		else
            mysql -D $DB_NAME -e \
            "UPDATE Borrow_Log SET return_date='$return_date' WHERE borrow_id=$borrow_id;"
            mysql -D $DB_NAME -e \
            "UPDATE Books SET availability=TRUE WHERE book_id=$book_id;"
            echo "Book returned successfully!"
=======
            "SELECT OFN.fine_amount 
            FROM Overdue_Fines OFN 
            JOIN Borrow_Log BL ON OFN.borrow_id = BL.borrow_id 
            WHERE BL.borrow_id = $borrow_id AND BL.book_id = $book_id;")
            fine_amount=$(echo "$overdue_info" | awk 'NR==2 {print $1}')
            if [[ -n $fine_amount && $(echo "$fine_amount" | grep -E '^[0-9]+(\.[0-9]{1,2})?$') ]]; then
                echo "There is an outstanding fine of: \$${fine_amount}."
                echo "The book cannot be returned until the fine is settled."
            else
                mysql -D $DB_NAME -e \
                "UPDATE Borrow_Log SET return_date='$return_date' WHERE borrow_id=$borrow_id;"
                mysql -D $DB_NAME -e \
                "UPDATE Books SET availability=TRUE WHERE book_id=$book_id;"
                echo "Book returned successfully!"
>>>>>>> bcde4763ecca315a4bc861ca34d3b4b67a92b77e
            fi
            ;;
        3)  # View Borrowed Books
            echo "List of Borrowed Books:"
            mysql -D $DB_NAME -e \
            "SELECT Borrow_Log.borrow_id, Users.name, Books.title, Borrow_Log.borrow_date, Borrow_Log.due_date, Borrow_Log.return_date
             FROM Borrow_Log
             JOIN Users ON Borrow_Log.user_id = Users.user_id
             JOIN Books ON Borrow_Log.book_id = Books.book_id
             WHERE Borrow_Log.return_date IS NULL;"
            ;;
        4)  # View Available Books
            echo "List of Available Books:"
            mysql -D $DB_NAME -e \
            "SELECT book_id, title FROM Books WHERE availability=TRUE;"
            ;;
        5)   # View User's Borrowed Books
            read -p "Enter User ID: " user_id
            echo "List of Borrowed Books for User ID $user_id:"
            mysql -D $DB_NAME -e \
            "SELECT Borrow_Log.borrow_id, Books.title, Borrow_Log.borrow_date, Borrow_Log.due_date, Borrow_Log.return_date
             FROM Borrow_Log
             JOIN Books ON Borrow_Log.book_id = Books.book_id
             WHERE Borrow_Log.user_id=$user_id AND Borrow_Log.return_date IS NULL;"
            ;;
        6)  # Exit
            exit 0 ;;
        *)  # Invalid Option
            echo "Invalid option. Please try again."
            ;;
    esac
done
