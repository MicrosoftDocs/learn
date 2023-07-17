At the time of this writing, MRTK3 does not yet have the *Object Collection* components that were available in MRTK2 (i.e. *Grid Object Collection*, *Scatter Object Collection* and *Tile Grid Object Collection*). Therefore they aren't covered in this tutorial. In the meantime, *Object Bar* can be used to help lay out an array of objects.

## Object Bar

An Object Bar is a dynamic collection of objects positioned in a horizontal or vertical stack. Spacing between objects can be configured.

## Difference between Prefabs and Collections / Object Bar

Collections are merely used for organizational purposes. Any changes made to a game object in a collection aren't reflected in other game objects. They're entirely different from Prefabs because they're only used to arrange a group of objects in a specific order.

Prefabs, on the other hand, are assets that assist in propagating the changes to all its instances. Prefabs are a reusable set of objects arranged in a particular way, but any changes made to the game object in a Prefab are reflected in all of its instances.
