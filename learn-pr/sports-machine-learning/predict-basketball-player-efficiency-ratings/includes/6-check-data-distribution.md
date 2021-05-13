You removed the row that had the outliers in the `points` and `possessions` columns. But you still have to deal with scattered missing values. Review those missing values now:

```python
# Recheck the totals for NaN values by row.
player_df.isna().sum()
```

```output
ID             0
points         0
possessions    0
team_pace      0
GP             6
MPG            5
TS%            0
AST            0
TO             0
USG            0
ORR            0
DRR            0
REBR           0
PER            9
dtype: int64
```

That's a lot of missing values. They might span many more rows, and you wouldn't want to discard that much data. Can you make some educated guesses about what to fill in for them?

As a review, the following table describes the data you're working with in the dataset. Data in different columns can behave quite differently. So apply some domain expertise to the data as you decide how to impute missing values.

| Column name | Description |
|-------------|--------------------|
| ID | A unique identifier for each player in the dataset |
| points | Total points scored by a player in a season |
| possessions | Total possessions by a player in a season |
| team_pace | Average number of possessions a team uses per game |
| GP | Games played by a player in a season |
| MPG | Average minutes played by a player per game |
| TS% | True shooting percentage, the player's shooting percentage, taking into account free throws and three-pointers  |
| AST | Assist ratio, the percentage of a player's possessions that end in an assist |
| TO | Turnover ratio, the percentage of a player's possessions that end in a turnover |
| USG | Usage rate, the number of possessions a player uses per 40 minutes |
| ORR | Offensive rebound rate |
| DRR | Defensive rebound rate |
| REBR | Rebound rate, the percentage of missed shots that a player rebounds |
| PER | Player efficiency rating, the measure of a player's per-minute productivity on the court |

One common strategy for imputation is to replace a missing value with the value immediately above or below it. But your missing values are for pace, points, possessions, and PER. Also, you don't know the order of the players in the DataFrame. For example, you don't know whether consecutive players are on the same team. So replacing missing values with nearby values is probably not a good strategy here.

Another common technique is to replace missing values in a column with the average value of that column. This technique might be appropriate for these columns. But you should check to see how the data in each column is distributed.

## Create histograms of the DataFrame data

A common way to visualize the distribution of data is a histogram. A *histogram* is a bar chart that shows how many times the data in a dataset appears within a range of values. Ranges are called *bins*. You'll produce a pretty granular view of the data by using 30 bins to construct histograms.

No built-in function in Python or in commonly used libraries plots multiple histograms. So you'll create the histograms by using a `for` loop as you did with the box plots. 

>[!NOTE]
>Matplotlib is a little easier than Seaborn when it comes to histograms. You can just plot the histograms sequentially without explicitly stating the column and row for each histogram.

```python
# Create a list of all column names, except for 'ID'.
cols = list(player_df.iloc[:, 1:])

# Define the size for the plots and add padding around them.
fig = plt.figure(figsize=(18, 11))
fig.tight_layout(pad=5.0)

# Loop over the columns in the DataFrame and create a histogram for each one.
for i in range(len(cols)):
    plt.subplot(3, 5, i+1)
    plt.hist(player_df[cols[i]], bins=30)
    plt.title(cols[i])
```

:::image type="content" source="../media/dataframe-histograms.png" alt-text="Screenshot showing DataFrame histograms." lightbox="../media/dataframe-histograms.png":::

Most of these histograms don't look normally distributed (the familiar bell curve). But it's tough to be certain by using only the human eye. You could try using fewer bins, but you might miss some important information in a lower-resolution histogram. Instead, try a different kind of visualization.

Take a look at a single histogram for a moment. In this case, you'll look at the histogram for `GP` (games played).

```python
# Create a histogram for the 'GP' column.
plt.hist(player_df['GP'], bins=30);
```
:::image type="content" source="../media/small-bin-histogram.png" alt-text="Screenshot showing a small-bin histogram.":::

> [!Note] 
> A semicolon (`;`) at the end of the `hist()` function call will cause the output to show only the graph. The output won't show any additional textual information about the underlying data. 
> 
> For example, if you remove the `;` from the preceding line, you see the following output before the graph:
>
> ```output
> (array([1., 0., 1., 0., 1., 2., 0., 0., 1., 0., 3., 1., 3., 0., 2., 2., 0.,
>         1., 2., 0., 1., 3., 4., 0., 0., 3., 0., 2., 2., 1.]),
>  array([48. , 48.7, 49.4, 50.1, 50.8, 51.5, 52.2, 52.9, 53.6, 54.3, 55. ,
>         55.7, 56.4, 57.1, 57.8, 58.5, 59.2, 59.9, 60.6, 61.3, 62. , 62.7,
>         63.4, 64.1, 64.8, 65.5, 66.2, 66.9, 67.6, 68.3, 69. ]),
>  <a list of 30 Patch objects>)
>  ```


Currently, the histogram provides the number of counts for each bin. But you could change the `density` parameter in the function so that the height of each column in the histogram shows that column's share of the overall area of the histogram rather than instance counts. In other words, `density=True` means that the area of the columns in the histogram adds up to 1.

```python
# Create a histogram for the 'GP' column, this time as a probability density.
plt.hist(player_df['GP'], density=True, bins=30);
```

:::image type="content" source="../media/small-bin-histogram-with-probability-density.png" alt-text="Screenshot showing a small-bin histogram that includes probability density.":::

## Create kernel-density estimates of the DataFrame data

You don't have to use rectangles in the histogram. You could instead use triangles, trapezoids, or even tiny Gaussian bell curves. This latter shape is basically what the kernel-density estimate (KDE) does. It essentially creates a histogram of little bells curves. The area under the bell curves is 1. 

Here's what the KDE of `GP` looks like compared to a 15-bin histogram:

```python
# Plot the KDE for 'GP' over the probability-density histogram.
plt.hist(player_df['GP'], density=True, bins=15)
plt.title('GP histogram')
sns.kdeplot(player_df['GP']);
```

:::image type="content" source="../media/large-bin-histogram-kde-overlay.png" alt-text="Screenshot showing a large-bin histogram overlaid with K D E.":::

More clearly than the histogram, the KDE helps you see that `GP`'s distribution is kind of bell-shaped, and it has a bulge on the right side. 

Use a `for` loop to generate a matrix of KDEs for all of the columns:

```python
# Create a list of all column names, except for 'ID'.
cols = list(player_df.iloc[:, 1:])

# Create a 3x5 matrix of subplots and add padding around them for readability.
fig, axes = plt.subplots(3, 5, figsize=(18, 11))
fig.tight_layout(pad=2.0)

# Loop over the columns of the DataFrame and create a KDE for each one.
for i in range(len(cols)):
    sns.kdeplot(ax=axes[i//5, i%5], data=player_df[cols[i]])
```

:::image type="content" source="../media/dataframe-kdes.png" alt-text="Screenshot showing DataFrame K D Es." lightbox="../media/dataframe-kdes.png":::

Sure enough, many of these columns have KDEs that have two pronounced tops. Each top represents a mode of the data, or a value around which values in the dataset concentrate. The fact that so many of the columns are bimodal indicates that the dataset represents samples from two discrete populations.

© 2020 Warner Bros. Ent. All Rights Reserved.