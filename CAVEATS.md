# Caveats

Three things travel with every CASE figure. They are here as a file
rather than a paragraph in a post because data outlives prose.

## 1. Player views do not add up to the team

`quarterback`, `passer`, `rusher` and `receiver` are **tabulations, not
allocations**. A completed pass is counted by the quarterback view and
again by the receiver view — about 1.49 view-play pairs per play.

Splitting a play's value between them would be attribution, which an
earlier version of this model showed recovers usage rather than skill
(a receiver's role correlates +0.90 with his identity). So there is no
allocation rule and the views will never reconcile to the team total.

`quarterback` and `rusher` both contain scrambles — pick one rather than
adding them. `receiver` coverage is materially lower before 2009.

## 2. Absolute per-play figures carry a known bias

Roughly **-0.055 points per play**, from an unresolved calibration gap
in `down`. **Rankings and comparisons are unaffected** — Spearman 0.988
against a corrected version — so league tables, team-vs-team and
season-over-season are sound.

What is not sound is publishing a per-play figure as precise. Round
hard, or frame it comparatively.

## 3. `as_of` is not decoration

Opponent context is *the season so far*, which is correct for a
descriptive metric. **A week-8 rating and a week-18 restatement of the
same games will differ.** That is the metric working, not instability —
but only if the two are distinguishable. Always carry `as_of`.

## 4. Not every nflfastR row has a CASE value

5,094 of 5,489 nflfastR rows carry a CASE value (92.8%).

The frame drops rows that cannot carry value — administrative rows,
rows with no possessing team, rows where points are underivable — and
de-duplicates on nflfastR's own key. A left join from nflfastR will
produce NAs on those rows. That is expected.
