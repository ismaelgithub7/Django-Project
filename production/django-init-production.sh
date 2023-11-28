#!/bin/sh
sleep 10
python3 /django-data/manage.py makemigrations
python3 /django-data/manage.py runserver --settings=calculator_project.settings-production 0.0.0.0:8000
tail -f /dev/null