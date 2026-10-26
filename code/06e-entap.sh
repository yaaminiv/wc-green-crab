#!/bin/bash

#SBATCH --partition=medmem          								 				  								  	     		    # Queue selection
#SBATCH --job-name=yrv_entap       							 															        # Job name
#SBATCH --mail-type=ALL              							   				     									     		    # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=yaamini.venkataraman@whoi.edu    				    									    		    # Where to send mail
#SBATCH --nodes=1                                                									            # One node
#SBATCH --exclusive                                                 								          # All 36 procs on the one node
#SBATCH --mem=500gb                                                  								          # Job memory request
#SBATCH --qos=unlim            								   															     	    	# Unlimited time allowed
#SBATCH --time=7-00:00:00           								   															     	    	# Time limit (d-hh:mm:ss)
#SBATCH --output=yrv_entap%j.log  								   															     		# Standard output/error
#SBATCH --chdir=/scratch/yaamini.venkataraman/wc-green-crab/output/06e-entap	  # Working directory for this script

#Adapted from the following:
#script by Zac Tobias: https://github.com/tepoltlab/RhithroLoxo_DE/blob/master/Snakefile

#Exit script if any command fails
set -e

#Load modules
module load entap
module load interproscan

#Program directory
ENTAP=/apps/EnTAP/2.3.0/

#Directory and file paths
TRINITY_DIR=/scratch/yaamini.venkataraman/wc-green-crab/output/06c-trinity
BLAST_DIR=/scratch/yaamini.venkataraman/wc-green-crab/output/06d-blast
OUTPUT_DIR=/scratch/yaamini.venkataraman/wc-green-crab/output/06e-entap
HOME_DIR=/user/yaamini.venkataraman

# Retain only the longest isoform for annotation - significantly speeds up annotation process
# python ${HOME_DIR}/06e-list-trinity-dups-to-remove.py ${BLAST_DIR}/transcriptome_contamRemoved.fasta
# python ${HOME_DIR}/06d-fasta_subsetter.py ${BLAST_DIR}/transcriptome_contamRemoved.fasta ${BLAST_DIR}/transcriptome_contamRemoved.fasta_dups.txt REMOVE
# mv ${BLAST_DIR}/transcriptome_contamRemoved.fasta ${BLAST_DIR}/transcriptome_contamRemoved_dupRemoved.fasta

echo "Download external databases"

# Make EnTap database
# Several databases can be downloaded and configured within EnTAP (UniProt Trembl, Uniprot Swiss-Prot, NCBI NR, NCBI Refseq Complete). However, the UnRef 90 database must be downloaded separately
# Download UniRef90
wget ftp://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/uniref90.fasta.gz

# EnTAP parses taxonomic information from reference database headers for contaminant filtering and taxonomic weighting.
# The existing uniref header format is incompatible with EnTAP. Using Zac's script to reformat the headers so they can be parsed by EnTAP
gunzip -c uniref90.fasta.gz > uniref90.fasta
python ${HOME_DIR}/06e-reformat_uniref.py uniref90.fasta uniref90_rf.fasta
gzip uniref90_rf.fasta
rm uniref90.fasta

echo "External database download complete"

echo "Start EnTAP configuration"

# Configure EnTAP to index the reference databases into diamond format
${ENTAP}/bin/EnTAP --config \
--run-ini ${OUTPUT_DIR}/entap_run.params \
--entap-ini ${ENTAP}/entap_config.ini \
-t 35

echo "EnTAP configuration complete"

#Unset python variables again to avoid conflicts with EnTAP run
# unset PYTHONPATH
# unset PYTHONHOME

echo "Start EnTAP annotation"

#Run EnTAP. The goal is to identify contaminated sequences to remove from the transcriptome.

${ENTAP}/bin/EnTAP --run \
--run-ini ${OUTPUT_DIR}/entap_run.params \
--entap-ini ${ENTAP}/entap_config.ini \
-t 35

echo "EnTAP annotation complete"

# Remove EnTAP contamination

# rule remove_EnTAP_contam:
#        input:
#                contam = ENTAP_CONTAM,
#                txm = TXM_LONG_CLEAN,
#                script = {'scripts/fasta_subsetter.py'}
#            output:
#                txm = TXM_LONG_CLEAN_CLEAN
#            shell:
#                """
#                awk 'FNR>1 {{print ">"$1}}' {input.contam} > outputs/entap_contam.txt
#                python {input.script} {input.txm} outputs/entap_contam.txt REMOVE
#                mv outputs/entap_contam_REMOVE.fasta {output.txm}
#                """
