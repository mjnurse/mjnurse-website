---
title: 19-05-02 - Statistical Testing
section: Misc
---

For a long time I've wanted to explore using statistics to determine how many tests are needed to test for errors.  The question I have is that, for a set of n records, if we want to be say 99.9% sure none contain an error, how many would be need to test at random to reach a point where we can be statistically, say, 99.9% sure there are no errors.

# The Basics

## Tests with a fixed number of options / records to test

If I have a die and there is a chance the number has not been printed on one side, how many times would I need to roll the die to be 99% sure all sides contain a number?

Lets assume there **is** a fault on one side of the die (and I can only see the top face of the die each time I roll it) - how many times would I need to roll the die to be 99% sure I'll find it?

This isn't easy to calculate.  We need to work out all the combinations of die sides on top (after n throws). These will include throws with our bad side on top.

----

**First Roll**

- 6 options, 1 is the bad side so chance of finding it is 1/6.

**Calculation** - `1/6 = 16.7%`

----

**Second Roll**

- If role 1 finds a bad side then we stop, there is a 1/6 chance of this.
- If roll one finds a good side (there is a 5/6 chance of this), we roll again.
- The second roll has a 1/6 chance of being bad.

**Calculation** - `1/6 + (5/6 x 1/6) = 30.6%`

----

**Third Roll**

- If role 1 finds a bad side then we stop, there is a 1/6 chance of this.
- If roll 1 finds a good side (there is a 5/6 chance of this), we roll again.
- Roll 2 roll has a 1/6 chance of being bad, if we find bad side we stop.
- If role 2 finds a good side (there is a 5/6 chance of this), we roll again.
- Roll 3 has a 1/6 chance of being bad.

**Calculation** - `1/6 + (5/6 x (1/6 + (5/6 x 1/6))) = 42.1%`

----

This gets very complicated very quick.

However, this question can be reversed and instead we can ask - *"What is the chance that each time I roll the die I won't find the bad side?"*  For each roll of the die there is a `5/6 = 83.3%` chance I won't find the bad side and that is true for every roll of the die regardless of the outcome of any earlier rolls.

However, if we ask the question **up front**, *"What is the chance I won't find the bad side within, say, 3 rolls"* then the maths is slightly different.

For 3 planned rolls the chance I won't find the faulty side is `5/6 x 5/6 x 5/6 = 125/216 = 57.9%`.  This means the chance that I will find the faulty side is `100% - 57.9% = 42.1%`.  This matches the value calculated above.

So lets see how many times I would need to plan to roll the die to be 99% sure I'll find the faulty side.

| Roll Number | % Chance Wont Find                    | % Chance Will Find   |
|-------------|---------------------------------------|----------------------|
| 1           | 5/6 = 83.3%                           | 16.7%                |
| 2           | 5/6 x 5/6 = (5/6)<sup>2</sup> = 69.4% | 30.6%                |
| 3           | (5/6)<sup>3</sup> = 57.9%             | 98.5%                |
| :           | :                                     | :                    |
| :           | :                                     | :                    |
| 24          | (5/6)<sup>24</sup> = 1.5%             | 98.5%                |
| 25          | (5/6)<sup>25</sup> = 1.3%             | 98.7%                |
| 26          | (5/6)<sup>26</sup> = 1.0%             | 99.0%                |

A surprisingly large number...  This number is large because the number of options (sides to land face up) for each roll remains the same.  We can never rule out and remove any side from the next roll.

## Tests with a reducing number of options / records to test

If we swap the die analogy for a bag containing six balls where, ideally, all the balls in the bag are white but there is a possibility that one of the balls is black, how many balls would I need to take out of the bag to be 99% sure there are no black balls?  The statistics here are slightly different and there is also the obvious upper limit.  Once I have removed all the balls (6 balls / 6 tests), if they are all white, I can be 100% sure there no black balls.  Let's assume one ball is black and do the do the math.  Again we focus on the chance of finding the bad ball which is far more simple in terms of the math.

Looking at each test in turn:

----

**Ball 1** 

-  For ball 1 taken from the bag there is a 1/6 chance it will be black

Calculation  `1/6 = 16.7% `

----

**Ball 2**   

- If ball 1 is black then we stop, there is a 1/6 chance of this.
- If ball 1 is white (there is a 5/6 chance of this), we take out ball 2.
- For ball 2 there is a 1/5 chance of it being black.

