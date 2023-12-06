# Django-Project
Este repositorio contiene una aplicación web python hecha utilizando django.
Se trata de una aplicación muy simple, una calculadora, ya que el objetivo de este proyecto es practicar. Además de la aplicación se ha creado todo lo necesario para desarrollar, y desplegar sobre esa aplicación mediante dockers. Los docker utilizados se encuentran en el siguiente repositorio: https://github.com/ismaelgithub7/dockers.git . También se harealizado mediante jenkins , a través de pipelines, procesos de CI/CD.
Tecnologias, herramientas o métodos que se han utilizado:

- Git.
- Git Flow.
- GitHub.
- Docker.
- Docker Compose.
- Jenkins.
- Django. (De forma superficial)
- Python.
- Shell Script.
- Linux.
- Postgres SQL.
- CI/CD.
- ChatGPT. (Como herramienta para corregir errores o para aprender, no para realizar el grueso de este royecto.)
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
Contiene los datos del projecto de Django.
#### 2.1 Subdirectorio 'calculator_app':
Contiene los datos de la app de Django.
### 3. Directorio 'production':
####
