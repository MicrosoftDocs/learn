Now that we have successfully added the players to the bench, we need to show the coach what the players' starting PER numbers are so that the coach can decide which five players should compose the starting lineup. 

## Add the initial PER stats

Like before, we can revisit the *index.html* file to find there is a `div` with the ID `playerCards` that we can use to show the PER stats for each player. And, like we did when we dynamically created the player buttons, we can dynamically create a `div` for each player to represent the players' PER for that quarter.

```javascript
// This function is called at the beginning of the game play to initialize
// PER for each player, and at each quarter to do two things: 
// 1. Ensure the players currently on the court have the correct PER represented
// 2. Update the stats for each player for the current quarter
function displayPlayerCards() {
    // Get the div in which the stats will be shown.
    var playerCardDisplay = document.getElementById('playerCards');

    // For each player, create a player stat card to show the PER for that player for a 
    // specific quarter.
    for (let [playerName, playerStats] of playerMap.entries()) {
        // Create an overall div that will contain the player stat information.
        var playerCard = document.createElement('div');

        // Set an ID for the card so we can get it later
        playerCard.id = playerName + '_card';

        // Set the style class name
        playerCard.className = 'playerCard';

        // Add the player image to the div.
        var playerImage = document.createElement('img');

        // Set the style for the image
        playerImage.className = 'perCard';

        // Load the image
        playerImage.src = 'images/'+playerName+'.png';

        // Add the image to the card
        playerCard.appendChild(playerImage);

        // Add the player's PER to the div.
        var newPlayerPER = document.createElement('p');

        // Set the style for the number
        newPlayerPER.className = 'perCard';

        // Set the text for the PER
        newPlayerPER.innerText = 'PER: ' + playerStats[currentQuarter].toPrecision(4);

        // Add the PER
        playerCard.appendChild(newPlayerPER);

        // Add the player stat card to the game.
        playerCardDisplay.appendChild(playerCard);
    }
}
```

## Test the initial stat display locally

We can test the initial stat display locally: right-click the *index.html* file, select **Copy Path**, and then paste that path in a browser address bar. If you had the page open from the last unit, make sure you do a hard refresh (Ctrl+Shift+R on Windows and Cmd+Shift+R on Mac). Upload the *game_stats.csv* file again, and you should see the 16 players sitting on the bench, with the 16 player stat cards on the right stat board.

:::image type="content" source="../media/local-test-start-game.png" alt-text="Screenshot that shows the test of the initial stat visualization.":::

© 2020 Warner Bros. Ent. All Rights Reserved