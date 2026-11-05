---
title: Excel - Check if unlocked cells contain data
---

When creating Excel documents with sheets, where a user is expected to populate a set of unlocked cells, it is useful to be able to count the number of populated cells.  

This allows you determine if the (form) sheet is 'clear' or if all cells have been populated.

Formula:

```
=LET(notes, "1) Doesn't recalculate when you change a cell's lock status, so press Ctrl+Alt+F9.
             2) OFFSET is volatile and is recalculated when any cell inside or outside the range is modified.
                This may cause performance issues.",
     range, A3:H14,
     unlocked, CELL("protect", OFFSET(INDEX(range, 1, 1), ROW(range)-MIN(ROW(range)), COLUMN(range)-MIN(COLUMN(range)))) = 0,
     populated, range <> "",
     num_unlocked_and_populated, SUMPRODUCT(unlocked * populated),
     num_unlocked_and_populated
)
```

`range` is the area of the sheet to check.

With this:

1) If you make the last line `num_unlocked_and_populated = 0` this tells you if the (form) sheet is 'clear'.

2) If you make the last line `num_unlocked_and_populated = SUM(unlocked*1)` this tells you if the (form) sheet is fully populated.  Note: The `*1` converts the True/False values to 0 and 1.
