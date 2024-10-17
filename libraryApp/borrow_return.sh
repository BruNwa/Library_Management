#!/bin/bash
#New code
while true; do
    echo " ================================ "
    echo " |      Borrow & Return Menu     |"
    echo " ================================ "
    echo " | 1. Borrow a Book              |"
    echo " | 2. Return a Book              |"
    echo " | 3. View All Borrowed Books    |"
    echo " | 4. View Unreturned Books      |"
    echo " | 5. View Available Books       |"
    echo " | 6. View User's Borrowed Books |"
    echo " | 7. Exit                       |"
    echo " --------------------------------- "
    echo
    read -p "Choose an option: " option

    case $option in
        1)  # Borrow a Book
            read -p "Enter User ID: " user_id
            read -p "Enter Book ID: " book_id

            # Check if the book is available
            availability=$(mysql -D $DB_NAME -sse "SELECT availability FROM Books WHERE book_id=$book_id;")
            if [ "$availability" = "1" ]; then
                borrow_date=$(date +%Y-%m-%d)
                due_date=$(date -d "$borrow_date + 14 days" +%Y-%m-%d)

                # Insert borrow record
                mysql -D $DB_NAME -e "INSERT INTO Borrow_Log (book_id, user_id, borrow_date, due_date) VALUES ($book_id, $user_id, '$borrow_date', '$due_date');"

                # Update book availability
                mysql -D $DB_NAME -e "UPDATE Books SET availability=FALSE WHERE book_id=$book_id;"

                echo "Book borrowed successfully! Due date is $due_date."
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
            fi
            ;;

        3)  # View All Borrowed Books (both returned and unreturned)
            echo "List of All Borrowed Books:"
            mysql -D $DB_NAME -e \
            "SELECT Borrow_Log.borrow_id, Users.first_name, Users.last_name, Books.title, Borrow_Log.borrow_date, Borrow_Log.due_date, Borrow_Log.return_date
             FROM Borrow_Log
             JOIN Users ON Borrow_Log.user_id = Users.user_id
             JOIN Books ON Borrow_Log.book_id = Books.book_id;"
            ;;

        4)  # View Unreturned Books
            echo "List of Unreturned Books:"
            mysql -D $DB_NAME -e \
            "SELECT Borrow_Log.borrow_id, Users.first_name, Users.last_name, Books.title, Borrow_Log.borrow_date, Borrow_Log.due_date
             FROM Borrow_Log
             JOIN Users ON Borrow_Log.user_id = Users.user_id
             JOIN Books ON Borrow_Log.book_id = Books.book_id
             WHERE Borrow_Log.return_date IS NULL;"
            ;;

        5)  # View Available Books
            echo "List of Available Books:"
            mysql -D $DB_NAME -e \
            "SELECT book_id, title FROM Books WHERE availability=TRUE;"
            ;;

        6)   # View User's Borrowed Books (both returned and unreturned)
            read -p "Enter User ID: " user_id
            echo "List of Borrowed Books for User ID $user_id:"
            mysql -D $DB_NAME -e \
            "SELECT Borrow_Log.borrow_id, Books.title, Borrow_Log.borrow_date, Borrow_Log.due_date, Borrow_Log.return_date
             FROM Borrow_Log
             JOIN Books ON Borrow_Log.book_id = Books.book_id
             WHERE Borrow_Log.user_id=$user_id;"
            ;;

        7)  # Exit
            exit 0 ;;

        *)  # Invalid Option
            echo "Invalid option. Please try again."
            ;;
    esac
done