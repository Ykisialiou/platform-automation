#!/bin/bash

set -eu

if [ -z "$1" ]
  then
    echo "Foundation name must be provded"
fi

FOUNDATION=$1

fly -t $FOUNDATION set-pipeline -p install-opsman -c pipelines/install-opsman.yml -l params/common.yml -l params/$FOUNDATION.yml
