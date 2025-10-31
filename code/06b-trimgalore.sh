#!/bin/bash

#SBATCH --partition=compute          								 				  								  	     		    # Queue selection
#SBATCH --job-name=yrv_trimgalore         							 															        # Job name
#SBATCH --mail-type=ALL              							   				     									     		    # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    									    		    # Where to send mail
#SBATCH --nodes=1                                                									            # One node
#SBATCH --exclusive                                                 								          # All 36 procs on the one node
#SBATCH --mem=100gb                                                 								          # Job memory request
#SBATCH --time=24:00:00            								   															     	    	# Time limit hrs:min:sec
#SBATCH --output=yrv_trimgalore%j.log  								   															     		# Standard output/error
#SBATCH --chdir=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06b-trimgalore	  # Working directory for this script

#Adapted from script by Sam Bogan: https://github.com/snbogan/CP_RNAseq/blob/main/Scripts/CP_cutadapt.txt

#Exit script if any command fails
set -e

#Program paths
TRIMGALORE=/vortexfs1/home/yaamini.venkataraman/TrimGalore-0.6.6/trim_galore
CUTADAPT=/vortexfs1/home/yaamini.venkataraman/miniconda3/bin/cutadapt
MULTIQC=/vortexfs1/home/yaamini.venkataraman/miniconda3/bin/multiqc
python=/vortexfs1/home/yaamini.venkataraman/miniconda3/bin/python

#Directory paths
DATA_DIR=/vortexfs1/omics/tepolt/raw_reads/C_maenas/Cm_yrv_2023
OUTPUT_DIR=/vortexfs1/scratch/yaamini.venkataraman/wc-green-crab/output/06b-trimgalore

#Trimming

echo "Start TrimGalore"

echo "Trim 1: Remove low-quality reads"

#Loop through input files in the directory
for input_file in ${DATA_DIR}/*_R1_001.fastq.gz; do
 # Extract the base filename
  filename=$(basename "$input_file")
 # Construct the corresponding R2 filename
  input_r2="${input_file/_R1/_R2}"
  # Run TrimGalore to trim adapters, remove low-quality sequences, and retain sequences of a specific length
    ${TRIMGALORE} \
    --cores 8 \
    --output_dir ${OUTPUT_DIR} \
    --paired \
    -a "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA" \
    -A "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" \
    --quality 20 \
    --length 20 \
    --fastqc_args \
    "--outdir ${OUTPUT_DIR} \
    --threads 28" \
    --path_to_cutadapt ${CUTADAPT} \
    $input_file \
    $input_r2
  # Print completion message
  echo "Trimming complete for $filename"
done

#Move trimmed files to a new directory
mkdir ${OUTPUT_DIR}/trim1
mv ${OUTPUT_DIR}/*trimmed.fq.gz ${OUTPUT_DIR}/trim1/.
mv ${OUTPUT_DIR}/*trimmed_fastqc* ${OUTPUT_DIR}/trim1/.
mv ${OUTPUT_DIR}/*fastq.gz_trimming_report.txt ${OUTPUT_DIR}/trim1/.

echo "Trim 1 MutiQC"

#MultiQC
${MULTIQC} \
${OUTPUT_DIR}/trim1/*

echo "Trim 2: Remove poly A tails"

#Remove adapter sequences. Specify universal adapters instead of using --illumina
${TRIMGALORE} \
--cores 8 \
--output_dir ${OUTPUT_DIR} \
--paired \
--fastqc_args \
"--outdir ${OUTPUT_DIR} \
--threads 28" \
--paired \
-a "AAAAAAAAAA" \
--path_to_cutadapt ${CUTADAPT} \
${OUTPUT_DIR}/trim1/*fq.gz

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

echo "TrimGalore complete"
