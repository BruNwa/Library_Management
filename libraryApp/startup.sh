#!/bin/bash

while true; do
    echo "Library Management Menu"
    echo "1. Book management"
    echo "2. user mana"
    echo "3. borrow_return"
    read -p "Choose an option: " choice

    case $choice in
        1) ./usr/src/app/book_management.sh ;;
        2) ./usr/src/app/user_management.sh ;;
        3) ./usr/src/app/borrow_return.sh ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done