#!/bin/bash
# Dokku plugin
#  Announce completion of deployment. This implementation does not do any kind of 
#  verification that the app has successfully completed startup.

case "$1" in
  post-deploy)
    echo "-----> Application deployed:"
	echo "       http://$(< "$HOME/$APP/HOSTNAME")"
    ;;
esac