library(ggplot2)
library(plotly)
library(cowplot)
library(tidyverse)

seq_spec <- read_csv("./data/sequencing-specific.csv")

# other static graphs
seq_spec %>% 
  group_by(topic, Year) %>% 
  summarise(total = n()) %>% 
  ggplot(aes(x = Year, y = total, colour = topic)) +
  geom_line() +
  facet_wrap(~ topic)

seq_spec %>% 
  group_by(topic, Year) %>% 
  summarise(total = n()) %>% 
  ggplot(aes(x = Year, y = total, colour = topic)) +
  geom_line()

ggplotly()

# static graph of cum total
seq_spec %>% 
  filter(topic != "NGS",
         topic != "third-generation sequencing",
         topic != "ont reads sequencing") %>%
  group_by(topic, Year) %>% 
  summarise(total = n()) %>%
  mutate(cum_total = cumsum(total),
         topic = str_replace(topic, "sequencing","")) %>% 
  ggplot(aes(x = Year, y = cum_total, colour = topic)) +
  geom_line()

## racing bar graphs
library(gganimate)
library(hrbrthemes)

seq_data <- seq_spec %>% 
  filter(topic != "NGS",
         topic != "third-generation sequencing",
         topic != "ont reads sequencing") %>%
  mutate(topic = str_replace(topic, " sequencing","")) %>% 
  group_by(topic, Year) %>% 
  summarise(total = n()) %>% 
  mutate(cum_total = cumsum(total)) %>% 
  ungroup()


#making ordered bars
ordered_df <- NULL

for (yr in 2003:2019) {
  order <- seq_data %>% 
    filter(Year == yr) %>% 
    arrange(cum_total) %>% 
    mutate(ordering = row_number())
  
  ordered_df <- ordered_df %>% rbind(order)
  
}

ordered_df %>% 
  ggplot(aes(x = Year, y = cum_total, colour = topic)) +
  geom_line()

# racing bars chart
p <- ordered_df %>% 
  ggplot(aes(ordering, group = topic))+
  geom_tile(aes(y = cum_total/2,
                height = cum_total,
                width = 0.9,
                fill = topic)) +
  geom_text(aes(y = cum_total, label = topic), hjust = "left", fontface = "bold", nudge_y = 50) +
  scale_fill_viridis_d() +
  coord_cartesian(clip = "off", expand = FALSE) +
  coord_flip() +
  transition_states(Year, transition_length = 4, state_length = 8) +
  ease_aes("cubic-in-out") +
  labs(title = "Year {closest_state}") +
  theme(legend.position = "none",
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        text = element_text(size=14),
        plot.title = element_text(size = 35)) +
  ylim(0,1300) +
  xlab("")

animate(p, nframes = 750, 
        fps = 10, 
        end_pause = 10)

 #text size
# year 
#blank frame