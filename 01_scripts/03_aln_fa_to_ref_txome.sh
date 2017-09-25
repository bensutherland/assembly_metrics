#!/bin/bash
# Map a set of fasta files against a set of metatranscriptome assemblies
# Note: Requires that reference is indexed by bowtie2 (see README.md) 

# define usage function
usage(){
    echo "Usage: $0 <your_assembly.fasta>"
    exit 1
}


# Global variables
DATA_FOLDER="00_input_files"
REF_FOLDER="02_assemblies"
REFERENCE="$1"

# User variables
NUM_THREADS="10"

# Map reads
ls -1 $DATA_FOLDER/*.fa |
	sort -u |
	while read i
	do
	  echo $i
	  name=$(basename $i)
	  label=$(echo $name | perl -pe 's/\.fa//')
	  ID="@RG\tID:${label}\tSM:${label}\tPL:Illumina"
	  bowtie2 --end-to-end -f --interleaved -k 40 --threads $NUM_THREADS --rg-id $ID -x $REFERENCE -U $i -S $i.bowtie2.sam
	  samtools view -Sb -f 2 $i.bowtie2.sam > $i.bowtie2.unsorted.bam
	  #samtools sort -n -o $i.bowtie2.sorted.bam $i.bowtie2.unsorted.bam
	  #samtools index $i.bowtie2.sorted.bam # note, if samtools sort -n is used, cannot index
      #rm $i.bowtie2.sam
done

# clean up space

