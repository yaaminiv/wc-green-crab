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
TRINITY=/vortexfs1/home/yaamini.venkataraman/.conda/envs/trinity_env/bin
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

# DE NOVO TRANSCRIPTOME ASSEMBLY

echo "Start de novo transcriptome assembly"

# Run Trinity to assemble de novo transcriptome. Using primarily default parameters.
${TRINITY}/Trinity \
--seqType fq \
--max_memory 100G \
--samples_file ${trinity_file_list} \
--SS_lib_type FR \
--min_contig_length 200 \
--full_cleanup \
--CPU 28

# Move transcriptome to the correct location
mv trinity_out_dir.Trinity.fasta ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta

# Collapse isoforms into supertranscripts.
# Output files are trinity_genes.fasta (supertranscripts in fasta format), trinity_genes.gtf (transcript structure annotation in gtf format), and trinity_genes.malign (multiple alignment view that contrasts the different candidate splicing isoforms)
${TRINITY}/Analysis/SuperTranscripts/Trinity_gene_splice_modeler.py \
--trinity_fasta ${OUTPUT_DIR}/trinity_out_dir/Trinity.fasta \
--incl_malign

# Move output files to a new folder
mkdir supertranscript_output
rsync --archive --progress --verbose trinity_genes.* supertranscript_output/.

echo "Completed de novo transcriptome assembly"

# GENERATE SUPPLEMENTAL FILES FOR THE TRANSCRIPTOME
#Use within-trinity tools to get baseline assembly statistics and files necessary for downstream analysis

echo "Start supplemental file creation"

# Assembly stats
${TRINITY}/util/TrinityStats.pl \
${OUTPUT_DIR}/supertranscript_output/trinity_genes.fasta \
> ${OUTPUT_DIR}/supertranscript_output/${assembly_stats}

# Create sequence lengths file (used for differential gene expression)
${TRINITY}/util/misc/fasta_seq_length.pl \
${OUTPUT_DIR}/supertranscript_output/trinity_genes.fasta \
> ${OUTPUT_DIR}/supertranscript_output/Trinity.fasta.seq_lens

# Create FastA index
${SAMTOOLS} faidx \
${OUTPUT_DIR}/supertranscript_output/trinity_genes.fasta \

echo "Completed supplemental file creation"

# TRANSCRIPT ABUNDANCE ESTIMATION

echo "Start transcript abundance estimation"

# Prepare the reference (target index) with bowtie2 prior to transcript abundance estimation. The output is a BAM file necessary for pseudo-alignment
${TRINITY}/util/align_and_estimate_abundance.pl \
--transcripts ${OUTPUT_DIR}/supertranscript_output/trinity_genes.fasta \
--est_method salmon \
--aln_method bowtie2 \
--prep_reference \
--coordsort_bam

# Perform transcript abundance estimation with salmon for each sample
${TRINITY}/util/align_and_estimate_abundance.pl \
--transcripts ${OUTPUT_DIR}/supertranscript_output/trinity_genes.fasta \
--seqType fq \
--samples_file ${trinity_file_list} \
--SS_lib_type RF \
--est_method salmon \
--aln_method bowtie2 \
--output_dir ${OUTPUT_DIR}/supertranscript_output \
--thread_count 16

# Get a list of the salmon quant.sf files so we don't have to list them individually
find ${OUTPUT_DIR}/. -maxdepth 2 -name "quant.sf" | tee ${OUTPUT_DIR}/supertranscript_output/salmon.quant_files.txt

# Generate a matrix with abundance estimates across all samples
${TRINITY}/util/abundance_estimates_to_matrix.pl \
--est_method salmon \
--quant_files ${OUTPUT_DIR}/supertranscript_output/salmon.quant_files.txt \
--name_sample_by_basedir \
--gene_trans_map none

# Move files to the correct location
rsync --archive --progress --verbose salmon* supertranscript_output/.

echo "Completed transcript abundance estimation"

# TRANSCRIPTOME ASSEMBLY STATISTICS

echo "Start transcript assembly statistic calculations"

# Calculate Ex50 statistics
contig_ExN50_statistic.pl ${OUTPUT_DIR}/supertranscript_output/salmon.isoform.TPM.not_cross_norm \
${OUTPUT_DIR}/supertranscript_output/trinity_genes.fasta \
| tee ${OUTPUT_DIR}/supertranscript_output/ExN50.stats

# Calculate N50 statistics
TrinityStats.pl ${OUTPUT_DIR}/supertranscript_output/trinity_genes.fasta \
> ${OUTPUT_DIR}/supertranscript_output/N50.txt

echo "Completed transcript assembly statistic calculations"

# TRANSCRIPTOME FILTERING BY TPM
# Although not always recommended at this stage, filtering is necessary for EnTAP annotation and contaminant removal.

echo "Start transcript filtering: TPM < 0.5"

#Filter out low-abundance transcripts (TPM < 0.5) for downstream analysis
${TRINITY}/util/filter_low_expr_transcripts.pl \
--matrix ${OUTPUT_DIR}/supertranscript_output/salmon.isoform.TPM.not_cross_norm \
--transcripts ${OUTPUT_DIR}/supertranscript_output/trinity_genes.fasta \
--min_expr_any 0.5 \
--trinity_mode \
> ${OUTPUT_DIR}/filtered_supertranscript_output/filtered_transcripts_min_exp_0.5.fasta

echo "Completed transcript filtering: TPM < 0.5"

echo "Start transcript filtering: TPM < 1"

#Filter out low-abundance transcripts (TPM < 0.5) for downstream analysis
${TRINITY}/util/filter_low_expr_transcripts.pl \
--matrix ${OUTPUT_DIR}/supertranscript_output/salmon.isoform.TPM.not_cross_norm \
--transcripts ${OUTPUT_DIR}/supertranscript_output/trinity_genes.fasta \
--min_expr_any 1 \
--trinity_mode \
> ${OUTPUT_DIR}/filtered_supertranscript_output/filtered_transcripts_min_exp_1.fasta

echo "Completed transcript filtering: TPM < 1"

echo "Ready to proceed to the next analytical step"
