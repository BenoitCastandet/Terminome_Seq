#!/bin/sh

#Script to find depth of read start sites
#samtools and bedtools programs must be installed

#Get 3'-ends from forward aligned reads in accepted_hits.bam from R2 file
samtools view accepted_hits.bam | awk '$2 == 0 {print $0}' | awk '{print $4}' > 3_forward.txt

#Get coverage
<3_forward.txt cut -d' ' -f1 | uniq -c | awk '{print $2, $1}' > 3_forward_coverage.txt


#Get 3'-ends from reverse aligned reads in accepted_hits.bam from R2 file
samtools view -h accepted_hits.bam | awk '$2 == 16 || $2 ~ ":" {print $0}' | samtools view -Sb - | bedtools bamtobed -i - | awk '{print $3}' | sort -k1,2n > 3_reverse.txt

#Get coverage
<3_reverse.txt cut -d' ' -f1 | uniq -c | awk '{print $2, $1}' > 3_reverse_coverage.txt
