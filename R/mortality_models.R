library(tidyverse)
library(xtable)
library(readr)

# get data
final_dat <- read_csv("data/armed_conflict.csv")

#log transform GDP
final_dat$gdp1000 <- log(final_dat$gdp1000)
is.na(final_dat) <- sapply(final_dat, is.infinite)
final_dat <- final_dat %>% mutate_all(~replace(., is.na(.), 0))

# "base" model
preds <- as.formula(" ~ armconf1 + gdp1000 + OECD + popdens + urban + 
                  agedep + male_edu + temp + rainfall1000 + earthquake + drought + 
                  ISO + as.factor(year)")


matmormod <- plm(update.formula(preds, matmor ~ .), index = c("ISO", "year"),
                 effect = "twoways",
                 model = "within",
                 data = final_dat)
un5mormod <- plm(update.formula(preds, under5mor ~ .), index = c("ISO", "year"),
                effect = "twoways",
                model = "within", data = final_dat)
infmormod <- plm(update.formula(preds, infmor ~ .), index = c("ISO", "year"),
                effect = "twoways",
                model = "within", data = final_dat)
neomormod <- plm(update.formula(preds, neomor ~ .), index = c("ISO", "year"),
                effect = "twoways",
                model = "within", data = final_dat)


