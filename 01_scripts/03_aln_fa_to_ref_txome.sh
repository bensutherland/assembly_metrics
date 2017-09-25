#!/bin/bash
# Map a set of fasta files against a set of metatranscriptome assemblies
# Note: Requires that reference is indexed by bowtie2 (see README.md) 

# Global variables
DATA_FOLDER="00_input_files"
REFERENCE="$1"
RESULT_FOLDER="04_mapping_results"

# User variables
NUM_THREADS="10"

# Prepare other variables to be used 
OUTPUT_FOLDER=$(basename $REFERENCE)
LOG_FILE=$OUTPUT_FOLDER"_log.txt"
echo $REFERENCE 2>&1 | tee -a $LOG_FILE 

# Map reads
ls -1 $DATA_FOLDER/*.fq |
	sort -u |
	while read i
	do
	  echo $i 2>&1 | tee -a $LOG_FILE 
	  name=$(basename $i)
	  label=$(echo $name | perl -pe 's/\.fa//')
	  ID="@RG\tID:${label}\tSM:${label}\tPL:Illumina"

          # Alignment
	  bowtie2 --end-to-end -k 40 --threads $NUM_THREADS --rg-id $ID -x $REFERENCE --interleaved $i -S $i.bowtie2.sam 2>&1 | tee -a $LOG_FILE
	  samtools view -Sb -f 2 $i.bowtie2.sam > $i.bowtie2.unsorted.bam
	  #samtools sort -n -o $i.bowtie2.sorted.bam $i.bowtie2.unsorted.bam
	  #samtools index $i.bowtie2.sorted.bam # note, if samtools sort -n is used, cannot index

          # Clean up
          rm $i.bowtie2.sam
          mkdir $RESULT_FOLDER/$OUTPUT_FOLDER
          mv $DATA_FOLDER/*.bam $RESULT_FOLDER/$OUTPUT_FOLDER
done

mv $LOG_FILE $RESULT_FOLDER
