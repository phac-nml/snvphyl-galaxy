#!/bin/bash



USAGE="$0 [API_KEY TOOLSHED_URL] \nExample: ./setup_toolshed.sh 24234234234 http://localhost:9009\nAttempting to create all users and categories in toolshed"
if [ $# -eq 0 ]
then
	echo -e $USAGE
	exit 1
else
    #get api key
    api_key=$1

    #get host
    api_host=$2
    
    echo "Attempting to create users for 'iuc' , 'devteam' and 'jjohnson'"
    users=("iuc" "devteam" "jjohnson")
    for i in "${users[@]}" ; do
        curl --data "email=$i@gmail.com&password=beer4me&username=$i" $api_host/api/users?key=$api_key
    done
    
    echo "Attempting to create multiple categories for all capsules and NML tools"
    cats=("Tool Dependency Packages" "Sequence Analysis" "Variant Analysis" "SAM" "Text Manipulation")
    for i in "${cats[@]}" ; do
        curl --data "name=$i" $api_host/api/categories?key=$api_key
    done
    
fi 
