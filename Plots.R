library(tidyverse)
load("errbs5916_site_coverage_mat")
small_matrix_4 <- errbs5916_site_coverage_mat[1:1000000, 1:2] #create smaller matrix of first 1 million rows and first 2 samples
two_columns_4 <- as_tibble(small_matrix_4) %>% gather(Sample, Cpg.Coverage) %>% drop_na() %>% filter(Cpg.Coverage >=10)
#put this data into two columns "Sample" and "Cpg.Coverage," drop NAs, filter it for at least 10x coverage
ggplot(two_columns_4, aes(x=Cpg.Coverage, color = Sample)) + geom_density() + xlim(c(0,1000))
#density plot of the CpG coverage of the first two samples/columns of errbs5916; most sites are covered 0-250x.
save(two_columns_4, file = "errbs5916_first_two_samples_10x_noNA.rda") #make the data easier to load

small_matrix_1 <- errbs5916_site_coverage_mat[1:1000000, 1:10] #make a smaller matrix from errbs5916
#this matrix contains the first one million rows and the first ten samples
two_columns <- as_tibble(small_matrix_1) %>% gather(Sample, Cpg.Coverage) %>% drop_na() %>% filter(Cpg.Coverage >=10)
#put this data into two columns "Sample" and "Cpg.Coverage" by making it a tibble and using the gather function
#drop NAs and filter for 10x coverage
ggplot(two_columns, aes(x=Sample, y=Cpg.Coverage)) + geom_boxplot(outlier.size = -1) + coord_flip(ylim = c(0,500))
#make a ggplot with this data, using Sample as independent variable and Cpg.Coverage as dependent variable
#the geom_boxplot function makes the ggplot a boxplot, and you can give the size of outliers
#coord_flip rotates the boxplot and sets the domain for CpG.Coverage
#From the boxplots, we can see the median CpG coverage in most of the 10 samples is between 0 and 200 
save(two_columns, file = "errbs5916_first_ten_samples_10x_noNA.rda") #make the data easier to load

library(tidyverse)
rrbs5910_10x_noNA <- rrbs5910 %>% gather(Sample, Cpg.Coverage) %>% drop_na() %>% filter(Cpg.Coverage >=10) 
rrbs6071_10x_noNA <- rrbs6071 %>% gather(Sample, Cpg.Coverage) %>% drop_na() %>% filter(Cpg.Coverage >=10) 
rrbs6125_10x_noNA <- rrbs6125 %>% gather(Sample, Cpg.Coverage) %>% drop_na() %>% filter(Cpg.Coverage >=10) 
errbs6121_10x_noNA <- errbs6121 %>% gather(Sample, Cpg.Coverage) %>% drop_na() %>% filter(Cpg.Coverage >=10)
errbs5975_10x_noNA <- errbs5975 %>% gather(Sample, Cpg.Coverage) %>% drop_na() %>% filter(Cpg.Coverage >=10) 
errbs5916_10x_noNA <- errbs5916 %>% gather(Sample, Cpg.Coverage) %>% drop_na() %>% filter(Cpg.Coverage >=10) 

test1 <- rrbs5910_10x_noNA %>% group_by(Sample) %>% summarize(Count=n(), Mean=mean(Cpg.Coverage)) %>% 
  mutate(Project=rep("rrbs5910", length(Sample)))
test1
#This created a separate project column next to the sample, count, and mean columns for rrbs5910
#This new column will be helpful for when we join all of this and we'll know which came from rrbs5910, and others, etc.

test2 <- rrbs6071_10x_noNA %>% group_by(Sample) %>% summarize(Count=n(), Mean=mean(Cpg.Coverage)) %>%
  mutate(Project=rep("rrbs6071", length(Sample)))
test2
#This created a separate project column next to the sample, count, and mean columns for rrbs6071

test3 <- rrbs6125_10x_noNA %>% group_by(Sample) %>% summarize(Count=n(), Mean=mean(Cpg.Coverage)) %>%
  mutate(Project=rep("rrbs6125", length(Sample)))
test3
#This created a separate project column next to the sample, count, and mean columns for rrbs6125

test4 <- errbs5916_10x_noNA %>% group_by(Sample) %>% summarize(Count=n(), Mean=mean(Cpg.Coverage)) %>%
  mutate(Project=rep("errbs5916", length(Sample)))
test4
#This created a separate project column next to the sample, count, and mean columns for errbs5916

test5 <- errbs5975_10x_noNA %>% group_by(Sample) %>% summarize(Count=n(), Mean=mean(Cpg.Coverage)) %>%
  mutate(Project=rep("errbs5975", length(Sample)))
test5

test6 <- errbs6121_10x_noNA %>% group_by(Sample) %>% summarize(Count=n(), Mean=mean(Cpg.Coverage)) %>%
  mutate(Project=rep("errbs6121", length(Sample)))
test6

#Bind test1, test2, test3, test4, test5, test6
p <- bind_rows(test1, test2, test3, test4, test5, test6)
p
ggplot(p, aes(x=Project, y=Count)) + geom_boxplot() + coord_flip()
#Boxplots of each project, comparing their numbers of CpG sites with at least 10x coverage
save(p, file = "all_projects.sample_count_mean.rda")

ggplot(p, aes(x=Project, y=Mean)) + geom_boxplot() + coord_flip()
#Boxplots of each project, comparing their mean CpG coverage with at least 10x coverage
