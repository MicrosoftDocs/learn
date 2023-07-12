In this exercise, You'll learn how to create speech commands and how to control them globally. You'll also learn how to control local speech commands that require the user to look at the object that controls the speech command.

## Ensure MRTK Speech object is enabled

* In the Hierarchy window, select the **MRTK XR Rig** > **MRTK Speech** game object and make sure it is enabled.

:::image type="content" source="../media/enable-mrtk-speech.png" alt-text="Screenshot of MRTK Speech object." lightbox="../media/enable-mrtk-speech.png":::

**MRTK Speech** object contains the **Speech Interactor** component. StatefulInteractable components register keywords with the SpeechInteractor, and the SpeechInteractor passes along keyword events to the corresponding StatefulInteractable components.

## Enable keyword recognition subsystem
* The Keyword Recognition Subsystem needs to be enabled for voice commands to work. Go to Edit > Project Settings > MRTK3, make sure the **MRTK Windows KeywordRecognition Subsystem** is selected.

    :::image type="content" source="../media/configure-keywordrecognitionsubsystem.png" alt-text="Screenshot of MRTK XR keyword recognition subsystem." lightbox="../media/configure-keywordrecognitionsubsystem.png":::

## Control speech commands

1. In the Project window, navigate to the **Packages** > **MRTK UX Components (Non-Canvas)** > **Slates**, drag the **Slate** prefab to the scene and change its name to **Indicator**. Change its position to x = -0.3, y=1.6, z=0.6.

    :::image type="content" source="../media/indicator-slate.png" alt-text="Screenshot of indicator." lightbox="../media/indicator-slate.png":::

2. In the Project window, navigate to the **Packages** > **ObjectBar**, drag the **HorizontalAppBar** prefab as child of the Indicator game object. Change its position to x = -0.08, y=0.01, z=-0.02
 
    :::image type="content" source="../media/indicator-buttons.png" alt-text="Screenshot of HorizontalAppBar prefab." lightbox="../media/indicator-buttons.png":::

3. Expand Indicator > HorizontalAppBar > Buttons, and change the name of its children button gameobjects to **Indicator**, **TapToPlace**, **Enable**, **Disable**.

    :::image type="content" source="../media/indicator-buttons-name.png" alt-text="Screenshot of indicator button name." lightbox="../media/indicator-buttons-name.png":::

4. Select Indicator > HorizontalAppBar > Buttons > Indicator > CompressableButtonVisuals > IconAndText > TextMeshPro, and change its text to **Indicator**. Repeat similar steps for other buttons **TapToPlace**, **Enable**, **Disable**.

    :::image type="content" source="../media/indicator-buttons-label.png" alt-text="Screenshot of indicator button labels." lightbox="../media/indicator-buttons-label.png":::

