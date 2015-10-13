# Listeria monocytogenes 1408MLGX6-3WGS

This example goes through the analysis of a *Listeria monocytogenes* dataset through SNVPhyl.  The source of this data can be found in the [WGS Standards and Analysis][] project.  The necessary reference and sequence reads can be downloaded from <http://irida.corefacility.ca/downloads/snvphyl-galaxy/examples/snvphyl-example-lm.tar.gz> (7.6 GB).

This example assumes you have a working version of SNVPhyl up and running within Galaxy.  For instructions on how to get to this stage, please refer to the [Install] documentation.
## Step 1: Generate Invalid Positions File

In this example, we will run PHAST, a phage search tool hosted at <http://phast.wishartlab.com/>, to find the locations of any phages that may be present in our reference genome.  We will then insert these locations into our **invalid-positions.bed** file which will be used in the SNVPhyl workflow.  Regions listed in the invalid-positions.bed file are excluded from the downstream analysis by SNVPhyl.

1.  Navigate to the PHAST homepage at **<http://phast.wishartlab.com>**.

2.  Select the **Select your nucleotide sequence file.... > Choose file** option from the main page.

    ![PHAST-select-fasta][]

3.  From the data set downloaded above, select the reference genome file named **CFSAN023463.fasta**. Click **Submit** to submit your reference genome to PHAST for analysis.  

    **Note:** The PHAST analysis can take up to 10 minutes to complete at this point.

4.  When PHAST has completed, a results page will appear:

    ![PHAST-results][]

5.  Click **Summary result file** to display a  page summarizing the PHAST results:

    ![PHAST-summary][]

6.  The page will list a summary of all of the phage sequences found by PHAST in our reference genome.  The positions we will be adding to our **invalid-positions.bed** file are under the column **REGION_POSITION**.

    ![PHAST-position-column][]

7.  Create a new text file named **invalid-positions.bed** using your preferred text editor.

