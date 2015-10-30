#!/bin/bash


ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USAGE="$0 Runs all bash script to install all users,categories,capsules and NML tools into a fresh toolshed"

if [ $# -eq 0 ]
then
	echo -e $USAGE
	exit 1
else
    #get api key
    api_key=$1
    
    #get host
    api_host=$2
    
    bash $ROOT_DIR/setup_toolshed.sh $api_key $api_host
    bash $ROOT_DIR/install_capsules.sh $api_key $api_host
    bash $ROOT_DIR/run_planemo_for_tools.sh shed_create --shed_key $api_key -m "initial_upload" -t $api_host
fi
