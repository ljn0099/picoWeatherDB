#!/bin/sh
set -e

TMP_SQL=/tmp/weather-db.tmp.sql

envsubst '${WEATHER_API_PASSWORD} ${WEATHER_COLLECTOR_PASSWORD}' < /docker-entrypoint-initdb.d/weather-db.sql.txt > "$TMP_SQL"

sed -i 's/CREATE EXTENSION postgis/CREATE EXTENSION IF NOT EXISTS postgis/g' "$TMP_SQL"

sed -i '/CREATE DATABASE weather;/d' "$TMP_SQL"

psql -v ON_ERROR_STOP=1 \
     --username "$POSTGRES_USER" \
     --dbname "$POSTGRES_DB" \
     -c "CREATE DATABASE weather;"

psql -v ON_ERROR_STOP=1 \
     --username "$POSTGRES_USER" \
     --dbname "weather" \
     -f "$TMP_SQL"

rm "$TMP_SQL"
