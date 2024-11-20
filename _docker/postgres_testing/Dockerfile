FROM postgis/postgis:16-3.4

COPY --chmod=755 ./entrypoint.sh /tmp/
COPY ./pgconf/ /tmp/pgconf/

# install ps command
RUN apt-get update && apt-get install procps -y


COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d/
EXPOSE 5432 5433

ENTRYPOINT "/tmp/entrypoint.sh"