5. Create a dummy button and use its built-in speech command to to enable **Indicator**. In the Project window, navigate to the **Packages** > **MRTK UX Components (Non-Canvas)** >**Button** > **32x32** folder, then drag the **PressableButton_32x32mm_Circular_IconOnly** prefab to the scene and change its name to **IndicatorEnable**. Change its scale to x = 0, y=0, z=0, to make it invisible.

   There are different ways to enable Indicator using speech command. You can write a script to listen to the voice input and activate Indicator when the voice input matches the expected keyword as below. For this tutorial, you don't need this script if you have done the above steps.

    ```c#
    // Copyright (c) Microsoft Corporation.
    // Licensed under the MIT License.
    using UnityEngine;
    using UnityEngine.Events;
    using System.Collections.Generic;
    using System;
    using Microsoft.MixedReality.Toolkit;
    using Microsoft.MixedReality.Toolkit.Subsystems;
    public class KeywordRecognitionHandler : MonoBehaviour
    {
        [Serializable]
        public struct KeywordEvent
        {
            [SerializeField]
            public string Keyword;
            [SerializeField]
            public UnityEvent Event;
        }
        [SerializeField]
        private List<KeywordEvent> _keywords = new List<KeywordEvent>();
        public List<KeywordEvent> Keywords
        {
            get => _keywords;
            set
            {
                _keywords = value;
                UpdateKeywords();
            }
        }
        [SerializeField]
        private UnityEvent GlobalEvent;
        private KeywordRecognitionSubsystem _keywordRecognitionSubsystem;
        private void Start()
        {
            _keywordRecognitionSubsystem = XRSubsystemHelpers.GetFirstRunningSubsystem<KeywordRecognitionSubsystem>();
            if (_keywordRecognitionSubsystem == null)
            {
                // TODO log warning
            }
            UpdateKeywords();
        }
        private void UpdateKeywords()
        {
            foreach (var data in _keywords)
            {
                _keywordRecognitionSubsystem.CreateOrGetEventForKeyword(data.Keyword).AddListener(() =>
                {
                    GlobalEvent?.Invoke();
                    data.Event?.Invoke();
                });
            }
        }
    }

  :::image type="content" source="../media/indicator-enable-button-create.png" alt-text="Screenshot of IndicatorEnable game object." lightbox="../media/indicator-enable-button-create.png":::

6. Select **IndicatorEnable** button gameobject and configure it as follows:
    1) In the **Pressable Button** component, enter the keyword **enable indicator** for Speech Recognition under **Advanced StatefullInteractable Settings** section.
    2) Deselect **Voice Requires Focus** so the user is not required to look at the object to trigger the speech command.
    3) Under On Click() event, click the small + icon to add another event.
    4) From the Hierarchy window, assign the **Indicator** object to the **None (Object)** field.
    5) From the **No Function** dropdown, select **GameObject** > **SetActive (bool)** to set this function as the action to be executed when the event is triggered.
    6) Select the argument checkbox, so it's **selected**

    :::image type="content" source="../media/indicator-enable-button.png" alt-text="Screenshot of adding action for keyword recognition." lightbox="../media/indicator-enable-button.png":::

7. Select Indicator > HorizontalAppBar > Buttons > Indicator  and configure it as follows:

    1) In the **Pressable Button** component, enter the keyword **disable indicator** for Speech Recognition under **Advanced StatefullInteractable Settings** section.
    2) Deselect **Voice Requires Focus** so the user is not required to look at the object to trigger the speech command.
    3) Under On Click() event, click the small + icon to add an event.
    4) From the Hierarchy window, assign the **Indicator** object to the **None (Object)** field.
    5) From the **No Function** dropdown, select **GameObject** > **SetActive (bool)** to set this function as the action to be executed when the event is triggered.
    6) Select the argument checkbox, so it's **unselected**

    :::image type="content" source="../media/indicator-enable-button.png" alt-text="Screenshot of unselecting Voice Requires Focus." lightbox="../media/indicator-enable-button.png":::


8. Select Indicator > HorizontalAppBar > Buttons > TapToPlace  and configure it as follows:

    1) In the **Pressable Button** component, enter the keyword **Enable Tap to Place** for Speech Recognition under **Advanced StatefullInteractable Settings** section.
    2) Deselect **Voice Requires Focus** so the user is not required to look at the object to trigger the speech command.
    3) Under On Click() event, click the small + icon to add an event.
    4) From the Hierarchy window, assign the object itself, that is, the same **RoverAssembly** object, to the **None (Object)** field.
    5) From the **No Function** dropdown, select **TapToPlace** > **bool enabled** to update this property value when the event is triggered.
    6) Select the argument checkbox, so it's **selected**

    :::image type="content" source="../media/indicator-configure-taptoplace-button.png" alt-text="Screenshot of indicator tap to place button." lightbox="../media/indicator-configure-taptoplace-button.png":::

9. Select Indicator > HorizontalAppBar > Buttons > Enable  and configure it as follows:

    1) In the **Pressable Button** component, enter the keyword **Enable Bounds Control** for Speech Recognition under **Advanced StatefullInteractable Settings** section.
    2) Deselect **Voice Requires Focus** so the user is not required to look at the object to trigger the speech command.
    3) Under On Click() event, click the small + icon to add an event.
    4) From the Hierarchy window, assign the **RoverExplorer** object to the **None (Object)** field.
    5) From the **No Function** dropdown, select **BoundsControl** > **bool enabled** to update this property value when the event is triggered.
    6) Select the argument checkbox, so it's **selected**
    7) Click the small + icon to add another event
    8) From the Hierarchy window, assign the **RoverExplorer** object to the **None (Object)** field
    9) From the **No Function** dropdown, select **ObjectManipulator** > **bool enabled** to update this property value when the event is triggered
    10) Select the argument checkbox, so it's **selected**.

    :::image type="content" source="../media/indicator-configure-enable-button.png" alt-text="Screenshot of configuring enable button." lightbox="../media/indicator-configure-enable-button.png":::

10. Select Indicator > HorizontalAppBar > Buttons > Disable  and configure it as follows:

    1) In the **Pressable Button** component, enter the keyword **Disable Bounds Control** for Speech Recognition under **Advanced StatefullInteractable Settings** section.
    2) Deselect **Voice Requires Focus** so the user is not required to look at the object to trigger the speech command.
    3) Under On Click() event, click the small + icon to add an event.
    4) From the Hierarchy window, assign the **RoverExplorer** object to the **None (Object)** field.
    5) From the **No Function** dropdown, select **BoundsControl** > **bool enabled** to update this property value when the event is triggered.
    6) Select the argument checkbox, so it's **unselected**
    7) Click the small + icon to add another event
    8) From the Hierarchy window, assign the **RoverExplorer** object to the **None (Object)** field
    9) From the **No Function** dropdown, select **ObjectManipulator** > **bool enabled** to update this property value when the event is triggered
    10) Select the argument checkbox, so it's **unselected**.

    :::image type="content" source="../media/indicator-configure-disable-button.png" alt-text="Screenshot of configuring disable button." lightbox="../media/indicator-configure-disable-button.png":::

11. If you use Holographic Remoting for Play mode to preview and debug your app, make sure the "Enable Audio" option is selected.

    :::image type="content" source="../media/enable-audio.png" alt-text="Screenshot of holographic remoting." lightbox="../media/enable-audio.png":::