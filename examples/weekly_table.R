# A weekly team table
library(tidyverse)

ts <- read_csv("data/2026/team_season_2026.csv.gz")

ts %>%
  arrange(rank_case_l) %>%
  select(posteam, games, case_l, rank_case_l, case_per_play,
         epa_per_play, rank_epa_per_play, points_for, points_against)
