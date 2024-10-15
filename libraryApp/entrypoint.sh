#!/bin/bash
cat > /root/.my.cnf <<EOF
[client]
user = ${DB_USER:-library_user}
password = ${DB_PASSWORD:-user}
host = ${DB_HOST:-mysql9}
port = ${DB_PORT:-3306}
EOF

chmod 600 /root/.my.cnf


echo "Waiting for MySQL to be available..."
until mysql -h "$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" -e "SHOW DATABASES;" > /dev/null 2>&1; do
    echo "MySQL is unavailable - sleeping"
    sleep 2
done



echo "MySQL is up - continuing..."

cp startup.sh /usr/local/bin/
chmod +x /usr/local/bin/startup.sh
chmod +x book_management.sh
chmod +x user_management.sh
chmod +x borrow_return.sh

echo "alias M3lib='/usr/local/bin/startup.sh'" >> /root/.bashrc

bash /usr/local/bin/startup.sh

