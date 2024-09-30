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

# comb_list <- list(full_data, dis_sub, new_conflictdata, covariates)
comb_list <- list(new_conflictdata, full_data, dis_sub)
# for reference: list(conflict data, mortality, disaster)
keys <- c("year", "ISO")

# Join multiple data.frames
df2 <- comb_list %>% reduce(full_join, by = keys)

# left join with covariates
final_data <- covariates %>% left_join(df2, by = keys)

# replace NA's
final_data <- final_data |>
  mutate(armconf1 = replace_na(armconf1, 0),
         drought = replace_na(drought, 0),
         earthquake = replace_na(earthquake, 0),
         totdeath = replace_na(totdeath, 0))

write.csv(final_data,"original/armed_conflict.csv")
