#!/bin/bash

add_book() {
    echo "Enter book title:"
    read title
    echo "Enter book author:"
    read author
    echo "Enter the published year:"
    read year
    echo "Enter book genre:"
    read genre
    echo "Enter book ISBN:"
    read isbn
    echo "Is the book availabe?:"
    read av

    
    mysql -D $DB_NAME -e \
    "INSERT INTO Books (title, author, year_published, genre, isbn, availability) VALUES ('$title', '$author','$year', '$genre', '$isbn','$av');"

    echo "Book '$title' added successfully!"
}


update_availability() {
    echo "Enter book ID to update availability:"
    read book_id
    echo "Is the book available? (1 for Yes, 0 for No):"
    read availability
    if [[ $availability == 1 ]]; then 
        mysql -D $DB_NAME -e \
        "UPDATE Books SET availability=TRUE WHERE book_id=$book_id;"
    elif [[ $availability == 0 ]]; then 
        mysql -D $DB_NAME -e \
        "UPDATE Books SET availability=FALSE WHERE book_id=$book_id;"
    fi

    echo "Availability for book ID '$book_id' updated to '$availability'."
}


while true; do
    echo "Book Management Menu"
    echo "1. Add a new book"
    echo "2. Update book availability"
    echo "3. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) add_book ;;
        2) update_availability ;;
        3) exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
