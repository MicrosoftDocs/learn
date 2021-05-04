You can begin with an empty scene and re-create the Scene components from any previous, related module(s), or you can begin with the relevant prebuilt Scene created for you based on a prior module.  Five Scenes have been included in the sample Unity project to assist with your learning.  Scene 2_PlaceDigitalTwinAssets contains a completed Scene from the prior module.  If you complete this module and are having difficulties or would simply like to confirm your work, you can load this Scene and compare it to the Scene you built.  If you choose to load the Scene representing a completed module, you still need to configure some parameters, including Maps SDK and Azure services.

## Open your previously built Scene

1.	If your previously built Scene is not already open, select **File > Open Scene**
2.	Browse to the folder where you saved your Scene.  Typically this is the **Assets > Scenes** folder in the root project folder structure.

OR

## Add existing Scene  [optional]

1.	In the Project Panel, open the **Assets > Scenes** folder
2.	Select and drag the Scene to the Hierarchy panel.  For this module, select
**2_PlaceDigitalTwinAssets**.  If you use this Scene, it will contain the **Bing Maps.prefab** Prefab.
3.	Configure necessary service parameters (e.g., Maps SDK, Azure Services, etc.)

> [!NOTE]
> The **Final_CompletedScene** contains configuration, scripts, and relevant pointers to the final build.  It will still require further configuration.

A number of Prefabs have been created to accelerate the connectivity of your wind farm to Azure Digital Twin.  The **ADTConnection** Prefab handles all incoming data from ADT through the Azure SignalR service.  This connection has an associated data handler script that will automatically update the TurbineSiteData Scriptable Object with operating information for each turbine.  This TurbineSiteData Scriptable Object is used to update controls on the **OperateSceneUI** based on events raised within this prefab.  The **ADTTurbineAlertController** sends an update to the Alert property from a local turbine.  It contains a number of scripts to track events for you.

## Add Operate Scene Prefab

1.	From the Project Panel, drag the **Assets > UIPrefabs > Prefabs > OperateSceneUI** to the Hierarchy Panel.
2.	Position the UI elements in the same way you position any other asset,using the **Move Tool, Rotate Tool**, etc.

<!-- :::image type="content" source="" alt-text=""::: -->

- Add ADT Connection Prefab
1.	From the Project Panel, drag the **Assets > ADTPrefabs > ADTConnection** to the Hierarchy Panel.  

<!-- :::image type="content" source="" alt-text=""::: -->

## Add ADT Turbine Alert Controller Prefab

1.	From the Project Panel, drag the **Assets > ADTPrefabs > ADTTurbineAlertController** to the Hierarchy Panel.

<!-- :::image type="content" source="" alt-text=""::: -->
