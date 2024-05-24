MRTK-Unity is a Microsoft-driven project that provides a set of components and features, used to accelerate cross-platform MR app development in Unity. you'll use the MRTK to rapidly build immersive interaction with the 3D model of the wind turbine in your Scene. In particular, we'll use the following MRTK object classes within the **Microsoft.MixedReality.Toolkit.UI** Namespace in this project:

* **ObjectManipulator**: The `ObjectManipulator` script makes an object movable, scalable, and rotatable using one or two hands. The script works with both HoloLens gesture input and immersive headset's motion controller input.

* **BoundsControl**: Bounds Control allows to transform objects (rotate and scale) and draws a cube around the object to visualize the possibility of user triggered transform manipulation. Bounds Control provides scale and rotation handles you can use for far and near interaction manipulation of the object. It further provides a proximity effect for scale and rotation handles that alters scaling and material.

* **NearInteractionGrabbable**: You can add NearInteractionGrabbable components to any GameObject that has a collidable on it to make that collidable near grabbable. Any `IMixedRealityNearPointer` will then dispatch pointer events to the closest near grabbable objects. Additionally, the near pointer will send focus enter and exit events when the decorated object is the closest object to the near pointer

* **RotationAxisConstraint**: Can be used to constrain the turbine to only rotate around the Y (Up) axis

    :::image type="content" source="../media/so-turbine.png" alt-text="Screenshot of the Unity scene window with the wind turbine prefab in view and the wind turbine prefab selected in the inspector.":::

## Turbine prefabs

Each Digital Twin turbine Prefab has a corresponding `ScriptableObject` in the Unity project that stores data received from Microsoft Azure. `ScriptableObjects` are basically lightweight objects that can globally persist data across scenes and application runs. The windmill Prefab holds a reference to this `ScriptableObject`, and an event is triggered to notify the asset when the data have been updated. Take a look at these prefabs to see the MRTK components included and where the Azure data is received:

1. Navigate to **Assets > Art > Prefabs** to see the Digital Twin turbine. In the Inspector for the windmill, you can see that there is an LOD group, the MRTK Components previously described, and other scripts attached to this prefab.

    :::image type="content" source="../media/so-turbine.png" alt-text="Screenshot of the Unity scene window with the wind turbine scriptable object in view and in the Inspector.":::

2. You can find our simulated corresponding Scriptable Objects for the turbines in **Assets > Scriptable Objects > Turbine Site Data**.

    :::image type="content" source="../media/so-turbine-data.png" alt-text="Screenshot of the Unity scene window with the wind turbine scriptable objects in view.":::