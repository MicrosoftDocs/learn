You have two options to start the exercises in this module:

1. If you're starting this module without having completed the Configure 3D assets for Mixed Reality in Unity  module or wish to abandon any previous work you undertook creating a Scene, add a pre-built scene:

- In the Project Panel, open the **Assets > Scenes > Supporting Scenes > ModuleStartScenes** folder.
- Select and drag the Scene to the Hierarchy panel.  For this module, locate and select
**2_PlaceDigitalTwinAssets**.  If you use this Scene, it contains the **Bing Maps.prefab** Prefab.
- Configure the necessary service parameters (that is, Maps SDK) as defined in Build a 3D Scene for Mixed Reality in Unity module. 

2. If you're starting this module after completing Configure 3D assets for Mixed Reality in Unity module **AND** you want to continue using your Scene:

- If your previously built Scene isn't already open in Unity, select **File > Open Scene**.
- Browse to the folder where you saved your Scene.  Typically, this is the **Assets > Scenes** folder in the root project folder structure.  If you followed the guidance in the previous module, your Scene will be called **MainScene**.

> [!NOTE]
> The **Assets > Scenes > CompletedScene** contains configuration, scripts, and relevant pointers to the final build.  If you want to use it, you will need to configure the Scene parameters (viz., Maps SDK and Azure Services) from steps found in this module and Build a 3D Scene for Mixed Reality in Unity.

Unity Prefabs have been created to accelerate the connectivity of your wind farm to the ADT service.  The **ADTConnection** Prefab handles all incoming data from ADT through the Azure SignalR service.  This connection has an associated data handler script that will automatically update the **TurbineSiteData ScriptableObject** with operating information for each turbine.  This TurbineSiteData ScriptableObject is used to update controls on the **OperateSceneUI** based on events raised within this prefab.  

## Add ADT Connection Prefab

1. From the Project Panel, drag the **Assets > ADTPrefabs > ADTConnection** to the Hierarchy Panel.  

:::image type="content" source="../media/inspector-adt-alert.png" alt-text="Screenshot of the Unity Inspector with the ADT Turbine Alert Controller prefab selected.":::

<!-- ## Add ADT Turbine Alert Controller Prefab

1. From the Project Panel, drag the **Assets > ADTPrefabs > ADTTurbineAlertController** to the Hierarchy Panel.

:::image type="content" source="../media/inspector-adt-connector.png" alt-text="Screenshot of the Unity Inspector with the ADT Connection prefab selected."::: -->