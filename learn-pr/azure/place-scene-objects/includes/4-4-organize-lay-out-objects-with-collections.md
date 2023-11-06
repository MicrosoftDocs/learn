## Object Bar

An Object Bar is a dynamic collection of objects positioned in a horizontal or vertical stack. Spacing between objects can be configured. This component is usually used to format UI, such as a button bar, but in this example we will use it to position pieces of a model. 

## Difference between Prefabs and Collections / Object Bar

Collections are merely used for organizational purposes. Any changes made to a game object in a collection aren't reflected in other game objects. They're entirely different from Prefabs because they're only used to arrange a group of objects in a specific order.

Prefabs, on the other hand, are assets that assist in propagating the changes to all its instances. Prefabs are a reusable set of objects arranged in a particular way, but any changes made to the game object in a Prefab are reflected in all of its instances.

## Unity Canvas Positioning 

While the Object Bar provides a tool to position objects for this specific use case, for most cases in MRTK3 object positioning should be accomplished with Unity's [Canvas UI](https://docs.unity3d.com/Documentation/Manual/UICanvas.html).
