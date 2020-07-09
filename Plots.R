load("errbs5916_site_coverage_mat")
small_matrix_4 <- no_nas_errbs5916[1:1000000, 1:2] #create smaller matrix of first 1 million rows and first 2 samples
two_columns_4 <- as_tibble(small_matrix_4) %>% gather(Sample, Cpg.Coverage) %>% filter(Cpg.Coverage >=10)
#put this data into two columns "Sample" and "Cpg.Coverage" and filter it for at least 10x coverage
ggplot(two_columns_4, aes(x=Cpg.Coverage, color = Sample)) + geom_density() + xlim(c(0,1000))
#density plot of the CpG coverage of the first two samples/columns of errbs5916; most sites are covered 0-250x.

small_matrix_1 <- no_nas_errbs5916[1:1000000, 1:10] #make a smaller matrix from errbs5916
#this matrix contains the first one million rows and the first ten samples
two_columns <- as_tibble(small_matrix_1) %>% gather(Sample, Cpg.Coverage)
#put this data into two columns "Sample" and "Cpg.Coverage" by making it a tibble and using the gather function
ggplot(two_columns, aes(x=Sample, y=Cpg.Coverage)) + geom_boxplot(outlier.size = -1) + coord_flip(ylim = c(0,500))
#make a ggplot with this data, using Sample as independent variable and Cpg.Coverage as dependent variable
#the geom_boxplot function makes the ggplot a boxplot, and you can give the size of outliers
#coord_flip rotates the boxplot and sets the domain for CpG.Coverage
#From the boxplots, we can see the median CpG coverage in most of the 10 samples is between 100 and 200 