#!/bin/sh

. ./user.sh

if [ "$#" -eq 0 ]; then
  LOCAL_UID=${LOCAL_UID} LOCAL_GID=${LOCAL_GID} docker compose exec -it redmine tmux
else
  LOCAL_UID=${LOCAL_UID} LOCAL_GID=${LOCAL_GID} docker compose $*
fi
