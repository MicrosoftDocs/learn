Our goal is to be able to use the data that we know about each Tune Squad player to make quick decisions during the game. We know that we want to leverage the player efficiency rating (PER) because it is a per-minute measurement of the player's productivity on the court. While in professional basketball the PER is computed for players based on their performance over an entire season, we can use it as a loose proxy for player performance in a single game. To use the PER in this way, we will need the following statistics for each player:

* **TS%**: True Shooting Percentage, a player's shooting percentage taking free throws and 3-pointers into account
* **AST**: Assist Ratio, the percentage of a player's possessions that end in an assist
* **TO**: Turnover Ratio, the percentage of a player's possessions that end in a turnover
* **USG**: Usage Rate, the number of possessions a player uses per 40 minutes
* **ORR**: Offensive rebound rate
* **DRR**: Defensive rebound rate
* **REBR**: Rebound Rate, the percentage of missed shots that a player rebounds

>[!NOTE] 
>PER technically also uses players' games-played and minutes-player-per-game statistics, but given that those are stats that span multiple games, we will leave them out here.

We don't have an actual game to follow since the film doesn't come out until Summer 2021, but we can simulate a game with math! We will use the standard deviation of players' stats as a means of simulating how they might perform in any given game. Because we don't have multiple games worth of data for our players, we will take the standard deviation of each stat across the players that we have. Of course this will not give us an accurate view of how we might expect players to perform in an actual game, but it will enable us to meet our primary objective: learning how data science *could* be used in a real-world scenario. After this module, you will be able to take actual player and game stats to test whether this approach is effective in the real world!

To make this process easier, let's create a look-up Series for each stats' standard deviations. A Series is basically a single-column DataFrame. Set the index of the Series to be the stat names to make looking them up easier later on.

```python
# Create a list of just the column names we are interested in.
game_stat_cols = list(ts_df.iloc[:, 7:-1])
game_stat_stdevs = []

# Create a list of standard deviations for each stat.
for stat in game_stat_cols:
    game_stat_stdevs.append(ts_df[stat].std())

# Create a Series of the standard deviations with the stat names as the index.
stdev_s = pd.Series(game_stat_stdevs, index=game_stat_cols)
stdev_s
```

```output
TS%     0.008805
AST     2.122891
TO      0.898795
USG     1.832257
ORR     1.100833
DRR     2.947654
REBR    1.906786
dtype: float64
```

With this Series we can run a simulation of our player data. We want to see if our very broad assumptions will enable us to see if PER might help us make choices about player to give a water break to and players to keep playing during a game.

## Train a machine learning model based on player data

To train a machine learning model to predict a player PER given particular player stats for a simulated game, we will leverage all of the data that we initially downloaded, including the human player data. To do this, we will need to split our data into two parts:
* **`X`:** Input - Data used to predict `y`
* **`y`:** Output - The value you are trying to have the machine learning model predict

The input data (`X`) is all of the data that you want your machine learning model to use to predict the output (`y`). In this case, we want our `X` to represent the seven columns described above. The output data (`y`) is the number that we want to predict given all of the columns in `X`. In our case, `y` will be `PER`. To create these two variables, we just need to grab the last 8 columns, minus the last column, and use that for our `X`, and grab only the last column to use for our `y`.

```python
# Import the necessary modules.
from sklearn.linear_model import LinearRegression
from numpy.random import randn

# Get the dependent and independent variables for model the PER.
X = player_df_final.iloc[:, 7:-1].to_numpy()
y = player_df_final.iloc[:, -1]
```

Next, we need to train/fit the machine learning model. We're leveraging scikit-learn's LinearRegression library, which is a pre-written linear regression machine learning model that will automatically learn how to predict `y` given `X`. For more information on how this works, you can check out the [Developer's Intro to Data Science video series](https://www.youtube.com/playlist?list=PLlrxD0HtieHjDop2DtiCmwTTcrlwKAVHE?azure-portal=true) and other [Microsoft Learn modules on Data Science](https://www.aka.ms/DevIntroDS_Learn?azure-portal=true).

```python
# Define and fit the model.
lin_reg = LinearRegression()
lin_reg.fit(X, y)
```

With this, we have a machine learning model (`lin_reg`) that we can use to predict PER given a set of the 7 input stats that we used to train the model (TS%, AST, TO, USG, ORR, DRR, and REBR).

## Test a machine learning model with random numbers based on standard deviation

Once you have fit that model, it means we can use it to predict PER for a player given new data on the seven columns. Let's explore how this model performs. We can use it to predict the PER for randomized data for the players over 10 iterations.

For each iteration, we're doing to do the following:
- Create an empty DataFrame that only contains the player's names
- For each of the stats for that player, we're going to generate a random number within the standard deviation for that player for that stat
- Save that randomly generated number in the DataFrame
- Predict the `PER` for each player based on the new DataFrame of randomly generated numbers
- Print each iteration, with the lowest `PER` player and the highest `PER` player

```python
# Print out the player with the highest and lower PER for each iteration.
print('Iteration # \thigh PER \tlow PER')

# Run the simulation ten times.
for i in range(10):

    # Define an empty temporary DataFrame for each iteration.
    # The columns of this DataFrame are the player stats and the index is the players' names.
    game_df = pd.DataFrame(columns=game_stat_cols, index=list(ts_df['player_name']))
    
    # Loop over the each stat.
    for stat in game_stat_cols:
        
        # Each player's stats is used as an mean for purposed of generating a random value for each iteration.
        game_df[stat] = list(ts_df[stat] + randn(len(ts_df)) * stdev_s[stat])
    
    # Use the fitted model to predict players' PERs based on the randomized data.
    game_df['PER'] = lin_reg.predict(game_df)

    # Print out the player with the highest and lower PER for each iteration.
    print('Iteration {}'.format(i+1) + ' \t' + game_df['PER'].idxmax() + ' \t' + game_df['PER'].idxmin())
```

| Iteration # | high PER | low PER |
|---|---|---|
| Iteration 1 | Speedy Gonzales | Road Runner |
| Iteration 2 | Speedy Gonzales | Marvin the Martian |
| Iteration 3 | Lola Bunny | Marvin the Martian |
| Iteration 4 | Speedy Gonzales | Penelope |
| Iteration 5 | Lola Bunny | Tasmanian Devil |
| Iteration 6 | Lola Bunny | Road Runner |
| Iteration 7 | Lola Bunny | Penelope |
| Iteration 8 | Lola Bunny | Penelope |
| Iteration 9 | Speedy Gonzales | Penelope |
| Iteration 10 | Elmer Fudd | Penelope |

>[!NOTE] 
>Your data will be different from the data shown here because each time we run this code we are generating a random number within the standard deviation for each relevant stat column, so if it is identical then it was complete luck!

Our methodology provides a variety of results that are pretty much inline with what we might expect given the stats - Lola and Speedy are likely some of the best players, based on PER. So, if we had in-game data, rather than random values based on the standard deviation, we could feasible feed that data into this machine learning model and determine which player (the lowest PER player) we should give a water break to, and which we should leave in (the highest PER player). As the game continues, the stats on each player will change, and if we see a high PER player start to drop down, we might consider giving them a water break because they are likely getting tired.

© 2020 Warner Bros. Ent. All Rights Reserved