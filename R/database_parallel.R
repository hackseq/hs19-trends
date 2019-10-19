library(future)
library(fulltext)
library(pubchunks)
library(tidyverse)
library(magrittr)
library(dplyr)
library(purrr)
library(here)
library(lubridate)

##specify that here is here::here because of conflict with lubridate
here <- here::here
plan(multisession)

searchTerms <- read.csv(here("/raw-data/SearchTerms.csv"))
searchTerms$Term %<>% as.character()
searchTerms <- searchTerms %>% filter(Topic=="Databases")

# ft_links() - get links for articles (xml and pdf).
df_raw <- NULL

for(st in searchTerms$Term[1]) {

  res1 <- ft_search(query = st, from = "plos", limit = 1000)
  
  mylinks %<-% ft_links(res1)$plos$ids
  
  # ft_get() - get full or partial text of articles.
  x %<-% ft_get(mylinks)
  
  x %>%
    ft_collect() %>% 
    pub_chunks(c("doi", "refDois", "history", "journal_meta", "publisher", "author", "aff", "title", "keywords", "abstract")) %>%  
    pub_tabularize() -> hold
  # .$elife
  for (nm in names(hold)){
     df_st <- map_df(hold[[nm]], `[`) %>%
              mutate(topic = st)
    df_raw <- bind_rows(df_raw,df_st)
    
  }
}



# Create simplified DF for analysis
df_raw_refined <- df_raw[, which(colSums(is.na(df_raw)) < 200)]
df_raw_refined %<>% select(-c("history.received", "journal_meta.journal.id", "journal_meta.journal.id.1", "journal_meta.journal.id.2", "journal_meta.issn", "journal_meta.publisher", ".publisher" )) %>%
  unite(col = author1, c(authors.surname, authors.given_names), sep = ", ") %>%
  mutate(Year = year(history.accepted), history.accepted = NULL) %>%
  rename("affiliation" = "aff.addr.line") %>%
  rename("journal" = "journal_meta.journal.title.group") %>%
  select(-starts_with("authors.")) %>% 
  select(-starts_with("aff.")) %>%
  distinct()

write.csv(df_raw_refined, here::here("data","Raissa-test.csv"))
