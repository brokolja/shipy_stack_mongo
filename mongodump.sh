#!/bin/bash

trap "exit" INT
# mongorestore from volume example:
# docker run --rm --network=database --volumes-from=xxx_mongodump_1 mongo bash -c 'mongodump --username "test1" --password "test1" --authenticationDatabase "admin" --verbose --host "mongo" --port 27017 --gzip --archive="/mongodump/2018-10-31_20-35_mongodump.archive"'
# mongorestore from host example:
# docker run --rm --network=database --volume=/var/lib/docker/volumes/xxx_mongodump/_data/2018-10-31_20-26_mongodump.archive:/tmp/mongodump.archive mongo bash -c 'mongodump --username "test1" --password "test1" --authenticationDatabase "admin" --verbose --host "mongo" --port 27017 --gzip --archive="/tmp/mongodump.archive"'


dumpMongo () {
  NOW=$(date +"%Y-%m-%d_%H-%M")
  mongodump --username "$MONGO_INITDB_ROOT_USERNAME" --password "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase "admin" --verbose --host "mongo" --port 27017 --gzip --archive="/mongodump/${NOW}_mongodump.archive"
  echo "Mongodump created: /mongodump/${NOW}_mongodump.archive"
  for file in $(find /mongodump/*_mongodump* -maxdepth 0 -mtime +7)
  do
      rm -rf $file
      echo "Removed very old mongodump: $file"
  done
}

mkdir -p /mongodump

while :
do
    if [ $(date '+%H%M') = '0400' ]
    then dumpMongo
    fi
    sleep 60
done
