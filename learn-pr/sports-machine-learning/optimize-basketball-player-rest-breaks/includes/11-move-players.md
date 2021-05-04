This web app won't be useful if the coach can't make a decision about which players should take a water break and which to put on the court. Now that the coach can see PER for each player for the first quarter, we want to help the coach visualize what the average PER for a starting lineup would be as they choose to move players between the court and the bench.

## Write the functionality to move players 

This unit fills in the `movePlayers()` function:

```javascript
// This function is called each time a player button is selected. A player
// button being selected indicates that the player either is moving to the
// court or moving to the bench for a water break.
function movePlayers() {

}
```

But first, we want to make sure the coach doesn't make changes to the players during a quarter. Although in a real basketball game, that's definitely OK to do, in this version, we have only PER stats for each quarter start, so we want to limit the functionality. 

```javascript
    // Don't let the coach change players during a quarter.
    if(quarterInPlay) {
        return;
    }
```

Now, we can use the HTML structure to figure out where the player currently is—the bench or the court. We know that the buttons were initially placed on a `div` that has the ID `playersOnBench`. We can start by testing whether the player is currently on the bench, which means that the coach is trying to move the player to the court.

```javascript
    // Get the div in which this button currently is (either bench or court).
    var parentDiv = this.parentElement;

    // Check whether the player is currently on the bench.
    if(parentDiv.id == 'playersOnBench') {
```

In the `if` statement, we need to make one check before we do anything else: You can have only five players on the court at any one time, so we want to make sure the coach isn't trying to add additional players. In this case, we'll just alert the coach that adding more players right now isn't allowed, and not actually move the player.

```javascript
        // If there are already five players on the court, don't let the player
        // move to the court; alert the coach that there are enough players.
        if(playersOnCourt >= maxPlayersOnCourt){
            alert('You can only have ' + maxPlayersOnCourt + ' players on the court at a time.');
        }
```

If there's room on the court for the player, we want to do a few things in our code:

1. Increase the count for number of players on the court.
2. Get the player's PER for the current quarter.
3. Calculate the average PER for all the players currently on the court.
4. Update the current PER for the court. 
5. Move the player to the court.

```javascript
        else {
            // If there is room on the court, update the number of players on
            // the court, and update the average PER for the quarter based on
            // this player moving to the court.
            playersOnCourt++;
            quarterPER += playerMap.get(this.id)[currentQuarter];
            quarterAvePER = quarterPER / playersOnCourt;
            document.getElementById('currentPER').innerText = 'Current PER: '+ quarterAvePER;
            
            // Move the player to the court
            document.getElementById('playersOnCourt').appendChild(this);
        }
```

Next, we want to support the coach moving players from the bench back to the court. We can put these steps in an `else` statement because there are only two places a player can be—the court or the bench. So, we'll do a few things in the `else` statement we'll create next:

1. Decrement the count of players on the court.
2. Calculate the PER for the players left on the court. If there are no more players on the court, set PER to 0.
3. Display PER to the coach.
4. Move the player to the bench.

```javascript
    } else {
        // If the player is being taken off the court for a water break, decrement
        // the number of players on the bench and remove the player's PER from the
        // average.
        playersOnCourt--;

        if(playersOnCourt != 0) {
            quarterPER -= playerMap.get(this.id)[currentQuarter];
            quarterAvePER = quarterPER / playersOnCourt;
        } else {
            // If there are no more players on the court, set the values to 0.
            quarterPER = 0;
            quarterAvePER = 0;
        }

        // Update the PER average. This might result in a zero value if your team is particularly tired.
        document.getElementById('currentPER').innerText = 'Current PER: '+ quarterAvePER;

        // Move the player to the bench.
        document.getElementById('playersOnBench').appendChild(this);
    }
```

## Review the final movePlayers code

The entire `movePlayers()` function should be like this code:

```javascript
// This function is called each time a player button is selected. A player's
// button being selected indicates that the player either moving to the
// court or moving to the bench for a water break.
function movePlayers() {
    // Don't let the coach change players during a quarter.
    if(quarterInPlay) {
        return;
    }

    // Get the div where this button currently is (either bench or court).
    var parentDiv = this.parentElement;

    // Check whether the player is currently on the bench.
    if(parentDiv.id == 'playersOnBench') {
        // If there are already five players on the court, don't let the player
        // move to the court, and alert the coach that there are enough players.
        if(playersOnCourt >= maxPlayersOnCourt){
            alert('You can only have ' + maxPlayersOnCourt + ' players on the court at a time.');
        } else {
            // If there is room on the court, update the number of players on
            // the court, and update the average PER for the quarter based on
            // this player moving to the court.
            playersOnCourt++;
            quarterPER += playerMap.get(this.id)[currentQuarter];
            quarterAvePER = quarterPER / playersOnCourt;
            document.getElementById('currentPER').innerText = 'Current PER: '+ quarterAvePER.toPrecision(4);
            
            // Move the player to the court.
            document.getElementById('playersOnCourt').appendChild(this);
        }
    } else {
        // If the player is being taken off the court for a water break, decrement
        // the number of players on the bench and remove the player's PER from the
        // average.
        playersOnCourt--;

        if(playersOnCourt != 0) {
            quarterPER -= playerMap.get(this.id)[currentQuarter];
            quarterAvePER = quarterPER / playersOnCourt;
        } else {
            // If there are no more players on the court, set the values to 0.
            quarterPER = 0;
            quarterAvePER = 0;
        }

        // Update the PER average. This might result in a zero value if your team is particularly tired.
        document.getElementById('currentPER').innerText = 'Current PER: '+ quarterAvePER.toPrecision(4);

        // Move the player to the bench.
        document.getElementById('playersOnBench').appendChild(this);
    }
}
```

## Test the functionality of moving players

Now, we can refresh the local web app in the browser and test the functionality we built. You should be able to select up to five players who are on the bench and move them over to the court:

:::image type="content" source="../media/move-to-court.png" alt-text="Screenshot that shows moving players to the court.":::

You should test this functionality:

- Try to add more than five players to the court, and make sure the alert pops up.
- Add players to the court, and then move them all back to the bench.
- Make sure that the average PER for players on the court is accurate depending on the stats for the players for a specific quarter.

© 2020 Warner Bros. Ent. All Rights Reserved
