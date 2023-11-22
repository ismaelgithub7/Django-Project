#!/bin/sh
project_name="calculator_project"
app_name="calculator_app"
restore_djangopath=false
if [ $restore_djangopath = true ];
then
    # lsof +D /django-data
    rm -rf /django-data/*
else
    echo "[INFO] Restore django data mode desactivated"
fi
cd /django-data
if [ -d "/django-data/$project_name" ];
then
    echo "[INFO] Some project exists"
else
    django-admin startproject $project_name
fi
python3 /django-data/$project_name/manage.py runserver 0.0.0.0:8000 &
if [ -d f"/django-data/$project_name/$app_name" ];
then
    echo "[INFO] App $app_name exists"
else
    cd $project_name
    python3 /django-data/$project_name/manage.py startapp $app_name
fi
tail -f /dev/null