# Escherichia coli 1405WAEXK

This example goes through the analysis of an *Escherichia coli* dataset through SNVPhyl.  The source of this data can be found in the [WGS Standards and Analysis][] project.  The necessary reference and sequence reads can be downloaded from <http://irida.corefacility.ca/downloads/snvphyl-galaxy/examples/snvphyl-example-ec.tar.gz>.

This example assumes you have a working version of SNVPhyl up and running within Galaxy.  For instructions on how to get to this stage, please refer to the [Install] documentation.

## Step 1: Importing data into Galaxy

There are two types of data that must be imported into Galaxy to run SNVPhyl, the reference genome `2011C-3609.fasta` and the sequence reads within the `fastq/` directory.

1.  Import reference genome **2011C-3609.fasta**

    To import **2011C-3609.fasta** please go to **Get Data > Upload File**.  From here, select **Choose local file** and find `2011C-3609.fasta`.  Click **Start** to start uploading.


2.  Import sequence reads from **fastq/**.

    To import the sequence reads, please go to **Get Data > Upload File**.  From here, select **Choose local file** and find all the `fastq/*.fastq.gz` files (_Shift-click_ lets you select all files). Once the files are selected, please find the **Type** column in the table and change from **Auto-detect** to **fastqsanger**.  This should change all file types to **fastqsanger**.  This should look like:

    ![ec-upload-fastqsanger][]

    Once this is complete, click on **Start** to start the upload.

On completion, you should see all files show up in your Galaxy **History** panel similar to below.

![ec-galaxy-history][]

## Step 2: Constructing Galaxy Dataset Pairs

SNVPhyl makes use of [Dataset Collections][] in Galaxy to properly structure paired-end sequence reads to run through SNVPhyl.  To construct the necessary data structure, please do the following.

1.  Click the **multiple datasets** icon ![multiple-datasets][].  This should allow selection of files in the Galaxy History to combine together into a single dataset collection.  Select all but the reference file **2011C-3609.fasta**.  This should look similar to.

    ![select-fastq-collection][]

2.  Select the **For all selected... > Build List of Dataset Pairs** option in the **History** panel.  This should bring up a window describing which files should be grouped together into a single set of paired-end files.  At the bottom, please name this set of files **ec-paired-reads**.  This should look as follows.

    ![ec-paired-list][]

    Click the **Create list** button.  This should create an **ec-paired-reads** entry in the Galaxy History.

## Step 3: Running the Workflow

Once a proper paired-end dataset collection **ec-paired-reads** is constructed, the SNVPhyl workflow can be run on the uploaded data.  To run the workflow, please do the following.

1.  At the very top of the Galaxy page, select **Workflow**.  This should bring you to a page where you can select from a number of installed workflows.  Please select **BETA: Snvphyl pipeline v 0.4 PE (imported from uploaded file) (imported from API)** and click **Run**.

2.  Adjust the main parameters.  Displayed in the **Workflow Parameters** at the top of the screen.  For this example, please set to:

    * **min_coverage**: 15
    * **min_mean_mapping**: 30
    * **alternative_allele_percentage**: 0.75
    * **run_name**: ec-example

3.  Verify that **Step 1: Input dataset collection** is set to **ec-paired-reads** and **Step 2: Input dataset** is set to **2011C-3609.fasta**.

4.  At the very bottom of this page, click the **Run workflow** button.  This should begin scheduling the workflow in your Galaxy history.  You should see each individual step running in Galaxy like below.

    ![run-pipeline][]

*Note: Depending on the resources dedicated to SNVPhyl and Galaxy, this may take a while (hours) to complete.*

## Step 4: Examine Results

The pipeline is complete when all steps have finished executing (all steps are green) which will appear like the following.

Once complete, please proceed to examining the results.  The main output files for the pipeline are:

1. tree
2. matrix
3. core
4. snp table
5. **ec-example-percentage_reference_mapped**:  This file shows the percent of reads that have mapped to the reference genome.  This can be used to assess any potential issues.

## Step 5: Interpretation

This dataset also includes additional metadata for each isolate in the file `Escherichia_coli_1405WAEXK-1.xlsx`.  Please open this file and let us compare to some of the output files obtained from this pipeline.

[WGS Standards and Analysis]: https://github.com/WGS-standards-and-analysis/datasets/
[Install]: ../install
[ec-upload-fastqsanger]: examples/images/ec-upload-fastqsanger.png
[ec-galaxy-history]: examples/images/ec-galaxy-history.png
[multiple-datasets]: examples/images/ec-multiple-datasets.png
[select-fastq-collection]: examples/images/ec-select-fastq-collection.png
[ec-paired-list]: examples/images/ec-paired-list.png
[run-pipeline]: examples/images/ec-run-pipeline.png
