#!/bin/bash
set -e

MANAGER_USER="spacewalk"
MANAGER_PASS="spacewalk"
MANAGER_DB_NAME="susemanager"
PGDATA="/var/lib/pgsql/data"

chmod +x /var/lib/pgsql/.bash_profile /usr/share/postgresql/bash_profile

su - postgres -c "/usr/lib/postgresql10/bin/pg_ctl -D $PGDATA initdb"
su - postgres -c "/usr/lib/postgresql10/bin/pg_ctl -D $PGDATA start"

su - postgres -c "createdb $MANAGER_DB_NAME ; echo \"CREATE ROLE $MANAGER_USER PASSWORD '$MANAGER_PASS' SUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;\" | psql"
echo "listen_addresses = '*'" >> /var/lib/pgsql/data/postgresql.conf
echo "local $MANAGER_DB_NAME $MANAGER_USER md5
host $MANAGER_DB_NAME $MANAGER_USER 127.0.0.1/8 md5
host $MANAGER_DB_NAME $MANAGER_USER ::1/128 md5
" > /tmp/pg_hba.conf
cat /var/lib/pgsql/data/pg_hba.conf >> /tmp/pg_hba.conf
mv /var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf.bak
mv /tmp/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf

#rm /etc/rhn/rhn.conf
su - postgres -c "/usr/lib/postgresql10/bin/pg_ctl -D $PGDATA stop"
