# Akeneo Docker and K8s

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
