The Mixed Reality Toolkit provides a set of tools and components to accelerate your Windows Mixed Reality app development. Grid Object Collection is one such component. Here you'll use Grid Object Collection to organize a set of game objects.

## Organize objects in a collection

1. In the Hierarchy window, right-click on the **RoverExplorer** object and select **Create Empty** to add an empty object as a child of the RoverExplorer, name the object **RoverParts**, and configure the **Transform** component as follows:

    * **Position**: X = 0, Y = 0.06, Z = 0
    * **Rotation**: X = 0, Y = 90, Z = 0
    * **Scale**: X = 1, Y = 1, Z = 1

    :::image type="content" source="../media/position-rover-parts.png" alt-text="Screenshot of Unity with newly created RoverParts object selected and positioned." lightbox="../media/position-rover-parts.png":::

2. In the Hierarchy window, select all the RoverExplorer > RoverAssembly > RoverModel > **Parts** child objects, right-click on them and select **Duplicate** to create a copy of each of the parts:

    :::image type="content" source="../media/duplicate-parts.png" alt-text="Screenshot of Unity with all Parts selected and Duplicate contextual popup menu." lightbox="../media/duplicate-parts.png":::

3. With the newly duplicated Parts child objects still selected, click-and-drag them on to the **RoverParts** object to make them child objects of the RoverParts object:

    :::image type="content" source="../media/child-part.png" alt-text="Screenshot of Unity with newly duplicated parts as children of RoverParts object." lightbox="../media/child-part.png":::

4. To make it easier to work with your scene, in the Hierarchy window, click the **eye** icon to the left of the object to toggle the **scene visibility** for the **RoverAssembly** object off. This hides the object in the Scene window without changing its in-game visibility:

    :::image type="content" source="../media/rover-assembly-visibility.png" alt-text="Screenshot of Unity with RoverAssembly scene visibility off." lightbox="../media/rover-assembly-visibility.png":::

5. In the Hierarchy window, clean up the RoverParts child objects' names by replacing the appended **(1)** with **_Part**:

    :::image type="content" source="../media/name-clean-up.png" alt-text="Screenshot of Unity with duplicated parts name cleaned up." lightbox="../media/name-clean-up.png":::

6. In the Hierarchy window, select the **RoverParts** object, then in the Inspector window, click the **Add Component** button, and search for and select **GridObjectCollection** to add the GridObjectCollection component to the RoverParts object:

    :::image type="content" source="../media/grid-object-collection-progress.png" alt-text="Screenshot of Unity RoverParts object with Add Component Grid Object Collection in progress." lightbox="../media/grid-object-collection-progress.png":::

7. Configure the **GridObjectCollection** component values as follows:

    * **Sort Type**: Alphabetic
    * **Layout**: Horizontal
    * **Cell Width**: 0.25
    * **Distance from parent**: 0.38

    :::image type="content" source="../media/grid-object-collection-configure.png" alt-text="Unity Hub with New button highlighted." lightbox="../media/grid-object-collection-configure.png":::

    Then click the **Update Collection** button to update the position of the RoverParts child objects.
