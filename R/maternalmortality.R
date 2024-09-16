# import libraries
library("tidyr")
library("dplyr")
library("readr")

# import data
mm <- read_csv("original/maternalmortality.csv")

mm_sub <- select(mm, c("Country Name", "2000":"2019")) %>% 
  pivot_longer(cols = 2:21) 

colnames(mm_sub) <- c("Country.name", "year", "MatMor")
