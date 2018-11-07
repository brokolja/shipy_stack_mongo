ARG VERSION=latest

FROM mongo:$VERSION

RUN echo "rs.initiate();" > /docker-entrypoint-initdb.d/replica-init.js

CMD [ "--replSet", "rs0" ]