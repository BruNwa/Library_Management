#!/bin/bash
DB_HOST="mysql9" 
DB_PORT="3306"
DB_NAME="library_db"
DB_USER="library_user"
DB_PASSWORD="user"
set -e

echo "Waiting for MySQL to be available..."
until mysql -h "$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;" > /dev/null 2>&1; do
    echo "MySQL is unavailable - sleeping"
    sleep 2
done

echo "MySQL is up - continuing..."

chmod +x startup.sh
chmod +x book_management.sh
chmod +x user_management.sh
chmod +x borrow_return.sh
bash startup.sh