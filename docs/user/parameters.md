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

##Minimum Length

##Minimum PID

##Minimum Insert Size

##Maximum Insert Size



[min_percent_coverage]: images/min_percent_coverage.png
[window_size]: images/window_size.png
[density_threshold]: images/density_threshold.png
[edit_param]: images/edit_param.png  
