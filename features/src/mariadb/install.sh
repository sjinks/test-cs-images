#!/bin/sh

set -e

PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin

if [ "$(id -u)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

echo '(*) Installing MariaDB...'

if [ -z "${_REMOTE_USER}" ] || [ "${_REMOTE_USER}" = "root" ]; then
    MARIADB_USER=www-data
else
    # shellcheck disable=SC2034
    MARIADB_USER="${_REMOTE_USER}"
fi

if [ "${INSTALLDATABASETOWORKSPACES}" != 'true' ]; then
    MARIADB_DATADIR=/var/lib/mysql
else
    # shellcheck disable=SC2034
    MARIADB_DATADIR=/workspaces/mysql-data
fi

apk add --no-cache mariadb-client mariadb
rm -f /var/lib/mysql

install -D -m 0755 -o root -g root service-run /etc/sv/mariadb/run
install -d -m 0755 -o root -g root /etc/service
ln -sf /etc/sv/mariadb /etc/service/mariadb

# shellcheck disable=SC2016
envsubst '$MARIADB_USER' '$MARIADB_DATADIR' < conf-mariadb.tpl > /etc/conf.d/mariadb

echo 'Done!'
