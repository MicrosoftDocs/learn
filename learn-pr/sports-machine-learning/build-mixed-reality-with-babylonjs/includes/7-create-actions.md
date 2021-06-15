Now that you have a place for each of the character icons, and a popup to show up large in the center of the screen, we need to make the icons and popUp interactable.

To make the icons interactable, loop through the `_players` and create a button for each player based on the `json` data.

This code belongs at the bottom of the `createCharacterButtons()` function in the `Environment` class in the `environment.ts` file:

```javascript
// Create an array of meshes to access later
var activeMesh: AbstractMesh[] = null;

// When the popUp is clicked, hide player container and close button
displayStatsContainer.onPointerUpObservable.add(() => {
    displayStatsContainer.isVisible = false;
    if (activeMesh) {
        activeMesh.forEach(mesh => {
            mesh.dispose();
        });
    }
});

// Loop through players in the json file and create a button for each player
for (var index = 0; index < this._players.length; index++) {
    let player = this._players[index];

    // Create the button and add it to the mainButtonPanel
    var button = new GUI.HolographicButton("orientation");
    mainButtonPanel.addControl(button);

    // Add the player's name and their image to the button on the mainButtonPanel
    button.text = player.name;
    button.imageUrl = player.imgUrl;

    // When the button is clicked, trigger the popUp to show, now with the PER
    button.onPointerUpObservable.add(async function () {
        displayStatsContainer.imageUrl = player.imgUrl;
        displayStatsContainer.text = `PER: ${player.per}`;
        displayStatsContainer.isVisible = true;
        displayStatsContainer.scaling = new Vector3(3, 3, 1);
        displayStatsContainer.position =  new Vector3(-6,-1,2);
    });
};
```

With this, you will have the players show up in your environment, and when you click them they will popUp with their stats. That is, if you initialize this new environment that you just created. You will do that in the next unit.

© 2021 Warner Bros. Ent. All Rights Reserved.
