# Assembly Metrics
Assess a genome assembly using various metrics (e.g. N50, total length, BUSCO)    

Scripts found within the directory `01_scripts/00_utility_scripts` originate from various sources, and these are attributed within each of the scripts themselves. Many are from Eric Normandeau's scripts repo:  https://github.com/enormandeau/Scripts   

**Warning**: this pipeline is provided "as is", without any warranty of any kind, express or implied.      

Run scripts from the main directory of the repo.    

Requirements:
`biopython`    
`BUSCO`    
`bwa`    
`samtools`    
`python3`    


### 0. Prelim Options ###
You can confirm the smallest contig size using     
`./01_scripts/00_utility_scripts/fasta_min_len.py my_minl500.fasta`


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
Using the job submission file, BUSCO can be run on multiple assemblies all found within 02_assemblies/*.fasta    
To set up on your own directory, customize the following in the SLURM job file:      
* Set path to BUSCO python script    
* Set path to BUSCO lineage folder    
* Set directories within the batch submission top part of the job script

After customizing to your directory, submit the job script    
`sbatch 01_scripts/jobs/job_BUSCO_multiple.sh`

This will result in multiple BUSCO directories for each fasta file found in your 02_assemblies folder

### 4. Align fastq against metatranscriptome
To assess a metatranscriptome, one approach is to take several individual fastq files and see how well they map against the assembly. 
First index your metatranscriptome using bowtie2.   
  
Then run the following command, including the bt2_index_base as <your_assembly>:    
`./01_scripts/03_aln_fa_to_ref_txome.sh 02_assemblies/your_assembly`   
  
The output results will be accessible in `04_mapping_results`, both in .bam format saved under the name of the reference, as well as in log format.   
