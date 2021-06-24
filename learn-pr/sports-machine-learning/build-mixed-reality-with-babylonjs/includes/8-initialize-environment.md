The last thing you need to do before your custom experience is ready for game time is to initialize the environment and replace the default environment in the *index.ts* file. But, before you do that, let's make sure you're attributing the *Space Jam: A New Legacy* film for using the imagery! 

## Add the *Space Jam: A New Legacy* film attribution

Sometimes you need to add 2D text and images. To add these types of objects to the scene, use `AdvancedDynamicTexture`. It allows you to add other `GUI` controls. 

Add `GUI.Rectangle` to create `imageRect`, and add that to the `guiMenu` dynamic texture. Then, get the image by using `GUI.Image`, set its properties, and add it to `imageRect`.

This function belongs in the `Environment` class found in the *environment.ts* file:

```javascript
public addLegalLine() {
    const guiMenu = GUI.AdvancedDynamicTexture.CreateFullscreenUI("UI");
    guiMenu.idealHeight = 720;

    //Creating the legal text box
    const textRect = new GUI.Rectangle("legalContainer");
    textRect.color = "white";
    guiMenu.addControl(textRect);

    //Creating the legal text
    const legal = new GUI.TextBlock("legalText", "© 2021 WBEI TM & ©2021 WarnerMediaDirect, LLC. All Rights Reserved.");
    legal.height = 0.2;

    // Positioning the legal text to the bottom center
    legal.verticalAlignment = GUI.Control.VERTICAL_ALIGNMENT_BOTTOM;
    legal.horizontalAlignment = GUI.Control.HORIZONTAL_ALIGNMENT_CENTER;
    textRect.addControl(legal);
}
```

Now, fans will know that this XR experience features the epic Tune Squad from the *Space Jam: A New Legacy* film!

## Initialize your custom environment

Now that you've created the functions, add an `init()` function to call helper functions that will create the character buttons and include the logo that you just added.

The `init()` function should go in the `Environment` class in the *environment.ts* file. Typically, `init()` functions are added just after `constructor()`:

```javascript
    public async init() {
        this.createCharacterButtons();
        this.addLegalLine();
    }

```

Now you're ready to exchange the default environment for the one that you just created!

## Initialize the custom environment and test

Back in the *index.ts* file, you need to replace the default environment that you created and create a new `Environment` instance. Pass in the `scene` and `engine` instances that you created earlier to construct the class. Then, call `init` to set up the buttons. Replace the line `const env = scene.createDefaultEnvironment();` with the following two lines of code:

```javascript
  const environment = new Environment(scene, engine);
  environment.init();
```

Finally, don't forget to import the `Environment` class that you just created. To import the class, add the following import statement toward the top of the *index.ts* file, just below the other import statements that were already there:

```javascript
  import {Environment} from "./environment"
```

We now have our scene created with the buttons to display the PER score for each character!

Let's run `npm start` and take a look at the scene. To view on a headset, you can deploy to a static website or use blob storage for static sites.

This is what the final scene should look like:

![Animation of the scene with player icons and P E R scores.](../media/space-jam-final.gif)

© 2021 Warner Bros. Ent. All Rights Reserved.
