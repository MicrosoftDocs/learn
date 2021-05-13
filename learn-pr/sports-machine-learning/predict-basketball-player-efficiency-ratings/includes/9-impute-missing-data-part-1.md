You know that values are missing throughout the data. Take another look at the columns that are missing values.

```python
# Recheck the totals for NaN values by row.
player_df.isna().sum()
```

```output
ID             0
player         0
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

First, revisit the histograms for `GP` and `MPG`:

```python
# Plot the KDE for 'GP' over the probability-density histogram.
plt.hist(player_df['GP'], density=True, bins=15)
plt.title('GP histogram')
sns.kdeplot(player_df['GP']);
```

:::image type="content" source="../media/gp-histogram.png" alt-text="Screenshot showing the G P histogram.":::

```python
# Plot the KDE for 'MPG' over the probability-density histogram.
plt.hist(player_df['MPG'], density=True, bins=15)
plt.title('MPG histogram')
sns.kdeplot(player_df['MPG']);
```

:::image type="content" source="../media/mpg-histogram.png" alt-text="Screenshot showing the M P G histogram.":::

If you squint hard, you'll probably agree that `GP` and `MPG` are both close enough to a normal distribution that you can justify imputing their missing values by using the average value for each column. But this solution won't work for `PER`:

```python
# Plot the KDE for 'PER' over the probability-density histogram.
plt.hist(player_df['PER'], density=True, bins=15)
plt.title('PER histogram')
sns.kdeplot(player_df['PER']);
```

:::image type="content" source="../media/per-histogram.png" alt-text="Screenshot showing the P E R histogram.":::

You'll have to handle `PER` differently, in the next unit.

## Impute missing values by using average values

To impute the missing values in the normally-enough distributed columns, use the `fillna()` DataFrame method. In the code, state that you're working with only three of the columns (`player_df[['GP','MPG']]`). Also state that you want to replace the `NaN` values in each of those columns with those columns' respective mean values: `fillna(value=player_df[['GP','MPG']].mean())`. (Once again, stringing together pandas methods makes your job much easier.)

```python
# Replace the missing values in 'GP' and 'MPG' with the mean values of the respective columns.
player_df[['GP','MPG']] = player_df[['GP','MPG']].fillna(value=player_df[['GP','MPG']].mean())

# Recheck the totals for NaN values by row to ensure that the expected missing values are filled in.
player_df.isna().sum()
```

```output

ID             0
player         0
points         0
possessions    0
team_pace      0
GP             0
MPG            0
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

Your data is nearly cleansed! You have only one column left to manipulate.

© 2020 Warner Bros. Ent. All Rights Reserved.