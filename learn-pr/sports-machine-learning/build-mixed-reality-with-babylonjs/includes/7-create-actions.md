Now that you have a place for each of the character icons, and a pop-up image to show up large in the center of the screen, you need to make the icons and pop-up images interactable.

To make the icons interactable, loop through `_players` and create a button for each player based on the JSON data.

This code belongs at the bottom of the `createCharacterButtons()` function in the `Environment` class in the *environment.ts* file:

```javascript
// Create an array of meshes to access later
var activeMesh: AbstractMesh[] = null;

// When the pop-up image is selected, hide the player container and close button
displayStatsContainer.onPointerUpObservable.add(() => {
    displayStatsContainer.isVisible = false;
    if (activeMesh) {
        activeMesh.forEach(mesh => {
            mesh.dispose();
        });
    }
});

// Loop through players in the JSON file and create a button for each player
for (var index = 0; index < this._players.length; index++) {
    let player = this._players[index];

    // Create the button and add it to the mainButtonPanel
    var button = new GUI.HolographicButton("orientation");
    mainButtonPanel.addControl(button);

    // Add the player's name and their image to the button on mainButtonPanel
    button.text = player.name;
    button.imageUrl = player.imgUrl;

    // When the button is selected, trigger the pop-up image to appear, now with the PER
    button.onPointerUpObservable.add(async function () {
        displayStatsContainer.imageUrl = player.imgUrl;
        displayStatsContainer.text = `PER: ${player.per}`;
        displayStatsContainer.isVisible = true;
        displayStatsContainer.scaling = new Vector3(3, 3, 1);
        displayStatsContainer.position =  new Vector3(-6,-1,2);
    });
};
```

With this code in place, you'll have the players show up in your environment. When you select them, their stats will pop up--that is, if you initialize this new environment that you just created. You'll do that in the next unit.

© 2021 Warner Bros. Ent. All Rights Reserved.
