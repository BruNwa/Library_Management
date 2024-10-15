manage_borrow_return() {
    echo " 1) Borrow a Book "
    echo " 2) Return a Book "
    echo "==========================="
    echo 
    read -p "Choose an option: " option

    case $option in
        1)  # Borrow a Book
            read -p "Enter User ID: " user_id
            read -p "Enter Book ID: " book_id
            availability=$(mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD -D $MYSQL_DATABASE -sse \
            "SELECT availability FROM Books WHERE book_id=$book_id;")
            if [ "$availability" = "1" ]; then
                borrow_date=$(date +%Y-%m-%d)
                due_date=$(date -d "$borrow_date + 14 days" +%Y-%m-%d)
                mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD -D $MYSQL_DATABASE -e \
                "INSERT INTO Borrow_Log (book_id, user_id, borrow_date, due_date) VALUES ($book_id, $user_id, '$borrow_date', '$due_date');"
                mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD -D $MYSQL_DATABASE -e \
                "UPDATE Books SET availability=FALSE WHERE book_id=$book_id;"
                echo "Book borrowed successfully!"
            else
                echo "Book is not available."
            fi
            ;;
        2)  # Return a Book
            read -p "Enter Borrow ID: " borrow_id
            read -p "Enter Book ID: " book_id
            return_date=$(date +%Y-%m-%d)
            mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD -D $MYSQL_DATABASE -e \
            "UPDATE Borrow_Log SET return_date='$return_date' WHERE borrow_id=$borrow_id;"
            mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD -D $MYSQL_DATABASE -e \
            "UPDATE Books SET availability=TRUE WHERE book_id=$book_id;"
            echo "Book returned successfully!"
            ;;
        *)  # Invalid Option
            echo "Invalid option. Please try again."
            ;;
    esac
}