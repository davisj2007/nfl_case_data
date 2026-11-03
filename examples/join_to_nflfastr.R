# Join CASE back to nflfastR
#
# game_id and play_id ARE nflfastR's keys, so this is a two-line
# operation. Expect NAs on rows CASE does not cover — see CAVEATS.md.

library(tidyverse)

pbp  <- nflreadr::load_pbp(2026)
case <- read_csv("data/2026/case_plays_2026.csv.gz")

joined <- pbp %>%
  left_join(case %>% select(game_id, play_id, case, v, wp, w, unit),
            by = c("game_id", "play_id"))

# how much is covered
joined %>% summarise(rows = n(), with_case = sum(!is.na(case)))
