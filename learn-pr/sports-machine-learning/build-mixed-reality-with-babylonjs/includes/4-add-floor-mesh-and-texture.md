Once you start getting into game and virtual world building. You will notice you need 3D models, and you may not know how to build them. Thankfully BabylonJS has built in mesh models and procedural textures that we can use without having to do any modeling.

> [!TIP]
> For a more detailed walk-through of the code, remember that you can always be running the CodeTour in Visual Studio Code. Head back to the environment setup unit if you need help getting that setup.

## Generate a wood floor

We will use the `MeshBuilder` to create the `ground` and then we will use the `WoodProceduralTexture` to create a wood like texture. Lastly add a `PhysicsImposter` to the `gymFloor`, which defines the physics of this mesh with parameters that imitate the ground.

All of the following code should go into the `createScene()` function, since this is part of the scene we're creating. Just below the environment initialization, you can replace the `const env = scene.createDefaultEnvironment();` line with the following code, since we're creating our own custom environment instead of using a default one.

```javascript
  // Create a floor in the scene and position it to the center
  var gymFloor = MeshBuilder.CreateGround("ground", { width: 60, height: 60 }, scene);
  gymFloor.position = new Vector3(0, -3.5, 0);

  // Create wood materials and texture into the scene
  var woodMaterial = new StandardMaterial("woodMaterial", scene);
  var woodTexture = new WoodProceduralTexture("text", 1024, scene);

  // Adjust the texture look more realistic 
  woodTexture.ampScale = 80.0;

  // Apply the texture to the material
  woodMaterial.diffuseTexture = woodTexture;

  // Apply the material to the gym floor mesh object
  gymFloor.material = woodMaterial;

  // Add physics that will simulate the ground
  gymFloor.physicsImpostor = new PhysicsImpostor(gymFloor, PhysicsImpostor.PlaneImpostor, { mass: 0, restitution: 1 }, scene);
```

You can read more about [Procedural Textures here](https://doc.babylonjs.com/divingDeeper/materials/using/proceduralTextures?azure-portal=true) if you're interested in exploring more details to fine tune your personal XR experience.

## Create a Photo Dome background

There are many ways to create the world around you in a game. We are going to do it a very simple way with a BabylonJS `PhotoDome`. What the PhotoDome does is take a photo (preferably a 360 degree photo) and use it as a texture to create a background material on an inverted sphere shape. So just like you can wrap a sphere with a image to make it look like a basketball, you can wrap an inverted shape with a 360 image to create a background scene without creating a 3D model.

Below we instantiate the `PhotoDome`, pass in the image url and set the size and resolution. This code belongs after the code you just wrote to create the gym floor in the `createScene()` function:

```javascript
  // Create PhotoDome with a png image and add it to the scene
  var dome = new PhotoDome(
      "mydome",
      "https://sjanlassets.blob.core.windows.net/assets/Looney-Court.png",
      {
          resolution: 32,
          size: 100
      },
      scene
  );
```

> [!TIP]
> You are welcome to try out other images with your PhotoDome, now is the chance to really make your XR experience unique and personal!

Save the changes and if you still have the project running the hot reload will reload your scene and it should look like the below image:

![spacejam-no-buttons](../media/space-jam-no-buttons.gif)

The scene is set, lets add our player buttons and actions!

© 2021 Warner Bros. Ent. All Rights Reserved.
