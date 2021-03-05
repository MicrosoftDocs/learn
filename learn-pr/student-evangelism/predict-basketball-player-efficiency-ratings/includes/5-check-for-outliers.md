You still have some lingering missing values, but let's set those missing values aside for a moment. Otherwise, you might be tempted to impute replacement values, and possible outliers in the dataset might skew your replacements.

*Outliers* are data values so far outside the distribution of other values that they bring into question whether they even belong in the dataset. Outliers often arise from data errors or other undesirable noise. You'll always need to check for and deal with possible outliers before you analyze the data.

A quick way to identify outliers is to use the pandas `describe()` function:

```python
player_df.describe()
```

**Output**

|   | ID | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| count | 42.000000 | 42.000000 | 42.000000 | 42.000000 | 36.000000 | 37.00000 | 42.000000 | 42.000000 | 42.000000 | 42.000000 | 42.000000 | 42.000000 | 42.000000 | 33.000000 |
| mean | 23.738095 | 1592.380952 | 1346.323810 | 106.526190 | 59.861111 | 35.27027 | 0.596357 | 26.221429 | 13.083333 | 30.478571 | 4.280952 | 14.850000 | 8.497619 | 22.594242 |
| std | 13.826555 | 351.876707 | 214.503887 | 6.676791 | 5.576239 | 1.91135 | 0.029284 | 5.199275 | 2.038282 | 4.919079 | 2.074025 | 7.277538 | 4.995876 | 7.255338 |
| min | 1.000000 | 183.000000 | 147.300000 | 89.700000 | 48.000000 | 30.50000 | 0.511000 | 14.800000 | 9.200000 | 16.500000 | 0.000000 | 0.900000 | -2.900000 | 8.710000 |
| 25% | 12.250000 | 1390.750000 | 1283.650000 | 102.400000 | 55.750000 | 34.10000 | 0.572250 | 23.275000 | 11.350000 | 26.975000 | 2.925000 | 8.475000 | 5.225000 | 20.120000 |
| 50% | 23.500000 | 1680.000000 | 1369.800000 | 106.800000 | 60.500000 | 35.40000 | 0.604000 | 27.200000 | 13.500000 | 30.650000 | 4.650000 | 16.800000 | 9.150000 | 24.230000 |
| 75% | 35.750000 | 1826.250000 | 1444.050000 | 111.950000 | 64.000000 | 36.90000 | 0.618750 | 30.550000 | 14.775000 | 34.850000 | 5.900000 | 20.325000 | 12.875000 | 28.380000 |
| max | 46.000000 | 2062.000000 | 1542.000000 | 118.800000 | 69.000000 | 38.80000 | 0.645000 | 33.200000 | 16.200000 | 36.700000 | 8.300000 | 29.400000 | 16.400000 | 34.260000 |

Here you see, for example, that the mean for all 42 players is 1592.38 points. But look at the numbers for min (183), 25% (1390.75), 50% (1680.0), 75% (1826.25), and max (2062). Here, the min points (183) might be an outlier. You can use box plots to visualize the values and determine possible outliers.

## Create box plots for columns

The traditional tool for probing for outlying data values is the *box plot*. The *box* in *box plot* refers to a box drawn around the range of data from the 25th percentile to the 75th percentile. (These percentiles demarcate important quarters of the data. Their range is called the *interquartile* range.) This box is the middle 50% of the data values for a given variable (a column in a DataFrame). You use another line to mark the median of the data, which is the 50th percentile.

The box plot is also called a *box-and-whisker plot* because you draw a T shape above and below the box to encompass the maximum and minimum values of the data, *excluding outliers*. This last part is important for your purposes because it lets you graphically identify outliers.

Ideally, you would produce the box plots for your columns in a single matrix that you can easily scan. Unfortunately, no single function produces multiple box plots, so you'll write a `for` loop instead. 

