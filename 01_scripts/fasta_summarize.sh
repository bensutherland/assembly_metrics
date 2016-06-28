#!/bin/bash
# Find the number of records and total length of a fasta file

## USAGE ##
# fasta_characterize.sh <your_file.fasta> <min_length>

# User Input 
INPUT="$1"
LENGTH="$2"

# Do not change
TRIMMED_INPUT="$INPUT"_minlength500.fa

# Characterize full file
echo " ** n50 calculation for $INPUT"
./01_scripts/00_utility_scripts/fasta_n50.py $INPUT

echo " ** Number records in $INPUT"
grep -c '>' $INPUT

echo " ** Full length of $INPUT"
grep -v '>' $INPUT | wc -c

echo " ** Longest contig"
./01_scripts/00_utility_scripts/fasta_max_len.py $INPUT

# Limit file to records greater than $LENGTH 
echo " ** minimum length = $LENGTH"
./01_scripts/00_utility_scripts/fasta_minlength.pl $LENGTH $INPUT > $TRIMMED_INPUT

# Run summarization for trimmed file
echo " ** n50 calculation for $TRIMMED_INPUT"
./01_scripts/00_utility_scripts/fasta_n50.py $TRIMMED_INPUT

echo " ** Number records in $TRIMMED_INPUT"
grep -c '>' $TRIMMED_INPUT

echo " ** Full length of $TRIMMED_INPUT"
grep -v '>' $TRIMMED_INPUT | wc -c

