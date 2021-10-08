#!/usr/bin/bash

if [ "$(dig -x "$(hostname -i)" +short | cut -f1 -d .)" = "liferay-2" ]; then
    while ! curl -s http://liferay-1:8080/o/health/readiness; do
        echo "Waiting for liferay-1 to come up..."
        sleep 10
    done
fi

while ! mysqladmin ping -h database --silent; do
    echo "Waiting for database to come up..."
    sleep 10
done

while ! curl -s "http://search:9200/_cat/health?v"; do
    echo "Waiting for elasticsearch to come up..."
    sleep 10
done