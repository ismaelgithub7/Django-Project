# Django-Project
Este repositorio contiene una aplicación web python hecha utilizando django.
Se trata de una aplicación muy simple, una calculadora, ya que el objetivo de este proyecto es practicar. Además de la aplicación se ha creado todo lo necesario para desarrollar, y desplegar sobre esa aplicación mediante dockers. Los docker utilizados, menos el de postgres, se encuentran en el siguiente repositorio: https://github.com/ismaelgithub7/dockers.git . También se ha realizado mediante jenkins , a través de pipelines, procesos de CI/CD.
Tecnologias, herramientas o métodos que se han utilizado:

- Git.
- Git Flow.
- GitHub.
- Docker.
- Docker Compose.
- Jenkins.
- Django. (De forma superficial)
- Python.
- HTML
- Shell Script.
- Linux.
- Postgres SQL.
- CI/CD.
- ChatGPT. (Como herramienta para corregir errores o para aprender, no para realizar el grueso de este royecto.)
## Funcionamiento General.
Todo el funcionamiento y despliegue del proyecto es realizado a través de dockers, con el objetivo de que pueda ser utilizado en multitud de ambientes, y de una forma sencilla a traves de micorservicios. Todo el código de la aplicación de Django se encuentra en el directorio 'django-data'. 
Este proyecto está dividido en 2 secciones principales:
- Desarrollo, solo hay un dokcer , el docker de la aplicación django, en el se introduce el código de la aplicación Django y se sirve a través del puerto 8000. El objetivo de esto es realizar el desarrollo de la aplicación y poder ver el resultado a través del docker de una forma rápida. Se utiliza una base de datos sqlite.
- Producción, se trata del grueso de este proyecto, se utilizan tres dockers, el propio de Django utilizado en la parte de desarrollo, pero esta vez no con el objetivo de realizar desarrollo, sino que utilizando gunicorn redirigir las conexiones al segundo docker que sería el de nginx, el cual es utilizado para servir la aplicación de una forma más adecuada a producción. El tercer y último docker es el de postgress, en vez de utilizar una base de datos sqlite como en desarrollo, se utiliza algo más adecuado para producción como una base de datos de postgres.
Con el despliege de estos tres dockers se servirá la aplicación web por el puerto 80 del host donde es desplegada.

Además de todo lo anterior se ha realizado un proceso de CI/CD. Se ha utilizado un servidor de Jenkins tambien dockerizado que se puede observar en https://github.com/ismaelgithub7/jenkins-server .Se ha utilizado webhooks de github para ejecutar estos procesos de forma automática. Cuando se sube algo a la rama de desarrollo se ejecuta el pipeline de CI, si se sube algo a la rama de producción se ejecuta el pipeline de CD. Tambien se han unido al servidor dos nodos , uno de desarrollo donde se realizan las pruebas necesarias para después desplegarlo en el otro nodo, el de producción.

- Pipeline de CI, se despliega el proyecto como en desarrollo, se ejecutan los tests unitarios de la aplicación, posteriormente se levantan los dockers de producción y se comprueba su funcionamiento, al final de la ejecución, tanto si ha fallado como si ha sido realizado con éxito se envía un correo con los logs de la ejeciución.
- Pipeline de CD, este pipeline comprueba si existe ya un projecto de esta aplicación en producción, si existe este se para y se salvaguarda en un directorio, posteriormente se despliega el nuevo proyecto y se testea su correcto funcionamiento. Si el nuevo proyecto falla, se recupera el que ya había instalado, si no falla se elimina el que ya había y se deja el nuevo. De esta forma siempre habría un proyecto levantado en todo momento, salvo mientras se para uno y se inicia otro. Finalmente al igual que en el pipeline de Ci se envía un correo con los logs de la ejecución.

## Aspectos que se realizarán en el futuro.
- Más pruebas relacionadas con CI, utilización de sonarqube...
- Mejorar pruebas de funcionamineto dockers.
- Documentar configuraciones o aspectos que no se pueden observar en este repositorio como la creación del servidor de jenkins.
- Mejorar formato del correo que se envía al terminar la ejecución de los pipelines de Jenkins.
- Despliege automático del proyecto en un cluster de Kubernetes.
- Utilización de Terraform.
- Documentar pruebas de funcionamiento.
- utilización de ssl para la web.

