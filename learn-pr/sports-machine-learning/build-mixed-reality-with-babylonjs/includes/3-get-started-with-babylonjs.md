To get you started on your first Mixed Reality project using Bablyon.js, we've provided some starter code for you. 

> [!Tip]
> For a more detailed explanation of the starter project, follow the CodeTour! Make sure that you have the [CodeTour extension](https://marketplace.visualstudio.com/items?itemName=vsls-contrib.codetour?azure-portal=true) installed in Visual Studio Code expand it in the Explorer pane and click "Start Tour".

## HTML and CSS in the `index.html`

Let's take a deeper look at the starter project. Below we see the only HTML and CSS needed. We don't need to change anything here but let's take a look to understand whats going on:

```html
<!DOCTYPE html>
<html>

    <head>
        <style>
            html,
            body {
                overflow: hidden;
                width: 100%;
                height: 100%;
                margin: 0;
                padding: 0;
                text-align: center;
            }

            #renderCanvas {
                width: 100%;
                height: 100%;
                touch-action: none;
            }
        </style>
    </head>

    <body>
        <canvas id="renderCanvas"></canvas>
        <script src="index.js"></script>
    </body>

</html>
```

There is an inline `style` tag that has the minimal CSS we need. Then the only HTML we need is the `canvas` element and the `script` tag to import the `index.js` file.

## The `index.ts` TypeScript file

The `index.ts` file is the TypeScript file that creates the main scene. When you run `npm run build` it is transpiled to vanilla JavaScript and saved to the `dist` folder. This is then called with the `script` tag in the index.html.

We are using Webpack which is an open-source JavaScript module bundler it generates static assets representing those modules. The configuration for WebPack is in the `webpack.config.js` file. This describes how to bundle the assets for the `dist` folder. WebPack compiles the script down to one source and that is used to serve the game script.

The below script shows how we import the packages needed from BabylonJS to create our game scene. Create the `canvas` variable to grab the renderCanvas canvas HTML tag from the html body section. Then we create the engine variable and pass in the new [BabylonJS Engine](https://www.babylonjs.com/?azure-portal=true).

```javascript
 import {
  Scene,
  HemisphericLight,
  Vector3,
  Engine,
  ArcRotateCamera,
  CannonJSPlugin,
  MeshBuilder,
  StandardMaterial,
  PhotoDome,
  PhysicsImpostor
} from "babylonjs";
import * as cannon from "cannon";
import { WoodProceduralTexture } from "babylonjs-procedural-textures";

var canvas = document.getElementById("renderCanvas") as HTMLCanvasElement;
// Load the 3D engine
var engine: Engine = null;
var sceneToRender = null;
var createDefaultEngine = function () {
  return new Engine(canvas, true, {
    preserveDrawingBuffer: true,
    stencil: true,
  });
};
```

## Create scene and Default XR Experience

Below we have the `createScene` function. Here we initialize the scene, pass in the engine and create a camera. The camera is the point of view of the game player. Next we need to add light. The cool thing about virtual reality (VR) is that it's a blank slate. You can build whatever you can dream up. That is why we need to add light, there isn't light unless we add it to the scene.

You can use the [scene.createDefaultEnvironment()](https://doc.babylonjs.com/divingDeeper/scene/fastBuildWorld?azure-portal=true) from BabylonJS which will give you the basics you need in an environment for free without having to build out what you want. This is great if the defaults work for your project. However, sometimes you need more custom environments and building it out manually makes sense.

We are going to be using the `createDefaultXRExperienceAsync` gives us a lot of functionality for free.

The default xr experience will provide the following:

- Create a basic experience helper and initialize it
- Create an HTML UI button to enter XR
- Initialize the input source class which will initialize controllers
- Enable the pointer selection and teleportation features

[Read more about it here](https://doc.babylonjs.com/divingDeeper/webXR/webXRExperienceHelpers#the-basic-experience-helper?azure-portal=true)

```javascript
// Function to create a scene with camera, lights, an environment, and a mixed reality experience
var createScene = async function () {
  // Create the scene and the camera
  var scene = new Scene(engine);
  var camera = new ArcRotateCamera("cam", -Math.PI / 2, Math.PI / 2, 10, new Vector3(0, -2, 3), scene);

  // Create a basicl hemispheric light source and add it to the scene
  var light = new HemisphericLight(
    "light1",
    new Vector3(0, 1, 0),
    scene
  );

  // Reduce the light intensity to 70%
  light.intensity = 0.7;

  // Create default Environment
  const env = scene.createDefaultEnvironment();

  // Create default XR Experience
  const xr = await scene.createDefaultXRExperienceAsync({
    floorMeshes: [env.ground],
  });

  // Return the completed scene with camera, lights, an environment, and a mixed reality experience
  return scene;
};
```

With this asynchronous function, you will have a scene that has a camera, lights, an environment, and a mixed reality experience, but this scene doesn't yet have physics or a way to be rendered.

## Add Physics with a Physics Engine

Next we need to add some physics to our world. There are plugins for 4 different physics engines available for use with BabylonJS: Cannon.js, Oimo.js, Energy.js and Ammo.js. We will be using CannonJS for this example but you can read more about the different engines on the [BabylonJS Docs](https://doc.babylonjs.com/divingDeeper/physics/usingPhysicsEngine?azure-portal=true). CannonJS is a physics engine written completely in JavaScript. If you aren't familiar with what physics engines are they provide an approximate simulation of certain physical systems like mass, gravity, friction and restitution.

In the starter code, you should add the following code after you have adjusted hte light intensity, but before you create the default environment. This code will add the `CannonJSPlugin` and set the gravitational force.

```javascript
  // Create the physics engine
  var cannonPlugin = new CannonJSPlugin(true, 10, cannon);

  //enable physics and set gravity force.
  scene.enablePhysics(new Vector3(0, -3, 0), cannonPlugin);
```

Now your scene has a sense of gravity and physics.

## Render the scene

Finally, it's time to render the scene. To do this, you need to create an engine, actually create a scene, render the scene using the engine, and then resize the engine to the size of the scene.

The following code should go under your asynchronous `createScene()` function:

```javascript
// Create a default engine to load the scene
try {
  engine = createDefaultEngine();
} catch (e) {
  console.log(
    "the available createEngine function failed. Creating the default engine instead"
  );
  engine = createDefaultEngine();
}
if (!engine) throw "engine should not be null.";

// Create the scene
createScene().then((returnedScene) => {
  sceneToRender = returnedScene;
});

// Render the scene using the engine
engine.runRenderLoop(function () {
  if (sceneToRender) {
    sceneToRender.render();
  }
});

// Resize the engine to fit the scene
window.addEventListener("resize", function () {
  engine.resize();
});

```

Now you can actually test the scene being rendered in the browser!

Run `npm start` and navigate to the the localhost ([https://localhost:8080](https://localhost:8080?azure-portal=true)). If you still have it running from above the hot reload should have refreshed when you saved your changes and you will see them reflected. The scene will be a blank blue scene since we haven't added any mesh objects or textures.

Now that we have setup the basic elements of the scene we are ready to start adding meshes and building out our virtual reality experience!

© 2021 Warner Bros. Ent. All Rights Reserved.
