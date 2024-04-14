#!/bin/sh

if [ "$#" -eq 0 ]; then
  LOCAL_UID=${LOCAL_UID} LOCAL_GID=${LOCAL_GID} docker compose exec -it redmine tmux
else
  eval "echo \"$(cat mitamae/node_tmpl.yml)\" > mitamae/node.yml"
  LOCAL_UID=${LOCAL_UID} LOCAL_GID=${LOCAL_GID} docker compose $*
fi
