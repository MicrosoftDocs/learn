Now let's learn how to create parent objects, add prefabs to the scene, and use the Transform component to place them in particular positions.

## Import the tutorial assets

To get started, first download the following Unity custom package: [MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.3.0.0-pre.18.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/getting-started-v3.0.0-pre.18/MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.3.0.0-pre.18.unitypackage)

1. In the Unity menu, select **Assets** > **Import Package** > **Custom Package...**.

    :::image type="content" source="../media/import-custom-package.png" alt-text="Screenshot that shows how to import a custom package." lightbox="../media/import-custom-package.png":::

2. In **Import package**, select the **MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.2.5.0.1.unity** package that you downloaded, and then select **Open**.

    :::image type="content" source="../media/import-tutorial-package.png" alt-text="Screenshot that shows how to import the tutorial package." lightbox="../media/import-tutorial-package.png":::

3. In **Import Unity Package**, select **All** to ensure that all the assets will be imported. Then select **Import**.

    :::image type="content" source="../media/click-all-button.png" alt-text="Screenshot that shows how to select all the assets." lightbox="../media/click-all-button.png":::

## Create the parent object

1. In the **Hierarchy** window, right-click on an empty spot, and select **Create Empty** to add an empty object to your scene.

    :::image type="content" source="../media/contextual-popup-menu.png" alt-text="Screenshot that shows how to create and add an empty object to your scene." lightbox="../media/contextual-popup-menu.png":::

2. Right-click on the newly created object, select **Rename**, and change the name to **RoverExplorer**.

    :::image type="content" source="../media/rename.png" alt-text="Screenshot that shows how to rename the object." lightbox="../media/rename.png":::

3. With the **RoverExplorer** object still selected, in the **Inspector** window, configure the **Transform** component as follows:

    * **Position**: X = 0, Y = 0.9, Z = 2
    * **Rotation**: X = 0, Y = 0, Z = 0
    * **Scale**: X = 1, Y = 1, Z = 1

    :::image type="content" source="../media/position-rover-explorer.png" alt-text="Screenshot that shows the RoverExplorer object selected and positioned." lightbox="../media/position-rover-explorer.png":::

## Add the tutorial prefabs

1. In the **Project** window, go to the **Assets** > **MRTK.Tutorials.GettingStarted** > **Prefabs** folder.

    :::image type="content" source="../media/select-prefabs-folder.png" alt-text="Screenshot of the Project window with the Prefabs folder selected." lightbox="../media/select-prefabs-folder.png":::

2. From the **Project** window, drag the **Table** prefab onto the **RoverExplorer** object, to make it a child of that object. Then, in the **Inspector** window, configure the **Transform** component as follows:

    * **Position**: X = 0, Y = -0.005, Z = 0
    * **Rotation**: X = 0, Y = 0, Z = 0
    * **Scale**: X = 1.2, Y = 0.01, Z = 1.2

    :::image type="content" source="../media/position-prefab-table.png" alt-text="Screenshot of the newly added Table prefab selected and positioned." lightbox="../media/position-prefab-table.png":::

3. From **Project**, drag the **RoverAssembly** prefab onto the **RoverExplorer** object, to make it a child of that object. Then, in **Inspector**, configure the **Transform** component as follows:

    * **Position**: X = -0.1, Y = 0, Z = 0
    * **Rotation**: X = 0, Y = -135, Z = 0
    * **Scale**: X = 1, Y = 1, Z = 1

    :::image type="content" source="../media/position-rover-assembly.png" alt-text="Screenshot of the newly added RoverAssembly prefab selected and positioned." lightbox="../media/position-rover-assembly.png":::
