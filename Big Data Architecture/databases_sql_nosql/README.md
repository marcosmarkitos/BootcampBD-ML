# Master Class Bases de datos Session I [Dockerized]

- Instalar docker:  
https://store.docker.com/search?type=edition&offering=community

- Instalar docker-compose (en linux solamente):  
https://docs.docker.com/compose/install/

- Instalar pgAdmin4: (opcional)
https://www.pgadmin.org/download/

- Instalar NoSQL Booster:  (opcional)
https://nosqlbooster.com/downloads  

- Clonar este repositorio, entrar y ejecutar:  
```
docker-compose up -d --build
```
  
- Debeis obtener el token de jupyter que se encuentra en los logs:  
```
docker-compose logs notebook
```

- Si os sale un error de carga de datos, o si al hacer queries con PostgreSQL os reporta 
que no existen tablas, ejecutad lo siguiente despues de levantar todo con compose:  
```
docker exec -it master_class_bd_session_1_psql_1 /bin/bash
psql -U dota dota < /docker-entrypoint-initdb.d/dota.sql
```

- Si no salen resultados para `mongo` simplemente relanzar:
```
docker-compose up -d --build
```
  
- Con el token puedes entrar en http://localhost:8888/ (http://192.168.99.100:8888 para usuarios de Docker Toolbox en Windows 10) e introducirlo para comenzar.

- Al terminar la clase, ejecutar:
```
docker-compose down
```
## Links interesantes:

- [Diagrama comparativo modelos](https://docs.google.com/drawings/d/1pncEgJMPd8r69JI0d9bn1tCCmSivYgzp7o-5kpBMeGs/edit?usp=sharing)
