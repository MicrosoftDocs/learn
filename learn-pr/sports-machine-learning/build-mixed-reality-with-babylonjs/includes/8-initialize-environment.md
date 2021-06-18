The last thing you need to do before your custom experience is ready for game time is to initialize the environment and replace the default environment in the *index.ts* file. But before you do that, you might want to add more 2D imagery!

## Add the *Space Jam: A New Legacy* logo

Sometimes you need to add 2D text and images. To add these types of objects to the scene, use `AdvancedDynamicTexture`. It allows you to add other `GUI` controls. 

Add `GUI.Rectangle` to create `imageRect`, and add that to the `guiMenu` dynamic texture. Then, get the image by using `GUI.Image`, set its properties, and add it to `imageRect`.

This function belongs in the `Environment` class found in the `environment.ts` file:

```javascript
public addLogo() {
    // Create a GUI that will be full-screen
    const guiMenu = GUI.AdvancedDynamicTexture.CreateFullscreenUI("UI");
    guiMenu.idealHeight = 720;

    // Create a rectangle that the image will be added to
    const imageRect = new GUI.Rectangle("titleContainer");
    imageRect.thickness = 0;

    // Add the image rectangle to the GUI
    guiMenu.addControl(imageRect);

    // Create the logo with an image
    const logo = new GUI.Image("", "https://sjanlassets.blob.core.windows.net/assets/SpaceJamANewLegacyLogo.png")

    // Specify the height and width of the photo
    logo.width = 0.1;
    logo.height = 0.2;

    // Align the logo to the top and center of the GUI, which is the top and center of the screen
    logo.verticalAlignment = GUI.Control.VERTICAL_ALIGNMENT_TOP;
    logo.horizontalAlignment = GUI.Control.HORIZONTAL_ALIGNMENT_CENTER;

    // Add the logo to the image rectangle
    imageRect.addControl(logo);
}
```

Now, fans will know that this XR experience features the epic Tune Squad from the *Space Jam: A New Legacy* film!

## Initialize your custom environment

Now that you've created the functions, add an `init()` function to call helper functions that will create the character buttons and include the logo that you just added.

The `init()` function should go in the `Environment` class in the *environment.ts* file. Typically, `init()` functions are added just after `constructor()`:

```javascript
    public async init() {
        this.createCharacterButtons();
        this.addLogo();
    }

```

Now you're ready to exchange the default environment for the one that you just created!

## Initialize the custom environment and test

Back in the *index.ts* file, create a new `Environment` instance. Pass in the `scene` and `engine` instances that you created earlier to construct the class. Then, call `init` to set up the buttons.

```javascript
  const environment = new Environment(scene, engine);
  environment.init();
```

We now have our scene created with the buttons to display the PER score for each character!

Let's run `npm start` and take a look at the scene. To view on a headset, you can deploy to a static website or use blob storage for static sites.

This is what the final scene should look like:

![Animation of the scene with player icons and P E R scores.](../media/space-jam-final.gif)

© 2021 Warner Bros. Ent. All Rights Reserved.
