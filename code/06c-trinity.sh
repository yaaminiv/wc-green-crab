#!/bin/bash

#SBATCH --partition=medmem          								 				  								  	     		    # Queue selection
#SBATCH --job-name=yrv_trinity        							 															        # Job name
#SBATCH --mail-type=ALL              							   				     									     		    # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    									    		    # Where to send mail
#SBATCH --nodes=1                                                									            # One node
#SBATCH --exclusive                                                 								          # All 36 procs on the one node
#SBATCH --mem=500gb                                                 								          # Job memory request
#SBATCH --qos=unlim            								   															     	    	# Unlimited time allowed
#SBATCH --time=25-00:00:00           								   															     	    	# Time limit (d-hh:mm:ss)
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
BOWTIE2=/vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin/bowtie2

#Directory and file paths
DATA_DIR=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06b-trimgalore/trim-illumina-polyA
OUTPUT_DIR=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06c-trinity
assembly_stats=assembly_stats.txt
trinity_file_list=/vortexfs1/home/yaamini.venkataraman/trinity-samples.txt

# Run Trinity to assemble de novo transcriptome. Using primarily default parameters.
${TRINITY}/Trinity \
--seqType fq \
--max_memory 100G \
--samples_file ${trinity_file_list} \
--SS_lib_type RF \
--min_contig_length 200 \
--full_cleanup \
--CPU 28

# Move transcriptome to the correct location
mv trinity_out_dir.Trinity.fasta trinity_out_dir/Trinity.fasta

#Use within-trinity tools to get baseline assembly statistics and files necessary for downstream analysis
# Assembly stats
${TRINITY}/util/TrinityStats.pl \
${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
> ${assembly_stats}

# Create gene map files
${TRINITY}/util/support_scripts/get_Trinity_gene_to_trans_map.pl \
${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
> ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta.gene_trans_map

# Create sequence lengths file (used for differential gene expression)
${TRINITY}/util/misc/fasta_seq_length.pl \
${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
> ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta.seq_lens

# Create FastA index
${SAMTOOLS} faidx \
${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta

# Prepare the reference (target index) with bowtie2 prior to transcript abundance estimation. The output is a BAM file necessary for pseudo-alignment
${TRINITY}/util/align_and_estimate_abundance.pl \
--transcripts ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
--est_method salmon \
--aln_method bowtie2 \
--gene_trans_map ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta.gene_trans_map \
--prep_reference \
--coordsort_bam

# Perform transcript abundance estimation with salmon
${TRINITY}/util/align_and_estimate_abundance.pl \
--transcripts ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
--seqType fq \
--samples_file ${trinity_file_list} \
--SS_lib_type RF \
--est_method salmon \
--aln_method bowtie2 \
--gene_trans_map ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta.gene_trans_map \
--output_dir ${OUTPUT_DIR} \
--thread_count 16

# Get a list of the salmon quant.sf files so we don't have to list them individually
find ${OUTPUT_DIR}/. -maxdepth 2 -name "quant.sf" | tee ${OUTPUT_DIR}/salmon.quant_files.txt

# Generate a matrix with all abundance estimates
$TRINITY_HOME/util/abundance_estimates_to_matrix.pl \
--est_method salmon \
--gene_trans_map none \
--quant_files ${OUTPUT_DIR}/salmon.quant_files.txt \
--name_sample_by_basedir

# Calculate Ex50 statistics
contig_ExN50_statistic.pl ${OUTPUT_DIR}/salmon.isoform.TPM.not_cross_norm \
${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
| tee ${OUTPUT_DIR}/ExN50.stats

# Calculate N50 statistics
TrinityStats.pl ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
> ${OUTPUT_DIR}/N50.txt
