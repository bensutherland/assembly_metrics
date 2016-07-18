# assembly_metrics
Assess the results of a genome assembly through various metrics (e.g. N50, total length, BUSCO)

*Note: This repository comes with no guarantees, it is simply meant to help with determining various quality metrics of an assembly.*

Scripts found withint the directory `01_scripts/00_utility_scripts` originate from various sources, and these are attributed within each of the scripts themselves.

All scripts should be run from the main directory of the repo.

Some scripts require biopython.

### 1. Simple Calculations on fasta ###
`01_scripts/01_fasta_summarize.sh <assembly.fasta> <minimum_length>`   

Where minimum length is a number that is the smallest length that you would like your assembly to contain.   

Provides for the full assembly and the limited length assembly:     
* number of records
* total length
* n50 

### 2. Markers against genome ###
First use bwa to index your assembly.fasta
`bwa index <assembly.fasta>`

`01_scripts/02_fasta_map.sh <query.fasta> <assembly.fasta>`

Then use a utility script to get statistics from the .bam file
`01_scripts/00_utility_scripts/bam_assess.sh 03_mapped/<output.bam>`

