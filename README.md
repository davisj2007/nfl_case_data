# CASE - every NFL play, measured against what the situation expected

Context Aware Scoring Expectation. Every play since 2006, valued in
points by how much it changed the expected final margin - and every game's
plays add up to its final score.

Site: https://case.jakedavisanalytics.com - including every season since 2006, ranked, at
https://case.jakedavisanalytics.com/history.html

## What's here

21 seasons, 2006 through 2026, one folder each
under `data/`. The current season is updated every week; the latest release is
week 7 of 2026 (`2026-W07`). Every row was scored by the same model,
`v2006-2025c`, and says so in its `model_version` column.

| file | what's in it |
|---|---|
| `case_plays` | one row per play. Everything else is built from it. |
| `team_game` | one row per team per game: totals, with EPA, yards and points alongside |
| `team_season` | one row per team per season, the same, with CASE+ for completed seasons |
| `team_ledger_season` | offense produced, defense allowed, and net, per team per season |
| `team_ledger_game` | the same, per game |
| `team_ledger_by_unit` | the same, split by passing, rushing, special teams, penalties and clock management |
| `player_season` | the player views (quarterback, passer, rusher, receiver), per season |
| `player_game` | the same, per game |
| `game_summary` | one row per game: excitement, tension, win-probability movement, lead changes, win expectancy, BASE CASE |
| `game_timeline` | every play's path through its game: expected margin and win probability, home side |
| `implied_wins` | each team's win probability summed across its games, by second |

Every file comes as gzipped CSV and as Parquet - same contents, pick your poison.

## Start here

- `CASE_DICTIONARY.md` - every column, generated from the data itself
- `CASE_CAVEATS.md` - **read this before you publish anything**
- `examples/` - joining to nflfastR, a weekly table, one game's path

## How it stays honest

A play's CASE is `points + V(next state) - V(current state)`, where `V` is the
expected net points from a state to the **end of the game**. Because every
play is measured from the state before it to the state after, a game's plays
telescope: they add up to the final margin, minus the small home edge at
kickoff, exactly. Any split of the plays - by team, unit, down, quarter,
drive - adds up the same way. If you ever find a game where it doesn't,
that's a bug and I'd like to hear about it.

Every row carries `as_of` (when it was produced) and `model_version` (what
produced it). When the model changes, every season is rescored with it, so the
whole repository always speaks with one voice.

## License and citation

Released under **Creative Commons Attribution 4.0** (CC BY 4.0): share it and
adapt it, including commercially, with credit. See `LICENSE.md`.

CASE is built on play-by-play data from **nflverse** (nflfastR and nflreadr),
also CC BY 4.0 - so credit nflverse alongside CASE.

Cite as:

> Davis, J. (2026). *CASE: Context Aware Scoring Expectation*, data release as of 2026-W07. Jake Davis Analytics. https://case.jakedavisanalytics.com
