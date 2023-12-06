#!/bin/sh
/docker-data/wait-for-it.sh postgres-alpine-production:5432
python3 /django-data/manage.py makemigrations
python3 /django-data/manage.py runserver --settings=calculator_project.settings-production 0.0.0.0:8000
gunicorno --bind 0.0.0.0:8000 calculator_project.wsgi:application
tail -f /dev/null