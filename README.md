# shiftycal
Generates an .ics for tricky shift work. See https://webchick.substack.com/p/using-icalendar-for-semi-predictable for background.

This script assumes you have a CSV file in the same directory called "shifts.csv" and it contains values like the following:

```
2021-01-19,Day
2021-02-04,Eve
```

Adjust accordingly!

To use it:

```
./shifty.sh > shifts.ics
```
