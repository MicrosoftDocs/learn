We're ready to build out the `createCharacterButtons` function. 

## Create a character icon

Use the following code to add `CylinderPanel` to `mainManager`. `CylinderPanel` will be the container for the icons. Then create `meshManager` and `meshPanel` to display the pop-up `displayStatsContainer` player card. Add the `onPointerUpObservable` click event to remove `displayStatsContainer` from the scene when it's selected.

The `createCharacterButtons()` function belongs in the *environment.ts* file within the `Environment` class.

```javascript
public createCharacterButtons() {
    // Create the main 3D UI manager for the icon grid
    var mainManager = new GUI.GUI3DManager(this._scene);

    // Create a cylindrical panel so that the images wrap around the user
    var mainButtonPanel = new GUI.CylinderPanel();
    mainButtonPanel.margin = 0.2;
    mainManager.addControl(mainButtonPanel);

    // Create an anchor so that the main panel doesn't move
    var anchor = new TransformNode("");
    mainButtonPanel.linkToTransformNode(anchor);
    mainButtonPanel.position =  new Vector3(0,-2,-3);

    // Create 8 columns and 2 rows so that each of the 16 players can be displayed
    mainButtonPanel.columns = 8;
    mainButtonPanel.rows = 2;

    // Set panel layouts
    mainButtonPanel.blockLayout = true;
}
```

Now you have a position for each of the player cards within the main panel.

## Create the character pop-up image

Now you need add the code for the pop-up image that contains the PER value of the player. So when a player icon is selected, their stat card (name, image, and PER) will appear large in the center of the screen.

This code belongs at the bottom of the `createCharacterButtons()` function that you started earlier.

```javascript
// Create the mesh 3D UI manager for the pop-up image when a user selects a player
var meshManager = new GUI.GUI3DManager(this._scene);
var meshPanel = new GUI.PlanePanel();
meshPanel.margin = 0.2;

// Add meshPanel to meshManager and anchor it
meshManager.addControl(meshPanel);
meshPanel.linkToTransformNode(anchor);
meshPanel.position = new Vector3(6, 0, -1);

// Set the player container and add it to the mesh panel
var displayStatsContainer = new GUI.HolographicButton("orientation");
meshPanel.addControl(displayStatsContainer);
displayStatsContainer.isVisible = false;
```

The character pop-up image has the `visible` property set to `false` so that it's not showing initially. The last part is making these character icons interactable!

© 2021 Warner Bros. Ent. All Rights Reserved.
