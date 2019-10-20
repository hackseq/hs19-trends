library(tidyverse)
library(tidytext)
library(tm)
library(widyr)
library(igraph)
library(ggplot2)
library(ggraph)
library(readr)
library(tidygraph)
library(viridis)


# Read in data
df_raw <- read_csv("data/AllWebscrape.csv") %>% 
  rename_all(tolower) %>% 
  rename(term = topic) %>% 
  mutate(term = str_to_lower(term))

search_terms <- read_csv("raw-data/SearchTerms.csv") %>% 
  rename_all(tolower) %>% 
  mutate(term = str_to_lower(term))

df <- df_raw %>% 
  left_join(search_terms, by = "term") %>% 
  mutate(topic = ifelse(term %in% c("global alignment sequence", "read alignment sequence")
                        ,"Sequence Alignment"
                        ,topic))

# Separate data by topics
df_assembly <- df %>% 
  filter(topic == "Assembly")
df_databases <- df %>% 
  filter(topic == "Databases")
df_epigenetics <- df %>% 
  filter(topic == "Epigenetics")
df_geneexp <- df %>% 
  filter(topic == "Gene Expression")
df_genomeann <- df %>% 
  filter(topic == "Genome Annotation")
df_phylogenetics <- df %>% 
  filter(topic == "Phylogenetics")
df_seqal <- df %>% 
  filter(topic == "Sequence Alignment")
df_sequence <- df %>% 
  filter(topic == "Sequencing")
df_strucpred <- df %>% 
  filter(topic == "Structural Prediction")
df_varcall <- df %>% 
  filter(topic == "Variant Calling")

### Create function
visualize_bigrams <- function(df_name){
# Create frequencies of bigrams
df <- df_name %>% 
  mutate(abstract_clean = removeWords(gsub("[^A-Za-z0-9 ]","",abstract), stop_words$word))

df2 <- df %>%
  unnest_tokens(bigrams, abstract_clean, token = "ngrams", n = 2)

df3 <- as.data.frame(table(df2$bigrams)) %>% 
  arrange(desc(Freq))

# Visualizations
word_cors <- df3 %>%
  top_n(100, Freq) %>% 
  separate(Var1, c("item1", "item2"))

wordList <- c(word_cors$item1, word_cors$item2) %>% unique()

wordListToken <- df %>%
  unnest_tokens(bigrams, abstract_clean, token = "ngrams", n = 1) 
wordListTokenDF <- as.data.frame(table(wordListToken$bigrams)) %>% 
  arrange(desc(Freq)) %>%
  filter(Var1 %in% wordList)

names(wordListTokenDF)[2] <- "Term_Frequency"
names(word_cors)[3] <- "Edge_Frequency"

graph_from_data_frame(vertices =  wordListTokenDF, d = word_cors) ->graphHold

graphHold %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = Edge_Frequency), show.legend = TRUE) +
  geom_node_point(aes(color = Term_Frequency, size = Term_Frequency), alpha = 0.7) +
  scale_fill_viridis_c() +
  geom_node_text(aes(label = name), repel = TRUE) +
  scale_color_viridis_c(direction = -1) +
  theme_void() + guides(size=FALSE)
}

### Execute function
visualize_bigrams(df)
visualize_bigrams(df_assembly)
visualize_bigrams(df_databases)
visualize_bigrams(df_epigenetics)
visualize_bigrams(df_geneexp)
visualize_bigrams(df_genomeann)
visualize_bigrams(df_phylogenetics)
visualize_bigrams(df_seqal)
visualize_bigrams(df_sequence)
visualize_bigrams(df_strucpred)
visualize_bigrams(df_varcall)
