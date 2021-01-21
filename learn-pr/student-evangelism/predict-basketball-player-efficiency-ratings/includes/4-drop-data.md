One of the quickest ways to cleanse data is to drop columns and rows that don't add value to your data-discovery goals. In the previous unit, you discovered two columns that have only `NaN` values for each row. They were unnamed columns, so they were probably included in the original dataset by mistake. Those columns are straightforward to drop.

## Drop columns

To drop columns, you'll use the `dropna()` method. Like `isna()`, `dropna()` looks for `NaN` values. But it goes a step further and removes either the rows or the columns that contain `NaN` values. Start by setting some parameters to the method:

- By default, `dropna()` removes rows, so specify that you want to remove columns by using the `axis` parameter.
- The `dropna()` method usually returns a new DataFrame. Use the `inplace` parameter to tell it to drop these columns in the original `player_df` DataFrame.
- You also want `dropna()` to remove only columns in which all of the values are missing. So set the `how` parameter to `'all'`.

```python
# Drop columns that have no values.
player_df.dropna(axis='columns', inplace=True, how='all')
player_df.isna().sum()
```

```output
ID              0
points          3
possessions     3
team_pace       3
GP              7
MPG             6
TS%             1
AST             1
TO              1
USG             1
ORR             1
DRR             1
REBR            1
PER            10
dtype: int64
```

You successfully removed the empty columns. You see that if you call `.info()` again:

```python
player_df.info()
```

```output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 46 entries, 0 to 45
Data columns (total 14 columns):
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   ID           46 non-null     int64  
 1   points       43 non-null     float64
 2   possessions  43 non-null     float64
 3   team_pace    43 non-null     float64
 4   GP           39 non-null     float64
 5   MPG          40 non-null     float64
 6   TS%          45 non-null     float64
 7   AST          45 non-null     float64
 8   TO           45 non-null     float64
 9   USG          45 non-null     float64
 10  ORR          45 non-null     float64
 11  DRR          45 non-null     float64
 12  REBR         45 non-null     float64
 13  PER          36 non-null     float64
dtypes: float64(13), int64(1)
memory usage: 5.2 KB
```

You now have only 14 columns instead of 16. Most of the rows have data for each column.

## Drop rows

You should also address the possibility that an entire row is missing values. That is, one of the players in the DataFrame might have no stats. You can try to address this missing row as you did last time, by using `dropna()`. But this time, use the method's default row-based behavior.

```python
# Drop rows that have no values.
player_df.dropna(inplace=True, how='all')
player_df.isna().sum()
```

```output
ID              0
points          3
possessions     3
team_pace       3
GP              7
MPG             6
TS%             1
AST             1
TO              1
USG             1
ORR             1
DRR             1
REBR            1
PER            10
dtype: int64
```

Hmmm. No change. So you know that no row has all `NaN` values. That's great!

Now look at the DataFrame itself. It's large enough that you wouldn't want to print all of the rows all the time. But it's not so large that it's unmanageable to print it here once.

```python
# Show the entire DataFrame.
player_df
```

**Output**

