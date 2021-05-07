Unity’s Prefab system allows you to create, configure, and store a GameObject complete with all its components, property values, and child GameObjects as a reusable Asset. The Prefab Asset acts as a template from which you can create new Prefab instances in the Scene.

When you want to reuse a GameObject configured in a particular way – like a non-player character (NPC), prop or piece of scenery – in multiple places in your Scene, or across multiple Scenes in your Project, you should convert it to a Prefab. This is better than simply copying and pasting the GameObject, because the Prefab system allows you to automatically keep all the copies in sync.

Any edits that you make to a Prefab Asset are automatically reflected in the instances of that Prefab, allowing you to easily make broad changes across your whole Project without having to repeatedly make the same edit to every copy of the Asset.  You can override any particular instance of the Prefab, known as instance overrides, to create variations between Prefab instances, while still linking those instances to the same Prefab Asset.  When you modify a Prefab Asset, the changes are reflected in all of its instances. However, you can also make modifications directly to an individual instance. Doing this creates an instance override on that particular instance.

The Prefab wind turbine model you're importing is an Autodesk’s Filmbox format (*.FBX), complete with Level Of Detail (LOD) groups defined for meshes to improve rendering performance.

:::image type="content" source="../media/lod-turbine.png" alt-text="Screenshot of the Unity scene window with the wind turbine prefab in view.":::

Your HoloLens 2 app will be retrieving assets from Blob Storage hosted in an Azure Storage Account. As part of an Azure Resource Manager (ARM) template used in the next module, this storage account and Blob Storage will be created automatically.