If you begin with a new Unity project, your Scene will be labeled **Untitled**.  

1. **File > Save** menu option. This will overwrite the original Scene.  Save the Scene as **MainScene**.

You can begin with an empty scene and re-create the Scene components from any previous, related module(s), or you can begin with the relevant prebuilt Scene created for you based on a prior module.  Five Scenes have been included in the sample Unity project to assist with your learning.  Scene **1_Build3DScene** contains a completed Scene for this module.  If you complete this module and are having difficulties or would simply like to confirm your work, you can load this Scene and compare it to the Scene you built.  If you choose to load the Scene representing a completed module, you still need to configure some parameters, including Maps SDK and Azure services.

## Add existing Scene  [optional]

1. In the Project Panel, open the **Assets > Scenes** folder
2. Select and drag the Scene to the Hierarchy panel.  For this module, select
**1_Build3DScene**
3. Configure necessary service parameters (for example, Maps SDK, Azure Services, and so on)

> [!NOTE]
> The **Final_CompletedScene** contains configuration, scripts, and relevant pointers to the final build.  It will still require further configuration.  After you have added the Scene you would prefer to work with, remove any other unwanted Scenes by right clicking and** Remove Scene**.

:::image type="content" source="../media/main-scene.png" alt-text="Screenshot of the Unity editor with the 1 underscore build 3d scene loaded.":::

## Add Static Terrain

1. In the Project Panel, open the **Assets > Art > Prefabs** folder
2. Drag the Terrain Model named **Static Terrain** into the scene editor window
3. With the Static Terrain object selected in the **Hierarchy** Panel on the left, the **Inspector** window on the right will show the **Position, Rotation, and Scale** parameters under the Transform section.  Position the terrain using the Position coordinates `(X = -1.25, Y = -0.59, Z = 2)` so that the Static Terrain is in front of the user at startup.  
4. Save the scene under the **File > Save** menu option.

:::image type="content" source="../media/static-terrain-position.png" alt-text="Screenshot of the Unity inspector with the static terrain prefab selected and the transform component in view.":::

You now have the static terrain Prefab loaded and available for use in your app. Next, you can load the Bing Maps dynamic terrain into the Scene.

## Create Bing Maps Account

If you haven’t already, you need to [create a Bing Maps account](https://docs.microsoft.com/bingmaps/getting-started/bing-maps-dev-center-help/creating-a-bing-maps-account).  You'll use that account to generate a developer **Key** in the Microsoft Bing Maps Dev Center, which is a code used to authenticate with the service. The app you build will connect to the service using your account.  

When you create a Bing Maps Key, be sure to select **Basic** as the key type and **Windows Application** as the Application Type.

## Add Dynamic Terrain and configure Bing Maps data feed

1. From the Project panel, drag in the following Prefab into the **Hierarchy** panel:
- **Assets > Art > Prefabs > Bing Maps Design**

2. Select the new instance of the Prefab in the hierarchy panel, and expand the **Map Session** component in the Inspector and enter the **Developer Key** obtained in the previous section.

:::image type="content" source="../media/maps-developer-key.png" alt-text="Screenshot of the Bings Maps Design prefab with the map session script selected.":::

3. You may need to select another item in the hierarchy, then select Bing Maps again to refresh
4. Expand the **Map Renderer (Script)** component in the **Inspector** and set the following **Location** and **Map Layout** settings:

**Location**
|  |  |
|---|---|
| Latitude | 48.38 |
| Longitude | -67.703 |
| Zoom Level | 15.5 |

**Map Layout**
|  |  |
|---|---|
| Map Shape | Cylinder |
| Local Map Radius | 1 |
| Local Base Height | 0.3 |

:::image type="content" source="../media/map-renderer.png" alt-text="Screenshot of the Bings Maps Design prefab with the map renderer script selected.":::

5. Expand the **Transform** component in the **Inspector** and position the map using the **Position** coordinates (X = 0, Y = -0.7, Z = 2) so it sits in front of the user.

:::image type="content" source="../media/bing-maps-transform.png" alt-text="Screenshot of the Bings Maps Design prefab with the transform component selected.":::

6. Save the scene under the **File > Save** menu option.  If prompted, save your Scene in the **Scenes** folder.
7. In the Scene, you should have both the Static and Dynamic terrain loaded.  Navigate the Scene using your mouse and/or keyboard.  
8. Press the **Play** button and navigate the Game panel.  
9. Observe any differences between the Static Terrain and Dynamic Terrain (for example, endless terrain and contour lines in the Bing Maps terrain v. higher resolution imagery in the Static Terrain)

:::image type="content" source="../media/bing-static-dueling-terrain.png" alt-text="Screenshot of the main scene in play mode with the static and bing map terrains side by side.":::

## Remove static terrain 

1. Right-click the Static Terrain in the Hierarchy panel and select **Delete**.
2. Save the Scene under the **File > Save** menu option. This will overwrite the original Scene.