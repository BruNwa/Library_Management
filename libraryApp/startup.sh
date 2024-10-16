#!/bin/bash

while true; do
    clear
    echo "*****************************************"
    echo "*         📚 LIBRARY MANAGEMENT 📚      *"
    echo "*****************************************"
    echo "*                                       *"
    echo "*          1. 📖 Book Management        *"
    echo "*          2. 👥 User Management        *"
    echo "*          3. 📅 Borrow/Return          *"
    echo "*          4. 💸 Fines                  *"
    echo "*                                       *"
    echo "*****************************************"
    echo "*   Please select an option [1-3]:      *"
    echo "*****************************************"
    read -p "Choose an option: " choice

    case $choice in
        1)  clear
            ./book_management.sh ;;
        2)  clear
            ./user_management.sh ;;
        3)  clear
            ./borrow_return.sh ;;
        4) clear
            ./fine_management.sh;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
