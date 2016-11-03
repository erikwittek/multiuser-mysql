#!/bin/sh
set -e

OLD_IFS=$IFS
IFS=';'
for ENTRY in $DB_USERS; do
  MYSQL_DATABASE=$(echo $ENTRY | cut -d ":" -f 1)
  MYSQL_USER=$(echo $ENTRY | cut -d ":" -f 2)
  MYSQL_PASSWORD=$(echo $ENTRY | cut -d ":" -f 3)

  echo "Creating database: $MYSQL_DATABASE with user: $MYSQL_USER and password: $MYSQL_PASSWORD"
  echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" | "${mysql[@]}"
  echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" | "${mysql[@]}"
  echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" | "${mysql[@]}"
  echo "FLUSH PRIVILEGES ;" | "${mysql[@]}"
done
IFS=$OLD_IFS
