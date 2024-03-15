Scene data can come from different sources, ranging from CAD, GIS, 3D content-creation software, imagery, and so on. Some preprocessing of these data might be required to load complex geometries with high polygon counts. For your wind-farm use case, we've created two Unity Prefabs for you. Using Unity's Prefab system allows you to create, configure, and store a GameObject complete with all its components, property values, and child GameObjects as a reusable Asset. The Prefab Asset acts as a template from which you can create new Prefab instances in the Scene.

## Reusing GameObjects

When you want to reuse a GameObject configured in a particular way—in our case, it's the terrain or scenery—in multiple places in your Scene or across multiple Scenes in your Project, you should convert it to a Prefab. This approach is better than simply copying and pasting the GameObject, because the Prefab system allows you to automatically keep all copies of the asset in sync. Any edits that you make to a Prefab asset are automatically reflected in the instances of that Prefab, allowing you to easily make broad changes across your whole project without having to make the same edit to every copy of the asset.

## Dynamic terrain assets

The dynamic terrain Prefab asset is built for you using the Microsoft Maps SDK, a map control for Unity that allows developers to connect the Bing Maps 3D mapping service to a Unity Scene. The dynamic terrain Prefab in this module uses the Maps SDK, and it's been preloaded into your Unity project. You'll need to assign your Bing Maps Developer Key to this project. To get started with Maps SDK, follow the [Maps SDK Getting started Wiki](https://github.com/microsoft/MapsSDK-Unity/wiki/Getting-Started).
