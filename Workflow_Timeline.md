# Introduction
We have been assigned two proteins from a selection scan that showed positive selection in tetraploid Cochleria officinalis compared to the diploid Cochlearia pyrenica. The task we have is to analyse the differences in these two key proteins between two species of cochleria (diploid and tetraploid) to uncover any differences within them that may lead to this positive selection. In summary, we start with some sequence data of these species and hope to end up with structural data that we can interpret visually, and through scientific studies, to compare and contrast the proteins in both diploid and tetraploid states.

---
# Timeline

> ##  1 - Find genes in reference file
+ We begin with the files listed below (step 1.1) and search the gff3 file with the gene IDs given in the pdf file names (g38026 and g32580 for our CASP1 and mystery gene respectively). These can be searched for in any text editor with a search function.

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
+ By doing this on MAC or WINDOWS machines with the suggested text editors, we find a row which shows the ID being equal to our search, and the label of "gene" with the appropriate start and end positions. 
These positions of each gene (for each protein) can be noted down for the next stage of analysis.

---
> ## 2 - Consensus sequence creation
+ We then need to create a consensus sequence of the Cochleria species (both diploid and tetraploid) at the specified gene locations we just uncovered.
The steps for this analysis are outlined in the code files Windows_Method.sh or MAC_Method.sh.

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
+ accession info in file References_and_info.md
---
> ## 3.3 - expected outcome
+ We get a highlighted output that will show each reading frame of each direction of the newly translated sequence (into amino acids).
+ We selected the most appropriate reading frame from this stage for further analysis. We picked the largest and cleanest reading frames that when BLASTed in step4 (the next step) were identified as proteins. We saved the outputs into one file "protein_sequences.txt". For CASP1 we pasted orf8 and orf9 together but for the unknown protein we just pasted in the whole of orf1.

---
> ## 3.4 - Files (output)
+ protein_sequences.txt

---
> ## 4 - pBLAST orfs from step 3
+ Taking the most appropriate reading frames from your proteins you can then (from the same website) run a protein BLAST search to get an idea of the potential proteins you are dealing with. Ensure you select the correct protein database (we used Swissprot and non-redundant protein sequences). 

---
> ## 4.1 - Files (input)
+ protein_sequences.txt

---
> ## 4.2 Software needed
+ website for ORF finding - https://www.ncbi.nlm.nih.gov/orffinder/
  + See References_and_info.md for accession info
+ website for protein BLAST - https://blast.ncbi.nlm.nih.gov/Blast.cgi
  + See References_and_info.md for accession info
---
> ## 4.3 Expected outcome
+ You should get a list of similar proteins to your sequence (possibly homologues) that may give you an idea of the protein you are dealing with. However, should you not find anything or have terrible matches, it is possible you selected the wrong ORF and will need to go back to step3 (but it also may be an undiscovered/undocumented protein). From here you can note down/save any links to high matching homologues if you wish to investigate them further in later stages. For our CASP protein we found homologues in other CASP1 sequences (including arabidopsis) but domain information was uncharacterized. We found that our mystery protein was similar to LINE-1 retrotransposable element ORF2 protein in humans, from positions 10-237; we noted this down and used this to aid our search for structures to compare to in step8. It was also similar to Rnase_H_like domain but at different positions, 462-582.

---
> ## 5 - construct 3D models with Alphafold 
+ Using the protein sequence deduced by ORF finder in step (3), you can then use Alphafold to structure your proteins in 3D for analysis. This step may take some time so the sooner you start the better! First you will need to access Alphafold colab online notebook (link listed below). Paste in your protein sequence e.g. the protein1 diploid protein sequence. Give your job a memorable name, for ours we termed them <ProteinName>_<diploid/tetraploid>. Select the appropriate save settings e.g. "save_all" or "save_to_google_drive". We only ticked "save_all". You can then click at the top hotbar of the webpage that says "Runtime" then click "Run all".

---
> ## 5.1 Files (input)
+ protein_sequences.txt (specific sequences)

---
> ## 5.2- Software needed
+ website for Alphafold hosting - https://colab.research.google.com/github/sokrypton/ColabFold/blob/main/AlphaFold2.ipynb
+ Accession info in References_and_info.md

