#!/bin/sh
project_name="calculator_project" # Nombre prra crear un proyecto.
app_name="calculator_app" # Nombre para crear una app dentro del proyecto anterior.
port_server="8000" # Puerto en el que se sirve la app web.
ip_acces_server="0.0.0.0" 
restore_djangopath=false # Si se activa se borran todos los datos de código de app o proyectos.


# colores ANSI utilizados más abajo.
r='\033[0;31m'
v='\033[0;32m'
a='\033[1;33m'
t='\033[0m'
z='\033[0;34m'

# Utilizando las anteriores variables se crean los proyectos y apps necesarias, si se escribe el nombre de una app o proyecto que no existe se crea automáticamente al iniciar el docker.
if [ $restore_djangopath = true ];
then
    rm -rf /django-data/*
else
    echo "[${z}INFO${t}] Restore django data mode desactivated"
fi
cd /django-data
if [ -d "/django-data/$project_name" ];
then
    echo "[${z}INFO${t}] Some project exists"
else
    django-admin startproject $project_name /django-data
fi
if [ -d "/django-data/$app_name" ];
then
    echo "[${z}INFO${t}] App $app_name exists"
else
    python3 /django-data/manage.py startapp $app_name
fi
python3 /django-data/manage.py runserver 0.0.0.0:$port_server & # Se inicia el servidor de Django
echo "[${v}SUCCESS${t}] Aplicación web levantada correctamente acceso: http://localhost:$port_server/"
tail -f /dev/null