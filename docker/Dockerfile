FROM webdevops/php-nginx:7.2

ARG AKENEO_VERSION
ENV PROVISION_CONTEXT="production" \
    WEB_DOCUMENT_ROOT="/app/web" \
    WEB_DOCUMENT_INDEX="app.php" \
    CLI_SCRIPT="/app/bin/console" \
    DISABLE_MOD="ioncube" \
    SYMFONY_ENV="prod" \
    DB_HOST="localhost" \
    DB_PORT="3306" \
    DB_NAME="test" \
    DB_USER="user" \
    DB_PASSWORD="pass" \
    ES_HOSTS="localhost:9200" \
    PIM_DATABASE_HOST='"%env(DB_HOST)%"' \
    PIM_DATABASE_PORT='"%env(DB_PORT)%"' \
    PIM_DATABASE_NAME='"%env(DB_NAME)%"' \
    PIM_DATABASE_USER='"%env(DB_USER)%"' \
    PIM_DATABASE_PASSWORD='"%env(DB_PASSWORD)%"' \
    PIM_INDEX_HOSTS='"%env(ES_HOSTS)%"'

# Deploy scripts/configurations
COPY build/ /opt/docker/
WORKDIR /app/

RUN mkdir -p /var/log/nginx/ \
    && rm -rf /app/*.* \
    # Install nodejs
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-install nodejs \
    && npm i -g yarn \
    # Deactivate cron (runs separately in k8s)
    && docker-service-disable cron \
    # Install Akeneo
    && php -d memory_limit=-1 /usr/local/bin/composer global require hirak/prestissimo \
    && php -d memory_limit=-1 /usr/local/bin/composer create-project --no-progress --no-interaction --prefer-dist akeneo/pim-community-standard /app "v${AKENEO_VERSION}" \
    && cd /app \
    && yarn install \
    && php -d memory_limit=-1 /app/bin/console cache:warmup \
    && php -d memory_limit=-1 /app/bin/console pim:installer:prepare-required-directories \
    && php -d memory_limit=-1 /app/bin/console pim:installer:assets --symlink --clean \
    && yarn run webpack \
    && chown -R application:application /app/ \
    && rm /app/web/app_dev.php

ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]
CMD ["supervisord"]
