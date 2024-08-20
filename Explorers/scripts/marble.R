# Marble Guess (aim = 150)

# LOADING----
# packages
library(tidyverse)
library(janitor)
library(lattice)

# data
marble <- read_csv("Explorers/data/NSF_general.csv")
head(marble)

# ANALYSIS----
marble <- marble %>%
  arrange(desc(guess))%>%
  mutate(aim = 150,
         diff = guess - aim)
head(marble)

# PLOTS----


# histogram
hist(marble$guess) # overall
stripplot(marble$guess) # alternative graph, points only

hist(marble$diff) # difference to true value

marble %>%
  ggplot(aes(x = guess, colour = event))+ # categorised
  geom_histogram()+
  theme_classic()

marble %>%
  mutate(guess = log10(guess))%>% # log10()
  ggplot(aes(x = guess, colour = event))+
  geom_histogram()+
  theme_classic()

# jitter
marble %>%
  ggplot(aes(x = event, y = guess))+
  geom_jitter(width = 0.16)+
  theme_classic()

marble %>%
  mutate(guess = log10(guess))%>% # log10()
  ggplot(aes(x = event, y = guess))+
  geom_jitter(width = 0.16)+
  theme_classic()