8.  Add the position of the detected phage to the **invalid-positions.bed** file.  Separate each column entry by a TAB.  The final file should like this:  
 
    ![invalid-with-phage][]
    
    **Note:** The chromosome name is derived from our original reference filename:
    
    ![lm-reference-file][]
    

	![lm-reference-opened][]
	
    For more information on the formatting of the **invalid-positions.bed** file please refer to [Usage: Invalid Positions](../user/usage/#invalid-positions-masking-file)

9.  Save the **invalid-positions.bed** file to your hard drive.

We have now generated a properly formatted **invalid-positions.bed** file, showing a phage region discovered within our reference genome.  The positions within this region will be excluded from the downstream SNVPhyl analysis.    

## Step 2: Importing data into Galaxy

There are three types of data that must be imported into Galaxy to run SNVPhyl, the reference genome `CFSAN023463.fasta`, the invalid positions file created in Step 1, and the sequence reads within the `fastq/` directory.

1.  Import reference genome **CFSAN023463.fasta**

    To import **CFSAN023463.fasta** please go to **Get Data > Upload File**.  From here, select **Choose local file** and find `CFSAN023463.fasta`.  Click **Start** to start uploading.

    ![galaxy-get_data][]

2.  Import sequence reads from **fastq/**.

    To import the sequence reads, please go to **Get Data > Upload File**.  From here, select **Choose local file** and find all the `fastq/*.fastq.gz` files (_Shift-click_ lets you select all files). Once the files are selected, please find the **Type** column in the table and change from **Auto-detect** to **fastqsanger**.  This should change all file types to **fastqsanger**.  This should look like:

    ![lm-upload-fastqsanger][]

    Once this is complete, click on **Start** to start the upload.

3.  To import the invalid positions file, please go to **Get Data > Upload File**.  From here, select **Choose local file** and select the invalid positions file created in Step 1.  Once this is complete, click on **Start** to start the upload.

On completion, you should see all files show up in your Galaxy **History** panel similar to below.

![lm-galaxy-history][]

## Step 3: Constructing Galaxy Dataset Pairs

SNVPhyl makes use of Dataset Collections in Galaxy to properly structure paired-end sequence reads to run through SNVPhyl.  To construct the necessary data structure, please do the following.

1.  Click the **multiple datasets** icon ![multiple-datasets-icon][].  This should allow selection of files in the Galaxy History to combine together into a single dataset collection.  Select all but the reference file **CFSAN023463.fasta**.  This should look similar to.

    ![select-fastq-collection][]

2.  Select the **For all selected... > Build List of Dataset Pairs** option in the **History** panel.  
 
   ![build-list-dataset-lm][]
 
This should bring up a window describing which files should be grouped together into a single set of paired-end files.  At the bottom, please name this set of files **lm-paired-reads**.  This should look as follows.

   ![lm-paired-list][]

   Click the **Create list** button.  This should create an **lm-paired-reads** entry in the Galaxy History.
 
## Step 4: Running the Workflow

Once a proper paired-end dataset collection **lm-paired-reads** is constructed, the SNVPhyl workflow can be run on the uploaded data.  To run the workflow, please do the following.

1.  At the very top of the Galaxy page, select **Workflow**.  This should bring you to a page where you can select from a number of installed workflows.  Please select **the invalid positions workflow** and click **Run**.

2.  Adjust the main parameters.  Displayed in the **Workflow Parameters** at the top of the screen.  For this example, please set to:

    * **min_coverage**: 15
    * **min_mean_mapping**: 30
    * **alternative_allele_percentage**: 0.75
    
    ![lm-run-parameters][]    

3.  Verify that **Input dataset collection** is set to **lm-paired-reads**, **Input dataset** is set to **CFSAN023463.fasta**, and **Invalid positions file** is set to **invalid-positions.bed**.

4.  At the very bottom of this page, click the **Run workflow** button.  This should begin scheduling the workflow in your Galaxy history.  You should see each individual step running in Galaxy like below.

    ![run-pipeline][]

*Note: Depending on the resources dedicated to SNVPhyl and Galaxy, this may take a while (hours) to complete.*

## Step 5: Examine Results

The pipeline is complete when all steps have finished executing (all steps are green) a new phylogenetic tree will be generated.

The main output files for the pipeline are:

   * Phylogeny

    ![lm-result-tree][]

   * SNV Matrix
   * Core Positions
   * Mapping Quality
   
 Please see the [Output](../user/output/#output) section for additional details.  

## Step 6: Interpretation

The SNVPhyl pipeline outputs several files which are useful for evaluating the quality of the phylogenetic tree generated by the run.  First, we will look at the vcf2core file generated by the pipeline:

  From the Galaxy side menu, click on the view data icon ![view-data-icon][] for the **vcf2core.tsv** file which was output by the pipeline.

  In the viewing window, the output should look like:

  ![lm-vcf2core-data][]

  From this view, we can see several important statistics.  The most important of these is the **Percentage in core** statistic.  This stat indicates the percentage of genome positions that were queried to identify SNVs within the SNVPhyl pipeline.  Typically, a value of 90% or greater is considered good for any given run.

  Next, we will look at the filterStats.txt file generated by the pipeline.
  
  Again, click on the view data icon ![view-data-icon][] for the **filterStats.txt** file.
  
  In the viewing window, the output should look like:
  
  ![lm-filter-stats][]
  
  In this output, we see a summary of the total number of single nucleotide variants called by the SNVPhyl pipeline for the run.  The first statistic, **Number of sites used to generate phylogeny**, will vary widely depending on the organism being investigated and the clonality (i.e - how genetically similar the strains are) of the isolates.  
  
  A better QC indicator is the **Percentage of sites filtered** statistic.  If a high percentage of the SNV's are filtered, there are several possible interpretations.  On the one hand, this may indicate that there was large variation in the accessory genome of the isolates, which is excluded from the analysis, and would appear as a large number of filtered positions.  Another possibility is that this can indicate an issue with the quality of the reads (i.e poor depth of coverage, poor mapping to reference, etc) used to generate the phylogeny.  For this analysis, we can see that 125 SNV's were used to generate the phylogeny from a total of 158 that were called by the pipeline.
  
  
  The remaining statistics describe the types of filters that were responsible for eliminating low quality SNV's from the pipeline.  These are:
  
  * Coverage filtered - SNV's located in low depth of coverage regions
  
  * mpileup filtered -  SNV's determined to be invalid by the mpileup variant caller
  
  * Density filtered -  SNV's located in high density regions of the genome
  
  * Invalid filtered -  SNV's determined to be invalid 
  
  *Note: The Density filtered statistic is a work in progress, and will display a value of 0 until it is fully implemented*   
  
  Finally, we will look at the mappingQuality.txt file generated by the pipeline.  This file provides information on how well the reads from each individual strain mapped to the reference genome.
  
  Again, click on the view data icon ![view-data-icon][] for the mappingQuality.txt file.
  
  In the viewing window, the output should look like:
  
  ![lm-mapping-quality][]
  
  Only isolates that fail the thresholds set for the mapping quality check are listed in the mappingQuality.txt output file.  
  
  For our run, in order to pass the mapping quality check, each strain would have to map to over 95% of the reference genome with a minimum depth of coverage of 15 at each  position.  We can see that only a single strain failed the mapping quality check, **CFSAN023466**, where it mapped to only 92.45% of the reference genome with a minimum depth of coverage of 15 at each position.  At 92.45%, it is unlikely that this strain would effect the pipeline results in a serious way.
  
  In situations where there are strains with very poor mapping quality (<80%), the pipeline output can be effected drastically.  In these situations, large sections of the genome will be excluded from the **core genome** from which variants are called and many informative SNV's may be excluded from the final pipeline output.  In these cases, it can be useful to exclude poorly mapping isolates and re-run the pipeline.
  
  Furthermore, if a large proportion of the strains in a given run are mapping poorly to the reference, it may be useful to change the reference strain used.             

[WGS Standards and Analysis]: https://github.com/WGS-standards-and-analysis/datasets/
[Install]: ../install
[PHAST-select-fasta]: ../images/listeria-example/PHAST-upload-ref.png
[PHAST-results]: ../images/listeria-example/PHAST-results.png
[PHAST-summary]: ../images/listeria-example/PHAST-summary.png
[PHAST-position-column]: ../images/listeria-example/PHAST-position-column.png
[invalid-with-phage]: ../images/listeria-example/invalid-with-phage.png
[lm-reference-file]: ../images/listeria-example/lm-reference-file.png
[lm-reference-opened]: ../images/listeria-example/lm-reference-opened.png
[galaxy-get_data]: ../images/listeria-example/galaxy-get_data.png
[lm-upload-fastqsanger]: ../images/listeria-example/lm-upload-fastqsanger.png
[build-list-dataset-lm]: ../images/listeria-example/build-list-dataset-lm.png
[lm-galaxy-history]: ../images/listeria-example/lm-galaxy-history.png
[multiple-datasets-icon]: ../images/multiple-datasets-icon.png
[select-fastq-collection]: ../images/listeria-example/select-fastq-collection.png
[lm-paired-list]: ../images/listeria-example/lm-paired-list.png
[select-galaxy-workflow]: ../images/listeria-example/select-galaxy-workflow.png
[lm-run-parameters]: ../images/listeria-example/lm-run-parameters.png
[run-pipeline]: ../images/listeria-example/run-pipeline.png
[lm-vcf2core-data]: ../images/listeria-example/lm-vcf2core-data.png
[view-data-icon]: ../images/view-data-icon.png
[lm-filter-stats]: ../images/listeria-example/lm-filter-stats.png
[lm-mapping-quality]: ../images/listeria-example/lm-mapping-quality.png
[lm-result-tree]: ../images/listeria-example/lm-result-tree.png