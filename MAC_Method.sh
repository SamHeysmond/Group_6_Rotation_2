## SCRIPT INFO
# This script shows the workflow for combining the given vcf and fasta files
# to create consensus sequences 
#
# Conda was used as the package manager in this case. 

## Versions for MAC method
# MAC OS V12.6.5
# Terminal V 2.12.7
# conda V23.9.0
# bcftools V1.11
# samtools V1.3.1
# vcftools V0.1.16

## Files for MAC method
# Reference genome fasta file -> C_excelsa_V5.fasta
# VCF of populations tested (diploid) -> UK_scan_dips.vcf
# VCF of populations tested_2 (tetraploid) -> UK_scan_tets.vcf
# Gff of the reference (not required) -> C_excelsa_V5_braker2_wRseq.gff3

#############################################################################
############## M A C # O S # S T E P S ######################################
#############################################################################
### MAC method for creating consensus sequence (alternate method to windows WSL method)

## 1) Setting up environment

## 1.1) Adding conda to environment
export PATH=/home/sam/miniconda3/condabin/conda:$PATH
source /home/sam/miniconda3/etc/profile.d/conda.sh

## 1.2) install all software needed to base conda environment
conda install -c bioconda samtools
conda install -c bioconda bcftools

## 2) activate conda base environment
conda activate

## 3) compress the vcf files
bgzip -c /Users/yaz/Desktop/HPC/VCFs/UK_scan_dips.vcf >/Users/yaz/Desktop/HPC/UK_scan_dips.vcf.gz 
bgzip -c /Users/yaz/Desktop/HPC/VCFs/UK_scan_tets.vcf >/Users/yaz/Desktop/HPC/UK_scan_tets.vcf.gz
 
## 4) filter VCFs for allele frequency >= 50%
bcftools filter -i 'AF >= 0.5' /Users/yaz/Desktop/HPC/UK_scan_dips.vcf.gz -Oz -o /Users/yaz/Desktop/HPC/UK_scan_dips_filtered.vcf.gz
bcftools filter -i 'AF >= 0.5' /Users/yaz/Desktop/HPC/UK_scan_tets.vcf.gz -Oz -o /Users/yaz/Desktop/HPC/UK_scan_tets_filtered.vcf.gz
 
## 5) index the filtered VCFs
bcftools index -t /Users/yaz/Desktop/HPC/UK_scan_dips_filtered.vcf.gz
bcftools index -t /Users/yaz/Desktop/HPC/UK_scan_tets_filtered.vcf.gz
 
## 6) create consensus sequences with filtered VCFs
# faidx will require you to know the location of your gene from the gff file
samtools faidx /Users/yaz/Desktop/HPC/Reference_Genome/C_excelsa_V5.fasta Cexcelsa_scaf_3:41053833-41054780 | bcftools consensus /Users/yaz/Desktop/HPC/UK_scan_dips_filtered.vcf.gz > /Users/yaz/Desktop/HPC/dips_con_s.fa
 
samtools faidx /Users/yaz/Desktop/HPC/Reference_Genome/C_excelsa_V5.fasta Cexcelsa_scaf_3:41053833-41054780 | bcftools consensus /Users/yaz/Desktop/HPC/UK_scan_tets_filtered.vcf.gz > /Users/yaz/Desktop/HPC/tets_con_2.fa
 
samtools faidx /Users/yaz/Desktop/HPC/Reference_Genome/C_excelsa_V5.fasta Cexcelsa_scaf_3:6912760-6916296 | bcftools consensus /Users/yaz/Desktop/HPC/UK_scan_tets_filtered.vcf.gz > /Users/yaz/Desktop/HPC/tets_con.fa
 
samtools faidx /Users/yaz/Desktop/HPC/Reference_Genome/C_excelsa_V5.fasta Cexcelsa_scaf_3:6912760-6916296 | bcftools consensus /Users/yaz/Desktop/HPC/UK_scan_dips_filtered.vcf.gz > /Users/yaz/Desktop/HPC/dips_con_2.fa

## 7) deacticate base conda environment
conda deactivate

echo "MAC_Method.sh has finished"
#End of file






