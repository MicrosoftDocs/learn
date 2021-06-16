We have now setup the scene, default xr experience and physics. We are going to build out the character buttons and interactions next. 

To create the buttons and interactions we will be using the BabylonJS-GUI library. We will use the `GUI.GUI3DManager` and `GUI.CylinderPanel` to manage the group of `GUI.HolographicButton` buttons.

First, create a new file called `environment.ts`. We import our packages and player class that we setup to map the properties from the JSON file:

# Import the packages

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

Now, when you build your project all of the necessary packages will be imported and available to you to create your Mixed Reality experience.

## Create class and constructor

Next we will create the environment class and private variables to map in the constructor. We need to pass in our scene, engine, and import the JSON data to an array.

> [!TIP]
> This module uses the [starter code found on GitHub](https://aka.ms/LearnWithBasketball/BabylonsJS?azure-portal=true). If you completed the previous module in this *Space Jam: A New Legacy* inspired learning path, you might also have your own players.json file, which you can also use.

```javascript
export class Environment {
    private _scene: Scene;
    private _engine: Engine;
    private _players: Array<Player>;

    constructor(scene: Scene, engine: Engine) {
        this._scene = scene;
        this._engine = engine;

        //import data from json
        this._players = require('./data/players.json');
    }
}
```

Now you have an environment with a scene, engine to render the scene, and data from the json file, it's time to create the player icons and make them clickable!

© 2021 Warner Bros. Ent. All Rights Reserved.