## Estructura y contenidos.
- Como se puede observar la estructura de este repositorio está compuesta por:
### 1. Directorio 'develop'.
Esta carpeta contiene todo lo necesario para poder iniciar la aplicación web en un entrono de desarrollo, pudiendo levantarlo mediante un docker compose 'compose-develop.yaml'. De esta forma un desarrollador podría modificar o ampliar la aplicación y poder verla en acción de una forma aislada de su host. Se utiliza una base de datos Sqlite.
#### 1.1 Subdirectorio 'docker-data':
Este subdirectorio contiene un script que a través de un volumen bindeado es introducido dentro del docker y posteriormente ejecutado. en el existen varia opciones para trabajar con el. Además se levanta el servidor django de forma automática después de iniciar el docker.
#### 1.2 Archivo 'compose-develop.yaml':
Se trata del archivo docker compose que se utiliza para levantar el docker de Django.
### 2. Directorio 'django-data'.
Este directorio contiene todo el código de la aplicación de Django. es utilizado como volumen por los dockers para contenarizarla. Contiene test unitarios para realizarls en el proceso de CI.
#### 2.1 Subdirectorio 'calculator_project':
Contiene los datos del projecto de Django. Dentro de este en vez de lo normal, que sería tener un archivo solo de settings, hay dos, uno es para configuraciones de producción 'settings-producción', y el otro para entornos de desarrollo.
#### 2.1 Subdirectorio 'calculator_app':
Contiene los datos de la app de Django.
### 3. Directorio 'production':
Esta carpeta contiene todo lo necesario para desplegar la aplicación en un ambiente de producción, utilizando una base de datos postgres en vez de una sqlite. Tambien se utiliza nginx y gunicorn para servir la aplicación.
#### 3.1 Subdirectorio 'Docker-data':
Este subdirectorio contiene archivos que son introducidos en sus respectivos dockers a la hora de levantarlos. Son scripts y archivos de opciones.
##### 3.1.1 subdirectorio '/docker-data/django':
Contiene dos archivos, uno es el script de inicialización del docker de django con la aplicación web dentro. El otro es un script muy popular que se utiliza para parar el inicio de un docker hasta que un determinado servicio de otro docker se inicie. En este caso se utiliza para retrasar el levantamiento del servidor de django hasta que la base de datos de postgres esté levantada.
##### 3.1.2 subdirectorio '/docker-data/nginx':
Este subdirectorio contiene los archivos de configuración de nginx para que sean editables desde el exterior del docker. Se introducen en el docker mediante un bind volume.
En el archivo 'http.d/default.conf' se encuentra todo lo necesario para redirigir todo el tráfico del puerto 80 a la aplicación de Django.
##### 3.1.3 subdirectorio '/docker-data/postgres':
Como se puede observar, este directorio contiene 3 archivos, un archivo sql, que se ejecuta en el momento de levantar la base de datos.
El segundo es el archivo de inicialización del docker. El último es el archivo de configuración de postgres, este cada vez que se inicia el docker es copiado al directorio correspondiente y utilizado por postgres.
#### 3.2 Archivo 'compose.yaml':
Se trata del archivo de docker compose que levanta todos los dockers de producción.
### 4. Archivos pipelines de Jenkins.
Se trata de los archivos que utiliza jenkins en los procesos de CI/CD.
#### 4.1 Pipeline CI 'jenkinsfile-ci'.es
Un pipeline de Jenkins que principalmente se encarga de ejecutar test para el código de python de la aplicación. Tambien comprueba el funcionamiento de los dockers de producción. (Más explicado en el propio archivo.)
#### 4.2 Pipeline CD 'jenkinsfile-cd'.
Un Pipeline de Jenkins que se encarga del proceso CD, se comprueba el ambiente de producción y se prueba la nueva versión de la aplicación.
### 5. Directorios o archivos que se crean.
Se trata de archivos y directorios que no se suben al repositorio, pero que localmente, al utilizar el proyecto, aparecen.
#### 5.1 Directorio '/production/db-postgres'.
Este directorio es un bind volumen de la base de datos de producción de postgres, se usa para preservar localmente la base de datos, no tendría ningún sentido subirla al repositorio.
Tiene solo permisos de root, no se ve su contenido si no se utiliza sudo. Con fines de seguridad.
#### 5.2 Archivo 'django-data/db.sqlite3'.
Se trata del archivo que contiene la base de datos de la aplicación web en el ambiente de desarrollo, no se sube ya que se preserva localmente al igual que la de postgres de producción.
