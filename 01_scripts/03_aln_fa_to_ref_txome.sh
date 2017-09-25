#!/bin/bash
# Map a set of fasta files against a set of metatranscriptome assemblies
# Note: Requires that reference is indexed by bowtie2 (see README.md) 

# Global variables
DATA_FOLDER="00_input_files"
REF_FOLDER="02_assemblies"
REFERENCE="$1"
RESULT_FOLDER="04_mapping_results"

# User variables
NUM_THREADS="10"

# troubleshoot
echo $REFERENCE
OUTPUT_FOLDER=$(basename $REFERENCE)

# Map reads
ls -1 $DATA_FOLDER/*.fq |
	sort -u |
	while read i
	do
	  echo $i
	  name=$(basename $i)
	  label=$(echo $name | perl -pe 's/\.fa//')
	  ID="@RG\tID:${label}\tSM:${label}\tPL:Illumina"
	  bowtie2 --end-to-end -k 40 --threads $NUM_THREADS --rg-id $ID -x $REFERENCE --interleaved $i -S $i.bowtie2.sam
	  samtools view -Sb -f 2 $i.bowtie2.sam > $i.bowtie2.unsorted.bam
	  #samtools sort -n -o $i.bowtie2.sorted.bam $i.bowtie2.unsorted.bam
	  #samtools index $i.bowtie2.sorted.bam # note, if samtools sort -n is used, cannot index
      #rm $i.bowtie2.sam
          mkdir $RESULT_FOLDER/$OUTPUT_FOLDER
          mv *.bam $RESULT_FOLDER/$OUTPUT_FOLDER
done

# clean up space