Because of how the Seaborn library in Python works, you need to explicitly state the cell in the matrix where you want to render each box plot. Use the Python floor-division operator (`//`) to divide the 13 columns of interest (you don't need to look at `ID`) into rows. Use the modulo operator (`%`) to derive the column.

First, import the Matplotlib and [Seaborn](https://seaborn.pydata.org) libraries into your notebook:

```python
import matplotlib.pyplot as plt
import seaborn as sns
```

>[!NOTE]
>If you get an error when you import `matplotlib` or `seaborn`, you might need to install the libraries. For more information, see the [Matplotlib installation guide](https://matplotlib.org/3.3.2/users/installing.html?azure-portal=true) and the [Seaborn installation guide](https://seaborn.pydata.org/installing.html?azure-portal=true).

You should see no output, indicating that the libraries were successfully imported. Now you can:

- Create a list of the column names, excluding `ID`. Use the list to find specific values within each row.
- Create a matrix of subplots so you have one figure that shows all 13 columns.
- Add padding around the subplots to make them easier to read.
- Create a box plot based on the data in each column, across all of the rows.

```python
# Create a list of all column names, except for ID.
cols = list(player_df.iloc[:, 1:])

# Create a 3x5 matrix of subplots.
fig, axes = plt.subplots(3, 5, figsize=(18, 11))

# Create padding around subplots to make the axis labels readable.
fig.tight_layout(pad=2.0)

# Loop over the columns of the DataFrame and create a box plot for each one.
for i in range(len(cols)):
    sns.boxplot(ax=axes[i//5, i%5], y=player_df[cols[i]])
```

**Output**
:::image type="content" source="../media/dataframe-box-plots.png" alt-text="Screenshot showing DataFrame box plots." lightbox="../media/dataframe-box-plots.png":::

Sure enough, you can see two outliers in `points` and `possessions`. These outliers are represented as diamonds near the bottom of the first two box plots that visualize the `points` and `possessions` columns. The values are so far outside the range of the other data that they likely represent garbage data and not a seriously underperforming player.

Here, subject matter expertise becomes important. In this case, that expertise is knowledge about basketball. The likelihood of a professional player scoring only one point in their career is extremely small. Similarly, the likelihood of a player having 1,400 fewer possessions than the average number of possessions is also extremely small. So you can be confident that this outlying data is incorrect. 

In a different dataset, the factors might differ. So stopping to carefully evaluate outliers is critical to the data science journey.

## Identify and remove the rows that contain the outlier values

You could dig further into the data if you needed to. Was some of the data mistyped or corrupted in some way? With enough subject matter expertise or familiarity with how the data was gathered, you could attempt to correct the erroneous values. But you could also risk introducing your own bias or preconceived notions about the data into the dataset. Those accidents could ultimately hurt your analysis. Because you have 42 records remaining in the data, you're probably safest removing the offending row or rows.

The box plot tells you only that the outlying values exist, however. You now need to figure out the rows in which the values occur. 

Because both values occur below the minimum value of their respective columns, you can use the `idxmin()` method on both columns. This method returns the index number of the row in which a minimum value occurs. (You'll want to check each value separately.)

```python
# Identify the index number of the row that has the lowest value in 'points'.
points_outlier = player_df['points'].idxmin()
points_outlier
```

```output
35
```

```python
# Identify the index number of the row that has the lowest value in 'possession'.
possession_outlier = player_df['possessions'].idxmin()
possession_outlier
```

```output
35
```

Fortunately, the outliers are both on the same row. You can now use the `drop()` function again to manually remove the row.

You *could* manually enter the index number for the row. But this manual change would introduce the possibility of mistyping. Instead, use the variable you created to house the minimum value.

```python
# Drop the row that has the outlying values for 'points' and 'possessions'.
player_df.drop(player_df.index[points_outlier], inplace=True)

# Check the end of the DataFrame to ensure that the correct row was dropped.
player_df.tail(10)
```

**Output**

| | ID | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 31 | 36 | 2062.0 | 1505.7 | 111.5 | NaN | 37.0 | 0.620 | 29.8 | 15.6 | 36.2 | 4.9 | 23.9 | 14.7 | 27.86 |
| 32 | 37 | 1845.0 | 1435.7 | 113.1 | 69.0 | 36.9 | 0.634 | 33.2 | 14.0 | 36.5 | 4.1 | 21.5 | 16.4 | 34.26 |
| 33 | 38 | 1778.0 | 1526.4 | 109.3 | 66.0 | 34.9 | 0.612 | 30.6 | 15.9 | 35.9 | 5.5 | 18.8 | 13.7 | 28.65 |
| 34 | 39 | 1901.0 | 1444.1 | 109.7 | 67.0 | 36.5 | 0.609 | 27.2 | 14.8 | 35.5 | 5.0 | 21.8 | 8.9 | 20.12 |
| 36 | 41 | 2030.0 | 1431.0 | 112.3 | 68.0 | 37.0 | 0.618 | 32.5 | 15.3 | 34.5 | 5.7 | 15.7 | 13.2 | 30.07 |
| 37 | 42 | 1631.0 | 1465.7 | 110.1 | 66.0 | 37.5 | 0.613 | 28.4 | 14.4 | 35.7 | 6.5 | 20.7 | 14.0 | 28.40 |
| 38 | 43 | 1828.0 | 1507.2 | 112.7 | 64.0 | 36.5 | 0.618 | 31.3 | 14.0 | 34.9 | 5.9 | 21.3 | 14.5 | NaN |
| 39 | 44 | 1821.0 | 1443.7 | 118.8 | 66.0 | 36.6 | 0.609 | 27.3 | 13.5 | 35.8 | 7.0 | 23.8 | 11.5 | 22.96 |
| 40 | 45 | 1740.0 | 1443.9 | 114.1 | 68.0 | 37.1 | 0.611 | 26.6 | 15.2 | 29.3 | 8.3 | 17.7 | 11.1 | 21.22 |
| 41 | 46 | 1993.0 | 1459.0 | 112.5 | NaN | 36.9 | 0.627 | 30.4 | 15.0 | 33.7 | 6.3 | 19.3 | 14.1 | 28.76 |

Like the `head()` function, the `tail()` function shows the last five values of a DataFrame. And, sure enough, you've removed the row you needed to remove (for example, the row where the index is 35).

You can reset the index for the DataFrame again to ensure accuracy within the data:

```python
# Renumber the DataFrame index to reflect the dropped rows.
player_df.reset_index(drop=True, inplace=True)
```

If you execute `player_df.tail(10)` again, you'll see the indexes in order now until row 40.

© 2020 Warner Bros. Ent. All Rights Reserved.