|  | ID | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 1 | 1893.0 | 1251.8 | 97.8 | 63.0 | 33.9 | 0.569 | 17.2 | 11.5 | 26.1 | 4.7 | 23.3 | 7.8 | 10.90 |
| 1 | 2 | 1386.0 | 1282.5 | 110.5 | 58.0 | 32.5 | 0.511 | 24.8 | 9.7 | 26.9 | 6.1 | 0.9 | 10.7 | 27.30 |
| 2 | 3 | 1405.0 | 1252.3 | 105.8 | 55.0 | 36.3 | 0.605 | 25.7 | 13.9 | 28.1 | 4.5 | 4.9 | 1.8 | NaN |
| 3 | 4 | 1282.0 | 1235.9 | 100.7 | 54.0 | 37.6 | 0.636 | 29.5 | 11.0 | 22.3 | 4.8 | 4.6 | 5.6 | 22.35 |
| 4 | 5 | 1721.0 | 1254.0 | 105.7 | 59.0 | 30.5 | 0.589 | 22.8 | 9.9 | 24.6 | 1.2 | 8.4 | 12.1 | 28.38 |
| 5 | 6 | 1004.0 | 1322.4 | 102.1 | 57.0 | 36.3 | 0.574 | 20.3 | 13.5 | 31.0 | 1.2 | 20.5 | 3.4 | 9.83 |
| 6 | 7 | 1920.0 | 1207.6 | 109.8 | 55.0 | 37.0 | 0.573 | 26.0 | 13.1 | 30.7 | 0.0 | 10.3 | -2.6 | 8.71 |
| 7 | 8 | 1353.0 | 1348.1 | 112.2 | 57.0 | NaN | 0.574 | 24.4 | 11.3 | 26.3 | 5.5 | 5.8 | -2.2 | NaN |
| 8 | 9 | NaN | NaN | NaN | 54.0 | 31.7 | 0.577 | 24.6 | 14.4 | 35.7 | 2.5 | 14.1 | -4.6 | 4.68 |
| 9 | 10 | 1468.0 | 1400.9 | 93.7 | 61.0 | 35.6 | 0.547 | 22.9 | 12.2 | 22.7 | 5.8 | 6.4 | -2.9 | NaN |
| 10 | 11 | 1856.0 | 1303.8 | 93.4 | 55.0 | 33.6 | 0.563 | 28.9 | 14.7 | 26.7 | 1.4 | 17.3 | 4.3 | 9.67 |
| 11 | 12 | 1058.0 | 1231.5 | 99.4 | 63.0 | 32.8 | 0.550 | 25.1 | 12.9 | 27.2 | 2.1 | 12.1 | 11.4 | 22.97 |
| 12 | 13 | 1452.0 | 1246.1 | 103.6 | NaN | 31.7 | 0.584 | 32.4 | 14.7 | 16.5 | 3.2 | 19.0 | 4.1 | NaN |
| 13 | 14 | 1438.0 | 1499.6 | 108.1 | 60.0 | 35.0 | 0.569 | 28.6 | 12.2 | 36.2 | 4.9 | 6.0 | 7.4 | 27.57 |
| 14 | 15 | 1782.0 | 1329.0 | 104.6 | 51.0 | NaN | 0.590 | 26.5 | 9.9 | 29.7 | 3.1 | 29.4 | 5.5 | 9.38 |
| 15 | 16 | 1276.0 | 1257.5 | 89.7 | 58.0 | 32.8 | 0.572 | 15.5 | 16.2 | 23.8 | 3.4 | 15.4 | 6.0 | 9.49 |
| 16 | 17 | 1486.0 | 1343.6 | 100.6 | NaN | 34.9 | 0.603 | 26.2 | 11.1 | 36.7 | 3.0 | 14.3 | 5.3 | NaN |
| 17 | 18 | 1326.0 | 1542.0 | 107.8 | 52.0 | 31.8 | 0.583 | 25.3 | 11.7 | 30.6 | 3.3 | 9.9 | 5.3 | 19.78 |
| 18 | 19 | 1535.0 | 1336.2 | 104.0 | 56.0 | 35.4 | 0.636 | 27.2 | 10.8 | 29.9 | 0.7 | 5.6 | 7.9 | 30.44 |
| 19 | 20 | NaN | NaN | NaN | 57.0 | 34.0 | 0.526 | 28.3 | 11.7 | 25.6 | 3.1 | 4.7 | 1.0 | 11.57 |
| 20 | 21 | 1276.0 | 1354.9 | 101.2 | 50.0 | NaN | 0.560 | 21.4 | 12.4 | 28.6 | 2.6 | 9.3 | 10.3 | 24.23 |
| 21 | 22 | 1784.0 | 1287.1 | 101.3 | 59.0 | 33.8 | 0.601 | 27.2 | 12.4 | 21.8 | 2.9 | 5.2 | 9.9 | 25.15 |
| 22 | 23 | 1729.0 | 1205.0 | 103.8 | 61.0 | NaN | 0.645 | 20.6 | 13.1 | 31.5 | 4.0 | 12.0 | 5.2 | NaN |
| 23 | 24 | 1639.0 | 1287.4 | 105.2 | 52.0 | 35.4 | 0.570 | 32.7 | 15.0 | 26.6 | 1.6 | 5.0 | 9.4 | 25.12 |
| 24 | 25 | NaN | NaN | NaN | 59.0 | 34.9 | 0.578 | 16.9 | 11.8 | 28.7 | 2.8 | 14.1 | 3.0 | 12.27 |
| 25 | 26 | 1370.0 | 1384.7 | 103.3 | NaN | 34.2 | 0.571 | 14.8 | 9.9 | 33.1 | 2.4 | 16.3 | 3.7 | 15.04 |
| 26 | 27 | 1497.0 | 1410.9 | 98.3 | 57.0 | 34.1 | 0.613 | 15.4 | 10.0 | 29.3 | 3.8 | 5.7 | 6.7 | 25.35 |
| 27 | 28 | 1313.0 | 1420.5 | 105.0 | 48.0 | 35.1 | 0.569 | 19.0 | 10.9 | 29.2 | 4.6 | 17.7 | 5.2 | NaN |
| 28 | 29 | 1464.0 | 1353.4 | 103.3 | 63.0 | 34.4 | 0.595 | 17.9 | 9.2 | 29.3 | 1.0 | 8.7 | 4.1	20.49 |
| 29 | 30 | 1645.0 | 1415.7 | 109.8 | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN | NaN |
| 30 | 31 | 2049.0 | 1434.0 | 110.0 | 64.0 | 38.8 | 0.619 | 31.5 | 14.9 | 35.5 | 8.3 | 17.6 | 12.8 | 28.44 |
| 31 | 32 | 1795.0 | 1481.8 | 112.1 | 62.0 | 35.4 | 0.608 | 31.9 | 14.5 | 32.0 | 6.5 | 22.5 | 12.9 | 23.34 |
| 32 | 33 | 1805.0 | 1509.9 | 108.6 | 64.0 | 35.4 | 0.622 | 27.9 | 13.9 | 36.0 | 5.9 | 27.7 | 12.2 | 22.41 |
| 33 | 34 | 1743.0 | 1422.4 | 112.9 | 64.0 | 36.3 | 0.619 | 30.9 | 15.6 | 34.5 | 5.9 | 18.9 | 14.8 | NaN |
| 34 | 35 | 1963.0 | 1539.1 | 117.4 | NaN | NaN | 0.633 | 32.3 | 16.2 | 34.0 | 5.9 | 19.8 | 13.1 | 27.16 |
| 35 | 36 | 2062.0 | 1505.7 | 111.5 | NaN | 37.0 | 0.620 | 29.8 | 15.6 | 36.2 | 4.9 | 23.9 | 14.7 | 27.86 |
| 36 | 37 | 1845.0 | 1435.7 | 113.1 | 69.0 | 36.9 | 0.634 | 33.2 | 14.0 | 36.5 | 4.1 | 21.5 | 16.4 | 34.26 |
| 37 | 38 | 1778.0 | 1526.4 | 109.3 | 66.0 | 34.9 | 0.612 | 30.6 | 15.9 | 35.9 | 5.5 | 18.8 | 13.7 | 28.65 |
| 38 | 39 | 1901.0 | 1444.1 | 109.7 | 67.0 | 36.5 | 0.609 | 27.2 | 14.8 | 35.5 | 5.0 | 21.8 | 8.9 | 20.12 |
| 39 | 40 | 183.0 | 147.3 | 118.1 | 63.0 | 37.5 | 0.623 | 31.2 | 13.5 | 34.7 | 6.3 | 18.7 | 13.6 | 29.81 |
| 40 | 41 | 2030.0 | 1431.0 | 112.3 | 68.0 | 37.0 | 0.618 | 32.5 | 15.3 | 34.5 | 5.7 | 15.7 | 13.2 | 30.07 |
| 41 | 42 | 1631.0 | 1465.7 | 110.1 | 66.0 | 37.5 | 0.613 | 28.4 | 14.4 | 35.7 | 6.5 | 20.7 | 14.0 | 28.40 |
| 42 | 43 | 1828.0 | 1507.2 | 112.7 | 64.0 | 36.5 | 0.618 | 31.3 | 14.0 | 34.9 | 5.9 | 21.3 | 14.5 | NaN |
| 43 | 44 | 1821.0 | 1443.7 | 118.8 | 66.0 | 36.6 | 0.609 | 27.3 | 13.5 | 35.8 | 7.0 | 23.8 | 11.5 | 22.96 |
| 44 | 45 | 1740.0 | 1443.9 | 114.1 | 68.0 | 37.1 | 0.611 | 26.6 | 15.2 | 29.3 | 8.3 | 17.7 | 11.1 | 21.22 |
| 45 | 46 | 1993.0 | 1459.0 | 112.5 | NaN | 36.9 | 0.627 | 30.4 | 15.0 | 33.7 | 6.3 | 19.3 | 14.1 | 28.76 |

