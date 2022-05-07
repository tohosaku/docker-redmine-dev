#!/bin/sh

. ./user.sh

rm -rf ../redmine/tmp/downloads
mkdir ../redmine/tmp/downloads
chmod 777 ../redmine/tmp/downloads

LOCAL_UID=${LOCAL_UID} LOCAL_GID=${LOCAL_GID} docker compose -f docker-compose.yml -f docker-compose-test.yml $*
