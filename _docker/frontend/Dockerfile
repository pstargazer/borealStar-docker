# FROM alpine:latest
# FROM node:20-alpine
# FROM node:slim
FROM node:22-alpine3.19 AS node
# FROM alpine:3.19
FROM alpine:3.20

ENV NODE_VERSION 22

# Get NodeJS
COPY --from=node /usr/local/bin /usr/local/bin
# Get npm
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules

COPY ./_docker/frontend/conf /etc/

# library for node
RUN apk add libstdc++ 

ENV USERNAME docker
ENV USERGROUP process

ENV ENTRY_PREFIX /srv
ENV CMD_PATH /app

RUN apk add lsof

# prioritize ipv4 over ipv6,cause laravel runs v4
RUN echo net.ipv4.ip_forward=1 | tee -a /etc/sysctl.conf && sysctl -p

# set proccess user
# RUN addgroup --group 2000 ${USERGROUP} \
# RUN adduser --uid 2000 --ingroup users --shell /bin/sh ${USERNAME}
# USER ${USERNAME}



# copy code
WORKDIR "${CMD_PATH}"
ADD --chown=${USERNAME}:${USERGROUP} --chmod=775 ./frontend/ .
# entrypoint
ADD --chown=users --chmod=775 _docker/frontend/entrypoint.sh ${ENTRY_PREFIX}/



EXPOSE 80 5173 443
ENTRYPOINT /bin/sh $ENTRY_PREFIX/entrypoint.sh
