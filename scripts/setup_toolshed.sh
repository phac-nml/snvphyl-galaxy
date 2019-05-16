#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


USAGE="$0 [API_KEY TOOLSHED_URL] \nExample: ./setup_toolshed.sh http://localhost:9009\nAttempting to create all users and categories in toolshed"
if [ $# -eq 0 ]
then
	echo -e $USAGE
	exit 1
else
    #get host
    api_host=$1
    cookie="$ROOT_DIR/cookie"

    echo "Attempting to create admin user and generate api key"

    #getting csrf_token
    token=`curl -s -c $cookie "$api_host/" | grep token | cut -f 2 -d ':'  | cut -f 2 -d "'"`

    curl -s -c $cookie -o /dev/null --data "create_user_button=Submit" -d "session_csrf_token=$token" -d "email=admin%40localhost.com" -d "password=dna2protein" -d "confirm=dna2protein" -d "username=nml" -d "redirect=$api_host" -d "bear_field=" $api_host/user/create?cntrller=user&use_panels=True 
    sleep 5

    if [ ! -f $cookie ]; then
        echo "No cookie file found. Cannot continue"
        exit 1;
    fi

    if [ ! -s $cookie ]; then
        echo "Cookie Found, but file is empty. Cannot continue"
        exit 1;
    fi
    echo "Finished creating admin user"


    api_key=`curl -s -b $cookie --data "new_api_key_button=Generate+a+new+key+now" -d "session_csrf_token=$token" $api_host/user/api_keys?cntrller=user | grep "Current API key" -A 1  | tail -n 1 | sed 's/ //g'`

    echo "Attempting to create users for 'iuc' , 'devteam' and 'jjohnson'"
    users=("iuc" "devteam" "jjohnson")
    for i in "${users[@]}" ; do
        curl -s --data "email=$i@localhost.com&password=dna2protein&username=$i" -d "session_csrf_token=$token" $api_host/api/users?key=$api_key > /dev/null
    done
    
    echo "Attempting to create multiple categories for all capsules and NML tools"
    cats=("Tool Dependency Packages" "Sequence Analysis" "Variant Analysis" "SAM" "Text Manipulation")
    for i in "${cats[@]}" ; do
        curl -s --data "name=$i" -d "session_csrf_token=$token" $api_host/api/categories?key=$api_key > /dev/null
    done

    #remove cookie file
    rm $cookie

    echo $api_key > "$ROOT_DIR/api_key"
fi 
