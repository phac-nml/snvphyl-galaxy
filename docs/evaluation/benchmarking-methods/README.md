# 1. Variable recombination dynamics during the emergence, transmission and ‘disarming’ of a multidrug-resistant pneumococcal clone

From <https://www.ncbi.nlm.nih.gov/pubmed/24957517>.
Reference genome <https://www.ncbi.nlm.nih.gov/nuccore/CP002176>.
189 Illumina reads in `1-pneumo.tsv`.

```
perl download_sra_runs.pl fastq-1-pneumo 12 < 1-pneumo.tsv

# Rename _3.fastq to _2.fastq
prename  's/_3.fastq/_2.fastq/' *_3.fastq

# Estimate coverages
(for i in fastq-1-pneumo/*_1.fastq; do name=`basename $i _1.fastq`; forward=`sed -n 2~4p fastq-1-pneumo/${name}_1.fastq|tr -d '\n'|wc -c`; reverse=`sed -n 2~4p fastq-1-pneumo/${name}_2.fastq|tr -d '\n'|wc -c`; ref=`bp_seq_length references/CP002176.fasta | cut -d ' ' -f 2| tr -d '\n'`; cov=`echo "($forward+$reverse)/$ref"|bc -l`; echo -e "$name\t$forward\t$reverse\t$ref\t$cov"; done) | sort -k 5,5n | tee coverages.txt

# Run SNVPhyl

## Case 2 SNVs in 500 bp

### Docker
snvphyl.py --deploy-docker --fastq-dir fastq-1-pneumo/ --reference-file references/CP002176.fasta --output-dir output-1-pneumo-docker-3 --min-coverage 20

### Cluster
snvphyl.py --galaxy-url [URL] --galaxy-api-key [KEY] --fastq-history-name fastq-1-pneumo --reference-file references/CP002176.fasta --output-dir output-1-pneumo-waffles-no-filter --min-coverage 20

## Case no filtering

### Cluster
snvphyl.py --galaxy-url [URL] --galaxy-api-key [KEY] --fastq-history-name fastq-1-pneumo --reference-file references/CP002176.fasta --output-dir output-1-pneumo-waffles-no-filter --min-coverage 20 --filter-density-window 5 --filter-density-threshold 10

# Swap 'Reference' for '670-6B' for comparison with microreact tree
sed -i -e 's/reference/670-6B /' [tree]
```
