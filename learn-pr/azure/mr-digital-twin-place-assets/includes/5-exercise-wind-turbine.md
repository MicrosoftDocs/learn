You can begin with an empty scene and re-create the Scene components from any previous, related module(s), or you can begin with the relevant prebuilt Scene created for you based on a prior module.  Five Scenes have been included in the sample Unity project to assist with your learning.  Scene **1_Build3DScene** contains a completed Scene from the prior module.  If you complete this module and are having difficulties or would simply like to confirm your work, you can load this Scene and compare it to the Scene you built.  If you choose to load the Scene representing a completed module, you still need to configure some parameters, including Maps SDK and Azure services.

- Open your previously built Scene

1. If your previously built Scene is not already open, select **File > Open Scene**
2. Browse to the folder where you saved your Scene.  Typically this is the **Assets > Scenes** folder in the root project folder structure.

OR

- Add existing Scene  [optional]

4. In the Project Panel, open the **Assets > Scenes** folder
5. Select and drag the Scene to the Hierarchy panel.  For this module, select
**1_Build3DScene**
6. Configure necessary service parameters (e.g., Maps SDK, Azure Services, etc.)

> [!NOTE]
> The **Final_CompletedScene** contains configuration, scripts, and relevant pointers to the final build.  It will still require further configuration.

Placing your Prefab wind turbine assets in the Scene enables interaction with the assets.

## Place and configure turbine on Static Terrain

1. Open the **Assets > Art > Prefabs** folder in your Project Window
2. If you already have a map in the scene, delete the asset by right clicking it in the Hierarchy panel and select **Delete**.  Don’t worry, it only removes it from your Scene and does not delete the Prefab from your Unity Project.
3. Add the **Static Terrain.prefab** Prefab by dragging it to the Hierarchy panel
4. Drag the Prefab named **Wind Turbine Static Map.prefab** into the Scene window

:::image type="content" source="../media/prefab-static-terain-turbine.png" alt-text="Screenshot of the Unity project panel with the art folder open with the prefabs subfolder selected.":::

5. Make the **Wind Turbine Static Map** a child of the **Static Terrain** by nesting it under the Static Terrain Asset in the Hierarchy window.  Be sure to drag it to the bottom of the list of children or you will receive a message “Cannot restructure Prefab instance”.  If you receive this, select **Cancel**, and place the Prefab at the bottom of the list of children directly under the Static Terrain.

:::image type="content" source="../media/prefab-child-order-static-map.png" alt-text="Screenshot of the Unity scene window with the main scene running and the static terrain prefab in view.":::

6. Set the scale in the **Transform** component in the **Inspector** panel for the Wind Turbine to **(0.003, 0.003, 0.003)** so it approximately matches the terrain scale
7. Select the **Move Tool** just under the **Edit** menu item, select the Wind Turbine if it’s not already selected.  Use the green-red-blue arrows (or the center box) on screen to position the turbine at the centre of the terrain

:::image type="content" source="../media/move-turbine-static-terrain.png" alt-text="Screenshot of the Unity scene window with the main scene running and the wind turbine static map child object and scale tool highlighted.":::

8. With the turbine still selected, select the **Rotate Tool** just under the **Edit** menu item and experiment with rotating the turbine.

:::image type="content" source="../media/rotate-turbine-static-terrain.png" alt-text="Screenshot of the Unity scene window with the main scene running and the wind turbine static map child object and rotate tool highlighted.":::

9. Repeat steps 3 to 8 to place more turbines on the landscape.
10. Save the scene under the File > Save menu option.

## Place and configure prefab wind turbine on Dynamic Terrain

1. Open the **Assets > Art > Prefabs** folder in your Project Window.
2. If you already have a map in the scene, delete the asset by right clicking it in the Hierarchy panel and select **Delete**.  Don’t worry, it only removes it from your Scene and does not delete the Prefab from your Unity Project.
3. Add the **Bing Maps Design.prefab** Prefab by dragging it to the Hierarchy panel.  If necessary, add your Bing Maps 
4. Drag the Prefab named **Wind Turbine Design.prefab** into the Scene window

:::image type="content" source="../media/prefab-dynamic-wind-turbine-design.png" alt-text="Screenshot of the Unity project panel with the prefabs subfolder selected.":::

5. Make the **Wind Turbine Design** a child of the **Bing Maps Design** by nesting it under the **Bing Maps Design** Asset in the Hierarchy window.  Be sure to drag it to the bottom of the list of children or you will receive a message “Cannot restructure Prefab instance”.  If you receive this, select **Cancel**, and place the Prefab at the bottom of the list of children directly under the **Bing Maps Design**.

:::image type="content" source="../media/prefab-dynamic-child-order-wind-turbine.png" alt-text="Screenshot of the Unity hierarchy window with the main scene selected and the bing maps design child object expanded.":::

:::image type="content" source="../media/prefab-child-order-dynamic-map.png" alt-text="Screenshot of the Unity scene and hierarchy windows with the bing maps design prefab in view.":::

6. Set the scale in the **Transform** component in the Inspector for the Wind Turbine to 
**(0.005, 0.005, 0.005)** so it approximately matches the terrain scale
7. Select the **Move Tool** just under the **Edit** menu item, select the Wind Turbine if it’s not already selected.  Use the green-red-blue arrows (or the center box) on screen to position the turbine at the centre of the terrain

:::image type="content" source="../media/move-turbine-dynamic-terrain.png" alt-text="Screenshot of the Unity hierarchy window with the main scene selected and the wind turbine design child object expanded. Move tool is also selected.":::

8. With the turbine still selected, select the **Rotate Tool** just under the **Edit** menu item and experiment with rotating the turbine.

:::image type="content" source="../media/rotate-turbine-dynamic-terrain.png" alt-text="Screenshot of the Unity hierarchy window with the main scene selected and the wind turbine design child object expanded. Rotate tool is also selected.":::

9. Repeat steps 3 to 8 to place more turbines on the landscape.

:::image type="content" source="../media/multiple-turbines-dynamic-terrain.png" alt-text="Screenshot of the Unity hierarchy window with the main scene selected and multiple turbine prefabs placed on the dynamic terrain.":::

10. Save the scene under the **File > Save** menu option.