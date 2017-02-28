#!/bin/bash
# After mapping, find out how many queries hit in a single place with MAPQ >= 10 
# Requires samtools
# The linkage group section requires that your input fasta is a map in the MapComp format

module load samtools/1.3

## USAGE ##
# bam_assess.sh <your_file.bam>

# User Input
INPUT=$1


# Show how many hits:
echo "Number of hits in "$INPUT""
samtools view $INPUT |
    awk '$5 >= 10 { print $1 }' | 
    sort | uniq -c | sort -nr | 
    awk '$1 == 1 { print $2 }' |
    wc -l 

# Show where the hits are from (only works when $INPUT is in MapComp format)
echo "Number of query hits per linkage group"
samtools view $INPUT |
    awk '$5 >= 10 { print $1 }' | 
    sort | uniq -c | sort -nr | 
    awk '$1 == 1 { print $2 }' |
    awk -F_ '{ print $2 }' | sort -n | uniq -c > linkage_groups.temp 


NUMLGS=$( wc -l linkage_groups.temp )

# Show results
echo "Across "$NUMLGS" "
cat linkage_groups.temp 

# Cleanup
rm linkage_groups.temp 

