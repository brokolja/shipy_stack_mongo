ARG VERSION=latest

FROM mongo:$VERSION

RUN echo "rs.initiate({'_id': 'rs0', 'members': [{'_id': 0, 'host': 'localhost:27017'}]})" > /docker-entrypoint-initdb.d/replica-init.js

CMD [ "--replSet", "rs0" ]