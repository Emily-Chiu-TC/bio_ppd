# Script created by Katie Farrow 
# Norwich Science Festival: 24 February 2024 (Sat)

# PACKAGES ----
library(tidyverse)
library(janitor)
library(RColorBrewer)
library(colorBlindness)
library(readr)
library(ggimage)
library(gganimate)
library(gifski)

# IMPORT DATA ----
## file - import data set - open data set - continue analysis 
nsf1 <- read_csv("Explorers/data/NSF_2024_raw.csv")
head(nsf1)

## Clean/rename variables ----
## nsf1 <- dplyr::rename(nsf1, 'subject' = 'choice') # rename
colnames(nsf1) # quickly check the new variable names (nsf1)


# PLOTTING ----
#custom colours
sub_colours <-c("steelblue3", "darkgoldenrod3", "darkorchid3")#R Colours

## PLOT 1 - BAR/vertical ----
science_plot <- nsf1 %>%
    ggplot(aes(x=subject))+
    geom_bar(fill = sub_colours, width = 0.8, colour = "black", position = "dodge")+
    scale_fill_manual(values = sub_colours)+
    theme_void()+
  labs(x = "Subject",
       y = "Popularity",
       title = "Favorite science subject",
       caption = "Data Explorers Norwich Science Festival 2024")+
  theme(legend.position = "none", plot.margin=unit (c (0,1,1,1), 'cm'),
    axis.text.x = element_text(face = "bold", color = "black", size = 16, margin = margin(10, 10, 10, 10)),
    axis.text.y = element_text(face = "bold", color = "black", size = 16, margin = margin(10, 10, 10, 10)),
    axis.title.y  = element_text(face = "bold", color = "black", size = 20, angle = 90, margin = margin(20, 20, 20, 20)),
    axis.title.x  = element_text(face = "bold", color = "black", size = 20, margin = margin(10, 10, 10, 10)),
    plot.title = element_text(face = "bold", color = "black", size = 30, margin = margin(20, 20, 20, 20)),
    plot.caption = element_text(face = "bold", color = "darkorchid4", size = 16, margin = margin(1, 5, 1, 1)),
    plot.title.position = "plot")

science_plot

## PLOT 2 - BAR/horizontal----
sci_plot_flip <- nsf1 %>%
    ggplot(aes(x=subject))+
    geom_bar(fill = sub_colours, width = 0.8, size = 0.6)+
  
    theme_classic()+
    coord_flip()+
  labs(x = "Subject",
       y = "Popularity",
       title = "Favorite science subject",
       caption = "Data Explorers Norwich Science Festival 2024")+
  theme(
    legend.position = "none", plot.margin=unit (c (0,1,1,1), 'cm'),
    axis.text.x = element_text(face = "bold", color = "black", size = 16, margin = margin(10, 10, 10, 10)),
    axis.text.y = element_text(face = "bold", color = "black", size = 16, margin = margin(10, 10, 10, 10)),
    axis.title.y  = element_text(face = "bold", color = "black", size = 20, angle = 90, margin = margin(20, 20, 20, 20)),
    axis.title.x  = element_text(face = "bold", color = "black", size = 20, margin = margin(10, 10, 10, 10)),
    plot.title = element_text(face = "bold", color = "black", size = 30, margin = margin(20, 20, 20, 20)),
    plot.caption = element_text(face = "bold", color = "darkorchid4", size = 16, margin = margin(1, 5, 1, 1)),
    plot.title.position = "plot")

sci_plot_flip


# Checking for accessibility
colorBlindness::cvdPlot(sci_plot_flip) 


# Add the animation with gganimate - NOT USING----
nsf2 <- read_csv("nsf24_r.csv") 
head(nsf2)

# clean
nsf2 <- janitor::clean_names(nsf2) # turn all variables to lower-case (nsf2)
colnames(nsf2)

nsf2 <- nsf2 %>%
  select(time, subject, vote)
head(nsf2)

sum(is.na(nsf2)) # check NA
nsf2 <- nsf2 %>%
  drop_na()
view(nsf2)

# plot
animated_plot <- ggplot(nsf2,
                        aes(x = vote,
                            y = subject, fill = subject))+
  geom_col()+
  scale_fill_manual(values = sub_colours)+
  scale_y_discrete(limits = rev(levels(nsf2$subject)))+  # Reverse the order of the subjects
  transition_states(time) +  # Animate the graph over time
  ease_aes("linear", duration = 20)+  # Set a longer duration for each frame (linear)
  labs(x = "Popularity",
        y = "Subject",
        title = "Favorite science subject",
        caption = "Data Explorers Norwich Science Festival 2024")+
  theme(
    legend.position = "none", plot.margin=unit (c (0,1,1,1), 'cm'),
    axis.text.x = element_text(face = "bold", color = "black", size = 16, margin = margin(10, 10, 10, 10)),
    axis.text.y = element_text(face = "bold", color = "black", size = 16, margin = margin(10, 10, 10, 10)),
    axis.title.y  = element_text(face = "bold", color = "black", size = 20, angle = 90, margin = margin(20, 20, 20, 20)),
    axis.title.x  = element_text(face = "bold", color = "black", size = 20, margin = margin(10, 10, 10, 10)),
    plot.title = element_text(face = "bold", color = "black", size = 30, margin = margin(20, 20, 20, 20)),
    plot.caption = element_text(face = "bold", color = "darkorchid4", size = 16, margin = margin(1, 5, 1, 1)),
    plot.title.position = "plot")+
  theme_classic()

# Render the plot - gifski
animate(animated_plot, duration = 15, 
        height = 800, width = 800, res = 150)

# ,renderer = gifski_renderer(fps = 5)
# ,renderer = gifski_renderer(fps = 10)
# Save the animation as a GIF
anim_save("outputs/animate_graph.gif", animation = , height = 800, width = 800, res = 150)
