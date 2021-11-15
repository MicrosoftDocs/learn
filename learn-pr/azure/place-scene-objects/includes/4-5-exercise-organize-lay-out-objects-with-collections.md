The Mixed Reality Toolkit provides a set of tools and components to accelerate your Windows Mixed Reality app development. Grid Object Collection is one such component. Here are the steps to use Grid Object Collection to organize a set of game objects:

1. In the **Hierarchy** window, right-click on the **RoverExplorer** object, and select **Create Empty** to add an empty object as a child of the **RoverExplorer** object. Name the object **RoverParts**, and configure the **Transform** component as follows:

    * **Position**: X = 0, Y = 0.06, Z = 0
    * **Rotation**: X = 0, Y = 90, Z = 0
    * **Scale**: X = 1, Y = 1, Z = 1

    :::image type="content" source="../media/position-rover-parts.png" alt-text="Screenshot that shows the newly created RoverParts object selected and positioned." lightbox="../media/position-rover-parts.png":::

1. In **Hierarchy**, select all the child objects of the following: **RoverExplorer** > **RoverAssembly** > **RoverModel** > **Parts**. Right-click on them, and select **Duplicate** to create a copy of each of the parts.

    :::image type="content" source="../media/duplicate-parts.png" alt-text="Screenshot that shows how to duplicate all the parts selected." lightbox="../media/duplicate-parts.png":::

1. With the newly duplicated **Parts** child objects still selected, drag them onto the **RoverParts** object to make them child objects of that object:

    :::image type="content" source="../media/child-part.png" alt-text="Screenshot that shows the newly duplicated parts as children of the RoverParts object." lightbox="../media/child-part.png":::

1. To make it easier to work with your scene, in **Hierarchy**, select the **eye** icon next to the object to toggle the **scene visibility** for the **RoverAssembly** object off. This selection hides the object in the **Scene** window, without changing its in-game visibility.

    :::image type="content" source="../media/rover-assembly-visibility.png" alt-text="Screenshot that shows the RoverAssembly scene visibility off." lightbox="../media/rover-assembly-visibility.png":::

1. In **Hierarchy**, clean up the **RoverParts** child objects' names by replacing the appended **(1)** with **_Part**.

    :::image type="content" source="../media/name-clean-up.png" alt-text="Screenshot that shows how to clean up the duplicated names." lightbox="../media/name-clean-up.png":::

1. In **Hierarchy**, select the **RoverParts** object. Then, in the **Inspector** window, select **Add Component**, and search for and select **GridObjectCollection**. This selection adds the **GridObjectCollection** component to the **RoverParts** object.

    :::image type="content" source="../media/grid-object-collection-progress.png" alt-text="Screenshot that shows the RoverParts object with Add Component Grid Object Collection in progress." lightbox="../media/grid-object-collection-progress.png":::

1. Configure the **GridObjectCollection** component values as follows:

    * **Sort Type**: Alphabetic
    * **Layout**: Horizontal
    * **Cell Width**: 0.25
    * **Distance from parent**: 0.38

    :::image type="content" source="../media/grid-object-collection-configure.png" alt-text="Screenshot that shows Unity Hub, with New button highlighted." lightbox="../media/grid-object-collection-configure.png":::

    Then select **Update Collection** to update the position of the **RoverParts** child objects.
