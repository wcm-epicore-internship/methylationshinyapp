rrbs5910.df <- as.data.frame(rrbs5910_site_coverage_mat) #make rrbs5910_site_coverage_mat a data frame
rrbs5910_CG_sites <- rownames_to_column(rrbs5910.df, var = "Site") %>% as_tibble() #make a tibble with row name (CG site) as a column
rrbs6071.df <- as.data.frame(rrbs6071_site_coverage_mat) #make rrbs6071_site_coverage_mat a data frame
rrbs6071_CG_sites <- rownames_to_column(rrbs6071.df, var = "Site") %>% as_tibble() #make a tibble with row name (CG site) as a column
rrbs6125.df <- as.data.frame(rrbs6125_site_coverage_mat) #make rrbs6125_site_coverage_mat a data frame
rrbs6125_CG_sites <- rownames_to_column(rrbs6125.df, var = "Site") %>% as_tibble() #make a tibble with row name (CG site) as a column 
rrbs_binded <- full_join(rrbs5910_CG_sites, rrbs6071_CG_sites, by = NULL, copy = FALSE)
rrbs_binded2 <- full_join(rrbs_binded, rrbs6125_CG_sites, by = NULL, copy = FALSE) 
rrbs <- rrbs_binded2 %>% gather(Sample, Coverage, 2:47, convert = FALSE) %>% filter(Coverage >= 10)
#this tibble has site, sample, and coverage, filtered for 10x, and the NAs were removed automatically
r <- rrbs %>% group_by(Site) %>% summarize(Count_rrbs=n())
#group by site and count the number of samples that cover each

errbs5916.df <- as.data.frame(errbs5916_site_coverage_mat) #make errbs5916_site_coverage_mat a data frame
errbs5916_CG_sites <- rownames_to_column(errbs5916.df, var = "Site") %>% as_tibble() #make a tibble with row name (CG site) as a column
errbs5975.df <- as.data.frame(errbs5975_site_coverage_mat) #make errbs5975_site_coverage_mat a data frame
errbs5975_CG_sites <- rownames_to_column(errbs5975.df, var = "Site") %>% as_tibble() #make a tibble with row name (CG site) as a column
errbs6121.df <- as.data.frame(errbs6121_site_coverage_mat) #make errbs6121_site_coverage_mat a data frame
errbs6121_CG_sites <- rownames_to_column(errbs6121.df, var = "Site") %>% as_tibble() #make a tibble with row name (CG site) as a column
errbs_binded <- full_join(errbs5916_CG_sites, errbs5975_CG_sites, by = NULL, copy = FALSE)
errbs_binded2 <- full_join(errbs_binded, errbs6121_CG_sites, by = NULL, copy = FALSE) 
errbs <- errbs_binded2 %>% gather(Sample, Coverage, 2:126, convert = FALSE) %>% filter(Coverage >= 10) 
#This did not work, I got the error for more than 2^31 rows
#I also tried this line with %>% drop_na(), but that didn't work either, I got the same error

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
errbs_binded <- full_join(errbs5916_CG_sites, errbs5975_CG_sites, by = NULL, copy = FALSE)
errbs_binded2 <- full_join(errbs_binded, errbs6121_CG_sites, by = NULL, copy = FALSE) 
#creating errbs_binded worked, but R Studio crashed when I tried to run the errbs_binded2 line
