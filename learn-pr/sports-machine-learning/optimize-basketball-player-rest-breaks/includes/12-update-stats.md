Three functions are needed for the coach to actually run each quarter of the game. This unit introduces these three functions.

## Update the stats at the end of each quarter

At the end of each quarter, we'll want to make sure that the coach can see the updated PER stats for each player, so the coach can decide whether they want to change the lineup. This function is similar to the `displayPlayerCards()` function that we wrote in an earlier unit. 

The two differences with this new function are:

- We can update the player cards instead of creating them.
- We now have players on the court, and we can calculate PER based on the new stats for that quarter.

```javascript
// At the start of each quarter, do two things: 
// 1. Ensure the players currently on the court have the correct PER represented
// 2. Update the stats for each player for the current quarter.
function updateCardsInGame() {
    // For each player, update their player stat card to show PER for that player for 
    // a specific quarter.
    for (let [playerName, playerStats] of playerMap.entries()) {
        document.getElementById(playerName + '_card').children[1].innerText = 'PER: '+playerStats[currentQuarter].toPrecision(4);
    }

    // Reset the current quarter's total PER.
    quarterPER = 0;
    quarterAvePER = 0;

    // Get a list of all the players currently on the court.
    var currentPlayers = document.getElementById('playersOnCourt').children;

    // Loop through each of the players currently on the court.
    for(var playerIndex = 0; playerIndex < currentPlayers.length; playerIndex++) {
        // Get the name of the player
        var playerName = currentPlayers[playerIndex].id;

        // Get the PER for the player
        var playerPER = playerMap.get(playerName)[currentQuarter];

        // Add the PER to the quarter PER total
        quarterPER += playerPER;
    }

    // Get the average PER for the start of the quarter.
    quarterAvePER = quarterPER / playersOnCourt;

    // Update Current PER with the new average PER for the quarter now that the
    // stats have been updated.
    document.getElementById('currentPER').innerText = 'Current PER: '+ quarterAvePER.toPrecision(4);
}
```

## Write functionality for ending a quarter and the game

We'll need two functions that act as "wrap-up" functions for our app:

- `endQuarter()`: The purpose of this function is to preserve the PER of the quarter that finished and to initiate the next quarter to start (calling the `updateCardsInGame()` function).
- `endGame()`: The purpose of this function is to let the coach know how they did!

```javascript
// At the end of each quarter, show the coach the average PER
// for that quarter, allow the coach to make changes to the
// players on the court again, and add the stats for the next quarter to the game.
function endQuarter() {
    // Update the clock display
    document.getElementById('timer').innerText = 'Q '+ (currentQuarter + 1) + ' Time: 0:00';

    // Allow the coach to move players again.
    quarterInPlay = false;

    // Add the average PER of the quarter to the total count.
    totalAvePER += parseFloat(quarterAvePER.toPrecision(4));

    // Add the value to the display counter above the stats column.
    document.getElementById('averagePER').innerText += quarterAvePER + ' + ';

    // Progress to the next quarter.
    currentQuarter++;

    // Update the stats so that they reflect the next quarter.
    updateCardsInGame();

    // Let the coach know that the new PER stats are up to date. 
    alert('Q' + (currentQuarter+1) + ' PER stats are in!');

    // Encourage the coach to consider new players.
    document.getElementById('quarter').innerText = 'Choose Players for Q'+(currentQuarter+1);

    // Update the button text.
    document.getElementById('start').innerText = 'Start Q'+(currentQuarter+1);
}

// At the end of the game, show the coach the average PER
// for the entire game and clean up the final view of the app.
function endGame() {
    // Don't let the coach move players around; the game is over.
    quarterInPlay = true;

    // Calculate the average PER for the entire game, including the last quarter.
    totalAvePER += parseFloat(quarterAvePER);
    var averagePER = totalAvePER/numQuarters;

    // Let the coach know that the game is over and what the PER was for the game.
    alert('Game Over. Game Average PER was: ' + averagePER.toPrecision(4));
    document.getElementById('averagePER').innerText += quarterAvePER.toPrecision(4) + ' = ' + averagePER.toPrecision(4);

    // Clean up the web app view.
    document.getElementById('timer').innerText = 'That\'s All Folks!';
    document.getElementById('gameButton').innerText = '';
    document.getElementById('quarter').innerText = '';
    document.getElementById('currentPER').innerText = '';
}
```

© 2020 Warner Bros. Ent. All Rights Reserved