#!/bin/bash


ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USAGE="$0 Runs all bash script to install all users,categories,capsules and NML tools into a fresh toolshed"

if [ $# -eq 0 ]
then
	echo -e $USAGE
	exit 1
else
    #get host
    api_host=$1
    
    bash $ROOT_DIR/setup_toolshed.sh $api_host

    if [ ! -s "$ROOT_DIR/api_key" ]; then
        echo "Api key file is empty. Cannot continue. Please check $ROOT_DIR/setup_toolshed.sh"
        exit 1;
    fi
    
    api_key=`cat $ROOT_DIR/api_key`
    
    bash $ROOT_DIR/install_capsules.sh $api_key $api_host
    planemo shed_create -m "commit" --shed_key $api_key --shed_target $api_host tools/package_snvphyl
    bash $ROOT_DIR/run_planemo_for_tools.sh shed_create --shed_key $api_key -m "initial_upload" -t $api_host
    planemo shed_create -m "commit" --shed_key $api_key --shed_target $api_host tools/suite_snvphyl


    rm "$ROOT_DIR/api_key"
    echo "---------------"
    echo "Installation complete"
    echo "Admin user name: admin@localhost.com password: dna2protein"
    echo "Current api key: $api_key"
fi
