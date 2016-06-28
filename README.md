# assembly_metrics
Assess the results of a genome assembly through various metrics (e.g. N50, total length, BUSCO)

*Note: This repository comes with no guarantees, it is simply meant to help with determining various quality metrics of an assembly.*

Scripts found withint the directory `01_scripts/00_utility_scripts` originate from various sources, and these are attributed within each of the scripts themselves.

### Simple Calculations on fasta ###
`01_scripts/fasta_summarize.sh <assembly_name> <minimum_length>`   

Where minimum length is a number that is the smallest length that you would like your assembly to contain.   

Provides for the full assembly and the limited length assembly:     
* number of records
* total length
* n50 
