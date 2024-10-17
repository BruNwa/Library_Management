#!/bin/bash

while true; do
    clear
    echo "*******************************************************"
    echo "*                 📚 LIBRARY MANAGEMENT 📚            *"
    echo "*******************************************************"
    echo "*                                                     *"
    echo "*                1. 📖 Book Management                *"
    echo "*                2. 👥 User Management                *"
    echo "*                3. 📅 Borrow/Return                  *"
    echo "*                4. 💸 Fines                          *"
    echo "*            m3lib. 🐳 Enter the app container        *"
    echo "*         database. 🗄️ Access the database containe   *"
    echo "*             exit. 🚪 Exit the m3lib app             *"
    echo "*                                                     *"
    echo "*******************************************************"
    echo "*             Please select an option :               *"
    echo "*******************************************************"
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
        "m3lib")clear
                read -p "Enter the App Password: " -s pwd_app
                if [[ "$pwd_app" == "$APP_PASSWORD" ]]; then
                        clear
                        bash
                else
                        clear
                        echo "Wrong Password!"
                        sleep 1
                        exit
                fi;;
        "database") clear
                read -p "Enter the Password: " -s pwd_sql
                if [[ "$pwd_sql" == "$SQL_PWD" ]]; then
                        clear
                        mysql -D $DB_NAME
                else
                        clear
                        echo "Wrong Password!"
                        sleep 1
                        exit
                fi;;
        "exit") clear
            exit;;
        *) echo "Invalid option. Please try again."
            sleep 3;;
    esac
done
