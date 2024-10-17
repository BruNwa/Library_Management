#!/bin/bash

validate_name() {
    if [[ "$1" =~ ^[a-zA-z]+$ ]]; then
        return 0
    else
        return 1
    fi
}


title_case() {
    echo "$1" | sed "s/.*/\L&/; s/^./\U&/"
}


validate_email() {
    if [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}


validate_phone() {
    if [[ "$1" =~  ^[0-9]{11}$ ]]; then
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
        fi
    done
}


input_email() {
    while true; do
        read -p "Enter$1 Email Address: " email
        if validate_email "$email"; then
            echo "$email"
            break
        fi
    done
}


input_phone() {
    while true; do
        read -p "Enter$1 Phone Number: " phone
        if validate_phone "$phone"; then
            echo "$phone"
            break
        fi
    done
}


query_user_id() {
    count=$(mysql -D $DB_NAME -e \
    "SELECT * FROM Users WHERE user_id = $1;")

    echo $count

    if [[ -z count ]]; then
        echo "No User found with ID: $1"
        return 1 
    else
        mysql -D $DB_NAME -e \
        "SELECT * FROM Users WHERE user_id = $1 LIMIT 1;"
        return 0 
    fi
}


add_user() {
    echo "Create a new User:"
    first_name=$(input_name "" "First")
    echo
    last_name=$(input_name "" "Last")
    echo
    email=$(input_email "")
    echo
    phone=$(input_phone)
    echo

    mysql -D $DB_NAME -e \
    "INSERT INTO Users (first_name, last_name, email, phone) \
    VALUES ('$first_name', '$last_name', '$email', '$phone');"

    echo "User $first_name $last_name added successfully!"
}


remove_user() {
    read -p "ID of the user you want to remove? " id

    if query_user_id "$id"; then
        mysql -D $DB_NAME -e \
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
        echo "  ___________________________  "
        echo " |  Choose Detail to Change: |"
        echo "  ---------------------------  "
        echo " | 1. Change Name            |"
        echo " | 2. Change Email Address   |"
        echo " | 3. Change Phone Number    |"
        echo " | 4. Go back                |"
        echo "  ---------------------------   "
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

        mysql -D $DB_NAME -e \
        "UPDATE Users SET $query WHERE user_id = $id;"

        echo "User with ID $id updated successfully!"
        
    else
        echo "User with ID $id cannot be changed because they do not exist."
    fi
}


query_users() {
    echo " ______________________________ "
    echo "|      Query Users Database    | "
    echo " ------------------------------  "
    echo "|  1. Display all users        |  "
    echo "|  2. Selectively query users  |  "
    echo " ------------------------------   "
    read -p "Your chosen option: " option
    clear

    case $option in 
        1) 
            query=""
            ;;
        2) 
            echo " _____________________________  "
            echo "|     Choose Query Options:   |"
            echo " -----------------------------  "
            echo "|  1. Query IDs               |"
            echo "|  2. Query Names             |"
            echo "|  3. Query Email Addresses   |"
            echo "|  4. Query Phone Numbers     |"
            echo " ----------------------------- "

            read -p "Select criteria to query: " sub_option
            clear

            case $sub_option in
                1)
                    read -p "Enter the User ID: " id
                    query="WHERE U.user_id = $id"
                    ;;
                2)
                    read -p "Enter Name To Search: " name
                    have_query="HAVING Full_Name LIKE '%$name%'";;
                3)
                    read -p "Enter Email Address to Search: " email
                    query="WHERE U.email LIKE '%$email%'"
                    ;;
                4)
                    read -p "Enter Phone Number to Search: " phone
                    query="WHERE U.phone LIKE '%$phone%'"
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

    sql_query="SELECT U.user_id, \
    CONCAT(U.first_name,' ', U.last_name) AS Full_Name, \
    U.email, U.phone, \
    COUNT(B.borrow_id) AS Num_Borrowed, \
    COALESCE(SUM(O.fine_amount), 0) AS Total_Fine \
    FROM Users U \
    LEFT JOIN Borrow_Log B ON B.user_id = U.user_id \
    LEFT JOIN Overdue_Fines O ON B.borrow_id = O.borrow_id \
    $query \
    GROUP BY U.user_id, U.email, U.phone \
    $have_query;"

    mysql -D $DB_NAME -e "$sql_query"
    read -p "" pass
    clear
    query=""
    have_query=""
}


while true; do
    echo " ============================== "
    echo "|     User Management System   |"
    echo " ============================== "
    echo "|  1. Display Users            | "
    echo "|  2. Add a New User           | " 
    echo "|  3. Delete a User            | "
    echo "|  4. Update a User            | "
    echo "|  5. Exit                     | "
    echo " ------------------------------  "
    read -p "Your chosen option: " option
    clear

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
