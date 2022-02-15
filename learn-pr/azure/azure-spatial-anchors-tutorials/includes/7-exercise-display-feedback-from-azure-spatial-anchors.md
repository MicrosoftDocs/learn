## Set up a feedback panel

1. On the **Hierarchy** pane, right-click the **Instructions** > **TextContent** object. Select **3D Object** > **Text - TextMeshPro** to create a TextMeshPro text object as a child of the **Instructions** > **TextContent** object.

    :::image type="content" source="../media/asa-feedback-panel.png" alt-text="Screenshot of an Azure Spatial Anchors feedback panel." lightbox="../media/asa-feedback-panel.png":::

    > [!Tip]
    > To make it easier to work with your scene, turn off [scene visibility](https://docs.unity3d.com/Manual/SceneVisibility.html) for the **ParentAnchor** object by selecting the eye icon to the left of the object. This hides the object in the scene window without changing its in-game visibility.

2. Rename the newly created text (TMP) object **Feedback**. Then change its position and size on the **Inspector** pane so it's placed neatly underneath the instruction text. For example, for the **Rect Transform** component:

    * Change **Pos Y** to **-0.24**.
    * Change **Width** to **0.555**.
    * Change **Height** to **0.1**.

    Then choose font properties so the text fits nicely within the text area. For example, for the **TextMeshPro - Text** component:

    * Change **Font Style** to **Bold**.
    * Change **Font Size** to **0.17**.
    * Change **Alignment** to **Center** and **Middle**.

    :::image type="content" source="../media/create-text-object.png" alt-text="Screenshot of renaming the newly created text object." lightbox="../media/create-text-object.png":::

3. On the **Hierarchy** pane, select the **Feedback** object. Then on the **Inspector** pane, use the **Add Component** button to add the **Anchor Feedback Script (Script)** component and configure it as follows:

    * Assign the **Feedback** object to the **Anchor Feedback Script (Script)** component's **Feedback Text** field.

    :::image type="content" source="../media/assign-components.png" alt-text="Screenshot of assigning the components to the script." lightbox="../media/assign-components.png":::
