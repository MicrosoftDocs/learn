Unity’s Prefab system allows you to create, configure, and store a GameObject complete with all its components, property values, and child GameObjects as a reusable Asset. The Prefab Asset acts as a template from which you can create new Prefab instances in the Scene.

When you want to reuse a GameObject configured in a particular way—like a non-player character (NPC), prop, or piece of scenery—in multiple places in your Scene, or across multiple Scenes in your Project, you should convert it to a Prefab. This technique is better than simply copying and pasting the GameObject, because the Prefab system allows you to automatically keep all the copies in sync. Any edits that you make to a Prefab Asset are automatically reflected in that Prefab's instances, allowing you to easily make broad changes across your whole Project without having to repeatedly make the same edit to every copy of the Asset.

When you modify a Prefab Asset, the changes are reflected in all instances. You can override any instance of the Prefab to create variations between Prefab instances, while still linking those instances to the same Prefab Asset. Doing so creates an instance override on that instance of the Prefab.

The Prefab wind-turbine model you're importing is an Autodesk Filmbox format (*.FBX), complete with Level Of Detail (LOD) groups defined for meshes to improve rendering performance.

> [!TIP]
> Level of detail (LOD) is a technique that reduces the number of GPU operations that Unity requires to render distant meshes. When a GameObject in the Scene is far away from the Camera, you see less detail compared to when the GameObject is close to the Camera. However, by default, Unity uses the same number of triangles to render it at both distances. This can result in wasted GPU operations, which can impact performance in your Scene.

The LOD technique allows Unity to reduce the number of triangles it renders for a GameObject based on its distance from the Camera. To use it, a GameObject must have a number of meshes with decreasing levels of detail in its geometry. These meshes are called LOD levels. The further a GameObject is from the Camera, the lower-detail LOD level Unity renders. This technique reduces the load on the hardware for these distant GameObjects and can therefore improve rendering performance.

:::image type="content" source="../media/lod-turbine.png" alt-text="Screenshot of the Unity scene window with the wind-turbine prefab in view.":::
