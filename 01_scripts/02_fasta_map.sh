#!/bin/bash
# Map a fasta file against a reference 
# Requires bwa and samtools

# Load modules
module load samtools/1.3
module load bwa/0.7.13

## USAGE ##
# fasta_map.sh <your_query.fasta> <your_target.fasta>

# User Input
QUERY=$1
TARGET=$2

QUERYNAME=$(basename "$QUERY") 
TARGETNAME=$(basename "$TARGET")

#Variables
OUTPUT="$QUERYNAME"_"$TARGETNAME"
ASSEMBLY_FOLDER="02_assemblies"


echo $OUTPUT

# Map
bwa mem -t 4 $TARGET $QUERY > $ASSEMBLY_FOLDER/"$OUTPUT".sam 
samtools view -Sb -F 4 $ASSEMBLY_FOLDER/"$OUTPUT".sam > $ASSEMBLY_FOLDER/"$OUTPUT".bam 

