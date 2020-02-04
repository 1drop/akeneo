#!/usr/bin/env bash

docker-service disable nginx php-fpm
docker-service enable worker

#############################################
## Supervisord (start daemons)
#############################################

## Start services
exec /opt/docker/bin/service.d/supervisor.sh
