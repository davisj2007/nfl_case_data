# Caveats

These travel with every CASE number. They're a file instead of a paragraph in
a post because data outlives prose.

## 1. It describes, it doesn't predict

CASE says what happened, in context. It doesn't know which team is better -
every game starts from the same expectation - and it isn't a forecast. If you
want a forecast, that's LOWFI's job, and LOWFI isn't betting advice either.

## 2. Player numbers don't add up to the team

The player views - `quarterback`, `passer`, `rusher`, `receiver` - are
**tabulations, not allocations**. A completed pass counts in full for the
quarterback *and* the receiver, about 1.49 player entries per play. Splitting
it would mean deciding how much of a 40-yard completion was the throw and how
much was the route, and an earlier version of this project showed that
methods claiming to do that mostly recover *how a player is used*. So there's
no split, and players will never sum to their team.

`quarterback` and `rusher` both include scrambles: pick one, don't add them.
`receiver` coverage is noticeably thinner before 2009.

## 3. Single per-play numbers carry a small bias

About **-0.055 points per play**, from a calibration gap by down that I
haven't solved. It's the same for every team, so **rankings and comparisons
hold** (rank correlation 0.988 with a corrected version): league tables, team against team,
season against season. What doesn't hold is quoting one per-play figure as
precise. Round it, or compare it.

## 4. Seasons drift

The league-wide average moves by about ±0.15 points per play from season to
season, and no fix removes it, because it's real variation rather than a
model defect. Comparing teams across eras? Rank them within their own season
first.

## 5. `as_of` is not decoration

In-season numbers describe the season so far. A week 8 figure and the same
figure in week 18 will differ - not because the model changed, but because
more of the season happened. Always carry `as_of` with anything you quote.

## 6. Every season is rescored when the model changes

The whole repository is scored by one model, named in `model_version`. When a
new model version ships, every season is rescored with it, so a number from an
older release may not match today's. Quote the version with the number.

## 7. Late in games, win probability knows a little more than CASE

In the final minutes, win probability also accounts for timeouts and whether
the leading team can run out the clock - things an expected margin can't see.
So `wp` late in a game uses information that `case` doesn't. CASE itself, and
the expected final margin, are unaffected.

## 8. Not every nflfastR row has a CASE value

17,389 of 18,738 nflfastR rows carry a CASE value (92.8%).

Rows that can't carry a value are dropped - administrative rows, rows with no
team in possession, rows where the points can't be worked out - and duplicates
are removed on nflfastR's own key. A left join from nflfastR will show `NA` on
those rows. That's expected.

## 9. A few games aren't scored at all

A handful of games - 12 from 2006 through 2025 - have play-by-play whose
scoring doesn't add up to the final score, so CASE can't be reconciled for
them. They're left out of every table rather than scored wrong. If a team's
season total looks a game short, that's why.

## 10. Regular season and playoffs are both here

`season_type` marks each game `REG` or `POST`. Season tables and records are
regular season unless a file says otherwise.
