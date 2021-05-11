MRTK-Unity is a Microsoft-driven project that provides a set of components and features, used to accelerate cross-platform MR app development in Unity. you'll use the MRTK to rapidly build immersive interaction with the 3D model of the wind turbine in your Scene.  In particular, the following MRTK object classes within the **Microsoft.MixedReality.Toolkit.UI** Namespace will be used in this project:    

1. **ObjectManipulator**: The ObjectManipulator script makes an object movable, scalable, and rotatable using one or two hands. The script works with both HoloLens' gesture input and immersive headset's motion controller input.

2. **BoundsControl**: Bounds Control allows to transform objects (rotate and scale) and draws a cube around the object to visualize the possibility of user triggered transform manipulation. Bounds Control provides scale and rotation handles that can be used for far and near interaction manipulation of the object. It further provides a proximity effect for scale and rotation handles that alters scaling and material.

3. **NearInteractionGrabbable**: NearInteractionGrabbable components can be added to any GameObject that has a collidable on it to make that collidable near grabbable. Any IMixedRealityNearPointer will then dispatch pointer events to the closest near grabbable objects. Additionally, the near pointer will send focus enter and exit events when the decorated object is the closest object to the near pointer

4. **RotationAxisConstraint**:  Can be used to constrain the turbine to only rotate around the Y (Up) axis

    :::image type="content" source="../media/so-turbine.png" alt-text="Screenshot of the Unity scene window with the wind turbine prefab in view and the wind turbine prefab selected in the inspector.":::

Each Digital Twin turbine Prefab has a corresponding ScriptableObject in the Unity project that stores data received from Microsoft Azure. The Prefab holds a reference to this ScriptableObject and an event is triggered to notify the asset when the data have been updated. 

:::image type="content" source="../media/so-turbine-data.png" alt-text="Screenshot of the Unity scene window with the wind turbine scriptable object in view.":::