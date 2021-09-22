In this exercise, You'll learn how to create speech commands and how to control them globally. You'll also learn how to control local speech commands that require the user to look at the object that controls the speech command.

## Ensure the microphone capability is enabled

* In the Unity menu, select Mixed Reality > Toolkit > Utilities > **Configure Project for MRTK** to open the **MRTK Project Configurator window**. Then, in the **UWP Capabilities** section, verify that **Enable Microphone Capability** is greyed out:

    :::image type="content" source="../media/enable-microphone-capability.png" alt-text="Screenshot of MRTK Project Configurator window, verify that Enable Microphone Capability is greyed out in the UMP Capabilities." lightbox="../media/enable-microphone-capability.png":::

## Create speech commands

1. In the Hierarchy window, select the **MixedRealityToolkit** object, and then in the Inspector window, select the MixedRealityToolkit > **Input** tab and take the following steps:

    1) Expand the **Speech** section
    2) Clone the **DefaultMixedRealitySpeechCommandsProfile** and give it a suitable name for example, GettingStarted_MixedRealitySpeechCommandsProfile
    3) Verify that **Start Behavior** is set to **Auto Start**

    :::image type="content" source="../media/speech-commands-profile.png" alt-text="Screenshot of Configure DefaultMixedRealitySpeechCommandsProfile." lightbox="../media/speech-commands-profile.png":::

2. In the Speech > **Speech Commands** section, click the **+ Add a New Speech Command** button four times to add four new speech commands to the list of the existing speech commands, and then in the **Keyword** fields enter the following phrases:

    1) Enable Indicator
    2) Enable Tap to Place
    3) Enable Bounds Control
    4) Disable Bounds Control

    :::image type="content" source="../media/add-speech-commands.png" alt-text="Screenshot of Adding speech commands." lightbox="../media/add-speech-commands.png":::

## Control speech commands

1. In the Project window, navigate to the **Package** > **Mixed Reality Toolkit Foundation** > **SDK** > **Features** > **UX** > **Prefabs** > **ToolTip** folder to locate the tooltip prefabs:

    :::image type="content" source="../media/tool-tip-folder.png" alt-text="Screenshot of Opening tooltip folder." lightbox="../media/tool-tip-folder.png":::

2. In the Hierarchy window, right-click on an **empty spot** and select Create Empty to add an empty object to your scene. Name the object **SpeechInputHandler_Global**, and then in the Inspector window, use the **Add Component** button to add the **SpeechInputHandler** component and configure it as follows:

    1) **Unselect** the **Is Focus Required** checkbox, so the user isn't required to look at the object with the SpeechInputHandler component to trigger the speech command.
    2) From the Project window, assign the **SpeechConfirmation Tooltip** prefab to the **Speech Confirmation Tooltip** Prefab field, to have this prefab appear when a speech command is recognized.

    :::image type="content" source="../media/speech-input-handler.png" alt-text="Screenshot of Configuring speech input handler component." lightbox="../media/speech-input-handler.png":::

3. On the SpeechInputHandler component, click the small + icon three times to add three keyword elements:

    :::image type="content" source="../media/add-keyword-elements.png" alt-text="Screenshot of Adding keyword elements to speech input handler." lightbox="../media/add-keyword-elements.png":::

4. Expand **Element 0** and configure it as follows:
    1) In the **Keyword** field, enter **Enable Indicator**, to reference the Enable Indicator speech command you created in the previous section.
    2) Click the small + icon to add an event.
    3) From the Hierarchy window, assign the **Indicator** object to the **None (Object)** field.
    4) From the **No Function** dropdown, select **GameObject** > **SetActive (bool)** to set this function as the action to be executed when the event is triggered.
    5) Select the argument checkbox, so it's **selected**

    :::image type="content" source="../media/configure-keyword-element-0.png" alt-text="Screenshot of configuring keyword element 0." lightbox="../media/configure-keyword-element-0.png":::

5. Expand **Element 1** and configure it as follows:

    1) In the **Keyword** field, enter **Enable Bounds Control**, to reference the Enable Bounds Control command you created in the previous section.
    2) Click the small + icon to add an event.
    3) From the Hierarchy window, assign the **RoverExplorer** object to the **None (Object)** field.
    4) From the **No Function** dropdown, select **BoundsControl** > **bool enabled** to update this property value when the event is triggered.
    5) Select the argument checkbox, so it's **selected**
    6) Click the small + icon to add another event
    7) From the Hierarchy window, assign the **RoverExplorer** object to the **None (Object)** field
    8) From the **No Function** dropdown, select **ObjectManipulator** > **bool enabled** to update this property value when the event is triggered
    9) Select the argument checkbox, so it's **selected**.

    :::image type="content" source="../media/configure-keyword-element-1.png" alt-text="Screenshot of configuring keyword element 1." lightbox="../media/configure-keyword-element-1.png":::

6. Expand **Element 2** and configure it as follows:
    1) In the **Keyword** field, enter **Disable Bounds Control**, to reference the Disable Bounds Control command you created in the previous section.
    2) Click the small + icon to add an event.
    3) From the Hierarchy window, assign the **RoverExplorer** object to the **one (Object)** field.
    4) From the **No Function** dropdown, select **BoundsControl** > **bool enabled** to update this property value when the event is triggered.
    5) Verify that the argument checkbox is **unselected**.
    6) Click the small + icon to add another event.
    7) From the Hierarchy window, assign the **RoverExplorer** object to the **None (Object)** field.
    8) From the **No Function** dropdown, select **ObjectManipulator** > **bool enabled** to update this property value when the event is triggered.
    9) Verify that the argument checkbox is **unselected**.

    :::image type="content" source="../media/configure-keyword-element-2.png" alt-text="Screenshot of configuring keyword element 2." lightbox="../media/configure-keyword-element-2.png":::

7. In the Hierarchy window, select the **RoverExplorer** > **RoverAssembly** object, and then in the Inspector window, use the **Add Component** button to add the **SpeechInputHandler** component and configure it as follows:
    1) Verify that the **Is Focus Required** checkbox is **selected**, so the user is required to look at the object with the SpeechInputHandler component, that is, the RoverAssembly, to trigger the speech command.
    2) From the Project window, assign the **SpeechConfirmation Tooltip** prefab to the Speech **Confirmation Tooltip Prefab** field, to have this prefab appear when a speech command is recognized.

    :::image type="content" source="../media/add-speech-input-handler.png" alt-text="Screenshot of Add speech input handler to Rover Assembly." lightbox="../media/add-speech-input-handler.png":::

8. On the SpeechInputHandler component, click the small + icon to add a keyword element, expand the newly created element, and then configure it as follows:
    1) In the **Keyword** field, enter **Enable Tap to Place**, to reference the Enable Tap to Place command you created in the previous section.
    2) Click the small + icon to add an event.
    3) From the Hierarchy window, assign the object itself, that is, the same **RoverAssembly** object, to the **None (Object)** field.
    4) From the **No Function** dropdown, select **TapToPlace** > **bool enabled** to update this property value when the event is triggered.
    5) Select the argument checkbox, so it's **selected**

    :::image type="content" source="../media/configure-speech-input-handler.png" alt-text="Screenshot of configuring speech input handler on Rover Assembly." lightbox="../media/configure-speech-input-handler.png":::
