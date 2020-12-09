The `player_df_final` pandas DataFrame contains data from 40 players. The first 26 rows represent human players and the last 17 rows represent Tune Squad. We're going to build an app that helps the coach decide which player should take a water break during a game, without risking the game, but also without wearing out any of the players. In this module, we'll deal only with the Tune Squad. So, we can focus on the last 16 rows of data. 

Before we get started building the app, we have to make sure we have the data in a state that will be ready for the app to ingest.

Let's start by creating a DataFrame that represents only the Tune Squad players. This code chooses all rows, starting at row 27 (index 26, because the DataFrame is zero-based), and all columns:

```python
# Create a DataFrame of only Tune Squad players.
ts_df = player_df_final.iloc[26: , :]
ts_df
```

Here's the output:

|| ID | player | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 26 | 31 | tune_squad1 | 2049.0 | 1434.0 | 110.0 | 64.000000 | 38.800000 | 0.619 | 31.5 | 14.9 | 35.5 | 8.3 | 17.6 | 12.8 | 28.440000 |
| 27 | 32 | tune_squad2 | 1795.0 | 1481.8 | 112.1 | 62.000000 | 35.400000 | 0.608 | 31.9 | 14.5 | 32.0 | 6.5 | 22.5 | 12.9 | 23.340000 |
| 28 | 33 | tune_squad3 | 1805.0 | 1509.9 | 108.6 | 64.000000 | 35.400000 | 0.622 | 27.9 | 13.9 | 36.0 | 5.9 | 27.7 | 12.2 | 22.410000 |
| 29 | 34 | tune_squad4 | 1743.0 | 1422.4 | 112.9 | 64.000000 | 36.300000 | 0.619 | 30.9 | 15.6 | 34.5 | 5.9 | 18.9 | 14.8 | 29.858714 |
| 30 | 35 | tune_squad5 | 1963.0 | 1539.1 | 117.4 | 59.972222 | 35.272973 | 0.633 | 32.3 | 16.2 | 34.0 | 5.9 | 19.8 | 13.1 | 27.160000 |
| 31 | 36 | tune_squad6 | 2062.0 | 1505.7 | 111.5 | 59.972222 | 37.000000 | 0.620 | 29.8 | 15.6 | 36.2 | 4.9 | 23.9 | 14.7 | 27.860000 |
| 32 | 37 | tune_squad7 | 1845.0 | 1435.7 | 113.1 | 69.000000 | 36.900000 | 0.634 | 33.2 | 14.0 | 36.5 | 4.1 | 21.5 | 16.4 | 34.260000 |
| 33 | 38 | tune_squad8 | 1778.0 | 1526.4 | 109.3 | 66.000000 | 34.900000 | 0.612 | 30.6 | 15.9 | 35.9 | 5.5 | 18.8 | 13.7 | 28.650000 |
| 34 | 39 | tune_squad9 | 1901.0 | 1444.1 | 109.7 | 67.000000 | 36.500000 | 0.609 | 27.2 | 14.8 | 35.5 | 5.0 | 21.8 | 8.9 | 20.120000 |
| 35 | 41 | tune_squad11 | 2030.0 | 1431.0 | 112.3 | 68.000000 | 37.000000 | 0.618 | 32.5 | 15.3 | 34.5 | 5.7 | 15.7 | 13.2 | 30.070000 |
| 36 | 42 | tune_squad12 | 1631.0 | 1465.7 | 110.1 | 66.000000 | 37.500000 | 0.613 | 28.4 | 14.4 | 35.7 | 6.5 | 20.7 | 14.0 | 28.400000 |
| 37 | 43 | tune_squad13 | 1828.0 | 1507.2 | 112.7 | 64.000000 | 36.500000 | 0.618 | 31.3 | 14.0 | 34.9 | 5.9 | 21.3 | 14.5 | 29.102157 |
| 38 | 44 | tune_squad14 | 1821.0 | 1443.7 | 118.8 | 66.000000 | 36.600000 | 0.609 | 27.3 | 13.5 | 35.8 | 7.0 | 23.8 | 11.5 | 22.960000 |
| 39 | 45 | tune_squad16 | 1740.0 | 1443.9 | 114.1 | 68.000000 | 37.100000 | 0.611 | 26.6 | 15.2 | 29.3 | 8.3 | 17.7 | 11.1 | 21.220000 |
| 40 | 46 | tune_squad17 | 1993.0 | 1459.0 | 112.5 | 59.972222 | 36.900000 | 0.627 | 30.4 | 15.0 | 33.7 | 6.3 | 19.3 | 14.1 | 28.760000 |

Let's understand this data a bit more. We can see that some of the column headings are acronyms. Let's break down our column names:

* **ID**: A unique identifier for each player in the dataset
* **player**: A unique identifer created to track which player is a Tune Squad player versus a human
* **points**: Total points scored by a player in a season
* **possessions**: Total possessions by a player in a season
* **team_pace**: Average number of possessions a team uses per game
* **GP**: *Games played* by a player in a season
* **MPG**: *Average minutes played* by a player per game
* **TS%**: *True shooting percentage*, a player's shooting percentage, taking free throws and three-pointers into account
* **AST**: *Assist ratio*, the percentage of a player's possessions that end in an assist
* **TO**: *Turnover ratio*, the percentage of a player's possessions that end in a turnover
* **USG**: *Usage rate*, the number of possessions a player uses per 40 minutes
* **ORR**: *Offensive rebound rate*
* **DRR**: *Defensive rebound rate*
* **REBR**: *Rebound rate*, the percentage of missed shots that a player rebounds
* **PER**: *Player efficiency rating*, a measure of a player's per-minute productivity on the court

