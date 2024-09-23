# import libraries
library("tidyr")
library("dplyr")
library("readr")
library("purrr")
library("countrycode")

covariates <- read_csv("original/covariates.csv")

source("R/cleanmortality.R") # returns full_data
source("R/disaster.R") # returns dis_sub
source("R/conflict.R") # returns new_conflictdata

colnames(dis_sub)[1] <- "year"

comb_list <- list(full_data, dis_sub, new_conflictdata, covariates)
keys <- c("year", "ISO")

# Join multiple data.frames
df2 <- comb_list %>% reduce(inner_join, by = keys)
df2
