# Dockerized Symfony with mysql

Greatly inspired by https://github.com/dunglas/symfony-docker, but simplified.  
You will have a symfony 6.2 with MySQL.  
Makefile is based on Kevin Dunglas' one.

### Prerequisites:

- [🐳 docker compose v2.10+](https://docs.docker.com/compose/install/)

### HowTo:

- init the project with `make init` and visit http://localhost:8092
- see [Makefile](./Makefile) (try `make help`)

### Troubleshooting:

You might have some ports already used (event though i tried to use unused ports), modify 
[docker-compose.override.yml](./docker-compose.override.yml) at your convenience.

### Urls:

- Your project on http://localhost:8092
- Phpmyadmin on http://localhost:8093
