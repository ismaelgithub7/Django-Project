#!/bin/bash
chown -R postgres /docker-data/postgresql.conf # Se cambian los permisos del archivo de configuración de postgres para que pueda ser manejado.
cp /docker-data/postgres-db.sql /docker-entrypoint-initdb.d/postgres-db.sql # Se copia el archivo sql y se pega en el directorio para ser ejecutado en el inicio de base de datos.
su postgres # Se cambia el usuario actual para ser Postgres. 
./usr/local/bin/docker-entrypoint.sh postgres -c config_file=/docker-data/postgresql.conf & # Se ejecuta el script entrypoint del docker.
sleep 10 # Se espera 10 segundos a que acabe la utilización del archivo de configuración.
chmod g+r /docker-data/postgresql.conf # Se cambian los permisos del archivo de configuración.
chown -R root /docker-data/postgresql.conf # Finalmente se cambia el propietario paa que pueda ser editado desde fuera, con permisos root claro.
tail -f /dev/null

