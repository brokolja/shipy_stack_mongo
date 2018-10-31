#!/bin/bash

trap "exit" INT

dumpMongo () {
  echo 'mongodump running...'
  NOW=$(date +"%Y-%m-%d_%H-%M")
  mongodump --username "$MONGO_INITDB_ROOT_USERNAME" --password "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase "admin" --verbose --host "mongo" --port 27017 --gzip --archive="/mongodump/${NOW}_mongodump.archive"
  echo 'mongodump cleaning...'
  for file in $(find /mongodump/*_mongodump* -maxdepth 0 -mtime +7)
  do
      echo "mongodump removing old backup: $file"
      rm -rf $file
  done
}

mkdir -p /mongodump

while true; do
  dumpMongo
  sleep 1d
done