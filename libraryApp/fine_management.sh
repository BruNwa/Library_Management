#!/bin/bash
FINE_PER_DAY=1.00


TODAY=$(date +%Y-%m-%d)
mysql -D $DB_NAME -e \
    "INSERT INTO Overdue_Fines (borrow_id, fine_amount)
    SELECT borrow_id, DATEDIFF('$TODAY', due_date) * $FINE_PER_DAY
    FROM Borrow_Log
    WHERE return_date IS NULL
      AND due_date < '$TODAY'
      AND borrow_id NOT IN (SELECT borrow_id FROM Overdue_Fines);"
show_report()
{
echo "Fine Management Report:"
mysql -D $DB_NAME -e \
    "SELECT COUNT(*) AS total_fines FROM Overdue_Fines;

    -- Display example fines (showing first 5 for brevity)
    SELECT O.fine_id, U.name, B.title, O.fine_amount, L.due_date
    FROM Overdue_Fines O
    JOIN Borrow_Log L ON O.borrow_id = L.borrow_id
    JOIN Users U ON L.user_id = U.user_id
    JOIN Books B ON L.book_id = B.book_id
    LIMIT 5;"
}

while true; do
    echo " ============================== "
    echo "|      Fine Management Menu    |"
    echo " ============================== "
    echo " | 1. Show fines              | "
    echo " | 5. Exit                    | "
    echo "  ----------------------------  "
    read -p "Choose an option: " choice

    case $choice in
        1) show_report ;;
        5) exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac

done
