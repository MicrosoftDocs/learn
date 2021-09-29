Arranging objects in a *collection* is another functional feature provided by the Mixed Reality Toolkit. Object collection is a script to help lay out an array of objects in predefined three-dimensional shapes. It supports various surface styles, including plane, cylinder, sphere, and radial. Because it supports any object in Unity, it can be used to lay out both 2D and 3D objects. The following sections explain more about the different types of object collection scripts.

## Grid object collection

You can use this type of collection on a set of child objects to organize them with some layout parameters. Grid object collection helps you swiftly create control panels or a set of prefabs or objects.

## Scatter object collection

This type of collection is simply a set of child objects randomly laid out within a radius. To run the randomization, you press **update collection**. Feel free to run the update as many times as you want, until you get the desired result.

## Tile grid object collection

You can use this type of collection to lay game objects of consistent size in a basic grid layout. Tile grid object collection is helpful when you want to place game objects on the scene methodically. For example, you might want to place objects lined up at regular intervals; it will be a tedious job to monitor the position of all the objects concerning other objects, and then place them. Instead of doing this manually, you can use object collection scripts to make this task easier.

## Difference between prefabs and collections

Collections are merely used for organizational purposes. Any changes made to a game object in a collection aren't reflected in other game objects. They are entirely different from prefabs because they're only used to arrange a group of objects in a specific order.

Prefabs, on the other hand, are assets that assist in propagating the changes to all its instances. Prefabs are a reusable set of objects arranged in a particular way, but any changes made to the game object in a prefab are reflected in all of its instances.
