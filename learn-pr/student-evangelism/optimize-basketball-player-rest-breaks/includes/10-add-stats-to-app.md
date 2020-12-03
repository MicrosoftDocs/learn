Now that we have successfully added the players to the bench, we need to show the coach what the players' starting PER numbers are so that the coach can decide which five players should compose the starting lineup. 

## Add the initial PER stats

Like before, we can revisit the *index.html* file to find there is a `div` with the ID `playerStats` that we can use to show the PER stats for each player. And, like we did when we dynamically created the player buttons, we can dynamically create a `div` for each player to represent the players' PER for that quarter.

```javascript
// This function is called at the beginning of the game play to initialize the 
// PER for each player
function addStatsToGame() {
    // Get the div where the stats will be shown
    var stats = document.getElementById("playerStats");

    // For each player, create a player stat card to show the PER for that player for the 
    // given quarter
    for (let [playerName, playerStats] of playerMap.entries()) {
        // Create an overall div that will contain the player stat information
        newPlayerStat = document.createElement("div");
        newPlayerStat.id = playerName+"_card";
        newPlayerStat.className = "playerStat";

        // Add the player image to the div
        var playerImage = document.createElement("img");
        playerImage.className = "perCard";
        playerImage.src = "images/"+playerName+".png";
        newPlayerStat.appendChild(playerImage);

        // Add the player's PER to the div
        var newPlayerPER = document.createElement("p");
        newPlayerPER.className = "perCard";
        newPlayerPER.innerHTML = "PER: "+playerStats[currentQuarter];
        newPlayerStat.appendChild(newPlayerPER);

        // Add the player stat card to the game
        stats.appendChild(newPlayerStat);
    }
}
```

## Test the initial stat display locally

We can test this locally: right-click the *index.html* file, select **Copy Path**, and then paste that path in a browser address bar. If you had the page open from the last unit, make sure you do a hard refresh (Ctrl+Shift+R on Windows and Cmd+Shift+R on Mac). Upload the *game_stats.csv* file again, and you should see the 16 players sitting on the bench, with the 16 player stat cards on the right stat board.

:::image type="content" source="../media/local-test-2.png" alt-text="Screenshot that shows the test of the initial stat visualization.":::

© 2020 Warner Bros. Ent. All Rights Reserved