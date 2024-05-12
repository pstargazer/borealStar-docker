# FROM postgres:16

FROM postgis/postgis:16-3.4
# FROM postgis/postgis:16-master


#RUN uname -a
WORKDIR /var/lib/postgresql/
RUN ls -lR
RUN su -c "chmod 700 . -R"
RUN su -c "chown postgres:postgres . -R"

# postgres log dir
WORKDIR /var/log/postgresql
RUN su -c "chmod 777 . -R"
# RUN su -c "chown postgres:postgres . -R"

# chmod the config files
WORKDIR /etc/postgresql/${PGVERSION}/
RUN su -c "chmod 777 . -R"
# RUN su -c "chown postgres:postgres . -R"

# emtrypoint scripts
WORKDIR /opt/init/
ADD ./entrypoint.sh /opt/init/

RUN chmod 755 -R ./entrypoint.sh
RUN su -c "chmod 777 . -R"
# RUN su -c "chown postgres:postgres . -R"

# VOLUME [ "${PGDATA}" ]
# somewhy docker-entrypoint not working, so calling this manually
ADD ./docker-entrypoint-initdb.d  /docker-entrypoint-initdb.d
# /initdb.d
WORKDIR /docker-entrypoint-initdb.d
RUN su -c "chmod 777 . -R"
# RUN su -c "/initdb.d/00-init.sh"
# RUN su -c "/docker-entrypoint-initdb.d/00-init.sh"

EXPOSE 5432
# ENTRYPOINT [ "/opt/init/entrypoint.sh" ]
# CMD ["su", "postgres", "-S", "postgres","-c", "/opt/init/entrypoint.sh"]
CMD ["su","-c", "/opt/init/entrypoint.sh"]

