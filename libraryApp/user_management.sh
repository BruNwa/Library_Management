#!/bin/bash

DB_HOST="mysql9" 
DB_PORT="3306"
DB_NAME="library_db"
DB_USER="library_user"
DB_PASSWORD="user"


add_user() {
    read -p "Enter Name: " name
    read -p "Enter Email Address: " email
    read -p "Enter Phone Number: " phone

    mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e \
    "INSERT INTO Users (name, email, phone) VALUES ('$name', '$email', '$phone');"

    echo "User '$name' added successfully!"
}

remove_user() {
    read -p "Name of the user you want to remove? " name

    mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e \
    "DELETE FROM Users WHERE name = '$name';"

    echo "User '$name' deleted successfully!"
}

update_user() {
    read -p "Name of the user you want to change details? " name
    echo
    echo "Choose query options:"
    echo "1. Change Name"
    echo "2. Change Email Address"
    echo "3. Change Phone Number"
    echo "4. Go back"
    read -p "Your chosen option: " option

    case $option in
        1) 
            read -p "Change Name to: " name
            query="name = $name"
            ;;
        2)
            read -p "Change Email Address to: " email
            query="email = $email"
            ;;
        3)
            read -p "Change Phone Number to: " phone
            query="phone = $phone"
            ;;
        4) 
            break
            ;;
        *)
            echo "Invalid option. Try again."
            ;;
        esac

    mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e \
    "Update Users SET $query WHERE name = '$name';"
}

query_users() {
    echo "Query Users Database"
    echo "1. Query all users"
    echo "2. Selectively query users"
    read -p "Your Chosen Option: " option

    case $option in 
        1) 
            query=""
            ;;
        2) 
            echo "1. Query Names"
            echo "2. Query Email Addresses"
            echo "3. Query Phone Numbers"
            read -p "Select criteria to query: " sub_option

            case $sub_option in
                1)
                    read -p "Enter Name To Search: " name
                    query="WHERE name LIKE '%$name%'"
                    ;;
                2)
                    read -p "Enter Email Address to Search: " email
                    query="WHERE email LIKE '%$email%'"
                    ;;
                3)
                    read -p "Enter Phone Number to Search: " phone
                    query="WHERE phone LIKE '%$phone%'"
                    ;;
                *)
                    echo "Invalid option $option"
                    ;;
            esac
            ;;
        *)
            echo "Invalid option"
            ;;
    esac

    mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e \
    "SELECT * FROM Users $query;"
}


while true; do
    echo "User Management System"
    echo "1. Display Users"
    echo "2. Add a New User"
    echo "3. Delete an User"
    echo "4. Update an User"
    echo "5. Exit"
    read -p "Your Chosen Option: "

    case $option in
    1) 
        query_users
        ;;
    2)
        add_user
        ;;
    3)
        remove_user
        ;;
    4) 
        update_user
        ;;
    5)
        exit 0
        ;;
    *)
        echo "Invalid Option. Try again."
        ;;
    esac
done