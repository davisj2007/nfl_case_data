# Data dictionary

Generated from the data, so it cannot drift. 2026, as of 2026-W02.

## case_plays

| column | type | description |
|---|---|---|
| `season` | integer | NFL season |
| `week` | integer | week within the season |
| `season_type` | character | REG or POST |
| `game_id` | character | nflfastR game identifier. JOIN KEY. |
| `play_id` | numeric | nflfastR play identifier. JOIN KEY, with game_id. |
| `seq` | integer | play order within the game, as CASE sorts it (clock descending, ties on cumulative points). NOT the same as play_id order. |
| `home_team` | character | home team abbreviation |
| `away_team` | character | away team abbreviation |
| `posteam` | character | team with the ball |
| `defteam` | character | team on defense |
| `is_home` | logical | TRUE when posteam is the home team |
| `qtr` | numeric | quarter |
| `secs` | numeric | seconds remaining in the game. 0 THROUGHOUT overtime. |
| `fixed_drive` | numeric | nflfastR drive number |
| `series` | numeric | nflfastR series number |
| `play_context` | character | scrimmage, kickoff or try. Structural — these are different state spaces. |
| `play_type` | character | nflfastR play type |
| `down` | factor | down; 'none' on plays that carry none |
| `ydstogo` | numeric | yards to go, capped at 30 |
| `yardline_100` | numeric | yards from the opponent's end zone, for posteam |
| `margin` | numeric | score margin from posteam's perspective, BEFORE the play |
| `score_state` | factor | nine-level margin bucket cut at football thresholds (tied, up/down 1-3, 4-8, 9-16, 17+) |
| `case` | numeric | THE METRIC. Points above expectation on this play, to the team with the ball. |
| `pts` | numeric | points actually scored on the play, possession-signed |
| `v` | numeric | expected net points from this state to the end of the game, to posteam |
| `case_next` | numeric | a CASE-implied EPA. Points on the play plus the change in v_a — exactly EPA's construction on exactly EPA's target. Correlates 0.958 with nflfastR EPA. |
| `case_beyond` | numeric | what the play changed about the game AFTER the next score. case_next + case_beyond = case, exactly. Small (3% of variance); its per-play extremes in blowouts are outliers rather than findings. |
| `v_a` | numeric | the NEXT-SCORE component of v — the same quantity an expected-points model estimates |
| `v_b` | numeric | the AFTER-NEXT-SCORE component of v. No expected-points model attempts this. |
| `sd_R` | numeric | dispersion of net points remaining. The leverage weight's denominator. |
| `wp` | numeric | win probability for posteam, derived from v and sd_R |
| `w` | numeric | leverage weight, PRE-SNAP. phi(z) — how much the game was still in doubt. |
| `case_w` | numeric | case * w |
| `unit` | character | exclusive partition: pass offense, rush offense, special teams, clock management, penalty |
| `passer_id` | character | nflfastR passer id |
| `passer` | character | passer name |
| `rusher_id` | character | nflfastR rusher id |
| `rusher` | character | rusher name |
| `receiver_id` | character | nflfastR receiver id. Coverage is materially lower before 2009. |
| `receiver` | character | receiver name |
| `qb_id` | character | passer, or the rusher on a scramble. Sacks already carry a passer id. |
| `qb` | character | quarterback name, same rule |
| `shotgun` | numeric | nflfastR shotgun indicator |
| `no_huddle` | numeric | nflfastR no-huddle indicator |
| `penalty` | numeric | nflfastR penalty indicator |
| `yards_gained` | numeric | nflfastR yards gained |
| `epa` | numeric | nflfastR EPA, carried for comparison. NOT an input to CASE. |
| `desc` | character | nflfastR play description |
| `final_margin` | integer | final score margin, home minus away |
| `home_score` | integer | final home score |
| `away_score` | integer | final away score |
| `model_version` | character | the fitted model that produced this row |
| `as_of` | character | when this figure was produced. See CAVEATS. |

## Other tables

Summary tables are `group_by` aggregations of `case_plays` and share
its column meanings. `case_total`, `case_per_play` and `case_l` are the
sum, the mean and the leverage-weighted mean. `ess` is the effective
sample size of the weighting.

`game_timeline` carries the per-play path through a game in HOME frame:
`v_home` the expected final margin, `wp_home` the home win probability
from the same value function, `w` the leverage, and cumulative CASE per
side.

`implied_wins` is each team's win probability summed across every game
played, at ten-second intervals — the record they would hold if every
game froze at that second. The .500 reference is `0.5 * games`.
