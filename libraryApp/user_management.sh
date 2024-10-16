#!/bin/bash

validate_name() {
    if [ "$1" =~ [a-zA-z] ]; then
        return 0
    else
        return 1
    fi
}

title_case() {
    echo "$1" | sed "s/.*/\L&/; s/^./\U&/"
}

validate_email() {
    if [ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]; then
        return 0
    else
        return 1
    fi
}

validate_phone() {
    if [ "$1" =~  ^[0-9]{11}$ ]; then
        return 0
    else
        return 1
    fi
}

input_name() {
    while true; do
        read -p "Enter$1 $2 Name: " name
        if validate_name "$name"; then
            echo $(title_case "$name")
            break
        else
            echo "Invalid $2 Name. Please enter only letters."
        fi
    done
}

input_email() {
    while true; do
        read -p "Enter$1 Email Address: " email
        if validate_email "$email"; then
            echo "$email"
            break
        else
            echo "Invalid Email Address. Please Try Again."
        fi
    done
}

input_phone() {
    while true; do
        read -p "Enter$1 Phone Number: " phone
        if validate_phone "$phone"; then
            echo "$phone"
            break
        else
            echo "Invalid Phone Number. Please Try Again."
        fi
    done
}

query_user_id() {
    res=$(mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e \
    "SELECT * FROM Users WHERE user_id = $1;")


    if [[ "$result" == *"0 rows"* ]]; then
        echo "No user found with ID: $1"
        return 1 
    else
        echo "$result" 
        return 0 
    fi
}

add_user() {
    first_name=$(input_name "" "First")
    last_name=$(input_name "" "Last")
    email=$(input_email "")
    phone=$(input_phone)

    mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e \
    "INSERT INTO Users (first_name, last_name, email, phone) VALUES ('$first_name', '$last_name', '$email', '$phone');"

    echo "User $first_name $last_name added successfully!"
}

remove_user() {
    read -p "ID of the user you want to remove? " id

    if query_user_id "$id"; then
        mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p"$DB_PASSWORD" -D "$DB_NAME" -e \
        "DELETE FROM Users WHERE user_id = '$id';"

        echo "User with ID '$id' deleted successfully!"
    else
        echo "User with ID '$id' cannot be deleted because they do not exist."
    fi
}

update_user() {
    read -p "ID of the user you want to change details? " id
    echo
    if query_user_id "$id"; then
        echo "Choose query options:"
        echo "1. Change Name"
        echo "2. Change Email Address"
        echo "3. Change Phone Number"
        echo "4. Go back"
        read -p "Your chosen option: " option

        case $option in
            1) 
                first_name=$(input_name " New" "First")
                last_name=$(input_name " New" "Last")

                query="first_name = '$first_name', last_name = '$last_name'"
                ;;
            2)
                email=$(input_email "")
                query="email = '$email'"
                ;;
            3)
                phone=$(input_phone " New")
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

        mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e \
        "UPDATE Users SET $query WHERE user_id = '$id';"

        echo "User with ID '$id' updated successfully!"
    else
        echo "User with ID '$id' cannot be changed because they do not exist."
    fi
}

query_users() {
    echo "Query Users Database"
    echo "1. Query all users"
    echo "2. Selectively query users"
    read -p "Your chosen option: " option

    case $option in 
        1) 
            query=""
            ;;
        2) 
            echo "1. Query an ID"
            echo "2. Query Names"
            echo "3. Query Email Addresses"
            echo "4. Query Phone Numbers"
            read -p "Select criteria to query: " sub_option

            case $sub_option in
                1)
                    read -p "Enter the User ID: " id
                    query="WHERE user_id LIKE '%$id%'"
                    ;;
                2)
                    read -p "Enter Name To Search: " name
                    query="WHERE name LIKE '%$name%'"
                    ;;
                3)
                    read -p "Enter Email Address to Search: " email
                    query="WHERE email LIKE '%$email%'"
                    ;;
                4)
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

    mysql -h $DB_HOST -P $DB_PORT -u $DB_USER -p$DB_PASSWORD -D $DB_NAME -e \
    "SELECT * FROM Users $query;"
}

while true; do
    echo "User Management System"
    echo "1. Display Users"
    echo "2. Add a New User"
    echo "3. Delete a User"
    echo "4. Update a User"
    echo "5. Exit"
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
