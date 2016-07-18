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
`01_scripts/00_utility_scripts/bam_assess.sh 02_assemblies/<output.bam>`

### 3. BUSCO evaluation ###
BUSCO can be run on each assembly contained in 02_assemblies
Note to run this on your own computer it is necessary to:    
Set the path to the BUSCO main python script, the BUSCO lineage folder, and the directory within the SBATCH portion of the job script.
Requires that BUSCO is installed (currently working on v1.2)

To run the script go to the main directory and    
`sbatch 01_scripts/jobs/job_BUSCO_multiple.sh`

This will result in multiple BUSCO directories for each fasta file found in your 02_assemblies folder (currently requires to be ending in .fa)
