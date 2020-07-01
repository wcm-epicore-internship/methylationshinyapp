## Overview
To develop an R Shiny app for to facilitate the visualization and comparitive analysis of DNA methylation data obtained from Next Generation Sequencing of ERRBS and RRBS assays.

- Percentage overlap of CpG sites across ERRBS and RRBS experiments (definition, visualization, code)
- Data analysis steps - aggregate datasets (ERRBS, RRBS); Filter data (for 10x); Code visualization plots in R; Document here

## Background
  DNA methylation, the addition of methyl groups to a DNA molecule, is commonly known to control gene expression by repressing transcription. The methylation of a DNA segment may change the segment’s activity, and it is involved in a wide variety of processes like normal development, genomic imprinting, X-chromosome inactivation, and aging. Most mammalian DNA methylation occurs at CpG sites, which are regions of DNA with a cytosine nucleotide followed by a guanine nucleotide on the same strand. Specifically, methylation at CpG sites occurs in the cytosine. CpG islands are genomic regions where CpG sites occur at high frequencies, and the methylation of CpG islands are associated with repressing nearby genes. 
  Protocols such as RRBS and ERRBS are used to study methylation patterns of genomes. In these experiments, fragmented DNA treated with bisulfite is sequenced in order to identify CpG sites. Bisulfite treatment helps distinguish methylated cytosines from unmethylated cytosines. The reaction of an unmethylated cytosine with bisulfite causes that cytosine to convert to a uracil, whereas methylated cytosines are protected from conversion. In DNA sequencing, a fragment that begins with a C would indicate methylation, and a fragment that begins with a T would be unmethylated. 
  A variety of genomic data can be collected from RRBS and ERRBS, so this shiny app will focus on comparing the coverage provided by both protocols, using the hg19 human genome as a reference. After a genome undergoes fragmentation and DNA sequencing, the base pair sequences produced constitute a set of reads. Sequence coverage is a measure of redundancy and coverage depth, as it is the number of unique reads that contain a given nucleotide. Sequence coverage is different from percentage coverage, which measures the breadth of coverage of the reference genome by a DNA sample. ERRBS tends to produce a greater breadth of coverage than RRBS since ERRBS is an enhanced RRBS protocol, generating more extensive and improved coverage of CpG sites. This shiny app will focus on the overlap and differences between sequence coverage values produced by RRBS and ERRBS experiments.

## Making density plots and histograms of errbs5916 data with at least 10x coverage
```
small_matrix_4 <- no_nas_errbs5916[1:1000000, 1:2] #create smaller matrix of first 1 million rows and first 2 samples

two_columns_4 <- as_tibble(small_matrix_4) %>% gather(Sample, Cpg.Coverage) %>% filter(Cpg.Coverage >=10)
#put this data into two columns "Sample" and "Cpg.Coverage" and filter it for at least 10x coverage

ggplot(two_columns_4, aes(x=Sample)) + geom_density(color="red", fill="green") 
#Density plot of coverage of first 2 samples of the first 1 million rows of errbs5916 with at least 10x coverage

ggplot(two_columns_4, aes(x=Sample, y=Cpg.Coverage)) + geom_boxplot() + coord_flip(ylim = c(0,500))
#Boxplot of coverage (0-200) of first 2 samples of the first 1 million rows of errbs5916 with at least 10x coverage
```

## Roadmap
- Research Shiny apps and Github.
- Research the difference between ERRBS and RRBS methylation data.
- Describe the data for this project and define scientific objectives comparing and for visualizing this data.
- Create a Shiny app for interactive visual comparison of the data.

## Useful Links
- [GitHub and RStudio](https://resources.github.com/whitepapers/github-and-rstudio/)
- [Shiny from RStudio](https://shiny.rstudio.com/)
- [RRBS - Epigenomics Core website](https://epicore.med.cornell.edu/services.php?option=rrbsdescription#seq)
- [R for Data Science](https://r4ds.had.co.nz/)