Now you see that three rows are missing the same three values. Another row is missing 10 values. This information indicates two things:

- The dataset likely comes from two datasets that were joined together, and both of these earlier datasets had missing rows.
- You'll need to use critical thinking to determine how to remove these rows.

The dataset is small enough that you could manually drop the problem rows. But that shortcut wouldn't give you practice dealing with larger datasets, where manual removal isn't practical. So use the built-in pandas methods instead.

The `how` parameter in `dropna()` can be set to only `'any'` or `'all'`. Neither of those settings will get you what you need. Instead, use the `thresh` parameter.

The `thresh` parameter refers to *threshold*. This parameter lets you set the minimum number of non-`NaN` values a row or column needs to avoid being dropped by `dropna()`. To remove specific rows from the DataFrame, set `thresh` to `12`.

```python
# Drop all rows that don't have at least 12 non-NaN values.
player_df.dropna(inplace=True, thresh=12)
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

Now only three columns are missing values. But the rows have so few missing values that it's best to keep the rows and fill in the missing values with likely numbers. You'll address these rows in another unit. 

## Reset the DataFrame index

Because you've dropped rows, the index in the DataFrame is compromised. You see this problem if you print out the first 10 rows of the DataFrame:

```python
# Print the first 10 rows of the player_df DataFrame.
player_df.head(10)
```

**Output**

|  | ID | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 1 | 1893.0 | 1251.8 | 97.8 | 63.0 | 33.9 | 0.569 | 17.2 | 11.5 | 26.1 | 4.7 | 23.3 | 7.8 | 10.90 |
| 1 | 2 | 1386.0 | 1282.5 | 110.5 | 58.0 | 32.5 | 0.511 | 24.8 | 9.7 | 26.9 | 6.1 | 0.9 | 10.7 | 27.30 |
| 2 | 3 | 1405.0 | 1252.3 | 105.8 | 55.0 | 36.3 | 0.605 | 25.7 | 13.9 | 28.1 | 4.5 | 4.9 | 1.8 | NaN |
| 3 | 4 | 1282.0 | 1235.9 | 100.7 | 54.0 | 37.6 | 0.636 | 29.5 | 11.0 | 22.3 | 4.8 | 4.6 | 5.6 | 22.35 |
| 4 | 5 | 1721.0 | 1254.0 | 105.7 | 59.0 | 30.5 | 0.589 | 22.8 | 9.9 | 24.6 | 1.2 | 8.4 | 12.1 | 28.38 |
| 5 | 6 | 1004.0 | 1322.4 | 102.1 | 57.0 | 36.3 | 0.574 | 20.3 | 13.5 | 31.0 | 1.2 | 20.5 | 3.4 | 9.83 |
| 6 | 7 | 1920.0 | 1207.6 | 109.8 | 55.0 | 37.0 | 0.573 | 26.0 | 13.1 | 30.7 | 0.0 | 10.3 | -2.6 | 8.71 |
| 7 | 8 | 1353.0 | 1348.1 | 112.2 | 57.0 | NaN | 0.574 | 24.4 | 11.3 | 26.3 | 5.5 | 5.8 | -2.2 | NaN |
| 9 | 10 | 1468.0 | 1400.9 | 93.7 | 61.0 | 35.6 | 0.547 | 22.9 | 12.2 | 22.7 | 5.8 | 6.4 | -2.9 | NaN |
| 10 | 11 | 1856.0 | 1303.8 | 93.4 | 55.0 | 33.6 | 0.563 | 28.9 | 14.7 | 26.7 | 1.4 | 17.3 | 4.3 | 9.67 |

You see that the index counts 0 through 10, skipping 8. The row that had the index of 8 was dropped because it had more than two `NaN` values. In the 14 columns, the rows that had three or more `NaN` values didn't meet the threshold of 12 you set when you dropped rows earlier.

To fix this problem, reset the index for the DataFrame. This fix saves you from problems down the road when you're working with the DataFrame. While you're at it, take a look at the now smaller DataFrame.

```python
# Renumber the DataFrame index to account for the dropped rows.
player_df.reset_index(drop=True, inplace=True)
player_df.info()
```

```output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 42 entries, 0 to 41
Data columns (total 14 columns):
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   ID           42 non-null     int64  
 1   points       42 non-null     float64
 2   possessions  42 non-null     float64
 3   team_pace    42 non-null     float64
 4   GP           36 non-null     float64
 5   MPG          37 non-null     float64
 6   TS%          42 non-null     float64
 7   AST          42 non-null     float64
 8   TO           42 non-null     float64
 9   USG          42 non-null     float64
 10  ORR          42 non-null     float64
 11  DRR          42 non-null     float64
 12  REBR         42 non-null     float64
 13  PER          33 non-null     float64
dtypes: float64(13), int64(1)
memory usage: 4.7 KB
```

You see that you now have only 42 players in the DataFrame. Only three columns are missing some values.

© 2020 Warner Bros. Ent. All Rights Reserved.