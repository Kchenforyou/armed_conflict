# import libraries
library("tidyr")
library("dplyr")
library("readr")

conflictdata <- read_csv("original/conflictdata.csv")

conflictdata$best <- ifelse(conflictdata$best > 0, 1, 0)

# used summarize to remove duplicate countries in each year
new_conflictdata <- conflictdata %>% 
  group_by(ISO, year) %>%
  summarize(totdeath = max(best)) %>%
  mutate(armconf1 = ifelse(totdeath > 0, 1, 0)) %>%
  ungroup() 

# masked 1's and 0's as bools
# new_conflictdata$best <-ifelse(new_conflictdata$totdeath == 1, TRUE, FALSE) 

# lag year by one
new_conflictdata$year <- new_conflictdata$year + 1
