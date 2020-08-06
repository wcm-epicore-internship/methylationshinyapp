## Overview
To develop an R Shiny app for to facilitate the visualization and comparitive analysis of DNA methylation data obtained from Next Generation Sequencing of ERRBS and RRBS assays.

## Background
  DNA methylation, the addition of methyl groups to a DNA molecule, is commonly known to control gene expression by repressing transcription. The methylation of a DNA segment may change the segment’s activity, and it is involved in a wide variety of processes like normal development, genomic imprinting, X-chromosome inactivation, and aging. Most mammalian DNA methylation occurs at CpG sites, which are regions of DNA with a cytosine nucleotide followed by a guanine nucleotide on the same strand. Specifically, methylation at CpG sites occurs in the cytosine. CpG islands are genomic regions where CpG sites occur at high frequencies, and the methylation of CpG islands are associated with repressing nearby genes. 
  Protocols such as RRBS and ERRBS are used to study methylation patterns of genomes. In these experiments, fragmented DNA treated with bisulfite is sequenced in order to identify CpG sites. Bisulfite treatment helps distinguish methylated cytosines from unmethylated cytosines. The reaction of an unmethylated cytosine with bisulfite causes that cytosine to convert to a uracil, whereas methylated cytosines are protected from conversion. In DNA sequencing, a fragment that begins with a C would indicate methylation, and a fragment that begins with a T would be unmethylated. 
  A variety of genomic data can be collected from RRBS and ERRBS, so this shiny app will focus on comparing the coverage provided by both protocols, using the hg19 human genome as a reference. After a genome undergoes fragmentation and DNA sequencing, the base pair sequences produced constitute a set of reads. Sequence coverage is a measure of redundancy and coverage depth, as it is the number of unique reads that contain a given nucleotide. Sequence coverage is different from percentage coverage, which measures the breadth of coverage of the reference genome by a DNA sample. ERRBS tends to produce a greater breadth of coverage than RRBS since ERRBS is an enhanced RRBS protocol, generating more extensive and improved coverage of CpG sites. This shiny app will focus on the overlap and differences between sequence coverage values produced by RRBS and ERRBS experiments.
  
## Procedure

#### Basic metrics plots (≥10x coverage)
- Filtered each RRBS and ERRBS project for ≥10x coverage, grouped by sample, counted the number of CG sites and mean CG coverage for each project, and binded all projects together by row.
- Made boxplots and scatterplots to compare each project's number of CG units. In each graph, the median number of CG sites is indicated.
- Made boxplots and scatterplots to compare each project's mean CG coverage. In each graph, the median number of CG sites is indicated.


#### Basic metrics plots (≥5x coverage)
- Filtered each RRBS and ERRBS project for ≥5x coverage, grouped by sample, counted the number of CG sites and mean CG coverage for each project, and binded all projects together by row.
- Made boxplots and scatterplots to compare each project's number of CG units. In each graph, the median number of CG sites is indicated.
- Made boxplots and scatterplots to compare each project's mean CG coverage. In each graph, the median number of CG sites is indicated.


#### Overlap plots (RRBS vs. ERRBS coverage)
- Joined all RRBS data by site, filtered for ≥10x coverage, grouped by site, and counted the number of samples per site.
- Filtered all ERRBS data for ≥10x coverage, binded all ERRBS data by row, grouped by site, and counted the number of samples per site.
- Added a column to the RRBS and ERRBS datasets that calculated the percent of samples that covered each site.
- Filtered the RRBS and ERRBS datasets for sites that were covered by ≥90% of all RRBS or ERRBS samples.
- Made a venn diagram and an upset plot to compare the overlap of sites covered by ≥90% of RRBS vs. ERRBS samples.

## To do
- Create a Shiny app for interactive visual comparison of the data.

## Useful Links
- [GitHub and RStudio](https://resources.github.com/whitepapers/github-and-rstudio/)
- [Shiny from RStudio](https://shiny.rstudio.com/)
- [RRBS - Epigenomics Core website](https://epicore.med.cornell.edu/services.php?option=rrbsdescription#seq)
- [R for Data Science](https://r4ds.had.co.nz/)

