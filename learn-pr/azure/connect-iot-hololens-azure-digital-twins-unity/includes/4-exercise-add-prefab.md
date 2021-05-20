Now that you know a little more about the basics of using telemetry data and what ARM templates bring to the table, it's time to add Azure Digital Twins prefabs to the Unity project. Follow the steps below to get up and running with our pre-built Unity scene:

1. Clone or download the project from [GitHub](https://github.com/MicrosoftDocs/mslearn-mixed-reality-and-azure-digital-twins-in-unity/).
2. In the Project Panel, open the **Assets > Scenes > Supporting Scenes > ModuleStartScenes** folder.
3. For this module, locate and open **2_PlaceDigitalTwinAssets**.  This Scene contains the **Bing Maps.prefab** Prefab that we'll be using.
4. Find your Bing Maps developer key. If you don't have one, you can sign up for one here: [Create a Bing Maps account](/bingmaps/getting-started/bing-maps-dev-center-help/creating-a-bing-maps-account).
5. Select the **Bing Maps** game object from the **Hierarchy**, then enter your Developer Key and apply the following configurations to the **Map Renderer** component:

    **Location**

    | Property | Value |
    |---|---|
    | Latitude | 36.69 |
    | Longitude | -78.36 |
    | Zoom Level | 15.5 |

    **Map Layout**

    | Property | Value |
    |---|---|
    | Map Shape | Cylinder |
    | Local Map Radius | 1 |
    | Local Base Height | 0.3 |

> [!NOTE]
> The **Assets > Scenes > CompletedScene** contains configuration, scripts, and relevant pointers to the final build.  If you want to use it for reference, make sure you've completed all the configuration steps from this module and Build a 3D Scene for Mixed Reality in Unity.

Unity Prefabs have been created to accelerate the connectivity of your wind farm to the Azure Digital Twins service.  The **ADTConnection** Prefab handles all incoming data from ADT through the Azure SignalR service.  This connection has an associated data handler script that will automatically update the **TurbineSiteData ScriptableObject** with operating information for each turbine.  This TurbineSiteData ScriptableObject is used to update controls on the **OperateSceneUI** based on events raised within this prefab.  

## Add ADT Connection Prefab

1. From the Project Panel, drag the **Assets > ADTPrefabs > ADTConnection** to the Hierarchy Panel.  

    :::image type="content" source="../media/inspector-adt-connector.png" alt-text="Screenshot of the Unity Inspector with the ADT Turbine Alert Controller prefab selected.":::