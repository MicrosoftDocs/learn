In this exercise, you'll learn how to create speech commands with StatefulInteractables.

## Ensure MRTK Speech object is enabled

* In the Hierarchy window, select the **MRTK XR Rig** > **MRTK Speech** game object and make sure it is enabled.

:::image type="content" source="../media/enable-mrtk-speech.png" alt-text="Screenshot of MRTK Speech object." lightbox="../media/enable-mrtk-speech.png":::

**MRTK Speech** object contains the **Speech Interactor** component. StatefulInteractable components register keywords with the SpeechInteractor, and the SpeechInteractor passes along keyword events to the corresponding StatefulInteractable components.

## Enable keyword recognition subsystem
* The Keyword Recognition Subsystem needs to be enabled for voice commands to work. Go to Edit > Project Settings > MRTK3, make sure the **MRTK Windows KeywordRecognition Subsystem** is selected.

    :::image type="content" source="../media/configure-keywordrecognitionsubsystem.png" alt-text="Screenshot of MRTK XR keyword recognition subsystem." lightbox="../media/configure-keywordrecognitionsubsystem.png":::
 
## Control speech commands

1. From the [previous module](/training/modules/get-started-with-object-interaction), you should have a GameObject, **Menu.** Select **Menu** > **MenuContent-HorizontalLayout (Menu and Pin)** > **Buttons-GridLayout (Buttons)** > **Indicator** and configure it as follows:
    1) In the **Pressable Button** component, enter the keyword **enable indicator** for Speech Recognition under **Advanced StatefullInteractable Settings** section.
    2) Deselect **Voice Requires Focus** so the user is not required to look at the object to trigger the speech command
 
    :::image type="content" source="../media/indicator-enable-button.png" alt-text="Screenshot of adding action for keyword recognition." lightbox="../media/indicator-enable-button.png":::

2. Repeat these steps for the **TapToPlace**, **BoundsControl_Enable**, and **BoundsControl_Disable** buttons, but using the keywords **Enable Tap to Place**, **Enable Bounds Control**, and **Disable Bounds Control** respectively.

3. If you use Holographic Remoting for Play mode to preview and debug your app, make sure the "Enable Audio" option is selected.

    :::image type="content" source="../media/enable-audio.png" alt-text="Screenshot of holographic remoting." lightbox="../media/enable-audio.png":::