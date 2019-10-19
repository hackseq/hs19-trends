library(ggplot2)
library(plotly)
library(cowplot)
library(tidyverse)

#read_csv("./data/WebscrapeTopic/StructuralPrediction.csv")

# get all the excel files
files <- list.files(here("data/WebscrapeTopic"), pattern = "*.csv",full.names = T)



# read in all the files and 
# skip the first 10 rows (instructions and student names)
open_files <- files %>% 
  map(read_csv)

unique_files <- open_files %>%  
  map(~distinct(topic,.keep_all = TRUE)) %>% 
    

df_all_uni <- files %>% 
  map_df(read_csv) %>% 
  distinct(doi,.keep_all = TRUE)

df_all %>% 
  group_by(Year) %>% 
  summarise(n())

df_all %>% 
  group_by(doi) %>% 
  summarise(n()) %>% 
  filter(`n()` >= 2)

df_all %>% 
  ggplot(aes(x = Year, fill = topic)) +
  geom_bar()

df_all_uni %>% 
  ggplot(aes(x = Year)) +
  geom_bar() +
  facet_wrap(~ topic) +
  geom_vline(xintercept = 2015)

ggplotly()


df_all_uni %>% 
  group_by(topic, Year) %>% 
  summarise(total = n()) %>% 
  ggplot(aes(x = Year, y = total, colour = topic)) +
  geom_line() +
  facet_wrap(~ topic)

ggplotly()

# comparing specific search terms
df_all_uni %>% 
  filter(grepl("sequence", topic)) %>% 
  ggplot(aes(x = Year, y = total, colour = topic)) +
  geom_line()

seq <- df_all_uni %>% 
  filter(grepl("assembly", topic)) %>% 
  ggplot(aes(x = Year, y = total, colour = topic)) +
  geom_line() +
  facet_wrap(~ topic)
