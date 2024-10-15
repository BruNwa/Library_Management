#!/bin/bash



add_user() {
    read -p "Enter Name: " name
    read -p "Enter Email Address: " email
    read -p "Enter Phone Number: " phone

    mysql -D $DB_NAME -e \
    "INSERT INTO Users (name, email, phone) VALUES ('$name', '$email', '$phone');"

    echo "User '$name' added successfully!"
}

remove_user() {
    read -p "Name of the user you want to remove? " name

    mysql -D $DB_NAME -e \
    "DELETE FROM Users WHERE name = '$name';"

    echo "User '$name' deleted successfully!"
}

update_user() {
    read -p "ID of the user you want to change details? " id
    echo
    echo " _____________________________  "
    echo "|     Choose query options:   |"
    echo " -----------------------------  "
    echo " | 1. Change Name            |"
    echo " | 2. Change Email Address   |"
    echo " | 3. Change Phone Number    |"
    echo " | 4. Go back                |"
    echo "  ---------------------------   "
    read -p "Your chosen option: " option

    case $option in
        1) 
            read -p "Change Name to: " name
            query="name = '$name'"
            ;;
        2)
            read -p "Change Email Address to: " email
            query="email = '$email'"
            ;;
        3)
            read -p "Change Phone Number to: " phone
            query="phone = '$phone'"
            ;;
        4) 
            return
            ;;
        *)
            echo "Invalid option. Try again."
            return
            ;;
    esac

    mysql -D $DB_NAME -e \
    "UPDATE Users SET $query WHERE user_id = '$id';"

    echo "User with ID '$id' updated successfully!"
}

query_users() {
    echo " _____________________________  "
    echo "|      Query Users Database   | "
    echo " -----------------------------  "
    echo " | 1. Query all users        |  "
    echo " | 2. Selectively query users|  "
    echo "  ---------------------------   "
    read -p "Your chosen option: " option

    case $option in 
        1) 
            query=""
            ;;
        2) 
            echo " -------------------------  "
            echo "| 1. Query Names          |"
            echo "| 2. Query Email Addresses|"
            echo "| 3. Query Phone Numbers  |"
            echo " -------------------------  "
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
                    echo "Invalid option."
                    return
                    ;;
            esac
            ;;
        *)
            echo "Invalid option."
            return
            ;;
    esac

    mysql -D $DB_NAME -e \
    "SELECT * FROM Users $query;"
}

while true; do
    echo " ============================== "
    echo "|     User Management System   |"
    echo " ============================== "
    echo " | 1. Display Users           | "
    echo " | 2. Add a New User          | " 
    echo " | 3. Delete a User           | "
    echo " | 4. Update a User           | "
    echo " | 5. Exit                    | "
    echo "  ----------------------------  "
    read -p "Your chosen option: " option

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
        echo "Invalid option. Try again."
        ;;
    esac
done
