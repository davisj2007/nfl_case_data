# CASE — NFL play-by-play data

Context Aware Scoring Expectation. A **descriptive** metric: what teams
actually did, in context. Not a forecasting model.

Seasons released: **2006–2026** (21 seasons). The current season is updated weekly; the latest release is `2026-W02`.

## What is here

| file | grain |
|---|---|
| `case_plays` | one row per play. Everything else aggregates from it. |
| `team_game`, `team_season` | team totals with EPA, yards and points alongside |
| `player_season`, `player_game` | the non-exclusive spine views |
| `game_summary` | excitement, tension, biggest swing, held wins |
| `team_ledger_season`, `team_ledger_game` | offense produced, defense allowed, and net |
| `team_ledger_by_unit` | the same, split by passing, rushing, special teams, penalty and clock management |
| `game_timeline` | the per-play path through each game |
| `implied_wins` | win probability summed across games, by second |

CSV (gzipped) and Parquet. Same contents.

## Start here

- `DICTIONARY.md` — every column, generated from the data
- `CAVEATS.md` — **read this before publishing anything**
- `examples/` — joining to nflfastR, a weekly table, a game path

## License and citation

Released under **Creative Commons Attribution 4.0** (CC BY 4.0): share and
adapt, including commercially, with attribution. See `LICENSE.md`.

Built on play-by-play data from **nflverse** (nflfastR / nflreadr), also
CC BY 4.0 — credit nflverse alongside CASE.

Cite as:

> Davis, J. (2026). *CASE: Context Aware Scoring Expectation*, data release as of 2026-W02. Jake Davis Analytics. https://case.jakedavisanalytics.com

## The metric in one paragraph

CASE values a play as `points + V(next state) - V(current state)`, where
`V` is expected net points from a state to the **end of the game**. That
telescopes: the sum over a whole game equals the final margin minus `V`
at kickoff, exactly, across scores, turnovers, special teams and
halftime. Any partition of plays that covers each one once reconciles
to the game total.

Win probability is derived from the same `V` and its dispersion, so the
two cannot disagree. The leverage weight `w` is how much the game was
still in doubt, evaluated **pre-snap**.

## Not released

The fitted model. A package for building on CASE is a possible future
state; an API is another. Neither exists today.
