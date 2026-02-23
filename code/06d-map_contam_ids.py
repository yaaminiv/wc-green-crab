import pandas as pd
import sys
from ete3 import NCBITaxa
ncbi = NCBITaxa()

INPUT = sys.argv[1]
OUTPUT = sys.argv[2]

hits = pd.read_table(INPUT,header=None)

candidate_contam = [2,2157,10239,6157,6231,4751,33630,33090,2763,554915,543769,33634,37909,1458140] #list contam taxids

contam = []
contam = []
for i in hits.index:
    contig = hits.loc[i, 0]
    taxid_raw = hits.loc[i, 13]

    try:
        # 1. Ensure taxid is a clean integer (removes decimals/whitespace)
        taxid = int(float(taxid_raw))

        # 2. Attempt to get lineage
        lineage = ncbi.get_lineage(taxid)

    except (ValueError, KeyError, TypeError):
        # This handles the "taxid not found" or bad data types
        print(f"Warning: TaxID {taxid_raw} not found in local database. Skipping.")
        continue  # <--- This stops the current loop iteration and moves to the next row

    # 3. Intersection check (only runs if lineage was successfully retrieved)
    if set(lineage).intersection(candidate_contam):
        contam.append(contig)

with open(OUTPUT, 'w') as file:
    for i in contam:
        file.write(">"+'%s\n' % i)
