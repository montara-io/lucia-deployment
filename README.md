# Lucia project

Base repository for the Lucia project.

## Lucia architecture

![alt text](./docs/lucia-architecture.png)

## Spark job Listenr

As you can see in the architecture above, for collect data from the Spark job you should use Lucia Spark listenr. For more information [please see the documentation](https://github.com/montara-io/lucia-spark-listener#readme)

#### Docker-compose or helm-char for running the entire Lucia project in your premise

## docker compose

docker compose will setup the lucia environment running the following services:

- db - a postgres db
- flyway - migration scripts setting up the db schema
- kafka - messaging service used to communicate between services
- lucia-web-backend - the web backend service supporting the apis needed by the UI
- lucia-web-ui - the web UI
- lucia-spark-endpoint - endpoint exposed for the spark connector
- lucia spark-job-processor - backend service that processes the spark events

### env setup

In order to run the Lucia environment in docker compose run the following command

    ```
    cd docker-compose
    docker-compose pull
    docker-compose -p lucia up -d
    ```

This will run it under the lucia project name

### local env setup debugging

In order to build and then run the Lucia local environment in docker compose and debug with attach docker,
run the following command

1. clone and build the repositories with the following command
   NOTE: this will clone, then build the lucia projects locally, for this you need to have ssh configured on github:

   ```
   sh build
   ```

2. run docker-compose with the following command:
   ```
   cd docker-compose
   docker-compose -p lucia-local -f docker-compose-local.yml  up -d --build
   ```

This will run it under the lucia-local project name

## helm chart
The followint command will deploy the Lucia helm chart
Note: You should have Helm preinstall and configured and kubernetes to point to the right location

```
 cd lucia-helm-chart
 helm install <chart-name> .
```
If you want to use a specific namespace use (for example 'lucia')

```
   helm install <chart-name> . --create-namespace --namespace lucia
```

In order to update to the latest helm do git pull and then

```
   helm upgrade <chart-name> . 
```

## Lucia projects

1. [Web (backend + frontent)](https://github.com/montara-io/lucia-web)

2. [Data (Endpoint + Processor)](https://github.com/montara-io/lucia-data)

3. [Listener](https://github.com/montara-io/lucia-spark-listener)
