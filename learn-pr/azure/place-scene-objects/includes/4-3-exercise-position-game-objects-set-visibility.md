Before we move on the solvers we will learn how to create parent objects, add prefabs to the scene, and use transform to place them in particular positions

## Import the tutorial assets

Download the following Unity custom package:
[MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.2.5.0.1.unitypackage](https://github.com/microsoft/MixedRealityLearning/releases/download/getting-started-v2.5.0/MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.2.5.0.1.unitypackage)

1. To Import a Unity custom package, In the Unity menu, select Assets > Import Package > Custom Package... to open the Import package... window:

    :::image type="content" source="../media/import-custom-package.png" alt-text="Screenshot of Import custom package." lightbox="../media/import-custom-package.png":::

2. In the Import package... window, select the MRTK.HoloLens2.Unity.Tutorials.Assets.GettingStarted.2.5.0.1.unity package you downloaded and click the Open button:

    :::image type="content" source="../media/import-tutorial-package.png" alt-text="Screenshot of Import tutorial package." lightbox="../media/import-tutorial-package.png":::

3. In the Import Unity Package window, click the All button to ensure all the assets are selected, then click the Import button to import the assets:

    :::image type="content" source="../media/click-all-button.png" alt-text="Screenshot of Click the all button to ensure all the assets are selected." lightbox="../media/click-all-button.png":::

## Create the parent object

1. In the Hierarchy window, right-click on an empty spot, and select **Create Empty** to add an empty object to your scene:

    :::image type="content" source="../media/contextual-popup-menu.png" alt-text="Screenshot of Unity Create Empty contextual popup menu." lightbox="../media/contextual-popup-menu.png":::

2. Right-click on the newly created object, select **Rename**, and change the name to **RoverExplorer**:

    :::image type="content" source="../media/rename.png" alt-text="Screenshot of Unity Rename contextual popup menu." lightbox="../media/rename.png":::

3. With the RoverExplorer object still selected, in the Inspector window, configure the **Transform** component as follows:

    * **Position**: X = 0, Y = -0.6, Z = 2
    * **Rotation**: X = 0, Y = 0, Z = 0
    * **Scale**: X = 1, Y = 1, Z = 1

    :::image type="content" source="../media/position-rover-explorer.png" alt-text="Screenshot of Unity with RoverExplorer object selected and positioned." lightbox="../media/position-rover-explorer.png":::

## Add the tutorial prefabs

1. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.GettingStarted** > **Prefabs** folder:

    :::image type="content" source="../media/select-prefabs-folder.png" alt-text="Screenshot of Unity Project window with Prefabs folder selected." lightbox="../media/select-prefabs-folder.png":::

2. From the Project window, click-and-drag the **Table** prefab on to the **RoverExplorer** object to make it a child of the RoverExplorer object, then in the Inspector window, configure the **Transform** component as follows:

    * **Position**: X = 0, Y = -0.005, Z = 0
    * **Rotation**: X = 0, Y = 0, Z = 0
    * **Scale**: X = 1.2, Y = 0.01, Z = 1.2

    :::image type="content" source="../media/position-prefab-table.png" alt-text="Screenshot of Unity with newly added Table prefab selected and positioned." lightbox="../media/position-prefab-table.png":::

3. From the Project window, click-and-drag the **RoverAssembly** prefab on to the **RoverExplorer** object to make it a child of the RoverExplorer object, then in the Inspector window, configure the **Transform** component as follows:

    * **Position**: X = -0.1, Y = 0, Z = 0
    * **Rotation**: X = 0, Y = -135, Z = 0
    * **Scale**: X = 1, Y = 1, Z = 1

    :::image type="content" source="../media/position-rover-assembly.png" alt-text="Screenshot of Unity with newly added RoverAssembly prefab selected and positioned." lightbox="../media/position-rover-assembly.png":::
