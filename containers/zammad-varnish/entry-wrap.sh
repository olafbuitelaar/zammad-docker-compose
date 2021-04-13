#!/bin/bash

: "${ZAMMAD_RAILSSERVER_HOST:=zammad-railsserver}"
: "${ZAMMAD_RAILSSERVER_PORT:=3000}"

sed -i -e "s#\.host =.*#.host = \"${ZAMMAD_RAILSSERVER_HOST}:${ZAMMAD_RAILSSERVER_PORT}\";#g" /etc/varnish/default.vcl


/usr/local/bin/docker-varnish-entrypoint "$@"