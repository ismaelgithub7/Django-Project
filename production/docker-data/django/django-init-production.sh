#!/bin/sh
sleep 10
python3 /django-data/manage.py makemigrations
python3 /django-data/manage.py runserver --settings=calculator_project.settings-production 0.0.0.0:8000
gunicorn --bind 0.0.0.0:8000 calculator_project.wsgi:application
tail -f /dev/null