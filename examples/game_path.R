# The win-probability path through a game
#
# v_home and wp_home come from the SAME value function, so they cannot
# disagree. w shows where the game was live.
library(tidyverse); library(arrow)

tl <- read_parquet("data/2026/game_timeline_2026.parquet")

g <- tl %>% filter(game_id == first(game_id))

ggplot(g, aes(elapsed, wp_home)) +
  geom_hline(yintercept = 0.5) +
  geom_step() +
  labs(x = 'seconds elapsed', y = 'home win probability')
