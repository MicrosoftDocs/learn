Adding text to a scene can be very informative and can guide the users. Here you'll add text to the scene using TextMesh Pro and include Tooltips to provide short descriptions for each object.

## Add text to the scene

1. In the Hierarchy pane , right-click the **Table** object and select **3D Object** > **Text - TextMeshPro** to add a text object as a child of the Table object, and then in the Inspector pane, configure the **Rect Transform** component as follows:
    * Change **Pos Y** to 1
    * Change **Width** to 1
    * Change **Height** to 1
    * Change **Rotation X** to 90

    :::image type="content" source="../media/text-mesh-pro-selected.png" alt-text="Screenshot of Unity with newly created TextMesh Pro object selected." lightbox="../media/text-mesh-pro-selected.png":::

2. Configure the **TextMeshPro - Text** component as follows:
    * Change **Text** to Rover Explorer
    * Change **Font Style** to Bold
    * Change **Font Size** to 1
    * Change Extra Settings > **Margins** to 0.03

    :::image type="content" source="../media/text-mesh-pro-configured.png" alt-text="Screenshot of Unity with TextMeshPro component configured." lightbox="../media/text-mesh-pro-configured.png":::

## Add tooltips

1. In the Project pane, navigate to **Packages** > **Mixed Reality Toolkit Foundation** > **SDK** > **Features** > **UX** > **Prefabs** > **ToolTip** folder to locate the tooltip prefabs:

    :::image type="content" source="../media/tool-tips-folder.png" alt-text="Screenshot of Unity Project window with ToolTips folder selected." lightbox="../media/tool-tips-folder.png":::

2. In the Hierarchy pane, expand the **RoverExplorer** > **RoverParts** object and select all its child rover part objects, and then in the Inspector pane, select **Add Component** to add the **ToolTipSpawner** component and configure it as follows:
    * Ensure the **Focus Enabled** checkbox is checked to require the user to look at the part for the tooltip to appear
    * Assign the **Simple Line ToolTip** prefab from the Project window to the **Prefab** field
    * Change the ToolTip Override Settings > **Settings Mode** to **Override**
    * Change the ToolTip Override Settings > **Manual Pivot Local Position Y** to **1.5**

    :::image type="content" source="../media/rover-part-objects.png" alt-text="Screenshot of Unity with all rover part objects selected and ToolTipSpawner component added and configured." lightbox="../media/rover-part-objects.png":::

3. In the Hierarchy pane, select the first rover part, RoverParts > **Camera_Part**, and configure the **ToolTipSpawner** component as follows:
    * Change **Tool Tip Text** to reflect the name of the part, that is, **Camera**

    :::image type="content" source="../media/tool-tip-text.png" alt-text="Screenshot of Unity with Camera ToolTipText configured." lightbox="../media/tool-tip-text.png":::

4. **Repeat** this step for each of the rover part objects to configure the **ToolTipSpawner** component as follows:
    * For the **Generator_Part**, change the **Tool Tip Text** to **Generator**
    * For the **Lights_Part**, change the **Tool Tip Text** to **Lights**
    * For the **UHFAntenna_Part**, change the **Tool Tip Text** to **UHF Antenna** field
    * For the **Spectrometer_Part**, change the **Tool Tip Text** to **Spectrometer**

5. Press Play to enter Game mode, and then press-and-hold the right mouse button while moving your mouse until the gaze hits one of the parts and the tooltip for that part displays:

    :::image type="content" source="../media/tool-tip-triggered.png" alt-text="Screenshot of Unity Play mode split view with tooltip triggered by gaze." lightbox="../media/tool-tip-triggered.png":::