---
> ## 5.3- Expected outcome
+ We obtain a zip file containing the models and graphs for each sequence we entered. From these we could take the rank 1 pdb model for each protein sequence (best prediction), copy it out and rename it appropriately (shown in output files below).

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
> ## 6.2 - Software needed
+ website for protein searching - https://www.rcsb.org/
+ Accession info in References_and_info.md
---
> ## 6.3- Expected outcome
+ For CASP_1 we found no crystal structures. However, when enabling computer generated models we found similar models to our own alphafold model, but with no attached papers and no information on domains/key residues. For our unknown protein we found similar structures in humans (8SXU and 8SXT) and followed the link to their paper. 8SXT only supplied a model from around 245aa onwards so we needed another protein model to fit to the start of our protein. For this we used 7n8s which is an L1-EN domain from human L1 retrotransposon in humans, and was similar to our protein from regions 10-237, roughly matching the area we were missing.

---
> ## 6.4 - Files (output)
+ We saved the links to the papers for both structures of:
  + 8SXT  
  + 7n8s 

+ Files from 8SXT protein structure :
  + fasta sequence - rcsb_pdb_8SXT.fasta 
  + stucture file - 8sxt.pdb 

+ Files from 7n8s protein structure :
  + fasta sequence - rcsb_pdb_7n8s.fasta 
  + stucture file - 7n8s.pdb 

---
> ## 7 - Perform clustal Omega alignment
+ We found two well annotated homologues in humans in the pdb termed 8SXU and 8SXT. Taking the fasta file and pdb file of 8SXT protein structure we used clustal omega to align our reference, diploid, tetraploid and homologue in humans all together in one alignment.

---
> ## 7.1 - Files (Input)
+  rcsb_pdb_8SXT.fasta 
   +  homologue fasta sequence-
+ protein_sequences.txt
  + our diploid and tetraploid sequences
+ C_excelsa_V5.fasta
  + reference genome sequence to Arabidopsis Thaliana
	
---
> ## 7.2 - Software needed
+ clustal omega website - https://www.ebi.ac.uk/jdispatcher/msa/clustalo
  + see References_and_info.md
+ jalview application - https://www.jalview.org/download/
  + References_and_info.md

---
> ## 7.3 - Expected outcome
+ We obtained an alignment between the four sequences which was able to tell us the highly conserved regions as well as give us a direct sequence to sequence comparison of our proteins (diploid and tetraploid) vs the homologue in the paper. This would allow us to map mutations and functions described in the paper onto our protein as potential changes of function.....

---
> ## 7.4 - Files (Output)
+ CASP protein alignment- Casp.aln
  + FIGURE 1
+ Mystery protein alignment (containing 8sxt aligned to both diploid and tetraploid versions of our mystery protein) - Mystery.aln
  + FIGURE 2

---
> ## 8 - Model protein pdb in PYMOL
+ Once the protein structure prediction has finished, take the pdb files and input them into a structural visualisation app, in our case we used PYMOL. From here we were able to label and colour our structure as well as compare it to other homologues to discern any differences in functon that may be occuring between diploid and tetraploid species.

---
> ## 8.1 - Files (input)
+ alphafold_rank1_mystery_diploid.pdb
+ alphafold_rank1_mystery_tetraploid.pdb
+ 8sxt.pdb
+ 7n8S.pbd
+ color_h.py script (written by Dr S Bray) see References_and_info.md
+ pymol_code_Yasmin.txt
---
> ## 8.2 - Software needed
+ App for visualising proteins in 3D (PYMOL V2.5.8)
  + see References_and_info.md
+ Website for visualising the charge (if apbs plugin in PYMOL doesnt work)
  + APBS site- https://server.poissonboltzmann.org
+ Python installed onto your machine for running the color_h.py script in PYMOL
  + see References_and_info.md for version
---
> ## 8.3 - Expected output
By following the code in pymol_code_Yasmine.txt you will have all necessary outputs for structure figures in the writeup. This script also details the instructions to view the Protein charge using the APBS website.
Features of these figures include:
+ Alignment of diploid and tetraploid versions of the proteins to 8sxt and 7n8s
+ Residue highlighting at differences between diploid and tetraploids
+ Highlighting of important domains on both 8sxt and 7n8s
+ Highlighting of conserved regions around the mutations
+ Distance measurements between mutated and conserved residues
+ Hydrophobicity inspection
+ Protein charge inspection (website instructions at end of pymold_code_Yasmin.txt)

---
> ## 8.4 - Files (output)
+ Image files for figures of the 3D protein models (either by screenshotting or saving as image)
  + (FIGURE 3 onwards)
	




















