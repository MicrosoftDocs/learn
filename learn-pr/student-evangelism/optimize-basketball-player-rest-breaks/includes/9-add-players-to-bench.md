In the next function, `addPlayersToGame`, we initialize the players in the web app. Because we want our coach to be able to move players from the bench to the court and back depending on each player's PER for a specific quarter, we need to create HTML elements for each player. The HTML elements can have actions associated with them. One of the easiest ways to do this is to use buttons. 

Before we create a button for each player, we need to get the `div` in which the players will be displayed in our web app. If we take a look at the *index.html* file, we can see that there is a `div` that has the ID `bench`. Nested in that `div` is another `div` called `playersOnBench`. This probably is where we want the player buttons to appear.

```javascript
    // Get the bench div in which the players will be shown.
    var bench = document.getElementById("playersOnBench");
```

Now, we need to create an HTML button element for each player. This button element needs to have these elements:

- `id`: We'll set the ID to the player's name so that it's easy to identify later on.
- `className`: In the *styles.css* file, we can see a `playerButton` class, so we'll assign it here.
- `onclick`: This function is what we want our app to call when the button is selected.
- `style`: We can set a couple style attributes, like background color and width.
- `playerImage`: We'll add the player's image to the button, instead of their name.

After we create the button, we can add the button to the bench area that we identified earlier, and then repeat the process for each player:

```javascript
    // For each player, create a button. 
    for (let playerName of playerMap.keys()) {
        var newPlayer = document.createElement("button");
        newPlayer.id = playerName;
        newPlayer.className = "playerButton";

        // When the button is selected, call the movingPlayers function.
        newPlayer.onclick = movingPlayers;

        // Style the button.
        newPlayer.style.backgroundColor = "#AC6FAA";
        newPlayer.style.width = "32%";
        
        // Add the player's image to the button.
        var playerImage = document.createElement("img");
        playerImage.src = "images/"+playerName+".png";
        newPlayer.appendChild(playerImage);

        // Add the button to the bench.
        bench.appendChild(newPlayer);
    }
```

## Test the web app locally

Before continuing, let's make sure that our app is working so far. If we tried to test our app at this point, we should be able to upload our *game_stats.csv* file. Then, the 16 characters should be added as buttons to the bench area.

We can test our app in two ways:

- Commit our changes to the main branch on GitHub, triggering the GitHub action and redeploying our code to our static web app in Azure. We'll do this option in a later unit.
- Save the *main.js* file and open *index.html* locally in a browser. We'll do this option now to save on testing time while we are still building our app. 

To test your web app locally, right-click the *index.html* file, and then select **Copy Path**:

:::image type="content" source="../media/local-copy-path.png" alt-text="Screenshot that shows copying the local path to the index H T M L file.":::

Then, open a browser and paste the path in the address bar. You should see the same app that we saw when you first deployed it, but this time, you can actually start using it!

In the upper-left corner of the app, select the **Choose File** button and find your *game_stats.csv* file. After the file uploads, a couple things should happen:

1. The file name should appear next to the **Choose File** button.
2. Your 16 players should be added to the bench.

> [!NOTE] 
> If you select the player buttons, nothing happens yet because we haven't written the `movingPlayers` function yet.

:::image type="content" source="../media/first-test.png" alt-text="Screenshot that shows the first functionality test of the web app.":::

## Add PER for the first quarter to the app

Finally, we add the PER values for each player for the first quarter to the app. This happens in the next unit, but we know we need to call the function that will perform this task: 

```javascript
    // Call the function to add PER for each player to the game.
    addStatsToGame();
```

We can review the entire `addPlayersToGame` function here:

```javascript
// Function to add the players to the bench to start the game.
function addPlayersToGame() {
    // Get the bench div in which the players will be shown.
    var bench = document.getElementById("playersOnBench");

    // For each player, create a button. 
    for (let playerName of playerMap.keys()) {
        var newPlayer = document.createElement("button");
        newPlayer.id = playerName;
        newPlayer.className = "playerButton";

        // When the button is selected, call the movingPlayers function.
        newPlayer.onclick = movingPlayers;

        // Style the button.
        newPlayer.style.backgroundColor = "#F6FA1B";
        newPlayer.style.width = "32%";
        
        // Add the player's image to the button.
        var playerImage = document.createElement("img");
        playerImage.src = "images/"+playerName+".png";
        newPlayer.appendChild(playerImage);

        // Add the button to the bench.
        bench.appendChild(newPlayer);
    }

    // Call the function to add PER for each player to the game.
    addStatsToGame();
}
```

© 2020 Warner Bros. Ent. All Rights Reserved