#!/bin/bash

if [ -f /app.ini ];
then
    echo "Configuring Gogs with your app.ini"
    mv /app.ini /data/gogs/conf/app.ini
fi

exec /app/gogs/docker/start.sh
