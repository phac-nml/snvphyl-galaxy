#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOOLS_DIR="$ROOT_DIR/../tools"
TOOLS_TO_INSTALL="$TOOLS_DIR/tools-to-install.txt"
CURR_DIR=`pwd`

USAGE="$0 [planemo params]\nRuns 'planemo' with the passed parameters on all tools defined in $TOOLS_TO_INSTALL"

if [ $# -eq 0 ]
then
	echo -e $USAGE
	exit 1
else
	for tool in `cat $TOOLS_TO_INSTALL`
	do
		cd "$TOOLS_DIR/$tool"
		echo "Running planemo on tool '$tool'"
		planemo $@
		cd $CURR_DIR
	done
fi
