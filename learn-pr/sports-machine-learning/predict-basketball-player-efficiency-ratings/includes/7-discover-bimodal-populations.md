Recognizing that data comes from different populations can be essential in data analysis for business. For example, imagine that you're analyzing occupancy data for a lodging-rental business. Vacation renters and business renters (such as individuals renting for a temporary business trip) could distribute themselves very differently for length of stay, time of year, or types of amenities required. Separating the two populations would be useful for purposes such as generating different marketing promotions for each population.

In your basketball scenario, you know the dataset includes a mixture of human basketball players and Tune Squad players. You can take a few of the more distinguished bimodal graphs, for example `points`, `DRR`, and `PER`, and try to differentiate the two populations. 

First, look at each distribution on its own:

```python
# Plot the KDE for 'points' over the probability-density histogram.
plt.hist(player_df['points'], density=True, bins=15)
plt.title('Points histogram')
sns.kdeplot(player_df['points']);
```

:::image type="content" source="../media/points-histogram.png" alt-text="Screenshot showing a points histogram.":::

You see that at around 1,600, the two populations split. You can use that information to explore the data further. For example, you could hypothesize that Tune Squad players might score more points because they have skills that humans don't have. 

Take a look at the rows where players scored more than 1,600 points: 

```python
player_df.loc[player_df['points'] >= 1600].info()
```

```output
<class 'pandas.core.frame.DataFrame'>
Int64Index: 23 entries, 0 to 40
Data columns (total 14 columns):
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   ID           23 non-null     int64  
 1   points       23 non-null     float64
 2   possessions  23 non-null     float64
 3   team_pace    23 non-null     float64
 4   GP           20 non-null     float64
 5   MPG          20 non-null     float64
 6   TS%          23 non-null     float64
 7   AST          23 non-null     float64
 8   TO           23 non-null     float64
 9   USG          23 non-null     float64
 10  ORR          23 non-null     float64
 11  DRR          23 non-null     float64
 12  REBR         23 non-null     float64
 13  PER          20 non-null     float64
dtypes: float64(13), int64(1)
memory usage: 2.7 KB
```

Twenty-three rows include players who scored at least 1,600 points. 

Continue to narrow down the players who are likely to be part of Tune Squad: 

```python
# Plot the KDE for 'DRR' over the probability-density histogram.
plt.hist(player_df['DRR'], density=True, bins=15)
plt.title('DRR histogram')
sns.kdeplot(player_df['DRR']);
```

:::image type="content" source="../media/drr-histogram.png" alt-text="Screenshot showing a D R R histogram.":::

At around 15 defensive rebounds, you see the distribution split. Check to see if that information helps narrow down the population that might be Tune Squad players. 

Again, you could hypothesize that Tune Squad players are more likely to try to get the ball in a defensive rebound because of their special skills. So count how many players (rows) scored more than 1,600 points and have a DRR of more than 15:

```python
player_df.loc[(player_df['points'] >= 1600) & (player_df['DRR'] >= 15)].info()
```

```output
<class 'pandas.core.frame.DataFrame'>
Int64Index: 18 entries, 0 to 40
Data columns (total 14 columns):
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   ID           18 non-null     int64  
 1   points       18 non-null     float64
 2   possessions  18 non-null     float64
 3   team_pace    18 non-null     float64
 4   GP           15 non-null     float64
 5   MPG          16 non-null     float64
 6   TS%          18 non-null     float64
 7   AST          18 non-null     float64
 8   TO           18 non-null     float64
 9   USG          18 non-null     float64
 10  ORR          18 non-null     float64
 11  DRR          18 non-null     float64
 12  REBR         18 non-null     float64
 13  PER          16 non-null     float64
dtypes: float64(13), int64(1)
memory usage: 2.1 KB
```

Finally, take a look at PER. If the hypothesis is correct so far, Tune Squad players probably have a higher PER.

```python
# Plot the KDE for 'PER' over the probability-density histogram.
plt.hist(player_df['PER'], density=True, bins=15)
plt.title('PER histogram')
sns.kdeplot(player_df['PER']);
```

:::image type="content" source="../media/per-histogram.png" alt-text="Screenshot showing a P E R histogram.":::

