The Mixed Reality Toolkit provides a set of tools and components to accelerate your Windows Mixed Reality app development. Object Bar is one such component. Here are the steps to use Object Bar to organize a set of game objects:

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

1. In **Hierarchy**, select the **RoverParts** object. Then, in the **Inspector** window, select **Add Component**, and search for and select **ObjectBar**. This selection adds the **ObjectBar** component to the **RoverParts** object.

    :::image type="content" source="../media/object-bar-progress.png" alt-text="Screenshot that shows the RoverParts object with Add Component Object Bar in progress." lightbox="../media/object-bar-progress.png":::

1. Next set the number of Object Bar Objects to 5 and drag in each of the child parts. Notice that they are automatically clumped on top of each other.

    :::image type="content" source="../media/set-object-bar-parts.png" alt-text="Screenshot that shows the RoverParts added as Object Bar Objects." lightbox="../media/set-object-bar-parts.png":::

1. Configure the **ObjectBar** component values as follows. The other fields can be left with their default values:

    * **Object Bar Flow Direction**: Horizontal
    * **Spacing Between X**: 0.25
    * **Spacing Between Y**: 0
    
    You can also set the **Transform** of **RoverParts** to view it at a different angle. For instance:

    * **Rotation**: Y = 0

    :::image type="content" source="../media/object-bar-configure.png" alt-text="Screenshot that shows configuration of the Object Bar properties." lightbox="../media/object-bar-configure.png":::
