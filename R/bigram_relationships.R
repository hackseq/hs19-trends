library(tidyverse)
library(tidytext)
library(tm)
library(widyr)
library(igraph)
library(ggplot2)
library(ggraph)


# Read in data
df <- read_csv("data/AllWebscrape.csv") %>% 
  rename_all(tolower) %>% 
  rename(term = topic) %>% 
  mutate(term = str_to_lower(term))

search_terms <- read_csv("raw-data/SearchTerms.csv") %>% 
  rename_all(tolower) %>% 
  mutate(term = str_to_lower(term))

df <- df %>% 
  left_join(search_terms, by = "term")

# transform data
abstracts <- df2019$abstract

df <- df2019 %>% 
  mutate(abstract_clean = removeWords(df2019$abstract, stop_words$word))

df2 <- df %>%
  unnest_tokens(bigrams, abstract_clean, token = "ngrams", n = 2)

df3 <- as.data.frame(table(df2$bigrams)) %>% 
  arrange(desc(Freq))

# visualizations
word_cors <- df3 %>% 
  separate(Var1, c("item1", "item2")) %>% 
  filter(Freq > 6)

word_cors %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = Freq), show.legend = FALSE) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), repel = TRUE) +
  theme_void()
