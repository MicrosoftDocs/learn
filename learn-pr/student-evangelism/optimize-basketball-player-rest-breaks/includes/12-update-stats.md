There are three functions needed to enable the coach to actually run each quarter of the game. This unit will introduce these three functions.

## Update the stats at the end of each quarter

At the end of each quarter we will want to make sure that the coach can see the updated PER stats for each player so that they can make a decision if they want to change the line up. This function will be similar to the `addStatsToGame()` function that we wrote in a previous unit. 

The two differences with this new function is:
- We can update the player cards instead of creating them
- We now have players on the court and can calculate the PER based on the new stats for that quarter

```javascript
// At the start of each quarter to do two things: 1. Ensure the players
// currently on the court have the correct PER represented and 2. Update the stats 
// for each player for the current quarter
function updateStatsInGame() {
    // For each player, update their player stat card to show the PER for that player for the 
    // given quarter
    for (let [playerName, playerStats] of playerMap.entries()) {
        document.getElementById(playerName+"_card").children[1].innerHTML = "PER: "+playerStats[currentQuarter];
    }

    // Reset the current quarter's total PER
    quarterPER = 0;
    quarterAvePER = 0;

    // Get a list of all of the players currently on the court
    var currentPlayers = document.getElementById('playersOnCourt').children;

    // Loop through each of the players currently on the court
    for( var playerIndex = 0; playerIndex < currentPlayers.length; playerIndex++) {
        // Get the PER for each player for the given quarter
        playerName = currentPlayers[playerIndex].id;
        playerPER = playerMap.get(playerName)[currentQuarter];
        quarterPER += playerPER;
    }

    // Get the average PER for the start of the quarter
    quarterAvePER = quarterPER / playersOnCourt;

    // Update the Current PER with the new average PER for the quarter now that the 
    // stats have been updated.
    document.getElementById('currentPER').innerHTML = "Current PER: "+ quarterAvePER.toPrecision(4);
}
```

## Write functionality for ending a quarter and the game

We will need two functions that act as "wrap up" functions for our app:
- `endQuarter()` - The purpose of this function is to preserve the PER of the quarter that completed and initiate the next quarter to start (calling the `updateStatsInGame()` function above)
- `endGame()` - The purpose of this function is to let the coach know how they did!

```javascript
// At the end of each quarter, show the coach the average PER
// for that quarter, allow the coach to make changes to the
// players on the court again, and add the stats for the next quarter to the game
function endQuarter() {
    // Allow the coach to move players again
    quarterInPlay = false;

    // Add the average PER of the quarter to the total count
    totalAvePER += parseFloat(quarterAvePER.toPrecision(4));

    // Add the value to the display counter above the stats column
    document.getElementById('averagePER').innerHTML += quarterAvePER.toPrecision(4) + " + ";

    // Progress ot the next quarter
    currentQuarter++;

    // Update the stats so that they reflect the next quarter
    updateStatsInGame();

    // Let the coach know that the new PER stats are up to date 
    alert("Q" + (currentQuarter+1) + " PER stats are in!");

    // Encourage the coach to consider new players
    document.getElementById("quarter").innerHTML = "Choose Players for Q"+(currentQuarter+1);

    // Update the button text
    document.getElementById("start").innerHTML = "Start Q"+(currentQuarter+1);
}

// At the end of the game, show the coach the average PER
// for the entire game and clean up the final view of the app
function endGame() {
    // Don't let the coach move players around, the game is over
    quarterInPlay = true;

    // Calculate the average PER for the entire game, including the last quarter
    totalAvePER += parseFloat(quarterAvePER.toPrecision(4));
    var averagePER = totalAvePER/numQuarters;

    // Let the coach know that the game is over and what the PER was for the game
    alert("Game Over. Game Average PER was: " + averagePER.toPrecision(4));
    document.getElementById('averagePER').innerHTML += quarterAvePER.toPrecision(4) + " = " + averagePER.toPrecision(4);

    // Clean up the web app view
    document.getElementById("timer").innerHTML = "That's All Folks!";
    document.getElementById("gameButton").innerHTML = "";
    document.getElementById("quarter").innerHTML = "";
    document.getElementById('currentPER').innerHTML = "";
}
```

© 2020 Warner Bros. Ent. All Rights Reserved