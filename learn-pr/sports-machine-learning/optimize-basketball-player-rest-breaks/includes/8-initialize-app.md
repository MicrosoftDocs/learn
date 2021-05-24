In earlier units, we created a CSV file named *game_stats.csv* that contains a row of stats for each of the 16 players across four time periods within one game. Now, it's time to read in the PER for each player for each quarter of the game, so we can use that information to decide which players might need a water break.

> [!NOTE]
> The GitHub repo that you cloned contains an example *game_stats.csv* file. If you want to replace that example file with the one you made, just copy it and paste it into the *space-jam-a-new-legacy-app* repository folder and replace the one that's there.

## Read the game_stats data into a JavaScript variable

Open the *main.js* file in Visual Studio Code. You should see global variables that we'll use throughout our application. Just after these variables is a function declaration:

```javascript
// A map of playerName to an array of playerPER values
var playerMap = new Map();

// Variables to keep track of constants
const maxPlayersOnCourt = 5;
const numQuarters = 4;

// Variables to track state throughout the game
var currentQuarter = 0;
var playersOnCourt = 0;
var quarterInPlay = false;

// Variables to track PER throughout the game
var quarterPER = 0;
var quarterAvePER = 0;
var totalAvePER = 0;

// Function to read in all the player stats
function processPlayers(allPlayerStats) {
```

Now, we'll start writing our function to read in our data.

The first code comment is `Split the data by newline into an array`. The data being read in from the *game_stats.csv* file is coming in as one large string. To parse each row of data, we need to first split each row. Each row is delimited by a newline character. Using the `split(/\r\n|\n/)` function on the `allPlayerStats` parameter results in an array in which each element is a row from the CSV file. Name this array `allPlayerStatLines`.

We also need to remove the first line, as it contains header information which we don't need. We can do this by calling `shift`.

```javascript
    // Split the data by newline into an array.
    var allPlayerStatLines = allPlayerStats.split(/\r\n|\n/);

    // Remove the header line (first line)
    allPlayerStatLines.shift();
```

Now, you have access to all the data in a JavaScript array, and you don't have to worry about accessing the CSV file anymore.

## Gather player name and PER data

Although we do have access to all the data in the `allPlayerStatLines` variable, we can do a little upfront work to make it easier to access only the data we really need: player name and PER for each of the four quarters. To get this data, we'll create a map of player names to a list of PER per quarter. Before we can create the map, we need to isolate each player's data.

Looking at the CSV file, we can see that, for example, Sylvester appears on line 1, and then again on lines 18, 34, and 50. It's because Sylvester has four stats to represent his status in each of the four quarters of the game. The first entry for each player is for the start of the game, the next for the start of the first quarter, and so on. Because they are in order we can assume the next entry for a particular player is for the next quarter.

What we will do is read each line from the file. We'll get the name of the player, and look in the map to see if the player exists. If they don't (it's the first time we've seen the player in the data) we will add them. Then we'll get the PER value. Knowing the entries are in order of quarter, we can add each value knowing they're in the correct order.

```javascript
    // Loop through the rows and create a map entry of player name to a list of player PER
    for (var statLine of allPlayerStatLines) {
        // Get all individual stat values
        var stats = statLine.split(',');
        // If it's just an empty line, skip it
        if (!stats || stats.length <= 1) continue; // empty line

        // The second column has the player name
        var playerName = stats[1];

        // Check if player exists in map
        if (!playerMap.has(playerName)) {
            // First time we see the player; Add them in!
            playerMap.set(playerName, []);
        }

        // Get per value for player
        var per = parseFloat(stats[9]);

        // Add per value to player's array (the next quarter)
        playerMap.get(playerName).push(per);
    }
```

At the end of this loop we now have a `Map` where each player has an array of their PER values. With all our player data in a map, we can start adding our players to our web app so that they are ready to be put into the game by the coach.

```javascript
    // Add the players to the bench.
    displayPlayerBench();
```

In summary, our entire `processPlayers` function should look like this code:

```javascript
// Function to read in all player stats.
function processPlayers(allPlayerStats) {
    // Split the data by newline into an array.
    var allPlayerStatLines = allPlayerStats.split(/\r\n|\n/);

    // Remove the header line (first line)
    allPlayerStatLines.shift();

    // Loop through the 15 players and create a map entry of player name to player PER
    for (var statLine of allPlayerStatLines) {
        // Get all individual stat values
        var stats = statLine.split(',');
        // If it's just an empty line, skip it
        if (!stats || stats.length <= 1) continue; // empty line

        // The second column has the player name
        var playerName = stats[nameIndex];

        // check if player exists in map
        if (!playerMap.has(playerName)) {
            // First time we see the player; Add them in!
            playerMap.set(playerName, []);
        }

        // Get per value for player
        var per = parseFloat(stats[perIndex]);

        // Add per value to player's array (the next quarter)
        playerMap.get(playerName).push(per);
    }

    // Add the players to the bench.
    displayPlayerBench();
}
```

© 2020 Warner Bros. Ent. All Rights Reserved