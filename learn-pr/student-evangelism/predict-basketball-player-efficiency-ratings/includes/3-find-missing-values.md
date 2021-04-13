Basketball is full of statistics. You'll use some of them to make decisions about the hypothetical basketball team in this module. 

To make good decisions, you need good data. Throughout this module, you'll use a dataset that's based on publicly available [basketball stats](https://www.nba.com/stats/leaders/?azure-portal=true). You'll also use stats we created based on Tune Squad characters. All of the data is anonymized.

As fans, we can't influence the methodology for gathering data. This detail introduces some questions:

- Were best practices used to gather the data?
- Were biases introduced in the data?
- Is there data that wasn't gathered that could influence our findings?

Because we're fans of the sport, and not necessarily the scientists who gather the data, you'll explore the data by looking for missing values, outlying values, and patterns.

Data scientists commonly find themselves in this sort of situation. Collecting data can take years. So when you're first starting out in an area, you might have to rely on previously collected data to guide initial findings. As you know from the [data science lifecycle](https://docs.microsoft.com/azure/machine-learning/team-data-science-process/overview?azure-portal=true), the data science process is iterative. If you discover patterns and insights from the current data, you can perhaps influence the data that's collected in the future! 

## Explore the data

Before you jump into modifying the data, you can begin to explore it. Explore it by opening the CSV file in Visual Studio Code. Or explore it by using common pandas functions:

```python
# Print out the first five rows of the player_df DataFrame.
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

The output shows several ambiguous column headings. Let's break down those headings:

| Column name | Description |
|-------------|--------------------|
| ID | Unique identifier for each player in the dataset |
| points | Total points scored by a player in a season |
| possessions | Total possessions by a player in a season |
| team_pace | Average number of possessions a team uses per game |
| Unnamed: 4 | Unknown data |
| Unnamed: 5 | Unknown data |
| GP | Games played by a player in a season |
| MPG | Average minutes played by a player per game |
| TS% | True shooting percentage, the player's shooting percentage, taking into account free throws and three-pointers |
| AST | Assist ratio, the percentage of a player's possessions that end in an assist |
| TO | Turnover ratio, the percentage of a player's possessions that end in a turnover |
| USG | Usage rate, the number of possessions a player uses per 40 minutes |
| ORR | Offensive rebound rate |
| DRR | Defensive rebound rate |
| REBR | Rebound rate, the percentage of missed shots that a player rebounds |
| PER | Player efficiency rating, the measure of a player's per-minute productivity on the court |

Many of these data points make sense in the context of basketball. But even without a technical understanding of each of these columns, you can still start to cleanse the data. So if you're not well versed in these terms, don't worry! You can still gain many insights into the data.

The important thing to understand is that each of these columns lists data that can be counted during a game, except for the PER column. *PER* (player efficiency rating) is a calculation based on all of the other player stats. It determines "how good" a player is. 

You can use the PER column to predict how effective a player is during a game. As of this writing, the basketball player who has the highest PER is Michael Jordan. His score is 27.91. The player who has the second-highest rating, and the highest rating of currently active professional basketball players, is LeBron James. His score is 27.49.

The calculation of PER isn't perfect. Some fans and data scientists might choose to evaluate players differently. But in this module, you'll use PER as the measurement to help make decisions about players before and during games.

## Find missing values

Missing values are common in organically collected datasets. To look for missing values, use the built-in `isna()` function in pandas DataFrames. By default, this function flags each occurrence of a `NaN` value in a row in the DataFrame. Earlier you saw at least two columns that have many `NaN` values, so you should start here with your cleansing.

`NaN` stands for "not a number." It's a special floating-point value that represents an undefined value. It's different from, say, using `''` or `0`, because `NaN` literally has no value. You imported this value from empty cells in the CSV file.

Because you're most interested in seeing how many `NaN` values are in each row of the DataFrame, pair the `isna()` function with the DataFrame `sum()` function. A nice thing about pandas is that you can tack on functions one after another to create powerful, concise code. For example:

```python
# Total up the number of NaN values in each row of the DataFrame.
player_df.isna().sum()
```

```output
ID              0
points          3
possessions     3
team_pace       3
Unnamed: 4     46
Unnamed: 5     46
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

You know that you have 46 rows of data, because you can see that in the CSV file and in the printout for the DataFrame:

```python
# Print out the information about the DataFrame.
player_df.info()
```

```output
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 46 entries, 0 to 45
Data columns (total 16 columns):
 #   Column       Non-Null Count  Dtype  
---  ------       --------------  -----  
 0   ID           46 non-null     int64  
 1   points       43 non-null     float64
 2   possessions  43 non-null     float64
 3   team_pace    43 non-null     float64
 4   Unnamed: 4   0 non-null      float64
 5   Unnamed: 5   0 non-null      float64
 6   GP           39 non-null     float64
 7   MPG          40 non-null     float64
 8   TS%          45 non-null     float64
 9   AST          45 non-null     float64
 10  TO           45 non-null     float64
 11  USG          45 non-null     float64
 12  ORR          45 non-null     float64
 13  DRR          45 non-null     float64
 14  REBR         45 non-null     float64
 15  PER          36 non-null     float64
dtypes: float64(15), int64(1)
memory usage: 5.9 KB
```

There are 46 rows, and you see that the two unnamed columns have 0 non-`NaN` values (which means all 46 rows have `NaN` values for these two columns). So you can deduce that at least two columns can be eliminated from the DataFrame.

© 2020 Warner Bros. Ent. All Rights Reserved.