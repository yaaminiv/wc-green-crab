#!/bin/bash

#SBATCH --partition=compute          								 				  								  	     		# Queue selection
#SBATCH --job-name=yrv_fastqc         							 															        # Job name
#SBATCH --mail-type=ALL              							   				     									     		# Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    									    		# Where to send mail
#SBATCH --nodes=1                                                									        # One node
#SBATCH --exclusive                                                 								      # All 36 procs on the one node
#SBATCH --mem=100gb                                                 								      # Job memory request
#SBATCH --time=24:00:00            								   															     		# Time limit hrs:min:sec
#SBATCH --output=yrv_fastqc%j.log  								   															     		# Standard output/error
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/apalm-hypoxia-omics/02-trimgalore	# Working directory for this script

#Exit script if any command fails
set -e

#Program paths
TRIMGALORE=/vortexfs1/home/yaamini.venkataraman/TrimGalore-0.6.6/trim_galore
CUTADAPT=/vortexfs1/home/yaamini.venkataraman/miniconda3/bin/cutadapt
MULTIQC=/vortexfs1/home/yaamini.venkataraman/miniconda3/bin/multiqc

#Directory paths
DATA_DIR=/vortexfs1/home/yaamini.venkataraman/apalm-hypoxia-omics/data
OUTPUT_DIR=/vortexfs1/scratch/yaamini.venkataraman/apalm-hypoxia-omics/02-trimgalore

#Trimming

echo "Start TrimGalore"

echo "Trim 1: Remove low quality sequences"

#Remove sequences with quality < 20
${TRIMGALORE} \
--output_dir ${OUTPUT_DIR} \
--fastqc_args \
"--outdir ${OUTPUT_DIR} \
--threads 28" \
--quality 20 \
--path_to_cutadapt ${CUTADAPT} \
${DATA_DIR}/Apalm_01.fastq.gz \
${DATA_DIR}/Apalm_02.fastq.gz \
${DATA_DIR}/Apalm_13.fastq.gz \
${DATA_DIR}/Apalm_14.fastq.gz \
${DATA_DIR}/Apalm_15.fastq.gz \
${DATA_DIR}/Apalm_16.fastq.gz \
${DATA_DIR}/Apalm_17.fastq.gz \
${DATA_DIR}/Apalm_18.fastq.gz \
${DATA_DIR}/Apalm_24.fastq.gz \
${DATA_DIR}/Apalm_25.fastq.gz \
${DATA_DIR}/Apalm_26.fastq.gz \
${DATA_DIR}/Apalm_27.fastq.gz \
${DATA_DIR}/Apalm_28.fastq.gz \
${DATA_DIR}/Apalm_29.fastq.gz

#Move trimmed files to a new directory
mkdir ${OUTPUT_DIR}/trim1
mv ${OUTPUT_DIR}/*trimmed.fq.gz ${OUTPUT_DIR}/trim1/.
mv ${OUTPUT_DIR}/*trimmed_fastqc* ${OUTPUT_DIR}/trim1/.
mv ${OUTPUT_DIR}/*fastq.gz_trimming_report.txt ${OUTPUT_DIR}/trim1/.

echo "Trim 1 MutiQC"

#MultiQC
${MULTIQC} \
${OUTPUT_DIR}/trim1/*

echo "Trim 1 complete"

echo "Trim 2: Remove the first 12 bp"

#Remove sequences with quality < 20
${TRIMGALORE} \
--output_dir ${OUTPUT_DIR} \
--fastqc_args \
"--outdir ${OUTPUT_DIR} \
--threads 28" \
--clip_R1 12 \
--path_to_cutadapt ${CUTADAPT} \
${OUTPUT_DIR}/trim1/Apalm_01_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_02_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_13_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_14_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_15_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_16_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_17_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_18_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_24_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_25_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_26_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_27_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_28_trimmed.fq.gz \
${OUTPUT_DIR}/trim1/Apalm_29_trimmed.fq.gz

#Move trimmed files to a new directory
mkdir ${OUTPUT_DIR}/trim2
mv ${OUTPUT_DIR}/*trimmed_trimmed.fq.gz ${OUTPUT_DIR}/trim2/.
mv ${OUTPUT_DIR}/*trimmed_trimmed_fastqc* ${OUTPUT_DIR}/trim2/.
mv ${OUTPUT_DIR}*_trimmed.fq.gz_trimming_report.txt ${OUTPUT_DIR}/trim2/.

echo "Trim 2 MutiQC"

#MultiQC
${MULTIQC} \
${OUTPUT_DIR}/trim2/*

echo "Trim 2 complete"

echo "Trim 3: Remove Poly A tails"

#Remove sequences with quality < 20
${TRIMGALORE} \
--output_dir ${OUTPUT_DIR} \
--fastqc_args \
"--outdir ${OUTPUT_DIR} \
--threads 28" \
-a "AAAAAAAAAA" \
--path_to_cutadapt ${CUTADAPT} \
${OUTPUT_DIR}/trim2/Apalm_01_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_02_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_13_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_14_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_15_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_16_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_17_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_18_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_24_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_25_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_26_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_27_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_28_trimmed_trimmed.fq.gz \
${OUTPUT_DIR}/trim2/Apalm_29_trimmed_trimmed.fq.gz

#Move trimmed files to a new directory
mkdir ${OUTPUT_DIR}/trim3
mv ${OUTPUT_DIR}/*trimmed_trimmed_trimmed.fq.gz ${OUTPUT_DIR}/trim3/.
mv ${OUTPUT_DIR}/*trimmed_trimmed_trimmed_fastqc* ${OUTPUT_DIR}/trim3/.
mv ${OUTPUT_DIR}*_trimmed_trimmed.fq.gz_trimming_report.txt ${OUTPUT_DIR}/trim3/.


echo "Trim 3 MutiQC"

#MultiQC
${MULTIQC} \
${OUTPUT_DIR}/trim3/*

echo "Trim 3 complete"

echo "TrimGalore complete"
