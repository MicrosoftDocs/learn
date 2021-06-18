After you start getting into building games and virtual worlds, you'll notice that you need 3D models, but you might not know how to build them. Babylon.js has built-in mesh models and procedural textures that we can use without having to do any modeling.

> [!TIP]
> For a more detailed walkthrough of the code, remember that you can always have CodeTour running in Visual Studio Code. Head back to the environment setup unit if you haven't installed the extension.

## Generate a wood floor

We'll use `MeshBuilder` to create ground, and then we'll use `WoodProceduralTexture` to create a wood-like texture. Last, we'll add `PhysicsImposter` to `gymFloor`, which defines the physics of this mesh with parameters that imitate the ground.

All of the following code should go into the `createScene()` function, because this is part of the scene we're creating. Just below the environment initialization, you can replace the `const env = scene.createDefaultEnvironment();` line with the following code, because we're creating our own custom environment instead of using a default one.

```javascript
  // Create a floor in the scene and position it to the center
  var gymFloor = MeshBuilder.CreateGround("ground", { width: 60, height: 60 }, scene);
  gymFloor.position = new Vector3(0, -3.5, 0);

  // Create wood materials and texture in the scene
  var woodMaterial = new StandardMaterial("woodMaterial", scene);
  var woodTexture = new WoodProceduralTexture("text", 1024, scene);

  // Adjust the texture to look more realistic 
  woodTexture.ampScale = 80.0;

  // Apply the texture to the material
  woodMaterial.diffuseTexture = woodTexture;

  // Apply the material to the gym floor mesh object
  gymFloor.material = woodMaterial;

  // Add physics that simulates the ground
  gymFloor.physicsImpostor = new PhysicsImpostor(gymFloor, PhysicsImpostor.PlaneImpostor, { mass: 0, restitution: 1 }, scene);
```

If you're interested in exploring more details to fine-tune your XR experience, you can [read more about procedural textures](https://doc.babylonjs.com/divingDeeper/materials/using/proceduralTextures?azure-portal=true).

## Create a PhotoDome background

There are many ways to create the world around you in a game. We're going to do it in a simple way with a Babylon.js PhotoDome. The `PhotoDome` class takes a photo (preferably a 360-degree photo) and uses it as a texture to create a background material on an inverted sphere shape. So just as you can wrap a sphere with an image to make it look like a basketball, you can wrap an inverted shape with a 360-degree image to create a background scene without creating a 3D model.

The following code instantiates the `PhotoDome` class, passes in the image URL, and sets the size and resolution. This code belongs after the code that you just wrote to create the gym floor in the `createScene()` function.

```javascript
  // Create PhotoDome with a .png image and add it to the scene
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
> You're welcome to try out other images with your PhotoDome. Now is your chance to really make your XR experience unique and personal!

Save the changes. If you still have the project running, the hot reload will reload your scene. The scene should look like the following one:

![Three-dimensional animation of the scene without icons for players.](../media/space-jam-no-buttons.gif)

The scene is set. Let's add player buttons and actions!

© 2021 Warner Bros. Ent. All Rights Reserved.
