There are several ways to provide inputs. Inputs trigger certain events and perform some changes. UI components assist users in interacting with the holograms on the scene.

## Create a static panel of buttons

1. In the Hierarchy window, right-click the **RoverExplorer** object and select **Create Empty** to add an empty object as a child of the RoverExplorer. Name the object **Buttons**, and configure the **Transform** component as follows:
    * **Position**: X = -0.6, Y = 0.036, Z = -0.5
    * **Rotation**: X = 90, Y = 0, Z = 0
    * **Scale**: X = 1, Y = 1, Z = 1

    :::image type="content" source="../media/button-object-selected.png" alt-text="Screenshot of Unity with newly created Buttons object selected and positioned." lightbox="../media/button-object-selected.png":::

2. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.GettingStarted** > **Prefabs** folder, click-and-drag the **PressableCylinderButton** prefab onto the **Buttons** object, then right-click the PressableCylinderButton and select **Duplicate** to create a copy, repeat until you've a total of three PressableCylinderButton objects under **Buttons**:

    :::image type="content" source="../media/pressable-cylinder-button.png" alt-text="Screenshot of Unity with newly added PressableRoundButton prefabs." lightbox="../media/pressable-cylinder-button.png":::

    A window will prompt you to import TextMesh Pro. Select the first option to 'Import TMP Essentials'.

3. In the Hierarchy pane, select the **Buttons** object, and then in the Inspector pane, select **Add Component** to add the **Object Bar** component. Configure it as follows:

    * **Object Bar Flow Direction**: Horizontal
    * **Spacing Between**: X = 0.2, Y = 0

   Assign each object under **Buttons** to **Object Bar Objects** list on the **Object Bar** component:

    :::image type="content" source="../media/object-bar.png" alt-text="Screenshot of Unity Buttons object with GridObjectCollection component added, configured, and applied." lightbox="../media/object-bar.png":::

4. In the Hierarchy pane, name the buttons **Hints**, **Explode**, and **Reset**. For each button, change the **SpeechRecognitionKeyword** property under **Advanced StatefulInteractable Settings** in the **Pressable Button** component to match the button names::

    :::image type="content" source="../media/button-text-label.png" alt-text="Screenshot showing button text labels configured." lightbox="../media/button-text-label.png":::

5. In the Hierarchy pane, select the **Hints** button object, and then in the Inspector window, configure the **PressableButton.OnClicked ()** event as follows:

    * Assign the **RoverAssembly** object to the **None (Object)** field
    * From the **No Function** dropdown list, select **PlacementHintsController** > **TogglePlacementHints ()** to set this function as the action to be run when the event is triggered

    :::image type="content" source="../media/hints-button-object.png" alt-text="Screenshot of Hints button object OnClick event configured." lightbox="../media/hints-button-object.png":::

6. In the Hierarchy pane, select the **Explode** button object, then in the Inspector window, configure the **PressableButton.OnClicked ()** event as follows:
    * Assign the **RoverAssembly** object to the **None (Object)** field
    * From the **No Function** dropdown, select **ExplodedViewController** > **ToggleExplodedView()** to set this function as the action to be executed when the event is triggered

    :::image type="content" source="../media/explode-button-object.png" alt-text="Screenshot of Unity with Explode button object OnClick event configured." lightbox="../media/explode-button-object.png":::

7. Press the Play button to enter Game mode. Press-and-hold the space bar to activate the hand and use the mouse to press the **Hints** button to toggle the visibility of the placement hint objects:

    :::image type="content" source="../media/hint-button-pressed.png" alt-text="Screenshot of Unity Play mode split view with Hints button being pressed." lightbox="../media/hint-button-pressed.png":::

8. **Explode button** will toggle the exploded view on and off:

    :::image type="content" source="../media/explode-button-pressed.png" alt-text="Screenshot of Unity Play mode split view with Explode button being pressed." lightbox="../media/explode-button-pressed.png":::

    We will implement the **Reset** button later in the module.

## Create a dynamic menu that follows the user

