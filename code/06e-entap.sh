#!/bin/bash

#SBATCH --partition=compute          								 				  								  	     		    # Queue selection
#SBATCH --job-name=yrv_entap       							 															        # Job name
#SBATCH --mail-type=ALL              							   				     									     		    # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    									    		    # Where to send mail
#SBATCH --nodes=1                                                									            # One node
#SBATCH --exclusive                                                 								          # All 36 procs on the one node
#SBATCH --mem=180gb                                                 								          # Job memory request
#SBATCH --qos=unlim            								   															     	    	# Unlimited time allowed
#SBATCH --time=5-00:00:00           								   															     	    	# Time limit (d-hh:mm:ss)
#SBATCH --output=yrv_blast%j.log  								   															     		# Standard output/error
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06e-entap	  # Working directory for this script

#Adapted from the following:
#script by Grace Crandall: https://github.com/grace-ac/project-pycno-sswd-2021/blob/main/code/03-20220811_pycno_trinity_RNAseq_transcriptome.sh
#script by Zac Tobias: https://github.com/tepoltlab/RhithroLoxo_DE/blob/master/Snakefile
#script by Rayna Hamilton: https://github.com/tepoltlab/Hemigrapsus_transcriptome_pipeline/blob/main/2_transcriptome_assembly/Snakefile

#Exit script if any command fails
set -e

#Load module, activate the shell hook, and load environment
module load mambaforge
eval "$(conda shell.bash hook)"

#Program paths
TRINITY=/vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin/
CUTADAPT=/vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin/cutadapt
FASTQC=/vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin/fastqc
python=/vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin/python
JELLYFISH=//vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin/jellyfish
SALMON=/vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin/salmon
SAMTOOLS=/vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin/samtools
BOWTIE2=/vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin/bowtie2

#Directory and file paths
TRINITY_DIR=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06c-trinity
BLAST_DIR=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06d-blast
OUTPUT_DIR=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06e-entap
HOME_DIR=/vortexfs1/home/yaamini.venkataraman

# Make EnTap database
# First download reference databases for use in EnTAP: UniProt's uniref90, trembl, and sprot, and NCBI's nr and refseq databases.

wget ftp://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/uniref90.fasta.gz
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_trembl.fasta.gz
wget ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nr.gz
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
wget ftp://ftp.ncbi.nlm.nih.gov/refseq/release/complete/complete.nonredundant_protein.*.protein.faa.gz
cat complete.nonredundant_protein.*.protein.faa.gz > refseq_complete.faa.gz
rm complete.nonredundant_protein.*.protein.faa.gz

# EnTAP parses taxonomic information from reference database headers for contaminant filtering and taxonomic weighting.
# The existing uniref header format is incompatible with EnTAP. Using Zac's script to reformat the headers so they can be parsed by EnTAP

gunzip -c uniref90.fasta.gz > uniref90.fasta
python 06e-reformat_uniref.py uniref90.fasta uniref90_rf.fasta
gzip uniref90_rf.fasta
rm uniref90.fasta

#
