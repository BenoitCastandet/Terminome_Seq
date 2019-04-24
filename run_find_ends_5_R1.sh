#!/bin/sh

#Script to find depth of read start sites
#samtools and bedtools programs must be installed

#Get 5'-ends from forward aligned reads in accepted_hits.bam from R1 file
samtools view accepted_hits.bam | awk '$2 == 0 {print $0}' | awk '{print $4}' > 5_forward.txt

#Get coverage
<5_forward.txt cut -d' ' -f1 | uniq -c | awk '{print $2, $1}' > 5_forward_coverage.txt


#Get 5'-ends from reverse aligned reads in accepted_hits.bam from R1 file
samtools view -h accepted_hits.bam | awk '$2 == 16 || $2 ~ ":" {print $0}' | samtools view -Sb - | bedtools bamtobed -i - | awk '{print $3}' | sort -k1,2n > 5_reverse.txt

#Get coverage
<5_reverse.txt cut -d' ' -f1 | uniq -c | awk '{print $2, $1}' > 5_reverse_coverage.txt
