#!/bin/bash

## SCRIPT INFO
# This script shows the workflow for combining the given vcf and fasta files
# to create consensus sequences 
#
# Conda was used as the package manager in this case and the following commands
# work for windows subsystem for linux (WSL). 
# Where a code line changes between systems (Windows vs Mac) there will be a 
# comment denoting this change.

## Software versions used in this code
# For windows method 
# Windows 11 Home V 10.0.22631 Build 22631
# Terminal (Windows subsystem for Linux - Ubuntu) V2.0.9.0
# conda V23.10.0
# bcftools V1.19.1
# tabix (gzip) V1.19.1
# samtools V1.19.2

# For MAC method
# MAC OS V12.6.5
# Terminal V 2.12.7
# conda V23.9.0
# bcftools V1.11
# samtools V1.3.1
# vcftools V0.1.16

## FILES NEEDED
#VCFs
# UK_scan_dips.vcf
# UK_scan_tets.vcf

# Reference sequence
# C_excelsa_V5.fasta

## Adding conda to path
export PATH=/home/sam/miniconda3/condabin/conda:$PATH
source /home/sam/miniconda3/etc/profile.d/conda.sh
#############################################################################
############## W I N D O W S # O S # S T E P S ##############################
#############################################################################

## 1) Set up Bcftools environment in conda

#create bcftools environment (including tabix as well for compression)
#conda create -n bcftools_env bcftools tabix

#activate environment
conda activate bcftools_env

## 2) Prepare the VCF files for combination

# Using bgzip from the bcftools environment, compress the VCF files.
bgzip -c UK_scan_dips.vcf > UK_scan_dips.vcf.gz 
bgzip -c UK_scan_tets.vcf >UK_scan_tets.vcf.gz
 
# filter VCFs for allele frequency >= 50%
bcftools filter -i 'AF >= 0.5' UK_scan_dips.vcf.gz -Oz -o filtered_UK_scan_dips.vcf.gz
bcftools filter -i 'AF >= 0.5' UK_scan_tets.vcf.gz -Oz -o filtered_UK_scan_tets.vcf.gz
 
# index the filtered VCFs in the tbi format
bcftools index -t filtered_UK_scan_dips.vcf.gz
bcftools index -t filtered_UK_scan_tets.vcf.gz
 
## 3) Set up samtools environment for creation of consensus sequences

# Ensure no conda environment is active first
conda deactivate

# create samtools environment
#conda create -n samtools samtools

# activate the samtools environment
conda activate samtools

## 4.1) Windows method for creating consensus sequence

# First copy over regions of genes of interest from the reference fasta to a new fasta file
# To find this gene region you will need to look at the gff file and use the region labelled "gene"
samtools faidx C_excelsa_V5.fasta Cexcelsa_scaf_3:41053833-41054780 > CASP_1_reference_gene_sequence.fa

samtools faidx C_excelsa_V5.fasta Cexcelsa_scaf_3:6912760-6916296 > RNA_dir_DNA_pol_reference_gene_sequence.fa

## 4.2)Swap environments from samtools to bcftools
# deactivate current environment
conda deactivate

#activate bcftools environment
conda activate bcftools_env


## 4.3) pass the newly made fasta file into a consensus command, combining it with the vcf made earlier
# do this for both proteins and for both diploid and tetraploid versions of them.

# CASP_1 Diplpoid (this applied 13 variants)
# the "-s -" flag will ignore samples and only use REF or ALT allele, this removes IUPAC
# codes within the output to give a clean A,T,C,G sequence. 
cat CASP_1_reference_gene_sequence.fa | bcftools consensus -s - filtered_UK_scan_dips.vcf.gz > CASP_1_diploid_consensus.fa

# CASP_1 Tetraploid (this applied 9 variants)
cat CASP_1_reference_gene_sequence.fa | bcftools consensus -s - filtered_UK_scan_tets.vcf.gz > CASP_1_tetraploid_consensus.fa

#Unknown_Diploid (this applied 12 variants)
cat RNA_dir_DNA_pol_reference_gene_sequence.fa | bcftools consensus -s - filtered_UK_scan_dips.vcf.gz > RNA_dir_DNA_pol_diploid_consensus.fa

#Unknown_Tetraploid stuff (this applied 22 variants)
cat RNA_dir_DNA_pol_reference_gene_sequence.fa | bcftools consensus -s - filtered_UK_scan_tets.vcf.gz > RNA_dir_DNA_pol_tetraploid_consensus.fa

## 5) Deactivate conda environment
conda deactivate


## END OF SCRIPT





