When working with Azure Object Anchors, An object may turn out to be more difficult to detect at times. Here are some best practices to keep in mind when using Azure Object Anchors.

## Best practices for object conversion

* Dimension of your physical objects should be between the recommended range of 1m-10m.
* Use Software like [MeshLab](https://www.meshlab.net/) to ensure the following details.

  * Ensure that the 3D model has a triangle mesh and that the triangles on the exterior surface face outward. That is, the vertices should be orientated so that the normals are oriented outwards according to the right-hand rule.
  * Ensure that the scale units for the 3D Model are correct concerning the physical object. Units to be considered should be one of **Centimeters**, **Decimeters**, **Feet**, **Inches**, **Kilometers**, **Meters**, **Millimeters**, **Yards**.
  * Confirm that the nominal gravity direction corresponds to the object's real-world vertical orientation. If the object's downward vertical/gravity is -Y, use (**0, -1, 0**) if it is -Z then use (**0, 0, -1**).
  * Verify that the 3D model is in one of the supported file types: .glb, .gltf, .ply, .fbx, .obj.

## Best practices for object detection

* Start the app while standing about 2 meters away from the nearest surface when testing.
* Before starting the Azure Object Anchors app on HoloLens 2 device, remove all Holograms using the **Settings** app on your HoloLens2. To start with a fresh map go to **System** -> **Holograms** ->, there select **Remove all holograms**.
Clearing the holograms ensures that objects can be properly detected if it has been moved from its position recently.
* Once the holograms have been removed and before starting the app, scan the object by walking around it from 1-2 meters away a few times wearing the HoloLens.
* You may need to scan the object at a closer range from numerous angles and distances if it is dark and highly reflective.

## Troubleshooting steps if you are not able to detect model

* Add a few posters to ensure that your room has adequate textures.
* Scan the object more thoroughly in all directions.
* Clear the spatial mapping cache and rescan the object.
* When converting the 3D model, double-check that the gravity direction and asset dimensions are right.
