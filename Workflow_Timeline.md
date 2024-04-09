# Introduction
We have been assigned two proteins from a selection scan that showed positive selection in tetraploid Cochleria officinalis compared to the diploid Cochlearia pyrenica. The task we have is to analyse the differences in these two key proteins between two species of cochleria (diploid and tetraploid) to uncover any differences within them that may lead to this positive selection. In summary, we start with some sequence data and hope to end up with structural data that we can interpret visually, and through scientific studies, to compare and contrast the proteins in both diploid and tetraploid states.

---
# Timeline

> ##  1 - Find genes in reference file
+ We begin with the files listed below and search the gff file with the gene IDs given in the pdf file names (g38026 and g32580 for our CASP1 and mystery gene respectively).

> ## 1.1 - Files (input)
+ file 1) C_excelsa_V5.fasta (reference genome for Arabidopsis Thaliana)
+ file 2) C_excelsa_V5_braker2_wRseq.gff3 (A gff file based on this reference sequence above)
+ file 3) UK_scan_dips.vcf (A vcf file containing population data from diploid Cochleria species pyrenica)
+ file 4) UK_scan_tets.vcf (A vcf file containing population data from tetraploid Cochleria species officinalis)
+ file 5) g38026.pdf selection scan graph of our first protein of interest
+ file 6) g32580.pdf selection scan graph of our second protein of interest

> ## 1.2 - software versions needed- Windows
+ Windows notepad

> ## 1.3 - software versions needed - MAC
+ MAC TextEdit

> ## 1.4- Expected outcome
+ By doing this on MAC or WINDOWS machines with any text editor that has search functions, we find a row which shows the ID being equal to our search, and the label of "gene" with the appropriate start and end positions. 
These positions of each gene (for each protein) can be noted down for the next stage of analysis.

---
> ## 2 - Consensus sequence creation
+ We then need to create a consensus sequence of the Cochleria species (both diploid and tetraploid) at the specified gene locations we just uncovered.
The steps for this analysis are outlined in the code files WINDOWS_consensus.sh or MAC_consensus.sh.

> ## 2.1 Files (input)
+ Described in the relevant bash files WINDOWS_Method.sh or MAC_Method.sh

> ## 2.2 software versions needed- Windows AND MAC
+ Described in the relevant bash files WINDOWS_Method.sh or MAC_Method.sh

> ## 2.3 Expected outcome
+ By following the appropriate code file we end up with 4 files that can be used for further steps of analysis (as well as unnecessary extra files that can be ignored for now). If you choose to analyse a different number of proteins, then you will have 2x the number of proteins you wish to analyse (obtaining both diploid and tetraploid outputs for each protein).

> ## 2.4 Files (output)
These four files we expect (for our 2 proteins) consist of the following:
+ Consensus sequence fasta file for protein one in diploid form (e.g. protein1_diploid.fa)
+ Consensus sequence fasta file for protein one in tetraploid form (e.g. protein1_tetraploid.fa)
+ Consensus sequence fasta file for protein two in diploid form (e.g. protein2_diploid.fa)
+ Consensus sequence fasta file for protein two in diploid form (e.g. protein2_tetraploid.fa)

---
> ## 3- translate DNA to protein sequence
+ With these sequence files obtained previously, we now look to translate them to amino acids and discover any proteins/reading frames they contain. To do this we pasted each sequence separately into a protein ORF finder website (listed below by ncbi), setting the minimal ORF length to 30 (the lowest setting)

---
> ## 3.1 - Files (input)
+ Consensus sequence fasta file for protein one in diploid form (e.g. protein1_diploid.fa)
+ Consensus sequence fasta file for protein one in tetraploid form (e.g. protein1_tetraploid.fa)
+ Consensus sequence fasta file for protein two in diploid form (e.g. protein2_diploid.fa)
+ Consensus sequence fasta file for protein two in diploid form (e.g. protein2_tetraploid.fa)

---
> ## 3.2 - software needed -Windows OR Mac
+ website for ORF finding - https://www.ncbi.nlm.nih.gov/orffinder/

---
> ## 3.3 - expected outcome
+ We get a highlighted output that will show each reading frame of each direction of the newly translated sequence (into amino acids).
+ We selected the most appropriate reading frame from this stage for further analysis. We picked the largest and cleanest reading frames that when BLASTed (step4) were identified as some kind of protein. We saved the outputs into one file "protein_sequences.txt". For CASP1 we pasted orf8 and orf9 together but for the unknown protein we just pasted in the whole of orf1.

---
> ## 3.4 - Files (output)
+ protein_sequences.txt

---
> ## 4 - pBLAST orfs from step 3
+ Taking the most appropriate reading frames from your proteins you can then (from the same website) run a pBLAST search to get an idea of the potential proteins you are dealing with. Ensure you select the correct protein database (we used Swissprot and non-redundant protein sequences). 

---
> ## 4.1 - Files (input)
+ protein_sequences.txt

---
> ## 4- Software needed
+ website for ORF finding - https://www.ncbi.nlm.nih.gov/orffinder/
+ website for pBLAST - https://blast.ncbi.nlm.nih.gov/Blast.cgi

