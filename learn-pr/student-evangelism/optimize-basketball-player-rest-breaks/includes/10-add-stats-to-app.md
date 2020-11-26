Now that we have successfully added the players to the bench, we need to show the coach what their starting PER numbers are so that they can decide which five players should compose the starting lineup. 

## Adding the initial PER stats

Like before, we can revisit the `index.html` file to find there is a div with the id "playerStats" that we can use to show the PER stats for each player. And, like we did when we dynamically created the player buttons, we can dynamically create a div for each player to represent their PER for that quarter.

```JavaScript
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

We can test this out locally again by right-clicking the `index.html` file, choosing Copy Path, and pasting that path in a browser address bar. If you had the page open still from the last unit, make sure you do a hard refresh (ctrl+shift+r on Windows and cmd+shift+r on Mac). Re-upload the game_stats.csv file, and you should see the 16 players sitting on the bench, and the 16 player stat cards on the right-hand stat board.

:::image type="content" source="../media/local-test-2.png" alt-text="Screenshot showing the test of the initial stat visualization.":::

© 2020 Warner Bros. Ent. All Rights Reserved