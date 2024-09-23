# import libraries
library("tidyr")
library("dplyr")
library("readr")

mortality <- function(file){
  
  
}

# import data
mm <- read_csv("original/maternalmortality.csv")

# pivot table
mm_sub <- select(mm, c("Country Name", "2000":"2019")) %>% 
  pivot_longer(cols = "2000":"2019")

# change col names
colnames(mm_sub) <- c("Country.name", "year", "MatMor")

# force year as integers
mm_sub$year <- as.numeric(mm_sub$year)
