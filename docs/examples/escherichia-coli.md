# Escherichia coli 1405WAEXK

This example goes through the analysis of an *Escherichia coli* dataset through SNVPhyl.  The source of this data can be found in the [WGS Standards and Analysis][] project.  The necessary reference and sequence reads can be downloaded from <http://irida.corefacility.ca/downloads/snvphyl-galaxy/examples/snvphyl-example-ec.tar.gz> (2.2 GB).

This example assumes you have a working version of SNVPhyl up and running within Galaxy.  For instructions on how to get to this stage, please refer to the [Install] documentation.

## Step 1: Generate Invalid Positions File

In this example, we will run PHAST, a phage search tool hosted at <http://phast.wishartlab.com/>, to find the locations of any phages that may be present in our reference genome.  We will then insert these locations into our **invalid-positions.bed** file which will be used in the SNVPhyl workflow.  Regions listed in the invalid-positions.bed file are excluded from the downstream analysis by SNVPhyl.

1.  Navigate to the PHAST homepage at **<http://phast.wishartlab.com>**.

2.  Select the **Select your nucleotide sequence file.... > Choose file** option from the main page.

    ![PHAST-select-fasta][]

3.  From the data set downloaded above, select the reference genome file named **2011C-3609.fasta**. Click **Submit** to submit your reference genome to PHAST for analysis.  

    **Note:** The PHAST analysis can take up to 10 minutes to complete at this point.

4.  When PHAST has completed, links to the results page for each contig within our reference sequence, **2011C-3609.fasta**, will appear. For this analysis, 7 links should be displayed:

	 ![PHAST-results-links][]
	 
5.  Clicking on one of these links will lead us to the results page for the selected contig:	 

    ![PHAST-results][]

6.  Click **Summary result file** to display a  page summarizing the PHAST results:

    ![PHAST-summary][]

7.  Each of the above pages will list a summary of all of the phage sequences found by PHAST in our reference genome.  The positions we will be adding to our **invalid-positions.bed** file are under the column **REGION_POSITION**.  Below are a list of all the result summaries for each contig in our assembly, **2011C-3609.fasta**.

    ![PHAST-ec-result1][]
    
    ![PHAST-ec-result2][]
    
    ![PHAST-ec-result3][]
    
    ![PHAST-ec-result4][]
    
    ![PHAST-ec-result5][]
    
    ![PHAST-ec-result6][]
    
    ![PHAST-ec-result7][]

8.  Create a new text file named **invalid-positions.bed** using your preferred text editor.

