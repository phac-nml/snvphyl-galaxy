#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOOLS_DIR="$ROOT_DIR/../tools"
TOOLS_TO_INSTALL="$TOOLS_DIR/tools-to-install.txt"
CURR_DIR=`pwd`

USAGE="$0 [planemo shed_diff params]
\nRuns 'planemo shed_diff' with the passed parameters on all tools defined in $TOOLS_TO_INSTALL and prints a message only for tools with a difference.\n
Example:\n
\t$0 --shed_target http://localhost/shed --shed_key shed_key\n
\tdiff for tools/bcftools_call\n"

if [ $# -eq 0 ]
then
	echo -e $USAGE
	exit 1
else
	for tool in `cat $TOOLS_TO_INSTALL`
	do
		cd "$TOOLS_DIR/$tool"
		# a no-change diff is one that looks like (with changes, there are more messages)
		# wget -q --recursive -O - 'http://tool' | tar -xzf - -C /tmp/tool_shed_diff_Z_a9d0/_custom_shed_ --strip-components 1
		# mkdir "/tmp/tool_shed_diff_Z_a9d0/_local_"; tar -xzf "/tmp/tmp5azlo5" -C "/tmp/tool_shed_diff_Z_a9d0/_local_"; rm -rf /tmp/tmp5azlo5
		# cd "/tmp/tool_shed_diff_Z_a9d0"; diff -r _local_ _custom_shed_
		NO_CHANGE="wget mkdir cd "
		diff=`planemo shed_diff $@ | cut -f 1 -d ' ' | tr '\n' ' '`
		cd $CURR_DIR
		if [ "$NO_CHANGE" != "$diff" ]
		then
			echo "diff for $TOOLS_DIR/$tool"
		fi
	done
fi
