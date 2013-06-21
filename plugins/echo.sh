#!/bin/bash

cat

case "$1" in
  pre-build)
    echo ">>> Pre-build step"
    ;;
  post-build)
    echo ">>> Post-build step"
    ;;
  pre-deploy)
    echo ">>> Pre-deploy step"
    ;;
  post-deploy)
    echo ">>> Post-deploy step"
    ;;
  *)
    exit 1
    ;;
esac