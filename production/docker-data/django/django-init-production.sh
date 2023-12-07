#!/bin/sh
/docker-data/wait-for-it.sh postgres-alpine-production:5432 # Se pone en pausa la ejecución de este escript hasta detectar el servicio de postgres.
python3 /django-data/manage.py makemigrations
python3 /django-data/manage.py runserver --settings=calculator_project.settings-production 0.0.0.0:8000 # Se levanta el servidor de Django.
gunicorn --bind 0.0.0.0:8000 calculator_project.wsgi:application # Se realiza el archivo wsgi de la aplicación  Django.
tail -f /dev/null # se deja este docker activo sin realizar nada.