#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR="$ROOT_DIR/build"
TOOLS_DIR="$ROOT_DIR/tools"
WORKFLOWS_DIR="$ROOT_DIR/workflows"

echo "Builds tool and workflow tarballs under build/."
echo "These can then be uploaded to a Galaxy Tool Shed."

if [ ! -e $BUILD_DIR ]
then
	mkdir $BUILD_DIR
fi

# build all tools under $TOOLS_DIR
for i in $TOOLS_DIR/*
do
	name=`basename $i`
	tar -C $TOOLS_DIR/$name -czf $BUILD_DIR/$name.tar.gz .
done

tar -C $WORKFLOWS_DIR/core_phylogenomics_pipeline_workflow -czf $BUILD_DIR/core_phylogenomics_pipeline_workflow.tar.gz .

echo "Successfully built tarballs"
ls -l $BUILD_DIR/*.tar.gz
echo "Please upload these into a Galaxy Tool Shed"
