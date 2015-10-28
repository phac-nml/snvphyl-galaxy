#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CAPSULES_DIR="$ROOT_DIR/../tools/capsules"
CAPS_TO_INSTALL="$ROOT_DIR/../tools/capsules_install_order.txt"

USAGE="$0\nRuns 'curl' on toolshed directly to install capsules based on order provided '$CAPS_TO_INSTALL'. Please provide valid API key of admin user"

if [ $# -eq 0 ]
then
	echo -e $USAGE
	exit 1
else
    #get api key
    api_key=$1
    
    #get host
    api_host=$2

    for cap in `cat $CAPS_TO_INSTALL`
    do
	echo "Running curl for capsules '$CAPSULES_DIR/$cap'"
	curl --data "tool_shed_url='beer'&capsule_file_name=$CAPSULES_DIR/$cap" $api_host/api/repositories/new/import_capsule?key=$api_key
    done
fi
