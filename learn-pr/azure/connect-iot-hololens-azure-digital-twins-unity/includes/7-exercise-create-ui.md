Create ADT equipped User Interfaces to provide a window into operations data.

## Add the Operate Menu to the MainScene

1. If you have a **Bing Maps** Prefab or any turbine Prefabs in your Scene delete them, in the **Hierarchy** panel.
2. Drag the Prefab **Assets > Art > Prefabs > Bing Maps Operate** into the Hierarchy panel:
    - Configure the Maps SDK parameters, including your developer key
    - The **Bing Maps Operate** Prefab has additional components that load wind turbines using Addressables at runtime. The Addressable Asset System allows you to request an asset via its address. Once an asset (for example, a Prefab) is marked “addressable”, it generates an address, which can be called from a Unity application at runtime. Local and remotely stored assets are discovered by your application, along with any associated dependencies, and are returned.  
    - Turbine position can be changed via the Turbine Site Data **ScriptableObject**.   To alter the position of any turbine for placement at runtime, change the **Latitude** or **Longitude** values in the **Wind Turbine Meta Data**.  Find these configuration parameters for your Digital Twin turbines under **Assets > ScriptableObjects > Turbine Site Data**.

    :::image type="content" source="../media/scriptable-object-expanded.png" alt-text="Screenshot of the Unity editor with the Bing Maps operate prefab running in the main scene." lightbox="../media/scriptable-object.png":::

    > [!IMPORTANT]
    > Do not change any other parameters or characteristics on Addressables otherwise you will need to re-compile them, which is not covered in this module.

3. Drag the UI Panel Prefab from **Assets > UIPrefabs > Prefabs > OperateSceneUI** into the **Hierarchy** panel.  
    - This UI Panel is populated with Turbine Site Data at runtime. In this Prefab folder, you will find the **HandMenuOperate.prefab**.  This provides constraints, thresholds, and tracking configuration for menu operation on the HoloLens 2 using your hands.  The Prefab has been configured for default behavior and no further configuration is required.

    :::image type="content" source="../media/operate-scene-ui-expanded.png" alt-text="Screenshot of the Unity editor with the operate scene ui prefab running in the main scene. UI prefab is positioned away from the terrain." lightbox="../media/operate-scene-ui.png":::

## Explore the configurable items in the OperateSceneUI and Hand Menu - Operate

1. Use the Inspector panel to familiarize yourself with some of the parameters.
2. If you accidentally change a value, use Ctrl+Z to undo and revert to the original parameter

Once you are familiar with the Scene, you can go back and customize the color values of the data ranges in the **TurbinePanel** child of the **OperateSceneUI**.

## Customize colors for data ranges in UI

1. Navigate to **Assets > ScriptableObjects > Telemetry Range Data** in the Project Window. 
2. Select one of the four Telemetry ranges: **RangeAmbientTemperature, RangePower, RangeRotorSpeed, RangeWindSpeed**
3. Configure the color ranges on the **Health Indicator Gradient**.

## Position the UI in the MainScene

1. Select the **OperateSceneUI** Game Object in the hierarchy
2. Position the UI in the Scene as you would any other game object.  Consider how the user will likely be viewing the turbine data and where you would expect the User Interface to be relative to the turbine assets.

    :::image type="content" source="../media/position-ui-expanded.png" alt-text="Screenshot of the Unity editor with the operate scene ui prefab running in the main scene. UI prefab is positioned closer to the terrain." lightbox="../media/position-ui.png":::