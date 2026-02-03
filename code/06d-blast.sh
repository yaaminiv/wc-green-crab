#!/bin/bash

#SBATCH --partition=compute          								 				  								  	     		    # Queue selection
#SBATCH --job-name=yrv_blast       							 															        # Job name
#SBATCH --mail-type=ALL              							   				     									     		    # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    									    		    # Where to send mail
#SBATCH --nodes=1                                                									            # One node
#SBATCH --exclusive                                                 								          # All 36 procs on the one node
#SBATCH --mem=180gb                                                 								          # Job memory request
#SBATCH --qos=unlim            								   															     	    	# Unlimited time allowed
#SBATCH --time=5-00:00:00           								   															     	    	# Time limit (d-hh:mm:ss)
#SBATCH --output=yrv_blast%j.log  								   															     		# Standard output/error
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06d-blast	  # Working directory for this script

#Adapted from the following:
#script by Grace Crandall: https://github.com/grace-ac/project-pycno-sswd-2021/blob/main/code/03-20220811_pycno_trinity_RNAseq_transcriptome.sh
#script by Zac Tobias: https://github.com/tepoltlab/RhithroLoxo_DE/blob/master/Snakefile
#script by Rayna Hamilton: https://github.com/tepoltlab/Hemigrapsus_transcriptome_pipeline/blob/main/2_transcriptome_assembly/Snakefile

#Exit script if any command fails
set -e

#Load module, activate the shell hook, and load environment
module load mambaforge
eval "$(conda shell.bash hook)"
conda activate trinity_env

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
OUTPUT_DIR=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06d-blast

# Blast transcriptome against nt. database from Dec 31 2018 for initial round of contaminant filtering
mkdir ${OUTPUT_DIR}/blast-results

module load bio blast/2.7.1

blastn -query ${TRINITY_DIR}/trinity_out_dir/Trinity.fasta \
-db nt \
-evalue 1e-10 \
-max_target_seqs 1 \
-max_hsps 1 \
-num_threads 35 \
-outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle staxids" \
-out ${OUTPUT_DIR}/blast-results/transcriptome-contam.tab
