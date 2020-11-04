#!/bin/sh

if [ -z "$BUCKET" ]; then
  echo "\$BUCKET environment variable required"
  exit 1
fi

confd -onetime -backend env

exec /usr/sbin/nginx -g "daemon off;$@"
