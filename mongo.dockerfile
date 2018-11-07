ARG VERSION=latest

FROM mongo:$VERSION
## mongo --username "admin" --password "admin" --authenticationDatabase "admin" --eval "rs.status()"
RUN echo "rs.initiate({'_id': 'rs0', 'members': [{'_id': 0, 'host': '127.0.0.1:27017'}]})" > /docker-entrypoint-initdb.d/replica-init.js
