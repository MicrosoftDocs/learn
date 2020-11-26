In earlier units, we created a CSV file `game_stats.csv` that contains a row of stats for each of the 16 players across four time periods within one game. Now it's time to read in the PER for each player for each quarter so that we can use that information to make decisions about which players might need a water break.

>[!NOTE]
>The GitHub repo that you cloned contains an example `game_stats.csv` file, but if you want to replace it with the one you made, simply copy and paste it into the `space-jam-a-new-legacy-app` repository folder and replace the one that is there.

## Read the game_stats data into a JavaScript variable

Open the main.js file in Visual Studio Code, you should see a number of global variables that we will use throughout our application. Just after these variables, you should see a function declaration:

```JavaScript
// A map of playerName to an array of playerPER values
var playerMap = new Map();

// Variables to keep track of constants 
var perIndex = 9;
var numPlayers = 16;
var maxPlayersOnCourt = 5;
var secondsInQuarter = 12;
var numQuarters = 4;

// Variables to track state throughout the game
var currentQuarter = 0;
var playersOnCourt = 0;
var quarterInPlay = false;

// Variables to track the PER throughout the game
var quarterPER = 0;
var quarterAvePER = 0;
var totalAvePER = 0;

// Function to read in all of the player stats
function processPlayers(allPlayerStats) {
```

This is where we will get started writing our function to read in our data. The first comment says: `Split the data by newline into an array`. The data being read in from the `game_stats.csv` file is coming in as one large string. In order to parse each row of data, we need to first split each row. Each row is deliminated by a newline character. Using the `split(/\r\n|\n/)` function on the `allPlayerStats` parameter will result in an array where each element is a row from the csv file. You can name this array `allPlayerStatLines`.

```JavaScript
    // Split the data by newline into an array
    var allPlayerStatLines = allPlayerStats.split(/\r\n|\n/);
```

Now you have access to all of the data in a JavaScript array and don't have to worry about accessing the CSV file anymore. 

## Gather Player Name and PER data

While we do have access to all of the data in the `allPlayerStatLines` variable, we can do a little upfront work to make it easier to access only the data we really need: player name and PER for each of the four quarters. To do this, we will create a map of the player name to a list of PER per quarter. Before we can create the map, we need to isolate each players data. 

Looking at the CSV file, we can see that, for example, Sylvester appears on line 1, then again on lines 18, 34, and 50. That is because he has four stats to represent his status in each of the four quarters of the game. We will need to account for that when creating the map of player data.

```JavaScript
    // Loop through the 16 players and create a map entry of player name : player stats
    for (var playerIndex=1; playerIndex <= numPlayers; playerIndex++) {

        // Create variables to represent the four rows for each player's stats throughout the game
        var playerLine0 = allPlayerStatLines[playerIndex].split(',');
        var playerLine12 = allPlayerStatLines[playerIndex+numPlayers].split(',');
        var playerLine24 = allPlayerStatLines[playerIndex+(numPlayers*2)].split(',');
        var playerLine36 = allPlayerStatLines[playerIndex+(numPlayers*3)].split(',');
```

With these variables we can create the variables we need to create the map of player names to player PER. Notice that we first take a substring of the PER value to essentially truncate the value to only have 2 numbers after the decimal, and then we convert the PER string to a float. This could be useful in a stretch project if you want to sort players based on their PER.

```JavaScript
        // Create variables to represent the player name, PER for each time period
        var playerName = playerLine0[1];
        var playerPER0 = parseFloat(playerLine0[perIndex].substring(0,5));
        var playerPER12 = parseFloat(playerLine12[perIndex].substring(0,5));
        var playerPER24 = parseFloat(playerLine24[perIndex].substring(0,5));
        var playerPER36 = parseFloat(playerLine36[perIndex].substring(0,5));
```

Finally, we can add the player and their stats to the player map, and then loop around for the next player. Notice that we want to set the key in this `playerMap` entry to be the player's name, and then we want to create an array with the four PER values for that player to be the value.

```JavaScript
        // Add the player and their stats to the player map variable
        playerMap.set(playerName, [playerPER0, playerPER12, playerPER24, playerPER36]);
    }
```

Once we have all of our player data in a map, we can start adding our players to our web app so that they are ready to be put into the game by the coach. 

```JavaScript
    // Add the players to the Bench
    addPlayersToGame();
```

In summary, our entire `processPlayers` function should look like this:

```JavaScript
// Function to read in all of the player stats
function processPlayers(allPlayerStats) {
    // Split the data by newline into an array
    var allPlayerStatLines = allPlayerStats.split(/\r\n|\n/);

    // Loop through the 16 players and create a map entry of player name : player stats
    for (var playerIndex=1; playerIndex <= numPlayers; playerIndex++) {

        // Create variables to represent the four rows for each player's stats throughout the game
        var playerLine0 = allPlayerStatLines[playerIndex].split(',');
        var playerLine12 = allPlayerStatLines[playerIndex+numPlayers].split(',');
        var playerLine24 = allPlayerStatLines[playerIndex+(numPlayers*2)].split(',');
        var playerLine36 = allPlayerStatLines[playerIndex+(numPlayers*3)].split(',');

        // Create variables to represent the player name, PER for each time period
        var playerName = playerLine0[1];
        var playerPER0 = parseFloat(playerLine0[perIndex].substring(0,5));
        var playerPER12 = parseFloat(playerLine12[perIndex].substring(0,5));
        var playerPER24 = parseFloat(playerLine24[perIndex].substring(0,5));
        var playerPER36 = parseFloat(playerLine36[perIndex].substring(0,5));
        
        // Add the player and their stats to the player map variable
        playerMap.set(playerName, [playerPER0, playerPER12, playerPER24, playerPER36]);
    }

    // Add the players to the Bench
    addPlayersToGame();
}
```

© 2020 Warner Bros. Ent. All Rights Reserved