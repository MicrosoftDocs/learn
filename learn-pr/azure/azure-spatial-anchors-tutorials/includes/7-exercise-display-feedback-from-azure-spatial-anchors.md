## Set up ASA feedback panel

1. In the Hierarchy window, right-click on the **Instructions** > **TextContent** object. Select **3D Object** > **Text - TextMeshPro** to create a TextMeshPro text object as a child of the Instructions > TextContent object:

    :::image type="content" source="../media/asa-feedback-panel.png" alt-text="Screenshot of ASA feedback panel." lightbox="../media/asa-feedback-panel.png":::

    > [!Tip]
    > To make it easier to work with your scene, set the [Scene Visibility](https://docs.unity3d.com/Manual/SceneVisibility.html) for the ParentAnchor object to off by clicking the eye icon to the left of the object. This hides the object in the Scene window without changing their in-game visibility.

2. Rename the newly created Text (TMP) object **Feedback**, then, in the Inspector window, change its position and size, so it's placed neatly underneath the instruction text, for example:

    * Change the Rect Transform component's **Pos Y** to -0.24.
    * Change the Rect Transform component's **Width** to 0.555.
    * Change the Rect Transform component's **Height** to 0.1.

    Then choose font properties, so the text fits nicely within the text area, for example:

    * Change the TextMeshPro - Text component's **Font Style** to Bold.
    * Change the TextMeshPro - Text component's **Font Size** to 0.17.
    * Change the TextMeshPro - Text component's **Alignment** to Center and Middle.

    :::image type="content" source="../media/create-text-object.png" alt-text="Screenshot of Renaming the newly created text object." lightbox="../media/create-text-object.png":::

3. In the Hierarchy window, select the **Feedback** object still, then in the Inspector window, use the **Add Component** button to add the **Anchor Feedback Script (Script)** component and configure it as follows:

    * Assign the **Feedback** object itself to the **Anchor Feedback Script (Script)** component's **Feedback Text** field.

    :::image type="content" source="../media/assign-components.png" alt-text="Screenshot of Assigning the components to the script." lightbox="../media/assign-components.png":::
