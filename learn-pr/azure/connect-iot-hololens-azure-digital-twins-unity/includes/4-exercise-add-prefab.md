Now that you know a little more about the basics of using telemetry data and what ARM templates bring to the table, it's time to add Azure Digital Twins prefabs to the Unity project. Follow the steps in this procedure to get up and running with our prebuilt Unity scene:

1. Clone or download the project from [GitHub](https://aka.ms/mr-adt-mslearn).
1. In the **Project** panel, open the **Assets** > **Scenes** > **Supporting Scenes** > **ModuleStartScenes** folder.
1. For this module, locate and open **2_PlaceDigitalTwinAssets**. This scene contains **Bing Maps.prefab**, which is the prefab for this module.
1. Find your Bing Maps developer key. If you don't have a Bing Maps developer account, you can sign up for one here: [Create a Bing Maps account](/bingmaps/getting-started/bing-maps-dev-center-help/creating-a-bing-maps-account).
1. Select the **Bing Maps** game object from the **Hierarchy**, then enter your developer key and apply the following configurations to the **Map Renderer** component:

| Property | Value |
|---|---|
| Latitude | 36.69 |
| Longitude | -78.36 |
| Zoom Level | 15.5 |

| Property | Value |
|---|---|
| Map Shape | Cylinder |
| Local Map Radius | 1 |
| Local Base Height | 0.3 |

> [!NOTE]
> The **Assets** > **Scenes** > **CompletedScene** contains configuration, scripts, and relevant pointers to the final build. If you want to use it for reference, make sure you've completed all the configuration steps from this module and build a 3D Scene for mixed reality in Unity.

Unity prefabs have been created to accelerate the connectivity of your wind farm to the Azure Digital Twins service. The *ADTConnection* prefab handles all incoming data from Azure Digital Twins through the Azure SignalR Service. This connection has an associated data handler script that automatically updates the `TurbineSiteData ScriptableObject` with operating information for each turbine. This `TurbineSiteData` scriptable object is used to update controls on the `OperateSceneUI` based on events raised within this prefab.

## Add Azure Digital Twins connection prefab

From the **Project** panel, drag the **Assets** > **ADTPrefabs** > **ADTConnection** to the hierarchy panel.

:::image type="content" source="../media/inspector-adt-connector.png" alt-text="Screenshot of the Unity Inspector with the ADT Turbine Alert Controller prefab selected.":::
