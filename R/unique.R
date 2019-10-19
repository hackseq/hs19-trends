#!/usr/bin/env Rscript

library(tidyverse)
library(here)
library(stringr)

for (file in grep(list.files(here("data","WebscrapeTopic")), pattern = "_distinct", invert = TRUE, value = TRUE)) {
  csv <- read_csv(here("data", "WebscrapeTopic",file))
  
  csv_distinct <- csv %>%
    distinct(doi, .keep_all = TRUE)
  
  topic <- str_remove(file, ".csv")
  write_csv(csv_distinct,here("data","WebscrapeTopic",paste(topic,"distinct.csv", sep = "_")))
}