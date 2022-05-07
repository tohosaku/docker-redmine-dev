#!/bin/sh

. ./user.sh

LOCAL_UID=${LOCAL_UID} LOCAL_GID=${LOCAL_GID} docker compose $* 
