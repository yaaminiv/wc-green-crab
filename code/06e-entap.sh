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
#SBATCH --output=yrv_entap%j.log  								   															     		# Standard output/error
#SBATCH --chdir=/scratch/yaamini.venkataraman/wc-green-crab/output/06e-entap	  # Working directory for this script

#Adapted from the following:
#script by Zac Tobias: https://github.com/tepoltlab/RhithroLoxo_DE/blob/master/Snakefile

#Exit script if any command fails
set -e

#Load module, activate the shell hook, and load environment
module load mambaforge
unset PYTHONPATH
unset PYTHONHOME
eval "$(conda shell.bash hook)"
conda activate EnTAP

#Load modules with EnTAP dependencies
module load bio #Load bio module
module load rsem/1.3.0 #Load RSEM
module load blast/2.7.1 #Dependency for TransDecoder
module load transdecoder/5.3.0 #Load TransDecoder
module load interproscan/5.51-85.0 #Load InterProScan

#Load modules to compile EnTAP
module load cmake/3.18.6
module unload gcc
module load gcc/9.3.1
module load boost/gcc9/1.79

#Program paths
ENTAP=/vortexfs1/home/yaamini.venkataraman/EnTAP-v2.3.0

#Directory and file paths
TRINITY_DIR=/scratch/yaamini.venkataraman/wc-green-crab/output/06c-trinity
BLAST_DIR=/scratch/yaamini.venkataraman/wc-green-crab/output/06d-blast
OUTPUT_DIR=/scratch/yaamini.venkataraman/wc-green-crab/output/06e-entap
HOME_DIR=/vortexfs1/home/yaamini.venkataraman

# Make EnTap database
# First download reference databases for use in EnTAP: UniProt's uniref90, trembl, and sprot, and NCBI's nr and refseq databases.
wget ftp://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref90/uniref90.fasta.gz
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_trembl.fasta.gz
wget ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nr.gz
wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
wget ftp://ftp.ncbi.nlm.nih.gov/refseq/release/complete/complete.*.protein.faa.gz
cat complete.*.protein.faa.gz > refseq_complete.faa.gz
rm complete.*.protein.faa.gz

# EnTAP parses taxonomic information from reference database headers for contaminant filtering and taxonomic weighting.
# The existing uniref header format is incompatible with EnTAP. Using Zac's script to reformat the headers so they can be parsed by EnTAP
gunzip -c uniref90.fasta.gz > uniref90.fasta
python ${HOME_DIR}/06e-reformat_uniref.py uniref90.fasta uniref90_rf.fasta
gzip uniref90_rf.fasta
rm uniref90.fasta

# Configure EnTAP. this indexes the reference databases into diamond format
${ENTAP}/EnTAP --config -d nr.gz \
-d uniprot_trembl.fasta.gz \
-d refseq_complete.faa.gz \
-d uniprot_sprot.fasta.gz \
-d uniref90_rf.fasta.gz \
-t 35

#run EnTAP

rule run_EnTAP:
    input:
        config = ENTAP_CONFIG_OUT,
        txm = TXM_LONG_CLEAN,
    output:
        ENTAP_ANNOT_OUT,
        ENTAP_CONTAM
    params:
        dir = directory('EnTAP/')
    shell:
        """
        cd {params.dir}
        EnTAP --runN -i ../{input.txm} \
            -d entap_outfiles/bin/nr.dmnd \
            -d entap_outfiles/bin/refseq_complete.dmnd \
            -d entap_outfiles/bin/uniprot_sprot.dmnd \
            -d entap_outfiles/bin/uniprot_trembl.dmnd \
            -d entap_outfiles/bin/uniref90_rf.dmnd \
            -t 35 \
            -c bacteria \
            -c archaea \
            -c viruses \
            -c platyhelminthes \
            -c nematoda \
            -c fungi \
            -c alveolata \
            -c viridiplantae \
            -c rhodophyta \
            -c amoebozoa \
            -c rhizaria \
            -c stramenopiles \
            -c rhizocephala \
            -c entoniscidae \
            --taxon brachyura
        """

# Remove EnTAP contamination

rule remove_EnTAP_contam:
            input:
                contam = ENTAP_CONTAM,
                txm = TXM_LONG_CLEAN,
                script = {'scripts/fasta_subsetter.py'}
            output:
                txm = TXM_LONG_CLEAN_CLEAN
            shell:
                """
                awk 'FNR>1 {{print ">"$1}}' {input.contam} > outputs/entap_contam.txt
                python {input.script} {input.txm} outputs/entap_contam.txt REMOVE
                mv outputs/entap_contam_REMOVE.fasta {output.txm}
                """
