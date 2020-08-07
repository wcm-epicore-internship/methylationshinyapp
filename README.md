## Overview
To develop an R Shiny app to facilitate the visualization and comparitive analysis of DNA methylation data obtained from Next Generation Sequencing of ERRBS and RRBS assays.

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

## Description of the files

#### Basic metrics plots
- "Plots markdown.pdf" contains the basic metrics plots.
- "Basic metrics plots-markdown.Rmd" is the R markdown file used to create the PDF of the basic metrics plots.
- "Code for basic metrics plots.R" provides the code used to create the basic metrics plots.
- "all_projects.sample_count_mean.rda" contains all the ≥10x RRBS and ERRBS data binded together with sample, count, mean, and project columns for each site.
- "all_projects.sample_count_mean_5x.rda" contains all the ≥5x RRBS and ERRBS data binded together with sample, count, mean, and project columns for each site.
- "errbs5916_first_two_samples_10x_noNA.rda" contains the ≥10x data for the first two samples of the errbs5916 project, which was used in a density plot that compared the CG coverage between these two samples.
- "errbs5916_first_ten_samples_10x_noNA.rda" contains the ≥10x data for the first ten samples of the errbs5916 project, which was used in a set of boxplots that compared the CG coverage among these ten samples.

#### Overlap plots
- "Overlap plots markdown.pdf" contains the overlap plots.
- "Overlap plots markdown.Rmd" is the R markdown file used to create the PDF of the overlap plots.
- "Code for overlap plots.R" provides the code used to create the overlap plots.
- "rrbs_90.rda" contains the ≥10x data for all RRBS sites covered by ≥90% of all RRBS samples. There are site, count, mean coverage, and percent.rrbs (percent of RRBS samples that covered each site) columns for each site.
- "errbs_90.rda" contains the ≥10x data for all ERRBS sites covered by ≥90% of all ERRBS samples. There are site, count, mean coverage, and percent.rrbs (percent of ERRBS samples that covered each site) columns for each site.

## To do
- Create a Shiny app for interactive visual comparison of the data.

## Useful Links
- [GitHub and RStudio](https://resources.github.com/whitepapers/github-and-rstudio/)
- [Shiny from RStudio](https://shiny.rstudio.com/)
- [RRBS - Epigenomics Core website](https://epicore.med.cornell.edu/services.php?option=rrbsdescription#seq)
- [R for Data Science](https://r4ds.had.co.nz/)

