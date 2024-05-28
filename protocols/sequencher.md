# Sequencher

Methods for getting SMC genotype data with Sequencher

## Materials

- Sequencher (note: WHOI has a shared license to Sequencher. Be sure to completely quit the program after you finish to ensure others can use it)

## Methods

1. Open Sequencher. Create a New Project and add Sequences (`.abi` files, with chromatograms)
2. Double click the sequences for the forward strand of a sample, then click "show chromatogram."
3. With the chromatogram showing, remove the sequence information for poor quality chromatograms. Repeat for the reverse strand.
4. After cleaning the chromatograms, select both files, then click "Assemble Automatically." This will create a new contig. Rename that contig with the sample name.
5. Double click on the newly assembled contig, then click "Bases." This will bring you to a view of the forward and reverse sequences in blue colors on top, with the reference sequence on the bottom. There will be dots indicate disagreements.
6. Click "Show Chromatograms." To fix disagreements manually, click on the dot under the sequences in blue lettering. This will bring you to the place in the chromatograms with the disagreement. At each disagreement, evaluate if a nucleotide needs to be added, deleted, or changed. After fixing each disagreement, click "ReAligner" to ensure proper alignment at each step.
7. Repeat for all sequences.
8. Once all sequences have been cleaned and assembled into individual contigs, highlight all contigs and click "Assemble Automatically." This will create a "master contig". Rename with the genotyping date. Include reads that were not assembled into contigs in the event that one strand was poorer quality than another. The higher quality strands will be assembled while the lower quality strads will not be included in the master contig.
9. Once the master contig is assembled, rearrange the F and R strands for each sample so they are on top of eachother by selecting "View >> Sort/Clean Up >> By Name". Click "Show Chromatograms" and confirm that the chromatograms are in the correct order.
10. In the "Bases" view, click on the nucleotide with the ambiguity. This will bring all chromatograms to the locus used to genotype samples. Sometimes, sequence quality will show to loci with ambiguities, other times just one.
11. Go through chromatograms for each sample and confirm that the bases are correctly called at the locus with the ambiguity. Record the genotype at this locus. If sequence quality allows for genotype to be called at two loci, the genotypes at these loci should match.
