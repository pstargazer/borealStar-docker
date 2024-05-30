FROM node:20-alpine

COPY ./_docker/frontend/conf/hosts /etc/


ENV USERNAME docker
ENV USERGROUP process

ENV ENTRY_PREFIX /srv
ENV CMD_PATH /app


# set proccess user
RUN addgroup -g 100 ${USERGROUP} \
    && adduser -u 1000 -G ${USERGROUP} -s /bin/sh -D ${USERNAME}
USER ${USERNAME}

# RUN npm i --save-exact
ADD --chown=users --chmod=775 _docker/frontend/entrypoint.sh ${ENTRY_PREFIX}/

# copy code
WORKDIR "${CMD_PATH}"
ADD --chown=${USERNAME}:${USERGROUP} --chmod=775 ./frontend/ .



# ENTRYPOINT ["npm", "run", "start"]
EXPOSE 80 5173 443
CMD ["/sbin/init"]
ENTRYPOINT /bin/sh $ENTRY_PREFIX/entrypoint.sh
