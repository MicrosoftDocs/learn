Create Azure Digital Twins equipped user interfaces (UIs) to provide a window into operations data.

## Add the Operate menu to the main scene

1. If you have a Bing Maps prefab or any turbine prefabs in your scene, delete them in the **Hierarchy** panel.
1. Drag the prefab **Assets** > **Art** > **Prefabs** > **Bing Maps Operate** into the **Hierarchy** panel:

   - Configure the Maps SDK parameters, including your developer key.
   - The Bing Maps Operate prefab has other components that load wind turbines using *addressables* at runtime. The Addressable Asset System allows you to request an asset by using its address. Once an asset, for example, a prefab, is marked *addressable*, it generates an address. A Unity application can call the address at runtime. Your application discovers and returns local and remotely stored assets, along with any associated dependencies.
   - Turbine position can be changed by using the Turbine Site Data `ScriptableObject`. To alter the position of any turbine for placement at runtime, change the **Latitude** or **Longitude** values in the **Wind Turbine Meta Data**. Find these configuration parameters for your digital twin turbines under **Assets** > **ScriptableObjects** > **Turbine Site Data**.

   :::image type="content" source="../media/scriptable-object-expanded.png" alt-text="Screenshot of the Unity editor with the Bing Maps operate prefab running in the main scene." lightbox="../media/scriptable-object.png":::

   > [!IMPORTANT]
   > Don't change any other parameters or characteristics on addressables. Otherwise, you need to re-compile them, which is not covered in this module.

1. Drag the UI Panel prefab from **Assets** > **UIPrefabs** > **Prefabs** > **OperateSceneUI** into the **Hierarchy** panel.

   This UI panel is populated with Turbine Site Data at runtime.

   :::image type="content" source="../media/operate-scene-ui-expanded.png" alt-text="Screenshot of the Unity editor with the operate scene UI prefab running in the main scene, with the UI prefab positioned away from the terrain." lightbox="../media/operate-scene-ui.png":::

## Customize colors for data ranges in UI

1. Navigate to **Assets** > **ScriptableObjects** > **Telemetry Range Data** in the Project window.
1. Select one of the four telemetry ranges:

   - **RangeAmbientTemperature**
   - **RangePower**
   - **RangeRotorSpeed**
   - **RangeWindSpeed**

1. Configure the color ranges on the **Health Indicator Gradient**.

## Position the UI in the main scene

1. Select the **OperateSceneUI** game object in the hierarchy.
1. Position the UI in the scene as you would any other game object. Consider how the user is likely to view the turbine data and where you would expect the UI to be relative to the turbine assets.

   :::image type="content" source="../media/position-ui-expanded.png" alt-text="Screenshot of the Unity editor with the operate scene UI prefab in the main scene with the UI prefab closer to the terrain." lightbox="../media/position-ui.png":::
