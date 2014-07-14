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

tar -C $TOOLS_DIR/core_phylogenomics_pipeline -czf $BUILD_DIR/core_phylogenomics_pipeline.tar.gz .
tar -C $TOOLS_DIR/phyml -czf $BUILD_DIR/phyml.tar.gz .

tar -C $WORKFLOWS_DIR/core_phylogenomics_pipeline_workflow -czf $BUILD_DIR/core_phylogenomics_pipeline_workflow.tar.gz .

echo "Successfully built tarballs"
ls -l $BUILD_DIR/*.tar.gz
echo "Please upload these into a Galaxy Tool Shed"
