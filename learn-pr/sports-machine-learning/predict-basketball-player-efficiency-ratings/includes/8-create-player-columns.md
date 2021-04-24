You've identified the groups of players by examining the bimodal histograms. So now make a column to indicate whether a row represents a human or Tune Squad player. Then give each row a unique "name."

First, create the new column for the DataFrame. Create it by making a list of values for the column and then assigning the column a name.

```python
# Initialize the list to house the player data.
pop_list = []

# If the ID number is 30 or less, it's a human player; otherwise, it's a Tune Squad player.
for id in player_df['ID']:
    if id <= 30:
        pop_list.append('player'+str(id))
    else:
        pop_list.append('tune_squad'+str(id%30))

pop_list
```

```output
['player1',
 'player2',
 'player3',
 'player4',
 'player5',
 'player6',
 'player7',
 'player8',
 'player10',
 'player11',
 'player12',
 'player13',
 'player14',
 'player15',
 'player16',
 'player17',
 'player18',
 'player19',
 'player21',
 'player22',
 'player23',
 'player24',
 'player26',
 'player27',
 'player28',
 'player29',
 'tune_squad1',
 'tune_squad2',
 'tune_squad3',
 'tune_squad4',
 'tune_squad5',
 'tune_squad6',
 'tune_squad7',
 'tune_squad8',
 'tune_squad9',
 'tune_squad11',
 'tune_squad12',
 'tune_squad13',
 'tune_squad14',
 'tune_squad15',
 'tune_squad16']
```

>[!NOTE]
>You took a shortcut when you used `str(id%30)` to create the numbers for the Tune Squad players. The modulus operator (`%`) will divide and return the difference. 
>
>So for every ID after 30, the code enters the `else` branch. For example, for 31, the else branch creates a string that's `tune_squad` + `str(id%30)`, which is `str(31%30)`. If you do the math, 31 divided by 30 is 0 remainder 1. So the player string for the row that contains ID 31 is `tune_squad1`.

Now add this list of strings to the DataFrame:

```python
# Assign this list as the values for the new player column in the DataFrame.
player_df['player'] = pop_list
player_df.head()
```

**Output**

|   | ID | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER | player |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 1 | 1893.0 | 1251.8 | 97.8 | 63.0 | 33.9 | 0.569 | 17.2 | 11.5 | 26.1 | 4.7 | 23.3 | 7.8 | 10.90 | player1 |
| 1 | 2 | 1386.0 | 1282.5 | 110.5 | 58.0 | 32.5 | 0.511 | 24.8 | 9.7 | 26.9 | 6.1 | 0.9 | 10.7 | 27.30 | player2 |
| 2 | 3 | 1405.0 | 1252.3 | 105.8 | 55.0 | 36.3 | 0.605 | 25.7 | 13.9 | 28.1 | 4.5 | 4.9 | 1.8 | NaN | player3 |
| 3 | 4 | 1282.0 | 1235.9 | 100.7 | 54.0 | 37.6 | 0.636 | 29.5 | 11.0 | 22.3 | 4.8 | 4.6 | 5.6 | 22.35 | player4 |
| 4 | 5 | 1721.0 | 1254.0 | 105.7 | 59.0 | 30.5 | 0.589 | 22.8 | 9.9 | 24.6 | 1.2 | 8.4 | 12.1 | 28.38 | player5 |


Placing the new column last will cause problems later because the last column is the default location for new columns. So move the new column to the right of `ID`. 

Because you have too many columns to easily type, create a list of all but the last column (now `player`). Use the `insert()` list method to move the column to the second position in the list. (Remember that Python uses zero-based indexing!) 

Now use the altered list to specify the order of columns in the `player_df` DataFrame.

```python
# Create list of all DataFrame column names but the last one.
column_list = list(player_df.iloc[:, :-1])

# Make player the second item in the list.
column_list.insert(1, 'player')

# Reassign the columns in the player_df DataFrame in this new order.
player_df = player_df[column_list]

# Verify that the columns are ordered the way you expect.
player_df.head()
```

**Output**

|  | ID | player | points | possessions | team_pace | GP | MPG | TS% | AST | TO | USG | ORR | DRR | REBR | PER |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 1 | player1 | 1893.0 | 1251.8 | 97.8 | 63.0 | 33.9 | 0.569 | 17.2 | 11.5 | 26.1 | 4.7 | 23.3 | 7.8 | 10.90 |
| 1 | 2 | player2 | 1386.0 | 1282.5 | 110.5 | 58.0 | 32.5 | 0.511 | 24.8 | 9.7 | 26.9 | 6.1 | 0.9 | 10.7 | 27.30 |
| 2 | 3 | player3 | 1405.0 | 1252.3 | 105.8 | 55.0 | 36.3 | 0.605 | 25.7 | 13.9 | 28.1 | 4.5 | 4.9 | 1.8 | NaN |
| 3 | 4 | player4 | 1282.0 | 1235.9 | 100.7 | 54.0 | 37.6 | 0.636 | 29.5 | 11.0 | 22.3 | 4.8 | 4.6 | 5.6 | 22.35 |
| 4 | 5 | player5 | 1721.0 | 1254.0 | 105.7 | 59.0 | 30.5 | 0.589 | 22.8 | 9.9 | 24.6 | 1.2 | 8.4 | 12.1 | 28.38 |

Now the DataFrame contains all of the player data, with a new player column that indicates whether the row of stats is for a human player or a Tune Squad player. But as you can see, you still need to impute some missing values.

© 2020 Warner Bros. Ent. All Rights Reserved.