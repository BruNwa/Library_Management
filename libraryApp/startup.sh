#!/bin/bash

while true; do
    echo "Book Management Menu"
    echo "1. Book management"
    echo "2. user mana"
    echo "3. borrow_return"
    read -p "Choose an option: " choice

    case $choice in
        1) ./book_management.sh ;;
        2) ./user_management.sh ;;
        3) ./borrow_return.sh ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done