At around 17, the PER distributions split. Take a look at those rows that are at least 17 PER:

```python
player_df.loc[(player_df['points'] >= 1600) & (player_df['DRR'] >= 15) & (player_df['PER'] >= 17)]
```

**Output**

|  | ID | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 26 | 31 | 2049.0 | 1434.0 | 110.0 | 64.0 | 38.8 | 0.619 | 31.5 | 14.9 | 35.5 | 8.3 | 17.6 | 12.8 | 28.44 |
| 27 | 32 | 1795.0 | 1481.8 | 112.1 | 62.0 | 35.4 | 0.608 | 31.9 | 14.5 | 32.0 | 6.5 | 22.5 | 12.9 | 23.34 |
| 28 | 33 | 1805.0 | 1509.9 | 108.6 | 64.0 | 35.4 | 0.622 | 27.9 | 13.9 | 36.0 | 5.9 | 27.7 | 12.2 | 22.41 |
| 30 | 35 | 1963.0 | 1539.1 | 117.4 | NaN | NaN | 0.633 | 32.3 | 16.2 | 34.0 | 5.9 | 19.8 | 13.1 | 27.16 |
| 31 | 36 | 2062.0 | 1505.7 | 111.5 | NaN | 37.0 | 0.620 | 29.8 | 15.6 | 36.2 | 4.9 | 23.9 | 14.7 | 27.86 |
| 32 | 37 | 1845.0 | 1435.7 | 113.1 | 69.0 | 36.9 | 0.634 | 33.2 | 14.0 | 36.5 | 4.1 | 21.5 | 16.4 | 34.26 |
| 33 | 38 | 1778.0 | 1526.4 | 109.3 | 66.0 | 34.9 | 0.612 | 30.6 | 15.9 | 35.9 | 5.5 | 18.8 | 13.7 | 28.65 |
| 34 | 39 | 1901.0 | 1444.1 | 109.7 | 67.0 | 36.5 | 0.609 | 27.2 | 14.8 | 35.5 | 5.0 | 21.8 | 8.9 | 20.12 |
| 35 | 41 | 2030.0 | 1431.0 | 112.3 | 68.0 | 37.0 | 0.618 | 32.5 | 15.3 | 34.5 | 5.7 | 15.7 | 13.2 | 30.07 |
| 36 | 42 | 1631.0 | 1465.7 | 110.1 | 66.0 | 37.5 | 0.613 | 28.4 | 14.4 | 35.7 | 6.5 | 20.7 | 14.0 | 28.40 |
| 38 | 44 | 1821.0 | 1443.7 | 118.8 | 66.0 | 36.6 | 0.609 | 27.3 | 13.5 | 35.8 | 7.0 | 23.8 | 11.5 | 22.96 |
| 39 | 45 | 1740.0 | 1443.9 | 114.1 | 68.0 | 37.1 | 0.611 | 26.6 | 15.2 | 29.3 | 8.3 | 17.7 | 11.1 | 21.22 |
| 40 | 46 | 1993.0 | 1459.0 | 112.5 | NaN | 36.9 | 0.627 | 30.4 | 15.0 | 33.7 | 6.3 | 19.3 | 14.1 | 28.76 |

You could reasonably expect these rows to represent the Tune Squad players. For the purposes of this module, the 15 Tune Squad players were in fact added to the very end of the dataset. If you didn't know that detail, though, you could reasonably assume the data was compiled from two different datasets, where the second dataset was added to the end of the first dataset. 

The rows for player IDs 34 and 40 aren't a part of this set. Although index 34 and index 40 appear, the IDs 34 and 40 don't. You removed 40 earlier because the points in that row were only 183. Now look at player ID 34:

```python
player_df.loc[player_df['ID'] == 34]
```

**Output**

| | ID | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 29 | 34 | 1743.0 | 1422.4 | 112.9 | 64.0 | 36.3 | 0.619 | 30.9 | 15.6 | 34.5 | 5.9 | 18.9 | 14.8 | NaN |

The PER for player 34 is `NaN`. You haven't imputed any data yet, so that value makes sense.

© 2020 Warner Bros. Ent. All Rights Reserved.