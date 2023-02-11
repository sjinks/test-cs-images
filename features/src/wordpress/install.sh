#!/bin/sh

set -e

PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin

if [ "$(id -u)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

echo '(*) Installing WordPress...'

if [ -z "${_REMOTE_USER}" ] || [ "${_REMOTE_USER}" = "root" ]; then
    USER=www-data
else
    USER="${_REMOTE_USER}"
fi

: "${VERSION:=latest}"

install -d -m 0755 -o root -g root /etc/wp-cli
install -m 0644 -o root -g root wp-cli.yaml /etc/wp-cli
install -d -o "${USER}" -g "${USER}" -m 0755 /wp
cp -a wp/* /wp && chown -R "${USER}:${USER}" /wp/* && chmod -R 0755 /wp/* && find /wp -type f -exec chmod 0644 {} \;
su-exec "${USER}:${USER}" wp core download --path=/wp --skip-content --version="${VERSION}"

echo 'Done!'
