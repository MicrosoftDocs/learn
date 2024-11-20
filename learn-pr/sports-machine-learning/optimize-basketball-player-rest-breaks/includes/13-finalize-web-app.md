The final function is the one that will simulate the game actually running. In this case, instead of waiting 12 minutes, we'll pretend that a quarter is only 12 seconds. 

The `startNextQuarter()` function is called from the button that is defined in *index.html*. Locate the `div` that has the ID `start` to see the `onclick` declaration: 

```javascript
// This function is called when the Game button is selected. Each time the button is selected,
// it runs through a 12-second timer (simulating 12 minutes) and then updates the game
// to the next quarter.
function startNextQuarter() {
    // If there aren't exactly five players on the court, alert the coach that the game can't start.
    if(playersOnCourt != maxPlayersOnCourt){
        alert('Choose exactly ' + maxPlayersOnCourt + ' players to be on the court.');
        return;
    }

    // Update the button to indicate a quarter is in progress.
    document.getElementById('start').innerText = 'Q' + (currentQuarter + 1) + ' is in progress';

    // Define the interval period for the quarter; in this case, it's 12 seconds.
    var secondsInQuarter = 12;

    // Set the quarterInPlay variable to true so that the coach
    // can't move players during gameplay
    quarterInPlay = true;

    // Update the count down every 1 second, as indicated by the `1000` as
    // the second parameter to the setInterval function
    var x = setInterval(function() {        
        // Display the current time on the court board.
        document.getElementById('timer').innerText = 'Q '+ (currentQuarter + 1) + ' Time: ' + secondsInQuarter + ':00';

        // Decrement the interval counter for this quarter.
        secondsInQuarter--;

        // If the quarter has ended, reset the interval timer and get ready for the next quarter.
        if (secondsInQuarter < 0) {
            clearInterval(x);
            if(currentQuarter < 3) {
                endQuarter();
            }
            else {
                endGame();
            }
        }
    }, 1000);
}
```

Although the interval functionality is beyond the scope of this module, a critical piece (especially when you're testing new functionality) is that you can modify the interval timing, which is the second parameter in the `setInterval()` function; in this case, it's set to 1000. You can set it to 100 if you want the quarters shorter to more quickly test new changes.

## Test your new app

It's finally time! The app is finished! Now, we can test our app. Remember that you'll want to test all the functionality (including trying to add too many players to the court, or starting the game when there are too few players on the court).

1. Choose five players.
2. Press the **Start the Game!** button.
3. When the timer stops, adjust (or not) the players on the court versus players taking a break.
4. When your lineup is locked in, select the **Start Q2** button.

:::image type="content" source="../media/final-test-third-quarter.png" alt-text="Screenshot that shows the test of the final web app.":::

Repeat steps 3 and 4 for all four quarters, and then you should be at the end of the game!

:::image type="content" source="../media/final-test-end.png" alt-text="Screenshot that shows finishing the first game in the web app.":::

Congratulations! You finished your web app!

## Deploy your final web app

Now that you've finished your web app and you tested it locally, you can deploy it to the web! Deploying your app to the web is fairly easy. All you have to do is push your changes to your main branch!

To commit and push your changes, go to the source control extension, add a commit message, and select the check mark at the top. 

:::image type="content" source="../media/commit-code.png" alt-text="Screenshot that shows committing main J S file changes.":::

Next, push your changes: select the up and down arrows at the bottom of the Visual Studio Code window (be sure that you're on the main branch).

:::image type="content" source="../media/push-changes.png" alt-text="Screenshot that shows pushing main J S file changes.":::

After you commit and push your changes (and wait a little while for the GitHub action to be triggered and completed), you can go back to the Azure extension, right-click the Production app, and then select **Browse Site**.

:::image type="content" source="../media/browse-site.png" alt-text="Screenshot that shows browsing your finished site.":::

© 2021 Warner Bros. Ent. All Rights Reserved
