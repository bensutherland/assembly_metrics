#!/bin/bash
#SBATCH -o /home/bensuth/02_sfon_genome/10_assess_assemblies/assembly_metrics/output.txt
#SBATCH -e /home/bensuth/02_sfon_genome/10_assess_assemblies/assembly_metrics/error.txt
#SBATCH -D /home/bensuth/02_sfon_genome/10_assess_assemblies/assembly_metrics/ 
#SBATCH -J BUSCO 
#SBATCH --cpus-per-task=10
#SBATCH --time=60:00:00
#SBATCH --mem=20000

# Set python environment
source activate python3

# Set environment variables
BUSCO="/home/bensuth/programs/BUSCO_v1.2/BUSCO_v1.2.py"
LINEAGE="/home/bensuth/02_sfon_genome/10_assess_assemblies/metazoa"
ASSEMBLY_FOLDER="02_assemblies"

# Adjustable variables
NUM_CORES=10

# Move into BUSCO results folder 
cd 03_busco_results

# Perform BUSCO analysis on each assembly in 02_assemblies
ls -1 ./../$ASSEMBLY_FOLDER/*.fa |
    sort -u |
    while read i
    do
        NAME_base=$( basename $i)
        echo "Assessing $NAME_base "
        python $BUSCO -c $NUM_CORES \
            -o $NAME_base -in $i \
            -l $LINEAGE -m genome
    done