1. In the Project pane, navigate to the **Packages** > **MRTK UX Components** > **Near Menu** folder, click-and-drag the **NearMenuBase** prefab into the Hierarchy window, set its Transform **Position** to X = 0, Y = -0.4, Z = 0 and configure it as follows:
    * Verify that the **SolverHandler** component's **Tracked Target Type** is set to **Head**
    * Check the checkbox next to the **RadialView** Solver component so it's enabled by default

    :::image type="content" source="../media/near-menu-prefab.png" alt-text="Screenshot of Unity with newly added near menu prefab selected." lightbox="../media/near-menu-prefab.png":::

2. In the Hierarchy window, rename the object to **Menu**, then expand its **MenuContent-HorizontalLayout (Menu and Pin) > Buttons-GridLayout (Buttons)** child object to reveal the three buttons:

    :::image type="content" source="../media/menu-object-selected.png" alt-text="Screenshot of Unity with Menu object selected and ButtonCollection object expanded." lightbox="../media/menu-object-selected.png":::

3. Rename the first button in the Buttons-GridLayout (Buttons) to Indicator, then in the Hierarchy window, configure the Indicator game object as follows:

    * Select the **Frontplate > AnimatedContent > Icon > Label** object and change the **TextMesh Pro** component to match the name of the button. Make sure the Label object is activated in the hierarchy
    * Configure the **PressableButton.OnClicked()** event by assigning the **Indicator** object that looks like a chevron, to the **None (Object)** field and selecting **GameObject > SetActive (bool)** from the **No Function** dropdown (verify that the argument checkbox is **checked**)
    * Select the **Frontplate > AnimatedContent > Icon > UIButtonFontIcon** object and change the icon to the search icon on the **Font Icon Selector** component. You can find this in the list of icons, or set **Current Icon Name** to 'Icon 130'

    :::image type="content" source="../media/indicator-button-object.png" alt-text="Screenshot of Unity with Indicator button object Button Config Helper configured." lightbox="../media/indicator-button-object.png":::

4. To disable the chevron Indicator object, in the Hierarchy pane, select the Indicator object that looks like a chevron, then in the Inspector pane:

    * Clear the checkbox next to its name to make it inactive by default
    * Use the **Add Component** button to add the **Directional Indicator Controller (Script)** component

    :::image type="content" source="../media/directional-indicator-controller.png" alt-text="Screenshot of Unity with Indicator object selected, disabled, and DirectionalIndicatorController component added." lightbox="../media/directional-indicator-controller.png":::

5. Rename the second button to **TapToPlace**, then in the Hierarchy window, configure the TapToPlace game object as follows:

    * Select the **Frontplate > AnimatedContent > Icon > Label** object and change the **TextMesh Pro** component to match the name of the button. Make sure the Label object is activated in the hierarchy
    * Configure the **PressableButton.OnClicked()** event by assigning the RoverExplorer > **RoverAssembly** object to the **None (Object)** field and selecting **TapToPlace** > **bool Enabled** from the **No Function** dropdown (verify that the argument checkbox is **checked**)
    * Select the **Frontplate > AnimatedContent > Icon > UIButtonFontIcon** object and change the icon to the hand icon on the **Font Icon Selector** component. You can find this in the list of icons, or set **Current Icon Name** to 'Icon 13'

    :::image type="content" source="../media/tap-to-place-button.png" alt-text="Screenshot of Unity with TapToPlace button object Button Config Helper configured." lightbox="../media/tap-to-place-button.png":::

6. In the Hierarchy window, select the **RoverAssembly** object, then in the Inspector window, configure the **Tap To Place (Script)** component as follows:
    * Uncheck the checkbox next to its name to make it inactive by default
    * In the On **Placing Stopped ()** event section, select the + icon to add a new event:
    * Assign the **RoverExplorer** > **RoverAssembly** object to the **None (Object)** field
    * From the **No Function** dropdown, select **TapToPlace** > **bool Enabled** to update this property value when the event is triggered
    * Verify that the argument checkbox is **unchecked**

    :::image type="content" source="../media/tap-to-place-reconfigured.png" alt-text="Screenshot of Unity with TapToPlace component reconfigured." lightbox="../media/tap-to-place-reconfigured.png":::