9.  Add the position of the detected phages from our results above to the **invalid-positions.bed** file.  Separate each column entry by a TAB.  The final file should like this:  
 
    ![invalid-with-phage][]
    
    **Note:** The chromosome names are derived from the contig names in our original fasta reference file:
    
    ![ec-reference-file][]
    

	![ec-reference-opened][]
	
    For more information on the formatting of the **invalid-positions.bed** file please refer to [Usage: Invalid Positions](../user/usage/#invalid-positions-masking-file)

10.  Save the **invalid-positions.bed** file to your hard drive.

We have now generated a properly formatted **invalid-positions.bed** file, showing phage regions discovered within our reference genome.  The positions within these regions will be excluded from the downstream SNVPhyl analysis.    

## Step 2: Importing data into Galaxy

There are two types of data that must be imported into Galaxy to run SNVPhyl, the reference genome `2011C-3609.fasta` and the sequence reads within the `fastq/` directory.

1.  Import reference genome **2011C-3609.fasta**

    To import **2011C-3609.fasta** please go to **Get Data > Upload File**.  From here, select **Choose local file** and find `2011C-3609.fasta`.  Click **Start** to start uploading.

	![galaxy-get_data][]

2.  Import sequence reads from **fastq/**.

    To import the sequence reads, please go to **Get Data > Upload File**.  From here, select **Choose local file** and find all the `fastq/*.fastq.gz` files (_Shift-click_ lets you select all files). Once the files are selected, please find the **Type** column in the table and change from **Auto-detect** to **fastqsanger**.  This should change all file types to **fastqsanger**.  This should look like:

    ![ec-upload-fastqsanger][]

    Once this is complete, click on **Start** to start the upload.

On completion, you should see all files show up in your Galaxy **History** panel similar to below.

![ec-galaxy-history][]

## Step 3: Constructing Galaxy Dataset Pairs

SNVPhyl makes use of dataset collections in Galaxy to properly structure paired-end sequence reads to run through SNVPhyl.  To construct the necessary data structure, please do the following.

1.  Click the **multiple datasets** icon ![multiple-datasets-icon][].  This should allow selection of files in the Galaxy History to combine together into a single dataset collection.  Select all but the reference file **2011C-3609.fasta**.  This should look similar to.

    ![select-fastq-collection][]

2.  Select the **For all selected... > Build List of Dataset Pairs** option in the **History** panel.  This should bring up a window describing which files should be grouped together into a single set of paired-end files.  At the bottom, please name this set of files **ec-paired-reads**.  This should look as follows.

    ![ec-paired-list][]

3.  Click the **Create list** button.  This should create an **ec-paired-reads** entry in the Galaxy History.

## Step 4: Running the Workflow

Once a proper paired-end dataset collection **ec-paired-reads** is constructed, the SNVPhyl workflow can be run on the uploaded data.  To run the workflow, please do the following.

1.  At the very top of the Galaxy page, select **Workflow**.  This should bring you to a page where you can select from a number of installed workflows.  Please select **imported: SNVPhyl v0.2 Paired-End (invalid positions)** and click **Run**.

2.  Adjust the main parameters.  Displayed in the **Workflow Parameters** at the top of the screen.  For this example, please set to:

    * **min_coverage**: 15
    * **min_mean_mapping**: 30
    * **alternative_allele_percentage**: 0.75

3.  Verify that **Step 1: Input dataset collection** is set to **ec-paired-reads** that **Step 2: Input dataset** is set to **2011C-3609.fasta** and that **Step 3: Input dataset** is set to **invalid-positions.bed**.

	![ec-pipeline-params][]

4.  At the very bottom of this page, click the **Run workflow** button.  This should begin scheduling the workflow in your Galaxy history.  You should see each individual step running in Galaxy like below.

    ![run-pipeline][]

*Note: Depending on the resources dedicated to SNVPhyl and Galaxy, this may take a while (hours) to complete.*

## Step 5: Examine Results

The pipeline is complete when all steps have finished executing (all steps are green) a new phylogenetic tree will be generated.

The main output files for the pipeline can be found [here](data/Escherichia_coli_results.tar.gz).  They are:

   * Phylogeny

    [![ec-result-tree][]][ec-result-tree]

   * SNV Matrix
   * Core Positions
   * Mapping Quality
   
 Please see the [Output](../user/output/#output) section for additional details.  

## Step 6: Interpretation

The SNVPhyl pipeline outputs several files which are useful for evaluating the quality of the phylogenetic tree generated by the run.  First, we will look at the vcf2core file generated by the pipeline:

  From the Galaxy side menu, click on the view data icon ![view-data-icon][] for the **vcf2core.tsv** file which was output by the pipeline.

  In the viewing window, the output should look like:

  [![ec-vcf2core-data][]][ec-vcf2core-data]

  From this view, we can see several important statistics.  The most important of these is the **Percentage in core** statistic.  This stat indicates the percentage of genome positions that were queried to identify SNVs within the SNVPhyl pipeline.  Typically, a value of 90% or greater is considered good for any given run. Also, we can see from above that two of the contigs analyzed were found to contain no valid positions, and were excluded entirely from the downstream analysis.

  Next, we will look at the filterStats.txt file generated by the pipeline.
  
  Again, click on the view data icon ![view-data-icon][] for the **filter-stats.tsv** file.
  
  In the viewing window, the output should look like:
  
  [![ec-filter-stats][]][ec-filter-stats]
  
  In this output, we see a summary of the total number of single nucleotide variants called by the SNVPhyl pipeline for the run.  The first statistic, **Number of sites used to generate phylogeny**, will vary widely depending on the organism being investigated and the clonality (i.e - how genetically similar the strains are) of the isolates.  
  
  A better QC indicator is the **Percentage of sites filtered** statistic.  If a high percentage of the SNV's are filtered, there are several possible interpretations.  On the one hand, this may indicate that there was large variation in the accessory genome of the isolates, which is excluded from the analysis, and would appear as a large number of filtered positions.  Another possibility is that this can indicate an issue with the quality of the reads (i.e
  poor depth of coverage, poor mapping to reference, etc) used to generate the phylogeny.  For this analysis, we can see that 350 SNV's were used to generate the phylogeny from a total of 709 that were identified by the pipeline.
   
  The remaining statistics describe the types of filters that were responsible for eliminating low quality SNV's from the pipeline.  These are:
  
  * **Coverage filtered** - SNV's located in low depth of coverage regions
  
  * **mpileup filtered** -  SNV's determined to be invalid by the mpileup/bcftools variant caller
  
  * **Invalid filtered** -  SNV's determined to be invalid.  This includes any SNV's filtered in high density regions.      
  
  Finally, we will look at the **percentage_referenced_mapped** file generated by the pipeline.  This file provides information on how well the reads from each individual strain mapped to the reference genome.
  
  Again, click on the view data icon ![view-data-icon][] for the **percentage_referenced_mapped** file.
  
  In the viewing window, the output should look like:
  
  ![ec-mapping-quality][]
  
  Only isolates that fail the thresholds set for the mapping quality check are listed in the **percentage_referenced_mapped** output file.  
  
  For our run, in order to pass the mapping quality check, each strain would have to map to over 95% of the reference genome with a minimum depth of coverage of 15 at each  position.  We can see that three strains failed the mapping quality check, **2014C-3598**, **2014C-3655**, and **2014C-3907** which respectively mapped to 94.11%, 93.93%, and 94.88% of the reference genome with a minimum depth of coverage of 15 at each position.  With these values (>90%), it is unlikely that these strains would effect the pipeline results in a serious way.
  
  In situations where there are strains with very poor mapping quality (<80%), the pipeline output can be effected drastically.  In these situations, large sections of the genome will be excluded from the **core genome** from which variants are called and many informative SNV's may be excluded from the final pipeline output.  In these cases, it can be useful to exclude poorly mapping isolates and re-run the pipeline.
  
  Furthermore, if a large proportion of the strains in a given run are mapping poorly to the reference, it may be useful to change the reference strain used.             
[WGS Standards and Analysis]: https://github.com/WGS-standards-and-analysis/datasets/
[Install]: ../install
[PHAST-select-fasta]: ../images/PHAST-upload-ref.png
[PHAST-results]: ../images/PHAST-results.png
[PHAST-summary]: ../images/PHAST-summary.png
[PHAST-results-links]: ../images/ecoli-example/PHAST_ec_result_links.png
[PHAST-ec-result1]: ../images/ecoli-example/phast_ec_result1.png
[PHAST-ec-result2]: ../images/ecoli-example/phast_ec_result2.png
[PHAST-ec-result3]: ../images/ecoli-example/phast_ec_result3.png
[PHAST-ec-result4]: ../images/ecoli-example/phast_ec_result4.png
[PHAST-ec-result5]: ../images/ecoli-example/phast_ec_result5.png
[PHAST-ec-result6]: ../images/ecoli-example/phast_ec_result6.png
[PHAST-ec-result7]: ../images/ecoli-example/phast_ec_result7.png
[invalid-with-phage]: ../images/ecoli-example/invalid-ec-phage.png
[ec-reference-file]: ../images/ecoli-example/ec-reference-file.png
[ec-reference-opened]: ../images/ecoli-example/ec-reference-opened.png
[galaxy-get_data]: ../images/galaxy-get_data.png
[ec-upload-fastqsanger]: ../images/ecoli-example/ec-upload-fastqsanger.png
[ec-galaxy-history]: ../images/ecoli-example/ec-galaxy-history.png
[multiple-datasets-icon]: ../images/multiple-datasets-icon.png
[select-fastq-collection]: ../images/ecoli-example/select-fastq-collection.png
[ec-paired-list]: ../images/ecoli-example/ec-paired-list.png
[ec-pipeline-params]: ../images/ecoli-example/ec-pipeline-params.png
[run-pipeline]: examples/images/ec-run-pipeline.png
[view-data-icon]: ../images/view-data-icon.png
[run-pipeline]: ../images/run-pipeline.png
[ec-result-tree]: ../images/ecoli-example/ec-tree-results.png
[ec-vcf2core-data]: ../images/ecoli-example/ec-vcf2core-data.png
[ec-filter-stats]: ../images/ecoli-example/ec-filter-stats.png
[ec-mapping-quality]: ../images/ecoli-example/ec-mapping-quality.png
