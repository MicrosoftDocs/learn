Basketball is full of statistics, and we will use some of them to make decisions about our hypothetical basketball team. However, in order to make good decisions, we need good data. Throughout this module we will be using a dataset that is based on publicly available basketball data from [the NBA](https://www.nba.com/stats/leaders/?azure-portal=true) and stats created based on Tune Squad characters to get a full picture. All of our data is anonymized to start with.

Because we cannot influence what data is gathered by the NBA, we can't do anything about the methodology used to get the data in first place. This introduces a number of questions about the data:

- Were best practices used?
- Were biases introduced?
- Is there data that could influence our findings that wasn't gathered?

Since we are fans of the sport, and not necessarily the data scientists gathering the data, we can still explore and understand the data by looking for holes in the data (missing values), looking for outlying data values, and trying to assess patterns in the data.

This is a common situation that data scientists find themselves in. Collecting data can take years, so when we're first starting out in an area, we may have to rely on previously collected data to guide initial findings. As we know from the [Data Science Lifecyle](https://docs.microsoft.com/azure/machine-learning/team-data-science-process/overview?azure-portal=true), the process is iterative. If we can discover patterns and insights from the data that we have, we can perhaps influence the data that is collected in the future! 

## Exploring the data

Before jumping into modifying the data, we can begin to explore it. You can do this by opening the csv file in Visual Studio Code, but you could also do this with commong pandas functions!

```python
# Print out the first 5 rows of the player_df DataFrame
player_df.head()
```

**Output**

| | ID | points | possessions | team_pace | Unnamed: 4 | Unnamed: 5 | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 1 | 1893.0 | 1251.8 | 97.8 | NaN | NaN | 63.0 | 33.9 | 0.569 | 17.2 | 11.5 | 26.1 | 4.7 | 23.3 | 7.8 | 10.90 |
| 1 | 2 | 1386.0 | 1282.5 | 110.5 | NaN | NaN | 58.0 | 32.5 | 0.511 | 24.8 | 9.7 | 26.9 | 6.1 | 0.9 | 10.7 | 27.30 |
| 2 | 3 | 1405.0 | 1252.3 | 105.8 | NaN | NaN | 55.0 | 36.3 | 0.605 | 25.7 | 13.9 | 28.1 | 4.5 | 4.9 | 1.8 | NaN |
| 3 | 4 | 1282.0 | 1235.9 | 100.7 | NaN | NaN | 54.0 | 37.6 | 0.636 | 29.5 | 11.0 | 22.3 | 4.8 | 4.6 | 5.6 | 22.35 |
| 4 | 5 | 1721.0 | 1254.0 | 105.7 | NaN | NaN | 59.0 | 30.5 | 0.589 | 22.8 | 9.9 | 24.6 | 1.2 | 8.4 | 12.1 | 28.38 |

We can see that there are number of columns that are acronyms, let's break those down:

| Column Name | Column Description |
|-------------|--------------------|
| ID | a unique identifier for each player in the dataset |
| points | total points scored by a player in a season |
| possessions | total possessions by a player in a season |
| team_pace | the average number of possessions a team uses per game |
| Unnamed: 4 | Unknown data |
| Unnamed: 5 | Unknown data |
| GP | games played by a player in a season |
| MPG | average minutes played by a player per game |
| TS% | True Shooting Percentage, a player's shooting percentage taking free throws and 3-pointers into account |
| AST | Assist Ratio, the percentage of a player's possessions that end in an assist |
| TO | Turnover Ratio, the percentage of a player's possessions that end in a turnover |
| USG | Usage Rate, the number of possessions a player uses per 40 minutes |
| ORR | Offensive rebound rate |
| DRR | Defensive rebound rate |
| REBR | Rebound Rate, the percentage of missed shots that a player rebounds |
| PER | the player efficiency rating (PER), a measure of a player's per-minute productivity on the court |

While a lot of these data points make sense in the context of basketball, we can still start to cleanse our data even without a very technical understanding of each of these columns, so if you're not well versed in these terms, don't worry! There is still a lot to do to gain insights into the data.

The most important thing to understand is that each of these columns is data that can be counted during a game, expect for PER. PER, or player efficiency rating, is a calculation based on all of the other player stats that determines "how good" a player is. This column can be used to predict how effecitive a player is during a game. As of writing this module, the NBA player with the highest PER is Michael Jordan, with a rating of 27.91 and the NBA player with the second highest rating, as well as the highest rating of currently active NBA players is LeBron James with a score of 27.49.

The calculation of PER isn't perfect, and some fans and data scientists might choose to evaluate players differently, but for the purposes of this module, we will use PER as the measurement to help make decisions regarding players before and during games.

## Find Missing Values

Missing values are very common in organically collected data sets. To look for missing values, pandas DataFrames have the built-in `isna()` function. By default, this function flags each occurrence of a `NaN` value in row in the DataFrame. We saw above that there are at least two columns that have a lot of `NaN` values, so we should definitely start here with our cleansing.

`NaN` stands for Not a Number. It is a special floating-point value that represents an undefined value. It is different from, say, using '' or 0, in that it literally has no value. This is the value that we imported from empty cells in the CSV file.

Because we are most interested in seeing how many `NaN` values there are in each row of our DataFrame, we will pair the `isna()` function with the DataFrame `sum()` function. A nice thing about pandas is that we can just keep tacking on functions one after another to create powerful, concise code. For example:

```python
# Total up how many NaN values there are in each row of the DataFrame.
player_df.isna().sum()
```

```output
ID              0
points          3
possessions     3
team_pace       3
Unnamed: 4     47
Unnamed: 5     47
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

We know that we have 47 rows of data, because we can see that in the CSV file, as well as when we print out the information for the DataFrame:

```python
# Print out the information about the data frame
player_df.info()
```

```output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 47 entries, 0 to 46
Data columns (total 16 columns):
ID             47 non-null int64
points         44 non-null float64
possessions    44 non-null float64
team_pace      44 non-null float64
Unnamed: 4     0 non-null float64
Unnamed: 5     0 non-null float64
GP             40 non-null float64
MPG            41 non-null float64
TS%            46 non-null float64
AST            46 non-null float64
TO             46 non-null float64
USG            46 non-null float64
ORR            46 non-null float64
DRR            46 non-null float64
REBR           46 non-null float64
PER            37 non-null float64
dtypes: float64(15), int64(1)
memory usage: 6.0 KB
```

Since there are 47 rows and we can see that the two unnamed columns have 47 `NaN` values, we can deduce that there are at least two columns we can completely eliminate from our DataFrame.

© 2020 Warner Bros. Ent. All Rights Reserved