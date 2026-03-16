# Akasha

A universal library.

<br/>

## Architecture

This is a [serverpod](https://serverpod.dev) based solution.
The following containers / services and ports are included:

| service              | port | description                  |
| -------------------- | ---- | ---------------------------- |
| api server           | 9090 | This is the API server.      |
| insights server      | 9091 | This is the Insights server. |
| web server           | 9092 | This is the web server.      |
| akasha_postgres      | 9093 | Used during development.     |
| akasha_redis         | 9094 | Used during development.     |
| akasha_postgres_test | 9095 | Used during testing.         |
| akasha_redis_test    | 9096 | Used during testing.         |

- The api, insights, and web servers are defined the stages related files (found in [config](./akasha_server/config) directory).
- PostgreSQL and Redis related containers are defined in [docker-compose.yaml](./akasha_server/docker-compose.yaml) file.

<br/>

## Start

First of all, in the root directory, run `dart pub get` to get (download) the dependencies.

### API Server

In the `akasha_server` directory, run:

1. `docker compose up -d` to start the PostgreSQL and Redis containers in the background.
2. `dart run bin/main.dart --apply-migrations` or use `./dev.sh` provided script to start:
    1. API Server and apply the database migrations.
    2. Web Server.

Go to http://localhost:9092 to see the homepage of the Web server, and where you can open the main UI.

### Web App

To start the Web app in the browser with hot reload enabled, go to `akasha_flutter` directory and run `flutter run -d chrome` or use `./dev_web.sh` provided script.
