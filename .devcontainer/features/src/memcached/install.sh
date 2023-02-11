#!/bin/sh

set -e

PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin

if [ "$(id -u)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [ "${ENABLED}" = "true" ]; then
    echo '(*) Installing memcached...'
    apk add --no-cache php8-pecl-memcache php8-pecl-memcached memcached
    install -D -m 0755 service-run /etc/service/memcached/run
    install -m 0644 object-cache.php object-cache-next.php object-cache-stable.php /wp/wp-content/
    echo 'Done!'
fi
