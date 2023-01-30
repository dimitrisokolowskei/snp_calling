#!/bin/bash

# Variant calling (SNP) workflow
# By: Dimitri Sokolowskei

read1=
read2=
reference=
threads=8

bwa mem -t $threads \
  -R \
  $reference \	
  $read1 \
  $read2 \
  > aligned_reads.sam

gatk MarkDuplicatesSpark \
  -I aligned_reads.sam \
  -M dedup_metrics.txt \
  -O sorted_dedup_reads.bam

 gatk BaseRecalibrator \
   -I my_reads.bam \
   -R reference.fasta \
   --known-sites sites_of_variation.vcf \
   --known-sites another/optional/setOfSitesToMask.vcf \
   -O recal_data.table

 gatk ApplyBQSR \
   -R reference.fasta \
   -I input.bam \
   --bqsr-recal-file recalibration.table \
   -O output.bam


  

