We've set up the scene, default XR experience, and physics. Now let's build out the character icons and interactions. 

To create the icons and interactions, we'll use the `babylonjs-gui` library. We'll use `GUI.GUI3DManager` and `GUI.CylinderPanel` to manage the group of `GUI.HolographicButton` icons.

## Import the packages

First, create a new file called *environment.ts*. Import the packages and player class that you set up to map the properties from the JSON file:

```javascript
import {
    Scene,
    Engine,
    AssetsManager,
    Vector3,
    TransformNode,
    SceneLoader,
    Mesh
} from "babylonjs";

import { Player } from "./models/Player";
import * as GUI from "babylonjs-gui";
import 'babylonjs-loaders';
import { AbstractMesh } from "babylonjs/Meshes/abstractMesh";
```

Now, when you build your project, all of the necessary packages will be imported and available for you to create your Mixed Reality experience.

## Create the class and constructor

Next, create the environment class and private variables to map in the constructor. You need to pass in the scene and engine, and import the JSON data to an array.

> [!TIP]
> This module uses the [starter code on GitHub](https://aka.ms/LearnWithBasketball/BabylonsJS?azure-portal=true). If you completed the previous module in the learning path inspired by *Space Jam: A New Legacy*, you might also have your own *players.json* file. You can choose to use that.

```javascript
export class Environment {
    private _scene: Scene;
    private _engine: Engine;
    private _players: Array<Player>;

    constructor(scene: Scene, engine: Engine) {
        this._scene = scene;
        this._engine = engine;

        //Import data from JSON
        this._players = require('./data/players.json');
    }
}
```

Now you have an environment with a scene, an engine to render the scene, and data from the JSON file. It's time to create the player icons and make them clickable!

© 2021 Warner Bros. Ent. All Rights Reserved.