Although many of these data points make sense in the context of basketball, we can start to cleanse our data even without a highly technical understanding of each of these columns. So, if you're not well versed in these terms, don't worry! We still have a lot to do to gain insights into the data. 

The most important thing to understand is that each of these columns is data that can be counted during a game, expect for *player efficiency rating* (PER). PER is a calculation that's based on all the other player stats. PER determines "how good" a player is. This column can help predict how effective a player is during a game. When this module was written, the basketball player with the highest PER was Michael Jordan, with a rating of 27.91. The basketball player with the second highest rating, and with the highest rating of currently active basketball players, was LeBron James, with a score of 27.49.

The calculation of PER isn't perfect, and some fans and data scientists might choose to evaluate players differently. But in this module, we'll use PER as the measurement that will help the coach make decisions about which player should be given a quick water break during a game.

## Import Tune Squad data to merge with player data

Next, import the names of the Tune Squad players for the game. But before taking the next step, open the *tune_squad.csv* file in Visual Studio Code. You'll see that the file is tab-separated rather than comma-separated, so set `sep='\t'` in your `pd.read_csv()` call:

```python
# Import Tune Squad player names.
ts_name_df = pd.read_csv('tune_squad.csv', sep='\t')
ts_name_df
```

```output
	ID	player
0	31	Sylvester
1	32	Marvin the Martian
2	33	Road Runner
3	34	Foghorn Leghorn
4	35	Bugs Bunny
5	36	Elmer Fudd
6	37	Lola Bunny
7	38	Porky Pig
8	39	Tasmanian Devil
9	40	Yosemite Sam
10	41	Gossamer
11	42	Granny
12	43	Wile E. Coyote
13	44	Tweety
14	45	Penelope
15	46	Daffy Duck
```

The `ts_names_df` DataFrame contains the ID of the player, which matches the ID in the main DataFrame, and the player's actual name.

## Merge DataFrames to better qualify data

Now, we have two DataFrames that contain complementary data. We can merge the DataFrames on the ID column because we know those columns match:

```python
# Merge the two DataFrames.
ts_df = pd.merge(ts_df, ts_name_df, on='ID', how='left', suffixes=('_type', '_name'))
ts_df.head()
```

Here's the output:

|| ID | player_type | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER | player_name |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 31 | tune_squad1 | 2049.0 | 1434.0 | 110.0 | 64.000000 | 38.800000 | 0.619 | 31.5 | 14.9 | 35.5 | 8.3 | 17.6 | 12.8 | 28.440000 | Sylvester |
| 1 | 32 | tune_squad2 | 1795.0 | 1481.8 | 112.1 | 62.000000 | 35.400000 | 0.608 | 31.9 | 14.5 | 32.0 | 6.5 | 22.5 | 12.9 | 23.340000 | Marvin the Martian |
| 2 | 33 | tune_squad3 | 1805.0 | 1509.9 | 108.6 | 64.000000 | 35.400000 | 0.622 | 27.9 | 13.9 | 36.0 | 5.9 | 27.7 | 12.2 | 22.410000 | Road Runner |
| 3 | 34 | tune_squad4 | 1743.0 | 1422.4 | 112.9 | 64.000000 | 36.300000 | 0.619 | 30.9 | 15.6 | 34.5 | 5.9 | 18.9 | 14.8 | 29.858714 | Foghorn Leghorn |
| 4 | 35 | tune_squad5 | 1963.0 | 1539.1 | 117.4 | 59.972222 | 35.272973 | 0.633 | 32.3 | 16.2 | 34.0 | 5.9 | 19.8 | 13.1 | 27.160000 | Bugs Bunny |

## Organize the DataFrame for better readability

Although it doesn't technically matter where each column is in a DataFrame, having the player name at the left, near the ID, makes the most sense for readability.

To move that column over so that's it's next to the ID column:

1. Create a list of the columns.
1. Remove the **player_name** column from the list (we know it's at the end, so we can simply drop it off the list).
1. Put **player_name** in the second position of the column list, replacing the **player_type** column.
1. Set our DataFrame to the new arrangement of columns.

```python
# Rearrange the columns to put the ID and player_name columns next to each other.
column_list = list(ts_df)

player_name = column_list.pop()
column_list[1] = player_name

ts_df = ts_df[column_list]
ts_df.head()
```

Here's the output:

| | ID | player_name | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 31 | Sylvester | 2049.0 | 1434.0 | 110.0 | 64.000000 | 38.800000 | 0.619 | 31.5 | 14.9 | 35.5 | 8.3 | 17.6 | 12.8 | 28.440000 |
| 1 | 32 | Marvin the Martian | 1795.0 | 1481.8 | 112.1 | 62.000000 | 35.400000 | 0.608 | 31.9 | 14.5 | 32.0 | 6.5 | 22.5 | 12.9 | 23.340000 |
| 2 | 33 | Road Runner | 1805.0 | 1509.9 | 108.6 | 64.000000 | 35.400000 | 0.622 | 27.9 | 13.9 | 36.0 | 5.9 | 27.7 | 12.2 | 22.410000 |
| 3 | 34 | Foghorn Leghorn | 1743.0 | 1422.4 | 112.9 | 64.000000 | 36.300000 | 0.619 | 30.9 | 15.6 | 34.5 | 5.9 | 18.9 | 14.8 | 29.858714 |
| 4 | 35 | Bugs Bunny | 1963.0 | 1539.1 | 117.4 | 59.972222 | 35.272973 | 0.633 | 32.3 | 16.2 | 34.0 | 5.9 | 19.8 | 13.1 | 27.160000 |

In the code to rearrange the columns, because the **player_type** column wasn't necessary now that we have the actual names of the players, it was easiest to replace the column with the **player_name** column. We didn't have to explicitly drop the **player_type** column!

© 2020 Warner Bros. Ent. All Rights Reserved