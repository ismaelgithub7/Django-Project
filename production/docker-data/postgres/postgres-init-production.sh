#!/bin/bash
chown -R postgres /docker-data/postgresql.conf
cp /docker-data/postgres-db.sql /docker-entrypoint-initdb.d/postgres-db.sql
su postgres
./usr/local/bin/docker-entrypoint.sh postgres -c config_file=/docker-data/postgresql.conf &
sleep 10
chmod g+r /docker-data/postgresql.conf
chown -R root /docker-data/postgresql.conf
tail -f /dev/null

