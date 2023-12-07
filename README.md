# Django-Project

Este repositorio contiene una aplicación web en Python desarrollada con Django. Se trata de una aplicación muy simple: una calculadora. El objetivo principal de este proyecto es proporcionar práctica en el desarrollo web. Además de la aplicación, se han creado todos los elementos necesarios para el desarrollo y el despliegue de la aplicación mediante contenedores Docker. Los contenedores Docker utilizados, excepto el de PostgreSQL, se encuentran en el siguiente repositorio: [Repositorio Dockers](https://github.com/ismaelgithub7/dockers.git). El proceso de integración continua/despliegue (CI/CD) se ha implementado mediante Jenkins y pipelines.

## Tecnologías, herramientas o métodos utilizados:

- Git.
- Git Flow.
- GitHub.
- Docker.
- Docker Compose.
- Jenkins.
- Django (utilizado de manera superficial).
- Python.
- HTML.
- Shell Script.
- Linux.
- PostgreSQL.
- CI/CD.
- ChatGPT (utilizado como herramienta para corregir errores o aprender, no para realizar el grueso de este proyecto).

## Funcionamiento General:

El funcionamiento y despliegue del proyecto se realizan a través de contenedores Docker, con el objetivo de que pueda ser utilizado en diversos entornos de manera sencilla mediante microservicios. Todo el código de la aplicación Django se encuentra en el directorio 'django-data'.

Este proyecto se divide en dos secciones principales:

- **Desarrollo:** Solo hay un contenedor, el contenedor de la aplicación Django, donde se introduce el código de la aplicación y se sirve a través del puerto 8000. El objetivo es facilitar el desarrollo y la visualización rápida de los resultados a través del contenedor. Se utiliza una base de datos SQLite.

- **Producción:** Esta es la parte principal del proyecto, que utiliza tres contenedores. El contenedor de Django se utiliza nuevamente, pero esta vez, en lugar de desarrollo, se utiliza Gunicorn para redirigir las conexiones al segundo contenedor, que es el de Nginx. Este último se utiliza para servir la aplicación de manera más adecuada para producción. El tercer y último contenedor es el de PostgreSQL, que se utiliza en lugar de SQLite para una base de datos más adecuada en entornos de producción. La aplicación web se sirve a través del puerto 80 del host donde se despliega.

Además del funcionamiento mencionado anteriormente, se ha implementado un proceso de CI/CD utilizando un servidor de Jenkins dockerizado, que se puede encontrar en [Repositorio de docker servidor Jenkins](https://github.com/ismaelgithub7/jenkins-server). Se han utilizado webhooks de GitHub para ejecutar estos procesos de forma automática. Cuando se realiza una actualización en la rama de desarrollo, se ejecuta el pipeline de CI; si se realiza una actualización en la rama de producción, se ejecuta el pipeline de CD. Además, se han configurado dos nodos en el servidor: uno de desarrollo para realizar pruebas antes de desplegar en el nodo de producción.

- **Pipeline de CI:** Despliega el proyecto como en desarrollo, ejecuta pruebas unitarias de la aplicación, levanta los contenedores de producción y verifica su funcionamiento. Al final de la ejecución, ya sea que haya fallado o se haya completado con éxito, se envía un correo con los registros de la ejecución.

- **Pipeline de CD:** Este pipeline verifica la existencia de un proyecto de esta aplicación en producción. Si ya existe, se detiene y se guarda en un directorio; luego, se despliega el nuevo proyecto y se prueba su correcto funcionamiento. Si el nuevo proyecto falla, se recupera el proyecto anterior; si no falla, se elimina el proyecto anterior y se deja el nuevo. De esta manera, siempre hay un proyecto en ejecución, excepto durante el cambio de uno a otro. Al finalizar, al igual que en el pipeline de CI, se envía un correo con los registros de la ejecución.

## Aspectos que se realizarán en el futuro:

- Realizar más pruebas relacionadas con CI, incluida la utilización de SonarQube.
- Mejorar las pruebas de funcionamiento de los contenedores Docker.
- Documentar configuraciones o aspectos que no se pueden observar en este repositorio, como la creación del servidor de Jenkins.
- Mejorar el formato del correo que se envía al finalizar la ejecución de los pipelines de Jenkins.
- Implementar el despliegue automático del proyecto en un clúster de Kubernetes.
- Utilizar Terraform.
- Documentar pruebas de funcionamiento.
- Implementar el uso de SSL para la web.

## Estructura y Contenidos:

Como se puede observar, la estructura de este repositorio está compuesta por:

### 1. Directorio 'develop':

Este directorio contiene todo lo necesario para iniciar la aplicación web en un entorno de desarrollo mediante Docker Compose ('compose-develop.yaml'). De esta manera, un desarrollador puede modificar o ampliar la aplicación y verla en acción de forma aislada en su host. Se utiliza una base de datos SQLite.

#### 1.1 Subdirectorio 'docker-data':

Este subdirectorio contiene un script que, a través de un volumen vinculado, se introduce en el contenedor y se ejecuta automáticamente. Además, se levanta el servidor Django automáticamente después de iniciar el contenedor.

#### 1.2 Archivo 'compose-develop.yaml':

Este archivo Docker Compose se utiliza para levantar el contenedor de Django.

### 2. Directorio 'django-data':

Este directorio contiene todo el código de la aplicación Django y se utiliza como volumen para los contenedores que la contenerizan. También contiene pruebas unitarias para el proceso de CI.

#### 2.1 Subdirectorio 'calculator_project':

Contiene los datos del proyecto Django. En lugar de tener un archivo único de configuración ('settings'), hay dos archivos: uno para configuraciones de producción ('settings-producción') y otro para entornos de desarrollo.

#### 2.2 Subdirectorio 'calculator_app':

Contiene los datos de la aplicación Django.

### 3. Directorio 'production':

Este directorio contiene todo lo necesario para desplegar la aplicación en un entorno de producción, utilizando una base de datos PostgreSQL en lugar de SQLite. También se utiliza Nginx y Gunicorn para servir la aplicación.

#### 3.1 Subdirectorio 'Docker-data':

Este subdirectorio contiene archivos que se introducen en sus respectivos contenedores al levantarlos. Son scripts y archivos de opciones.

##### 3.1.1 Subdirectorio '/docker-data/django':

Contiene dos archivos: un script de inicialización del contenedor de Django con la aplicación web y otro script muy popular que se utiliza para retrasar el inicio de un contenedor hasta que un servicio específico de otro contenedor se inicie. En este caso, se utiliza para retrasar el levantamiento del servidor de Django hasta que la base de datos de PostgreSQL esté activa.

##### 3.1.2 Subdirectorio '/docker-data/nginx':

Este subdirectorio contiene archivos de configuración de Nginx para que sean editables desde fuera del contenedor. Se introducen en el contenedor mediante un volumen vinculado. En el archivo 'http.d/default.conf', se encuentra toda la configuración necesaria para redirigir todo el tráfico del puerto 80 a la aplicación de Django.

##### 3.1.3 Subdirectorio '/docker-data/postgres':

Este directorio contiene tres archivos: un archivo SQL que se ejecuta al levantar la base de datos, un archivo de inicialización del contenedor y un archivo de configuración de PostgreSQL. Este último se copia al directorio correspondiente y se utiliza cada vez que se inicia el contenedor de PostgreSQL.

#### 3.2 Archivo 'compose.yaml':

Este archivo Docker Compose levanta todos los contenedores de producción.

### 4. Archivos pipelines de Jenkins:

Estos archivos son utilizados por Jenkins en los procesos de CI/CD.

#### 4.1 Pipeline CI 'jenkinsfile-ci':

Un pipeline de Jenkins que se encarga principalmente de ejecutar pruebas para el código Python de la aplicación. También verifica el funcionamiento de los contenedores de producción (más información en el propio archivo).

#### 4.2 Pipeline CD 'jenkinsfile-cd':

Un pipeline de Jenkins que se encarga del proceso de CD. Verifica el entorno de producción y prueba la nueva versión de la aplicación.

### 5. Directorios o archivos que se crean:

Estos archivos y directorios no se cargan en el repositorio, pero aparecen localmente al utilizar el proyecto.

#### 5.1 Directorio '/production/db-postgres':

Este directorio es un volumen vinculado de la base de datos de producción de PostgreSQL, utilizado para preservar localmente la base de datos.

#### 5.2 Archivo 'django-data/db.sqlite3':

Este archivo contiene la base de datos de la aplicación web en el entorno de desarrollo y no se carga al repositorio, ya que se preserva localmente, al igual que la base de datos PostgreSQL de producción.
