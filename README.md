# Lucia Deployment project

Deployment repository for the Lucia project.
Docker-compose or helm-char for running the entire Lucia project in your premise

## docker compose

docker compose will setup the lucia environment running the following services:

- db - a postgres db
- flyway - migration scripts setting up the db schema
- lucia-web-backend - the web backend service supporting the apis needed by the UI
- lucia-web-ui - the web UI

### env setup

In order to run the Lucia environment in docker compose run the following command

    ```
    cd docker-compose
    docker-compose -p lucia up -d
    ```

This will run it under the lucia project name

### local env setup debugging

In order to run the Lucia environment in docker compose run the following command

1. clone the repositories with the following command:

   ```
   sh build
   ```

2. run docker-compose with the following command:
   ```
   cd docker-compose
   docker-compose -f docker-compose-local.yml  up -d --build
   ```

This will run it under the lucia project name

## helm chart

```

```
