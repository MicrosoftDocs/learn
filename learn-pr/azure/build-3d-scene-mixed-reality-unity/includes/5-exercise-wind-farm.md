Unity Prefabs let you create, configure, and store a GameObject as a reusable project asset. The dynamic terrain Prefab Asset is built using the Microsoft Maps SDK and connects to the Bing Maps 3D service. To get started, open up the blank **MainScene** we've included for you to develop throughout the learning path.

## Open the MainScene scene

1. [Download and Unzip the compressed folder from GitHub](https://aka.ms/mr-adt-mslearn) and take note of the folder location to where you extracted the project
2. In the **Project** panel, select **Assets > Scenes > MainScene**. Any **Save** actions will overwrite the original **MainScene**, which is the intent of this learning path. 

    :::image type="content" source="../media/main-scene.png" alt-text="Screenshot of the Unity editor with the one underscore build 3d scene loaded.":::

    > [!NOTE]
    > The **Assets > Scenes > CompletedScene** contains configuration, scripts, and relevant pointers to the final Scene. This Scene has been supplied to provide a ‘complete’ Scene representing all components and assets, but it will still require further configuration before it can be used (viz., Maps SDK and Azure Services).

We'll explore the benefits of static maps and dynamic maps in this module, starting by adding the static terrain and then adding the Maps SDK terrain.  

## Add static terrain

1. In the Project Panel, open the **Assets > Art > Prefabs** folder
2. Drag the Terrain Model named **Static Terrain** into the scene editor window
3. With the Static Terrain object selected in the **Hierarchy** Panel on the left, the **Inspector** window on the right will show the **Position, Rotation, and Scale** parameters under the Transform section.  Position the terrain using the Position coordinates `(X = -1.25, Y = -0.59, Z = 2)` so that the Static Terrain is to the front left of the user at startup.  
4. Save the scene under the **File > Save** menu option.

    :::image type="content" source="../media/static-terrain-position.png" alt-text="Screenshot of the Unity inspector with the static terrain prefab selected and the transform component in view.":::

You now have the static terrain Prefab loaded and available for use in your app. Next, you can load the Bing Maps dynamic terrain into the Scene.

## Create Bing Maps account

If you haven’t already, you need to [create a Bing Maps account](/bingmaps/getting-started/bing-maps-dev-center-help/creating-a-bing-maps-account).  You'll use that account to access the Microsoft Bing Maps Dev Center to generate a **Developer Key**, which is a code used to authenticate with the map service. The app you build will connect to that map service using your Bing Maps account.  

When you create a Developer Key, be sure to select Basic as the key type and **Windows Application** as the Application Type.

## Add dynamic terrain and configure Bing Maps data feed

1. From the Project panel, drag in the following Prefab into the **Hierarchy** panel:
    - **Assets > Art > Prefabs > Bing Maps Design**

2. Select the new instance of the Prefab in the hierarchy panel, and expand the **Map Session** component in the Inspector and enter the **Developer Key** obtained in the previous section.

    :::image type="content" source="../media/maps-developer-key.png" alt-text="Screenshot of the Bing Maps Design prefab with the map session script selected.":::

    > [!NOTE]
    > You may need to select another item in the hierarchy, then select Bing Maps again to refresh.

3. Expand the **Map Renderer (Script)** component in the **Inspector** and set the following **Location** and **Map Layout** settings:

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

    :::image type="content" source="../media/map-renderer.png" alt-text="Screenshot of the Bing Maps Design prefab with the map renderer script selected.":::

4. Expand the **Transform** component in the **Inspector** and validate the position of the map using the **Position** coordinates (X = 0, Y = -0.7, Z = 2) so the two maps are placed side by side.

    :::image type="content" source="../media/bing-maps-transform.png" alt-text="Screenshot of the Bing Maps Design prefab with the transform component selected.":::

5. Save the scene under the **File > Save** menu option.  If prompted, save your Scene in the **Scenes** folder.
6. In the Scene, you should have both the Static and Dynamic terrain loaded.  Navigate the Scene using your mouse and/or keyboard.

    > [!NOTE]
    > When you are navigating in the Scene panel, you may find your Assets of interest become set in awkward positions.  To return focus and zoom to a particular Asset, select the object in the Hierarchy panel, then click in the Scene window. Next, press Shift-F and your Scene will center on and zoom into the selected Asset.  The same effect can be achieved by double-clicking an Asset in the Hierarchy panel.
  
7. Press the **Play** button and navigate the Game panel.  

   Navigating within the Game panel can be achieved using the MRTK [input simulation service](/windows/mixed-reality/mrtk-unity/features/input-simulation/input-simulation-service).  Although many of the navigation techniques can be achieved using a standard keyboard and mouse, a wheel mouse simplifies navigation. 

8. Observe any differences between the Static Terrain and Dynamic Terrain (for example, endless terrain and contour lines in the Bing Maps terrain v. higher resolution imagery in the Static Terrain)

    :::image type="content" source="../media/bing-static-dueling-terrain.png" alt-text="Screenshot of the main scene in play mode with the static and Bing Maps terrains side by side.":::

## Remove static terrain 

1. Right-click the Static Terrain in the Hierarchy panel and select **Delete**.
2. Save the Scene under the **File > Save** menu option. This will overwrite the original Scene.