---
> ## 4 - Expected outcome
+ You should get a list of similar proteins to your sequence (possibly homologues) that may give you an idea of the protein you are dealing with. However, should you not find anything or have terrible matches, it is possible you selected the wrong ORF and will need to go back to step (3) (but it also may be an undiscovered/undocumented protein). From here you can note down/save any links to high matching homologues if you wish to investigate them further in later stages. For our CASP protein we found homologues in other CASP1 sequences (including arabidopsis) but domain information was uncharacterized. We found that our mystery protein was similar to LINE-1 retrotransposable element ORF2 protein in humans (so we noted this down and used this to aid our search for structures to compare to in step8).

---
> ## 5 - construct 3D models with Alphafold 
+ Using the protein sequence deduced by ORF finder in step (3), you can then use Alphafold to structure your proteins in 3D for analysis. This step may take some time so the sooner you start the better! First you will need to access Alphafold colab online notebook (link listed below). Paste in your protein sequence e.g. the protein1 diploid protein sequence. Give your job a memorable name, for ours we termed them <ProteinName>_<diploid/tetraploid>. Select the appropriate save settings e.g. "save_all" or "save_to_google_drive". We only ticked "save_all". You can then click at the top hotbar of the webpage that says "Runtime" then click "Run all".

---
> ## 5.1 Files (input)
+ protein_sequences.txt

---
> ## 5- Software needed
+ website for Alphafold hosting - https://colab.research.google.com/github/sokrypton/ColabFold/blob/main/AlphaFold2.ipynb

---
> ## 5- Expected outcome
+ We obtain a zip file containing the models and graphs for each sequence we entered. From these we could take the rank 1 pdb model for each protein sequence (best prediction), copy it out and rename it appropriately (shown in output files).

---
> ## 5.4 Files (output)
+ alphafold_rank1_CASP1_diploid.pdb
+ alphafold_rank1_CASP1_tetraploid.pdb
+ alphafold_rank1_mystery_diploid.pdb
+ alphafold_rank1_mystery_tetraploid.pdb

---
> ## 6 search for crystal structures
+ Whilst the alphafold was running we searched the web using the same input protein sequences to find homologues in protein databases for structural comparison, mainly through the protein database(pdb).

---
> ## 6.1 Files (input)
+ protein_sequences.txt

---
> ## 6 - Software needed
+ website for protein searching - https://www.rcsb.org/

---
> ## 6- Expected outcome
+ For CASP_1 we found no crystal structures. However, when enabling computer generated models we found similar models to our own alphafold model, but with no attached papers and no information on domains/key residues. For our unknown protein we found similar structures in humans (8SXU) and followed the link to their paper. 8SXU only supplied a model from around 245aa onwards so we needed another protein model to fit to the start of our protein. For this we used 7n8s which is an L1-EN domain from human L1 retrotransposon in humans.

---
> ## 6 - Files (output)
+ 8SXU paper link for mystery protein -
+ ??? paper link for mystery protein

+ Files from 8SXU protein structure :
  + fasta sequence - rcsb_pdb_8SXU.fasta 
  + stucture file - 8sxu.pdb 

---
> ## 7 - Perform clustal Omega alignment
+ We found one well annotated homologue in humans in the pdb termed 8SXU. Taking the fasta file and pdb file of this protein structure we used clustal omega to align our reference, diploid, tetraploid and homologue in humans all together in one alignment.

---
> ## 7.1 - Files (Input)
+ homologue fasta sequence- rcsb_pdb_8SXU.fasta 
+ our protein sequences - protein_sequences.txt
	
---
> ## 7.2 - Software needed
+ clustal omega website - 
+ jalview application -

---
> ## 7.3 - Expected outcome
+ We obtained an alignment between the four sequences which was able to tell us the highly conserved regions as well as give us a direct sequence to sequence comparison of our proteins (diploid and tetraploid) vs the homologue in the paper. This would allow us to map mutations and functions described in the paper onto our protein as potential changes of function.....

---
> ## 7.4 - Files (Output)
+ CASP protein alignment- Casp.aln
+ Mystery protein alignment (containing 8sxu aligned to both diploid and tetraploid versions of our mystery protein) - Mystery.aln

---
> ## 8 - Model protein pdb in PYMOL
+ Once the protein structure prediction has finished, take the pdb files and input them into a structural visualisation app, in our case we used PYMOL. From here we were able to label and colour our structure as well as compare it to other homologues to discern any differences in functon that may be occuring between diploid and tetraploid species.

---
> ## 8.1 - Files (input)
+ alphafold_rank1_CASP1_diploid.pdb
+ alphafold_rank1_CASP1_tetraploid.pdb
+ any_PDB_we_find_for_casp1.pdb

+ alphafold_rank1_mystery_diploid.pdb
+ alphafold_rank1_mystery_tetraploid.pdb
+ 8sxu.pdb

---
> ## 8.2 - Software needed
App for visualising proteins in 3D - PYMOL V2.5.8

---
> ## 8.3 - Expected output
By following the code in PYMOL_code.txt

---
> ## 8.4 - Files (output)
png files for figures
	




















