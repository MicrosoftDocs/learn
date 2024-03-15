In this module, you'll learn how to build a Scene in Unity. A Scene is like a canvas, where you'll set up an experience for your end user. Typically, these experiences start with broader data sets and supporting information to provide context in your immersive experience. In the wind-farm use case we introduced in the last module, you'll explore the use of two types of geographical scene data:

- Static terrain
- Dynamic terrain

Static terrain is loaded into the Scene once, and is loaded at design time. It isn't updated unless the source terrain file is updated and the Scene is refreshed. In contrast, dynamic terrain is loaded into the Scene on demand at run time. Both static and dynamic terrains are valuable, depending on the needs of the use case. Static terrain is useful for disconnected experiences, experiences where bandwidth concerns are present, where you already have imagery/data, or where data consistency is important (that is, the static terrain never changes). Dynamic terrain is most useful when used to ingest data that morphs or is updated, or when a developer doesn't have access to static data and would like to use a mapping service.

In this module, you'll load terrain data from a static source and then replace it with satellite imagery from the Bing Maps service via Maps SDK. You'll use this dynamic image 3D map to locate and interact with your wind turbines and associated operations data.
