FROM node:20-alpine

COPY ./_docker/frontend/conf/hosts /etc/

ENV BRANCH master
ENV CMD_PATH /var/www/html/$BRANCH

EXPOSE 80 5173 443

WORKDIR "/var/www/html/"
COPY ./backend/ .

RUN npm i --save-exact


ENTRYPOINT ["npm", "run", "start"]