Calculation  `1/6 + (5/6 x 1/5) = 33.3%`

----

**Ball 3**   

- If ball 1 is black then we stop, there is a 1/6 chance of this.
- If ball 1 is white (there is a 5/6 chance of this), we take ball 2.
- Ball 2 has a 1/5 chance of being black, if we find it we stop.
- If ball 2 is white (there is a 4/5 chance of this), we take ball 3.
- Ball 3 has a 1/6 chance of being black.

Calculation  `1/6 + (5/6 x (1/5 + (4/5 x 1/4))) = 55.3%`

----

Again, using the won't find calculation, and asking the question up front, how many balls will I need to remove to be 99% sure there isn't a black ball the math is:

| Ball Number | % Chance Wont Find                    | % Chance Will Find |
|-------------|---------------------------------------|--------------------|
| 1           | 83.3% (5/6)                           | 16.7%              |
| 2           | 66.7% (5/6 x 4/5)                     | 33.3%              |
| 3           | 50.0% (5/6 x 4/5 x 3/4)               | 50.0%              |
| 4           | 33.3% (5/6 x 4/5 x 3/4 x 2/3          | 66.7%              |
| 5           | 16.7% (5/6 x 4/5 x 3/4 x 2/3 x 1/2)   | 83.3%              |
| 6           | 0% (5/6 x 4/5 x 3/4 x 2/3 x 1/2 x 0/1)| 100%               |

The number of balls is too small to get to 99%, we hit 100% first.

# Here's What We Know So Far

If we choose a percentage `p%` likelihood of there being a bad side / bad ball / bad record in a set, we can calculate how many records we need to look at to be `t%` sure we will find it (and if we don't find it we can be `100 - t%` sure it doesn't exist).  The maths differs depending on whether we can or can't remove each record from the set if we test it and its good.

The above examples had a set of 6 sides / items / records and the two (records remain or removed) equations gave very different results but, as the set side increases the difference between the 2 should decrease.  Lets write a python program to test this assumption.

The Python programs is [stats_test.py](attatchments/stats_test.py)

# The Statistics

Running `stats_test.py`.

```
> python3 stats_test.py

Usage:

(1) stats_test.py <bad record perc> <set size> <target certainty perc>

(2) stats_test.py -g <1> <2> <3> <4> <5> <6> <7>

    Where: <1> - number bad record percentage rows in grid
           <2> - bad record percentage min
           <3> - bad record percentage max
           <4> - number target certainty percentage columns in grid
           <5> - target certainty percentage min
           <6> - target certainty percentage max
           <7> - test data set size

(3) stats_test.py -t <num test sets> <bad rec perc> <set size> <num of tests>

Percentages (perc) in range 0 - 100
```

Let's calculate the die / balls in a bag scenario above.

```
> python3 stats_test.py 16.667 6 99
--------------------------------------------------------------------------------
bad record likelihood: 16.667 %
set size:              6
target certainty:      99.0 %
--------------------------------------------------------------------------------
With good recs removed -   reached target certainty 99.0% after 6 tests
With good recs remaining - reached target certainty 99.0% after 26 tests
--------------------------------------------------------------------------------
```

Now lets calculate something a little more useful.  Assuming we have 100,000,000 records and we want to be 99.99% sure the risk of an error is less than 0.01%.

```
> python3 stats_test.py 0.01 100000000 99.99
--------------------------------------------------------------------------------
bad record likelihood: 0.01 %
set size:              100000000
target certainty:      99.99 %
--------------------------------------------------------------------------------
With good recs removed -   reached target certainty 99.99% after 92057 tests
With good recs remaining - reached target certainty 99.99% after 92099 tests
--------------------------------------------------------------------------------
```

So we need to test a little over 92,000 records chosen at random from 100,000,000 records to be 99.99% sure there is less than 0.01% of records in error.  Also, note that with this large set size the difference between the number of tests required if the good records are left in or removed is negligible.

Lets try a larger set size, 100,000,000,000.

```
> python3 stats_test.py 0.01 100000000000 99.99
--------------------------------------------------------------------------------
bad record likelihood: 0.01 %
set size:              100000000000
target certainty:      99.99 %
--------------------------------------------------------------------------------
With good recs removed -   reached target certainty 99.99% after 92099 tests
With good recs remaining - reached target certainty 99.99% after 92099 tests
--------------------------------------------------------------------------------
```

What's interesting here is that the number if tests (with good records remaining in the data set) is the same even though we have 1,000x more records.  This surprised me at first but the reason is obvious once seen.  As we are stating the max likelihood of there being a bad records as a percentage (of the total data set), as the set size increase so does the number of bad records.

If we reduce the bad record likelihood percentage value by a factor of 1,000 so that the max number of bad records in the same as was in the 100,000,000 test set then the number of test should go up.

```
> python3 stats_test.py 0.00001 100000000000 99.99
--------------------------------------------------------------------------------
bad record likelihood: 1e-05 %
set size:              100000000000
target certainty:      99.99 %
--------------------------------------------------------------------------------
With good recs removed -   reached target certainty 99.99% after 92060997 tests
With good recs remaining - reached target certainty 99.99% after 92103400 tests
--------------------------------------------------------------------------------
```

The number of tests does go up, a lot.

# Double Checking These Results

Lets check the math is correct by simulating a real scenario.  I wrote a function in `stats_test.py` to do this.  Below I calculate the test required for a few different scenarios and then test the values.

## Scenario 1:

### Calculate number of tests

```
> python3 stats_test.py 0.01 1000000 99.9
--------------------------------------------------------------------------------
bad record likelihood: 0.01 %
set size:              1000000
target certainty:      99.9 %
--------------------------------------------------------------------------------
With good recs removed -   reached target certainty 99.9% after 66743 tests
With good recs remaining - reached target certainty 99.9% after 69075 tests
--------------------------------------------------------------------------------
```

### Check that the suggested number of tests is correct

```
> python3 stats_test.py -t 10000 0.01 1000000 69075

num test sets: 10000 , num which found bad record: 9996 , percentage: 99.96%
```

Above, I ran 10,000 iterations of a test scenario which tests that I find a bad record by checking up to 69,075 records.  Of the 10,000 iterations, 9,996 found a bad record which is 99.96% of cases.  This confirms the suggested number of tests is good.

## Scenario 2:

### Calculate number of tests

```
> python3 stats_test.py 0.1 10000 50
--------------------------------------------------------------------------------
bad record likelihood: 0.1 %
set size:              10000
target certainty:      50.0 %
--------------------------------------------------------------------------------
With good recs removed -   reached target certainty 50.0% after 670 tests
With good recs remaining - reached target certainty 50.0% after 693 tests
--------------------------------------------------------------------------------
```

### Check that the suggested number of tests is correct

```
> python3 stats_test.py -t 100000 0.1 10000 693

num test sets: 100000 , num which found bad record: 51357 , percentage: 51.36%
```

Above, I ran 100,000 iterations of a test scenario which tests that I find a bad record by checking up to 693 records.  Of the 100,000 iterations, 51,357 found a bad record which is 51.36% of cases.  This confirms the suggested number of tests is good.

## Scenario 3:

### Calculate number of tests

Repeating the die test again.

```
> python3 stats_test.py 16.67 6 99
--------------------------------------------------------------------------------
bad record likelihood: 16.67 %
set size:              6
target certainty:      99.0 %
--------------------------------------------------------------------------------
With good recs removed -   reached target certainty 99.0% after 6 tests
With good recs remaining - reached target certainty 99.0% after 26 tests
--------------------------------------------------------------------------------
```

### Check that the suggested number of tests is correct

```
> python3 stats_test.py -t 1000000 16.67 6 26

num test sets: 1000000 , num which found bad record: 999843 , percentage: 99.98%
```

Above, I ran 1,000,000 iterations of a test scenario which tests that I find a bad record by checking up to 26 records (rolls).  Of the 1,000,000 iterations, 999,843 found a bad record which is 99.98% of cases.  This confirms the suggested number of tests is good.

# Some Useful Statistics

I added a procedure to `stats_test.py` to print a grid of number of tests required to a range of bad record likelihood percentages and target certainty percentages.

```
|--------------------------|--------------------------------------|
|                          | Level of certainty                   |
| Number of bad records    |--------------------------------------|
| less than                |      99.9% |     99.99% |    99.999% |
|--------------------------|------------|------------|------------|
| 1 in 10,000    = 0.01%   |     69,075 |     92,099 |    115,124 |
| 1 in 100,000   = 0.001%  |    690,773 |    921,030 |  1,151,287 |
| 1 in 1,000,000 = 0.0001% |  6,907,752 |  9,210,336 | 11,512,920 |
|-----------------------------------------------------------------|
```

<hr>
