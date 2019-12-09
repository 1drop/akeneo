# Akeneo Docker and K8s

## Docker image

The image is built based on `webdevops/php-nginx`.

Therefore it supports all environment variables documented here:
https://dockerfile.readthedocs.io/en/latest/content/DockerImages/dockerfiles/php-nginx.html#environment-variables

Additionally the necessary configuration values for Akeneo have been added:

| Variable    | Description                                     |
|-------------|-------------------------------------------------|
| DB_HOST     | Database host (e.g. mysql or 10.0.8.2)          |
| DB_PORT     | Database port (e.g. 3306)                       |
| DB_NAME     | Database name (e.g. akeneo)                     |
| DB_USER     | Database user (e.g. myuser)                     |
| DB_PASSWORD | Database password                               |
| ES_HOSTS    | Elasticsearch hosts (e.g. "elasticsearch:9200") |

## Helm

```shell script
helm install
kubectl exec -ti {akeneo} console pim:installer:db
kubectl exec -ti {akeneo} console pim:user:create --admin
```

## Docker Compose

We assume you have a reverse proxy up and running.

See https://github.com/codekitchen/dinghy-http-proxy or manually modify the `docker-compose.yml` and open the ports.

```shell script
# Start the environment
docker-compose up -d
# Run Akeneo setup
docker-compose exec --user=application akeneo bash
./bin/console pim:installer:db
./bin/console pim:user:create --admin
```

Open http://akeneo.docker
