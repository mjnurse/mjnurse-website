---
title: Dashboard Design Principles
layout: page-with-contents-list
---

'The greatest value of a picture is when it forces us to notice what we never expected to see'*John Tukey, 'Exploratory Data Analysis', 1977*

'A picture is worth a thousand words. An interface is worth a thousand pictures'*Ben Shneiderman, 2003*

'Data becomes useful knowledge of something that matters when it builds a bridge between a question and an answer. This connection is the signal.' *Stephen Few, 'Signal: Understanding What Matters in a World of Noise, 2015*

'Graphical excellence is that which gives to the viewer the greatest number of ideas in the shortest time with the least ink in the smallest space.' *Edward R. Tufte, 'The Visual Display of Quantitative Information', 2nd. Ed.*

*Data Visualisation should enable us to present insights and better representations of the truth so that businesses can make accurate and informed decisions in the least amount of time.*

# Choosing The Right Chart Type

## Displaying Nominal Data

Use bar charts for nominal data. A line chart suggests progression of data values left to right.

![](images/dashboard-design-01.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-02.png) ![](images/dashboard-design-97.png)

## Displaying Qualitative Data

Bar charts, particularly stacked bar charts, work well with Qualitative data.

![](images/dashboard-design-05.png) ![](images/dashboard-design-97.png)
![](images/dashboard-design-06.png) ![](images/dashboard-design-98.png)

## Displaying Sequential Data - Trends Over Time

Always left to right. Line graphs are good for comparing multiple trend categories.

![](images/dashboard-design-07.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-08.png) ![](images/dashboard-design-97.png)

## Bubble Charts

Bubble charts are a powerful chart for showing data across 3 dimensions for multiple categories.

![](images/dashboard-design-09.png)
![](images/dashboard-design-10.png)

## Take Care With Bubbles - They Can Be Deceiving

In the charts below the UK value is half the US value but the UK bubble is deceivingly large.

![](images/dashboard-design-11.png)
![](images/dashboard-design-12.png)

## Use Pie Charts With Care

If you use a pie chart label the segments. For example which has larger sales, Rabbit or Rat?

![](images/dashboard-design-13.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-14.png) ![](images/dashboard-design-97.png)

## A Well Structured Bar Chart Is Often Much Clearer and More Compact Than a Pie Chart

Visual perception works better comparing attribute line length vs. angles and areas.

![](images/dashboard-design-15.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-16.png) ![](images/dashboard-design-97.png)

# Using Colours Appropriately

Use colours sparingly - only use colour when it has meaning. Note: 10% males and 1% females cannot distinguish between Red and Green

![](images/dashboard-design-17.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-18.png) ![](images/dashboard-design-97.png)

Use colour as a dimension.

![](images/dashboard-design-19.png) ![](images/dashboard-design-97.png)
![](images/dashboard-design-20.png) ![](images/dashboard-design-97.png)

# Ordering Data

## Consider Ordering By Measures Rather Than Categories

Ordering charts my the measure can help with comparisons and finding minimum/maximum values.

![](images/dashboard-design-21.png) ![](images/dashboard-design-97.png)
![](images/dashboard-design-22.png) ![](images/dashboard-design-98.png)

## Grouping

Group Low Value Categories To Save Space And Focus On The Key Items.

![](images/dashboard-design-23.png) ![](images/dashboard-design-97.png)
![](images/dashboard-design-24.png) ![](images/dashboard-design-98.png)

# Chart Axis

## Axis Scales

**Nominal**: Discrete items from a shared category but with no intrinsic order: e.g. Red, Green, Blue, Yellow.

**Ordinal**: Items that have an intrinsic order but do not correspond to quantitative values: e.g. A,B,C,D,E

**Interval**: Items that have an intrinsic order and correspond to quantitative values: e.g. Jan, Feb, Mar, Apr, May...

## Orientation

Charts should normally be wider than they are tall - typically 50% wider than tall.

Eye is naturally practised in detecting deviations from the horizon.

Where the X and Y axis values are compared (for example in scatter plot) then the Chart can be square to avoid any bias.

## Axis Labels

Avoid overlapping labels - rotate text where appropriate. However if you see users tilting their head, consider swapping the axes.

![](images/dashboard-design-25.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-26.png) ![](images/dashboard-design-97.png)
![](images/dashboard-design-27.png) ![](images/dashboard-design-97.png)

## Bar Chart Axis Start Point

Bar Charts should normally start from 0 on the measure axis. A compressed axis can hide the differences.

![](images/dashboard-design-03.png) ![](images/dashboard-design-97.png)
![](images/dashboard-design-04.png) ![](images/dashboard-design-98.png)

## Consider Using Charts To Plot Percentage Change Rather Than Value

Use colours sparingly - only use colour when it has meaning. Note: 10% males and 1% females cannot distinguish between Red and Green

![](images/dashboard-design-28.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-29.png) ![](images/dashboard-design-97.png)

# Formatting Charts

## Remove Unnecessary Chart Decoration

Any pixels which are not directly conveying data should be avoided/removed.

![](images/dashboard-design-30.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-31.png) ![](images/dashboard-design-97.png)

## 3D Charts

Avoid 3D Charts - They rarely help to explain the data.

![](images/dashboard-design-32.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-33.png) ![](images/dashboard-design-99.png)

# Simplify Charts

## Consider Breaking Up Difficult To Read Charts

Charts with multiple categories can confuse the message. Consider using a collection of simple charts in its place.

![](images/dashboard-design-34.png)

Create one chart for each category. Ensure all charts share the same axis range so charts can be compared.

![](images/dashboard-design-50.png)

# In Table Charts

Small charts embedded in tables can bring the data to life.

![](images/dashboard-design-41.png)

# Tables

## Creating Effective Tables

- **Do not use a grid **to define rows and columns
- To separate rows, use only **whitespace** whenever possible
- Second choice: use a **subtle fill color **('zebra striping') or a **subtle gridlines** (grey, dotted)
- Columns rarely need anything other than whitespace and proper alignment (see next page)
- Use simple dark borders below the column headings and at the bottom of the table
- Text alignment/formatting **Column headers **should align with the information contained in the columns:
- **Text** - Align left
- **Dates** - Align left; make consistent width
- **Numbers** - Align right; use consistent number of decimal places

![](images/dashboard-design-42.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-43.png) ![](images/dashboard-design-97.png)
![](images/dashboard-design-44.png) ![](images/dashboard-design-97.png)
![](images/dashboard-design-45.png) ![](images/dashboard-design-97.png)

## Using Colour In Tables Can Highlight Important Cells

Limit the number of cells being coloured otherwise the value of the highlight can be lost. Limit the number of colours used.

![](images/dashboard-design-46.png) ![](images/dashboard-design-99.png)
![](images/dashboard-design-47.png) ![](images/dashboard-design-97.png)

<hr>
