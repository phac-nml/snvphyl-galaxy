# Parameters

The SNVPhyl workflow contains several parameters that can be changed from their default values to customize a run. Below is a description of each of these values, where they can be found, and how they can be altered:

##SNV Density Threshold 

The SNV density threshold parameter defines the absolute number of SNVs required within a given window for a region to be flagged as high density.  As a result, decreasing the density threshold will result in *stricter* filtering; increasing the proportion of the genome being flagged as high density. 

## SNV Density Window Size

The window size is one of two parameters that can be altered to adjust the sensitivity of the SNV density filter used in SNVPhyl.  For a region to be flagged as high density, it must contain at least [density threshold] SNVs across a region equal to the length of the window size.  As a result, increasing the window size generally results in *stricter* filtering; increasing the proprotion of the genome being flagged as high density.

This option can be found under the Step 12: Consolidate VCFs section of the workflow page. To alter this value, click on the [icon picture] icon and set the value to an integer greater than 0.  

## Minimum depth of coverage

The minimum depth of coverage parameter in Step 6: Verify Mapping Quality defines the depth of coverage required in order for a position within the genome to be considered mapped. 

This option can be found under the Step 6: Verify Mapping Quality section of the workflow page.  To alter this value, click on the [] icon and set the value to an integer value greater than 0.    

## Minimum percent coverage

The minimum percent coverage parameter in Step 6: Verify Mapping Quality defines the total percentage of positions within the genome that must have a depth of coverage greater than that specified by the minimum depth of coverage (see above), in order to pass the mapping quality check.    

This option can be found under the Step 6: Verify Mapping Quality section of the workflow page.  To alter this value, click on the [] icon and set the value to an integer value between 0 and 100.

 
