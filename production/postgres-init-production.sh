#!/bin/bash
chown -R postgres /postgresql-conf/postgresql.conf
su postgres
./usr/local/bin/docker-entrypoint.sh postgres -c config_file=/postgresql-conf/postgresql.conf &
sleep 10
chown -R 1000 /postgresql-conf/postgresql.conf
tail -f /dev/null

