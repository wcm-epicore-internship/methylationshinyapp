#ADDING CG SITE AS A COLUMN TO ALL RRBS DATA TIBBLES
rrbs5910.df <- as.data.frame(rrbs5910_site_coverage_mat) #make rrbs5910_site_coverage_mat a data frame
rrbs5910_CG_sites <- rownames_to_column(rrbs5910.df, var = "Site") %>% as_tibble() #make a tibble with row name (CG site) as a column
rrbs6071.df <- as.data.frame(rrbs6071_site_coverage_mat) #make rrbs6071_site_coverage_mat a data frame
rrbs6071_CG_sites <- rownames_to_column(rrbs6071.df, var = "Site") %>% as_tibble() #make a tibble with row name (CG site) as a column
rrbs6125.df <- as.data.frame(rrbs6125_site_coverage_mat) #make rrbs6125_site_coverage_mat a data frame
rrbs6125_CG_sites <- rownames_to_column(rrbs6125.df, var = "Site") %>% as_tibble() #make a tibble with row name (CG site) as a column 

#BIND ALL RRBS DATA TOGETHER
rrbs_binded <- full_join(rrbs5910_CG_sites, rrbs6071_CG_sites, by = NULL, copy = FALSE)
rrbs_binded2 <- full_join(rrbs_binded, rrbs6125_CG_sites, by = NULL, copy = FALSE) 
rrbs <- rrbs_binded2 %>% gather(Sample, Coverage, 2:47, convert = FALSE) %>% filter(Coverage >= 10)
#this tibble has site, sample, and coverage, filtered for 10x, and the NAs were removed automatically

#GROUP BY SITES AND COUNT NUMBER OF SAMPLES PER SITE AND MEAN COVERAGE PER SITE IN RRBS
r <- rrbs %>% group_by(Site) %>% summarize(Count_rrbs=n(), mean.cov_rrbs=mean(Coverage))
#group by site and count the number of samples that cover each and mean coverage of each

#ADDING CG SITE AS A COLUMN TO ALL ERRBS DATA TIBBLES
errbs5916.df <- as.data.frame(errbs5916_site_coverage_mat) #make errbs5916_site_coverage_mat a data frame
errbs5916_CG_sites <- rownames_to_column(errbs5916.df, var = "Site") %>% as_tibble() %>% gather(Sample, Coverage, 2:46,
   convert = FALSE) %>% filter(Coverage >= 10)
#make a tibble with row name (CG site) as a column, gather by sample and coverage, filter for 10x
errbs5975.df <- as.data.frame(errbs5975_site_coverage_mat) #make errbs5975_site_coverage_mat a data frame
errbs5975_CG_sites <- rownames_to_column(errbs5975.df, var = "Site") %>% as_tibble() %>% gather(Sample, Coverage, 2:41,
    convert = FALSE) %>% filter(Coverage >= 10)
#make a tibble with row name (CG site) as a column, gather by sample and coverage, filter for 10x
errbs6121.df <- as.data.frame(errbs6121_site_coverage_mat) #make errbs6121_site_coverage_mat a data frame
errbs6121_CG_sites <- rownames_to_column(errbs6121.df, var = "Site") %>% as_tibble() %>% gather(Sample, Coverage, 2:41,
    convert = FALSE) %>% filter(Coverage >= 10)
#make a tibble with row name (CG site) as a column, gather by sample and coverage, filter for 10x

#BIND ALL ERRBS DATA TOGETHER
errbs_binded <- bind_rows(errbs5916_CG_sites, errbs5975_CG_sites) 
errbs_binded2 <- bind_rows(errbs_binded, errbs6121_CG_sites) 

#GROUP BY SITES AND COUNT NUMBER OF SAMPLES PER SITE AND MEAN COVERAGE PER SITE IN ERRBS
e <- errbs_binded2 %>% group_by(Site) %>% summarize(Count_errbs=n(), mean.cov_errbs=mean(Coverage))
#group by site and count the number of samples that cover each and mean coverage of each

#ADDING % OF SAMPLES COLUMN TO R AND E
r <- r %>% mutate(Percent.rrbs=Count_rrbs/46*100) #There are 46 total samples for rrbs
e <- e %>% mutate(Percent.errbs=Count_errbs/125*100) #There are 125 total samples for errbs

#FILTERING FOR 90% IN R AND E
rrbs_90 <- r %>% filter(r$Percent.rrbs >= 90)
nrow(rrbs_90) #there are 2,694,292 sites covered ≥10x by ≥90% of samples in RRBS
errbs_90 <- e %>% filter(e$Percent.errbs >= 90)
nrow(errbs_90) #there are 2,378,895 sites covered ≥10x by ≥90% of samples in ERRBS

#MAKING OVERLAP PLOT (VENN DIAGRAM)
install.packages("ggVennDiagram")
library(ggVennDiagram)

rrbs90 <- as.list(rrbs_90$Site)
errbs90 <- as.list(errbs_90$Site)
x <- list(RRBS=rrbs90, ERRBS=errbs90)
ggVennDiagram(x)
#There are 517,347 sites that are covered ≥10x by ≥90% of samples ONLY IN RRBS
#There are 201,950 sites that are covered ≥10x by ≥90% of samples ONLY IN ERRBS
#There are 2,176,945 sites that are covered ≥10x by ≥90% of samples in BOTH RRBS AND ERRBS (overlap)

#MAKING OVERLAP PLOT (UPSET PLOT)
install.packages("UpSetR")
library(UpSetR)
upset(fromList(x), sets.bar.color = c("blue","pink"), main.bar.color = c("blue", "pink", "gray"), set_size.show = TRUE, 
      set_size.scale_max= 4e+06)