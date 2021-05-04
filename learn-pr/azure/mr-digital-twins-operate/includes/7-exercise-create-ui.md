Create ADT equipped User Interfaces to provide a window into operations data.

## Add the Operate Menu to the MainScene

1.	Delete your **Bing Maps** Prefab from your **MainScene** Scene in the **Hierarchy** panel.
2.	Drag the Prefab **Assets > Art > Prefabs > Bing Maps Operate** into the Hierarchy panel
i.	Configure the Maps SDK parameters including your developer key
ii.	The **Bing Maps Operate** Prefab has additional components that load wind turbines using Addressables at runtime. The Addressable Asset System allows you to ask for an asset via its address. Once an asset (e.g. a Prefab) is marked "addressable", it generates an address which can be called from anywhere. Wherever the asset resides (local or remote), the system will locate it and its dependencies, then return it.  
iii.	Turbine position can be changed via the Turbine Site Data **ScriptableObject**.   To alter the position of any turbine for runtime placement, change their **Latitude** or **Longitude** values in the **Wind Turbine Meta Data**.  Find these configuration parameters for your Digital Twin turbines under **Assets > ScriptableObjects > Turbine Site Data**.

<!-- :::image type="content" source="" alt-text=""::: -->

3.	Drag the UI Panel Prefab from **Assets > UIPrefabs > Prefabs > OperateSceneUI** into the **MainScene**.  
i.	This UI Panel takes the Turbine Site Data and populates its contents at runtime

<!-- :::image type="content" source="" alt-text=""::: -->

4.	Drag the Prefab **Assets > UIPrefabs > Prefabs > Hand Menu - Operate** into the **MainScene**.  This provides constraints, thresholds and tracking configuration for menu operation on the HoloLens 2 with your hands.  The Prefab has been configured for default behavior and no further configuration is required.

## Explore the configurable items in the OperateSceneUI and Hand Menu - Operate

1.	Use the Inspector panel to familiarize yourself with some of the parameters.
2.	If you accidentally change a value, use Ctrl+Z to undo and revert back to the original parameter

> [!NOTE]
> Once you are familiar with the Scene you can go back and customise the color values of the data ranges in the **TurbinePanel** child of the **OperateSceneUI**. To modify this, navigate to **Assets > ScriptableObjects > Telemetry Range Data** in the Project Window. Here you will find four Telemetry ranges: **RangeAmbientTemperature, RangePower, RangeRotorSpeed, RangeWindSpeed**. After selecting one of these ranges, you can then configure the colour ranges on the **Health Indicator Gradient**.

## Position the UI in the MainScene

1.	Select the **OperateSceneUI** Game Object in the hierarchy
2.	Position the UI in the Scene as you would any other game object.  Consider how the user will likely be viewing the turbine data and where you would expect the User Interface to be relative to the turbine assets.

<!-- :::image type="content" source="" alt-text=""::: -->


