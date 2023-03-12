#!/bin/sh

set -e

PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin

if [ "$(id -u)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [ "${ENABLED}" = "true" ]; then
    echo '(*) Installing phpMyAdmin...'

    if [ -z "${_REMOTE_USER}" ] || [ "${_REMOTE_USER}" = "root" ]; then
        WEB_USER=www-data
    else
        WEB_USER="${_REMOTE_USER}"
    fi

    apk add --no-cache phpmyadmin
    install -d -m 0777 -o "${WEB_USER}" -g "${WEB_USER}" /usr/share/webapps/phpmyadmin/tmp
    install -m 0640 -o "${WEB_USER}" -g "${WEB_USER}" config.inc.php /etc/phpmyadmin/config.inc.php
    install -m 0640 nginx-phpmyadmin.conf /etc/nginx/http.d/phpmyadmin.conf
    echo 'Done!'
fi
