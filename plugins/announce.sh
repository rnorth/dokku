#!/bin/bash
# Dokku plugin
#  Announce completion of deployment. This implementation does not do any kind of 
#  verification that the app has successfully completed startup.

cat

case "$1" in
  post-deploy)
    echo "-----> Application deployed:"
	echo "       http://$(< "$HOME/$2/HOSTNAME")"
    ;;
  *)
    exit 1
    ;;
esac