#!/bin/bash

#SBATCH --partition=compute          								 				  								  	     		    # Queue selection
#SBATCH --job-name=yrv_trinity        							 															        # Job name
#SBATCH --mail-type=ALL              							   				     									     		    # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    									    		    # Where to send mail
#SBATCH --nodes=1                                                									            # One node
#SBATCH --exclusive                                                 								          # All 36 procs on the one node
#SBATCH --mem=100gb                                                 								          # Job memory request
#SBATCH --qos=unlim            								   															     	    	# Unlimited time
#SBATCH --output=yrv_trinity%j.log  								   															     		# Standard output/error
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06c-trinity	  # Working directory for this script

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

#Directory and file paths
DATA_DIR=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06b-trimgalore/trim-illumina-polyA
OUTPUT_DIR=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06c-trimgalore
assembly_stats=assembly_stats.txt
trinity_file_list=/vortexfs1/home/yaamini.venkataraman/trinity-samples.txt

# Run Trinity to assemble de novo transcriptome. Using primarily default parameters.
${TRINITY}/Trinity \
--seqType fq \
--max_memory 100G \
--samples_file ${trinity_file_list} \
--SS_lib_type FR \
--min_contig_length 200 \
--full_cleanup \
--CPU 28

# Assembly stats
${TRINITY}/util/TrinityStats.pl \
${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
> ${assembly_stats}

# Create gene map files
${TRINITY}/util/support_scripts/get_Trinity_gene_to_trans_map.pl \
${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
> ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta.gene_trans_map

# RUN THINGS TO GET EXN50 STATS SIMILAR TO ZAC'S CODE

# Create sequence lengths file (used for differential gene expression)
# ${TRINITY}/util/misc/fasta_seq_length.pl \
# ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
# > ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta.seq_lens

# Create FastA index
# ${SAMTOOLS} faidx \
# ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta
