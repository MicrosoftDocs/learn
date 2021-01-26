Our goal is to use the data that we have about each Tune Squad player to make quick decisions during the game. We know we want to use the PER because it's a per-minute measurement of the player's productivity on the court. Although in professional basketball, PER is computed for players based on the player's performance over an entire season, we can use PER as a loose proxy for player performance in a single game. To use PER this way, we'll need the following statistics for each player:

* **TS%**: A player's shooting percentage, taking free throws and three-pointers into account
* **AST**: The percentage of a player's possessions that end in an assist
* **TO**: The percentage of a player's possessions that end in a turnover
* **USG**: The number of possessions a player uses per 40 minutes
* **ORR**: The player's offensive rebound rate
* **DRR**: The player's defensive rebound rate
* **REBR**: The percentage of missed shots that a player rebounds

> [!NOTE]
> Technically, PER also uses a player's games-played and minutes-player-per-game statistics. Because those stats span multiple games, we'll leave them out.

We don't have an actual game to follow because the film doesn't come out until Summer 2021. But, we can simulate a game by using math!

We'll use the standard deviation of players' stats to simulate how they might perform in a game. Because we don't have data from multiple games for our players, we'll take the standard deviation of each stat for the players we have. 

Of course, this approach won't give us an accurate view of how we might expect players to perform in an actual game, but we can use this data to meet our primary objective: learning how we *can* use data science in a real-world scenario.

When you finish this module, you'll be able to use actual player and game stats to test whether this approach is effective in the real world!

To make this process easier, let's create a lookup pandas Series for each stat's standard deviations. A Series basically is a single-column DataFrame. Set the stat names as the Series index to make looking them up easier later on.

```python
# Create a list of only the column names we are interested in.
game_stat_cols = list(ts_df.iloc[:, 7:-1])
game_stat_stdevs = []

# Create a list of standard deviations for each stat.
for stat in game_stat_cols:
    game_stat_stdevs.append(ts_df[stat].std())

# Create a Series of the standard deviations, with the stat names as the index.
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

With this Series, we can run a simulation of our player data. We want to see whether, with our very broad assumptions, a player's PER might help us make choices about the player: should we give the player a water break, and should we keep the player in the game?

## Train a machine learning model based on player data

To train a machine learning model to predict a player PER by using specific player stats for a simulated game, we'll use all the data that we initially downloaded, including the human player data. To do this, we'll need to split our data into two parts:

* `X`: The *input* data we use to predict `y`
* `y`: The *output* value that you want the machine learning model to predict

The input data (`X`) is all the data that you want your machine learning model to use to predict the output (`y`). In this case, we want `X` to represent the seven columns we are especially interested in. The output data (`y`) is the number that we want to predict when all the columns in `X` are considered. In our case, `y` will be `PER`. To create these two variables, we just need to grab the last eight columns, minus the last column, and use that for `X`. We'll grab only the last column to use for `y`.

```python
# Import the models and libraries we need.
from sklearn.linear_model import LinearRegression
from numpy.random import randn

# Get the dependent and independent variables for modeling the PER.
X = player_df_final.iloc[:, 7:-1].to_numpy()
y = player_df_final.iloc[:, -1]
```

Next, we need to train, or fit, the machine learning model. We're using the scikit-learn LinearRegression library, which is a pre-written linear regression machine learning model that will automatically learn how to predict `y` based on `X`. For more information about how this training works, you can check out the [Developer's Intro to Data Science video series](https://aka.ms/LearnWithDrG/DevIntroDS-Videos?azure-portal=true) and other [Microsoft Learn modules about data science](https://aka.ms/LearnWithDrG/DevIntroDS-Learn?azure-portal=true).

```python
# Define and fit the model.
lin_reg = LinearRegression()
lin_reg.fit(X, y)
```

This code gives us a machine learning model (`lin_reg`) that we can use to predict PER based on a set of the seven input stats that we used to train the model (TS%, AST, TO, USG, ORR, DRR, and REBR).

## Test a machine learning model with random numbers based on standard deviation

After fitting the model, we can use the model to predict PER for a player based on new data in the seven columns. Let's explore how this model performs. We can use the model to predict the PER for randomized data for the players over 10 iterations.

For each iteration, we'll do the following steps:

1. Create an empty DataFrame that contains only the player's names.
1. For each stat for that player, generate a random number within the standard deviation for that player for that stat.
1. Save that randomly generated number in the DataFrame.
1. Predict the PER for each player based on the new DataFrame of randomly generated numbers.
1. Print each iteration, with the lowest `PER` player and the highest `PER` player.

```python
# Print the player with the highest and lower PER for each iteration.
print('Iteration # \thigh PER \tlow PER')

# Run the simulation 10 times.
for i in range(10):

    # Define an empty temporary DataFrame for each iteration.
    # The columns of this DataFrame are the player stats and the index is the players' names.
    game_df = pd.DataFrame(columns=game_stat_cols, index=list(ts_df['player_name']))
    
    # Loop through each stat.
    for stat in game_stat_cols:
        
        # Each player's stats are used to generate a random value for each iteration.
        game_df[stat] = list(ts_df[stat] + randn(len(ts_df)) * stdev_s[stat])
    
    # Use the fitted model to predict players' PERs based on the randomized data.
    game_df['PER'] = lin_reg.predict(game_df)

    # Print the player with the highest and lower PER for each iteration.
    print('Iteration {}'.format(i+1) + ' \t' + game_df['PER'].idxmax() + ' \t' + game_df['PER'].idxmin())
```

Here's the output:

| Iteration # | high PER | low PER |
|---|---|---|
| Iteration 1 | Tweety | Road Runner |
| Iteration 2 | Tweety | Marvin the Martian |
| Iteration 3 | Lola Bunny | Marvin the Martian |
| Iteration 4 | Tweety | Penelope |
| Iteration 5 | Lola Bunny | Tasmanian Devil |
| Iteration 6 | Lola Bunny | Road Runner |
| Iteration 7 | Lola Bunny | Penelope |
| Iteration 8 | Lola Bunny | Penelope |
| Iteration 9 | Tweety | Penelope |
| Iteration 10 | Elmer Fudd | Penelope |


> [!NOTE]
> Your data will be different from the data shown here because each time we run this code, we generate a random number within the standard deviation for each relevant stat column. If it *is* identical, it was complete luck!

Our methodology provides a variety of results that are in line with what we might expect based on the stats: Lola is likely one of the best players, based on PER.

So, if we had in-game data instead of random values based on the standard deviation, we could feasibly feed that data into this machine learning model and determine which player (the lowest PER player) should take a water break and which should stay in the game (the highest PER player).

As the game continues, the stats for each player will change. If we see a high PER player's PER start to drop, we might consider giving that player a water break. The player's lower PER probably means that they're getting tired.

© 2020 Warner Bros. Ent. All Rights Reserved