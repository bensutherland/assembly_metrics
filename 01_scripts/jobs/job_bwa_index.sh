#!/bin/bash
#SBATCH -o /home/bensuth/02_sfon_genome/10_assess_assemblies/assembly_metrics/bwa_output.txt
#SBATCH -e /home/bensuth/02_sfon_genome/10_assess_assemblies/assembly_metrics/bwa_error.txt
#SBATCH -D /home/bensuth/02_sfon_genome/10_assess_assemblies/assembly_metrics/
#SBATCH -J bwa
#SBATCH --cpus-per-task=1
#SBATCH --time=60:00:00
#SBATCH --mem=20000

# Load modules
module load bwa/0.7.13

# Set environment variables
ASSEMBLY_FOLDER="02_assemblies"

# Perform BUSCO analysis on each assembly in 02_assemblies
ls -1 ./$ASSEMBLY_FOLDER/*.fasta |
    sort -u |
    while read i
    do
        bwa index $i
    done
