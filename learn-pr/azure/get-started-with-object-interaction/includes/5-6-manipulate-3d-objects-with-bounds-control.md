Things get interesting when you can manipulate those holograms using your hands or any input source. To manipulate and grab an object with tracked hands, the objects must have the following components attached to them:

* **Collider**: Collider components outline the form of a GameObject for bodily collisions. Colliders are invisible so don't need to exactly match the GameObject's mesh. A rough approximation of the mesh is frequently more efficient and indistinguishable in gameplay.

* **Object Manipulator(Script)**: The ObjectManipulator script makes an object movable, scalable, and rotatable using one or both hands. The object manipulator can be configured to manipulate how the item will reply to numerous inputs. The script must work with maximum sorts of interaction, including HoloLens 2 articulated hand, HoloLens 2 hand rays, HoloLens 1 gaze and gestures, and immersive headset motion controller input.

## Bounds control

The BoundsControl presents a simple capability for remodeling objects in mixed reality. A bounds control will display a container across the hologram to suggest that it can be interacted with. Handles at the corners and edges of the box will permit scaling, rotating, or translating the object. The bounds control additionally reacts to your input. On HoloLens 2, for example, the bounds control responds to finger proximity, offering visible remarks to help understand the space from the object. All interactions and visuals may be effortlessly customized.
