Arranging objects in a collection is another functional feature provided by MRTK. Object collection is a script to help layout an array of objects in predefined three-dimensional shapes. It supports various surface styles, including plane, cylinder, sphere, and radial. Since it supports any object in Unity, it can be used to layout both 2D and 3D objects. There are different types of Object Collection Scripts; they are as follows:

## Grid object collection

You can use Grid Object Collection on a set of child objects to organize them with some layout parameters. The collection can be used to swiftly create control panels or a set of prefabs/objects.

## Scatter object collection

A Scatter Object Collection is simply a set of child objects randomly laid out within a radius. Pressing "update collection" will run the randomization, feel free to run as many times until you get the desired result.

## Tile grid object collection

You can use Tile Grid Object Collection to lay game objects of consistent size in basic grid layout.

Object collection is used quite often to place game objects on the scene methodically. You might want to place objects lined up at regular intervals; it will be a tedious job to monitor the position of all the objects concerning other objects and then place them. Instead of doing this manually, you can use Object Collection scripts to ease this task.

## Difference between prefabs and collections

Collections are merely used for organization purposes. Any changes made to a game object in a collection aren't reflected in other game objects. They are entirely different from prefabs as they are only used to arrange a group of objects in a specific order. But prefabs, on the other hand, are assets that assist in propagating the changes to all its instances. Prefabs are a reusable set of objects arranged in a particular way, but any changes made to the game object in a prefab are reflected in all its instances.
