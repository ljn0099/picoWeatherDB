FROM postgis/postgis:18-3.6-alpine

RUN apk add --no-cache gettext

COPY init.sh /docker-entrypoint-initdb.d/init.sh
COPY weather-db.sql.txt /docker-entrypoint-initdb.d/weather-db.sql.txt

RUN chmod +x /docker-entrypoint-initdb.d/init.sh
