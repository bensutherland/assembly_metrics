#!/bin/bash
# Map a fasta file against a reference 
# Requires bwa and samtools

## USAGE ##
# fasta_map.sh <your_query.fasta> <your_target.fasta>

# User Input
QUERY=$1
TARGET=$2

QUERYNAME=$(basename "$QUERY") 
TARGETNAME=$(basename "$TARGET")

#Variables
OUTPUT="$QUERYNAME"_"$TARGETNAME"

echo $OUTPUT

# Map
bwa mem -t 4 $TARGET $QUERY > "$OUTPUT".sam 
samtools view -Sb -F 4 "$OUTPUT".sam > "$OUTPUT".bam 

# Move to appropriate folder
mv *.sam *.bam 03_mapped/
