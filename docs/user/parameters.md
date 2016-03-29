# Parameters

The SNVPhyl workflow contains several parameters that can be changed from their default values to customize a run. Below is a description of some of the more commonly used values, where they can be found, and how they can be altered:

##Density Threshold 

The SNV density threshold parameter defines the absolute number of SNVs required, within the window size indicated by the window size parameter described below, for a region to be flagged as high density.  As a result, decreasing the density threshold will result in stricter filtering; increasing the proportion of the genome being flagged as high density. The density regions are calculated independently for each isolate genome in a given SNVPhyl run. 

![density_threshold][]

##Density Window Size

The window size is another parameter that can be altered to adjust the sensitivity of the SNV density filter used in SNVPhyl.  For a region to be flagged as high density, it must contain at least **density threshold** SNVs across a region equal to the length of the window size.  As a result, increasing the window size generally results in stricter filtering; increasing the proprotion of the genome being flagged as high density.  The density regions are calculated independently for each isolate genome in a given SNVPhyl run.

This option can be found under the **Step 12: Consolidate VCFs** section of the workflow page. To alter this value, click on the ![edit_param][] icon and set the value to an integer greater than 0.  

![window_size][]

## Minimum percent coverage

The minimum percent coverage parameter in **Step 6: Verify Mapping Quality** defines the total percentage of positions within the genome that must have a depth of coverage greater than that specified by the min_coverage variable set in **Workflow Parameters**, in order to pass the mapping quality check.    

To alter this value, click on the ![edit_param][] icon and set the value to an integer value between 0 and 100.

![min_percent_coverage][]

#Step 4: Find Repeats

##Minimum Length

The minimum length parameter defines the minimum sequence length for repeat regions within the genome.  As such, for a region to be defined as repetitive it must be at least as long as the value of the minimum length parameter.
 
![minimum_length][]

##Minimum PID

The minimum PID parameter defines the minimum percent identity within a repetitive region.  The identity is defined as the percentage of bases between two sequences that have the same residues at the same positions when aligned.

![min_pid][]

#Step 5: Smalt Map

##Minimum Insert Size

The insert size of a read pair refers to the distance between the 5-ends of the mapped reads.  The minimum insert size defines the smallest allowable distance between the 5-prime ends of the mapped reads.

![min_insert_size][]

##Maximum Insert Size

The insert size of a read pair refers to the distance between the 5-prime ends of the mapped reads.  THe maximum inser size defines the largest allowable distance between the 5-prime ends of the mapped reads.

![max_insert_size][]

#Step 18: PhyML

##Evolution Model

The evolution model parameter describes the evolutionary model used by Phyml to generate the phylogenetic tree.  The default model is the GTR model, but optional models include the JC69, K80, F81, F84, HKY85, and TN93 substitution models. 

![evolution_model][]

##Transition/Transversion Ratio

The transition/transversion ratio parameter allows the user to specify a fixed transition/transversion ratio or allow the ratio to be estimated by PhyML.  This value is estimated by default. 

![transition/transversion_ratio][]

##Number of categories for the discrete gamma model

Phyml can account for a variable substitution rate among sites using the number of categories for the discrete gamma model.  As described in the Phyml documentation:

 "The default is to use four categories, in this case the likelihood of the phylogeny at one site is averaged over four conditional likelihoods corresponding to four rates and the computation of the likelihood is four times slower than with a unique rate. Number of categories less than four or higher than eight are not recommended. In the first case, the discrete distribution is a poor approximation of the continuous one. In the second case, the computational burden becomes high and an higher number of categories is not likely to enhance the accuracy of phylogeny estimation."   

![num_cat_gamma_model][]

##Shape parameter of the gamma model

The shape parameter of the gamma model is defined as a numerical paramter.  As described in the Phyml documentation:

"The higher its value, the lower the variation of substitution rates among sites (this option is used when having more than 1 substitution rate category). The default value is 1.0. It corresponds to a moderate variation. Values less than say 0.7 correspond to high variations. Values between 0.7 and 1.5 corresponds to moderate variations. Higher values correspond to low variations. This value can be fixed by the user. It can also be estimated by maximising the likelihood of the phylogeny."

![shape_param_gamma_model][]

##Proportion of invariant sites

As described in the Phyml documentation:

"The default is to consider that the data set does not contain invariable sites (0.0). However, this proportion can be set to any value in the 0.0-1.0 range, but it should not be larger than the proportion of constant sites in the alignments. This parameter can also be estimated by maximising the likelihood of the phylogeny. The later makes the program slower."

![prop_invariant_sites][]

##Tree Topology Search Operation

As described in the Phyml documentation:

"PhyML is able to perform two kinds of tree topology improvement: NNI (Nearest Neighbor Interchange) and SPR (Subtree Pruning and Regrafting). You can ask PhyML to compute only NNI (faster) or only SPR (a bit slower) or the both SPR & NNI and keep the best."

![tree_topology_search][]

[minimum_length]: images/minimum_length.png
[min_pid]: images/min_pid.png
[min_insert_size]: images/min_insert_size.png
[max_insert_size]: images/max_insert_size.png
[evolution_model]: images/evolution_model.png
[transition/transversion_ratio]: images/transition_transversion_ratio.png
[num_cat_gamma_model]: images/num_cat_gamma_model.png
[shape_param_gamma_model]: images/shape_param_gamma_model.png
[prop_invariant_sites]: images/prop_invariant_sites.png
[tree_topology_search]: images/tree_topology_search.png
[min_percent_coverage]: images/min_percent_coverage.png
[window_size]: images/window_size.png
[density_threshold]: images/density_threshold.png
[edit_param]: images/edit_param.png  
