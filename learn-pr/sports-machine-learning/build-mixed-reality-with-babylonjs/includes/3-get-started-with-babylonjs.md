To get you started on your first Mixed Reality project by using Bablyon.js, we've provided some starter code for you. 

> [!Tip]
> For a more detailed explanation of the starter project, follow the code tour. Make sure that you have the [CodeTour extension](https://marketplace.visualstudio.com/items?itemName=vsls-contrib.codetour&azure-portal=true) installed in Visual Studio Code. Expand it in the **Explorer** pane and select **Start Tour**.

## HTML and CSS in *index.html*

Let's take a deeper look at the starter project. In the following code, we see the HTML and CSS that we need. We don't need to change anything here, but let's take a look to understand what's going on.

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

An inline `style` element has the minimal CSS that we need. Then the only HTML that we need is the `canvas` element and the `script` tag to import the *index.js* file.

## The *index.ts* TypeScript file

The *index.ts* file is the TypeScript file that creates the main scene. When you run `npm run build`, it's transpiled to plain JavaScript and saved to the *dist* folder. This file is then called with the `script` tag in *index.html*.

We're using WebPack, which is an open-source JavaScript module bundler. It generates static assets that represent those modules. The configuration for WebPack is in the *webpack.config.js* file. This file describes how to bundle the assets for the *dist* folder. WebPack compiles the script down to one source, and that source is used to serve the game script.

The following code belongs at the top of the *index.ts* file and shows how we import the needed packages from Babylon.js to create our game scene. Create the `canvas` variable to grab the `renderCanvas` canvas HTML tag from the `html` > `body` section. Then create the engine variable and pass in the new [Babylon.js Engine](https://www.babylonjs.com/?azure-portal=true).

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

## Create the scene and the default XR experience

By using the `createScene` function shown later in this section, we can initialize the scene, pass in the engine, and create a camera. The camera is the point of view of the game player. 

Next, we need to add light. The cool thing about Virtual Reality is that it's a blank slate. You can build whatever you can dream up. There isn't light unless we add it to the scene.

You can use [scene.createDefaultEnvironment()](https://doc.babylonjs.com/divingDeeper/scene/fastBuildWorld?azure-portal=true) from Babylon.js to get the basics that you need in an environment, for free, without having to build it out. This is great if the defaults work for your project. However, sometimes you need a more custom environment, and building it out manually makes sense.

We'll use [createDefaultXRExperienceAsync](https://doc.babylonjs.com/divingDeeper/webXR/webXRExperienceHelpers#the-basic-experience-helper?azure-portal=true). It gives us a lot of functionality for free.

The default XR experience will provide the following:

- Create a basic experience helper and initialize it
- Create an HTML UI button to enter XR
- Initialize the input source class that will initialize controllers
- Enable the pointer selection and teleportation features

```javascript
// Function to create a scene with camera, lights, an environment, and a Mixed Reality experience
var createScene = async function () {
  // Create the scene and the camera
  var scene = new Scene(engine);
  var camera = new ArcRotateCamera("cam", -Math.PI / 2, Math.PI / 2, 10, new Vector3(0, -2, 3), scene);
  camera.wheelDeltaPercentage = 0.01;
  camera.attachControl(canvas, true);

  // Create a basic hemispheric light source and add it to the scene
  var light = new HemisphericLight(
    "light1",
    new Vector3(0, 1, 0),
    scene
  );

  // Reduce the light intensity to 70%
  light.intensity = 0.7;

  // Create the default environment
  const env = scene.createDefaultEnvironment();

  // Create the default XR experience
  const xr = await scene.createDefaultXRExperienceAsync({
    floorMeshes: [env.ground],
  });

  // Return the completed scene with camera, lights, an environment, and a Mixed Reality experience
  return scene;
};
```

With this asynchronous function, you'll have a scene that has a camera, lights, an environment, and a Mixed Reality experience. But this scene doesn't yet have physics or a way to be rendered.

## Add physics with a physics engine

Next, we need to add some physics to our world. Plug-ins for four physics engines are available for use with Babylon.js: Cannon.js, Oimo.js, Energy.js, and Ammo.js. We'll use Cannon.js for this example, but you can read more about the engines on the [Babylon.js site](https://doc.babylonjs.com/features/featuresDeepDive/physics/usingPhysicsEngine). 

Cannon.js is a physics engine written completely in JavaScript. If you aren't familiar with what physics engines are, they provide an approximate simulation of physical systems like mass, gravity, friction, and restitution.

In the starter code, add the following code after you adjust the light intensity, but before you create the default environment. This code will add `CannonJSPlugin` and set the gravitational force.

```javascript
  // Create the physics engine
  var cannonPlugin = new CannonJSPlugin(true, 10, cannon);

  //enable physics and set gravity force.
  scene.enablePhysics(new Vector3(0, -3, 0), cannonPlugin);
```

Now the scene has a sense of gravity and physics.

## Render the scene

Finally, it's time to render the scene. To do this, you need to create an engine, create a scene, render the scene by using the engine, and then resize the engine to the size of the scene.

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

// Render the scene by using the engine
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

Now you can test the scene being rendered in the browser!

Run `npm start` and go to the localhost ('https://localhost:8080'). If you still have it running from earlier, the hot reload should have refreshed when you saved your changes, and you'll see them reflected. The scene will be blank blue, because you haven't added any mesh objects or textures.

Now that you've set up the basic elements of the scene, you're ready to start adding meshes and building out the Virtual Reality experience.

© 2021 Warner Bros. Ent. All Rights Reserved.
