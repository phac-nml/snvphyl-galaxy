#!/bin/bash
input_tree=$1
output_tree=$2
output_stat=$3
tree_suffix=_phyml_tree.txt
stat_suffix=_phyml_stats.txt
shift 3

directory=`dirname $0`

phyml_3.1 -i $input_tree $*;
mv ${input_tree}${tree_suffix} ${output_tree};
mv ${input_tree}${stat_suffix} ${output_stat};
