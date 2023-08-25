In this module, you'll learn how to spatialize the button interaction sounds and also learn how to use an audio clip to test spatialized button interaction.

## Add a button

1. To add the Button prefab, in the **Project** window, select **Packages** and type "PressableButton_32x32mm_IconAndTextUnder" in the search bar.

    :::image type="content" source="../media/button-prefab.png" alt-text="Screenshot of Button prefab in Assets." lightbox="../media/button-prefab.png":::

2. The button prefab is the entry represented by a blue icon. Click and drag the **PressableButton_32x32mm_IconAndTextUnder** prefab into the Hierarchy. With the **PressableButton_32x32mm_IconAndTextUnder** object still selected, in the Inspector window, configure the **Transform** component as follows:

    * **Position**: X = 0, Y = 1.6, Z = 0.5
    * **Rotation**: X = 0, Y = 0, Z = 0
    * **Scale**: X = 1, Y = 1, Z = 1

    :::image type="content" source="../media/button-transform.png" alt-text="Screenshot of Button transform." lightbox="../media/button-transform.png":::
    To focus in on the objects in the scene, you can double-click on the **PressableButton_32x32mm_IconAndTextUnder** object, and then zoom slightly in again:

## Spatialize button feedback

In this step, you'll spatialize the audio feedback for the button. For related design suggestions, see [spatial sound design.](/windows/mixed-reality/spatial-sound-design).

In the **Audio Mixer** window you'll define destinations called **Mixer Groups**, for audio playback from **Audio Source** components.

1. To open the **Audio Mixer** window, In the Unity menu, select **Window** > **Audio** > **Audio Mixer**:

    :::image type="content" source="../media/open-audio-mixer.png" alt-text="Screenshot of Open Audio Mixer Window." lightbox="../media/open-audio-mixer.png":::
2. Create a **Mixer** by clicking the '+' next to **Mixers** and enter a suitable name to the Mixer for example, _Spatial Audio Mixer_. The new mixer will include a default **Group** called **Master**.

    :::image type="content" source="../media/first-mixer.png" alt-text="Mixer panel with first mixer." lightbox="../media/first-mixer.png":::

3. Open the mixer and right-click, then select **Add effect at bottom > Microsoft Spatializer Mixer.**

    :::image type="content" source="../media/add-effect.png" alt-text="Mixer panel with first mixer." lightbox="../media/first-mixer.png":::

4. In the Hierarchy window, select the **PressableButton_32x32mm_IconAndTextUnder** then in the Inspector window
  find the **Audio Source** component and Configure the Audio Source component as follows:

    1) For the **Output** property, click the selector and choose the **Mixer** that you created
    2) Check the **Spatialize** checkbox
    3) Move the **Spatial Blend** slider to 3D (1)

   :::image type="content" source="../media/button-audio-source.png" alt-text="Screenshot of Button audio source." lightbox="../media/button-audio-source.png":::

  > [!NOTE]
> If you move **Spatial Blend** to 1 (3D) without checking the **Spatialize** checkbox, Unity will use its panning spatializer, instead of the **Microsoft Spatializer** with HRTFs.

## Adjust the volume curve

By default, Unity will attenuate spatialized sounds as they get farther from the listener. When this attenuation is applied to interaction feedback sounds, the interface can become more difficult to use.

To disable this attenuation, you need to adjust the **Volume** curve In the **Audio Source** component.

* In the Hierarchy window, select the **PressableButton_32x32mm_IconAndTextUnder** then in the Inspector window
  navigate to  **Audio Source** > **3D Sound Settings** and Configure as follows:

  1) Set the **Volume Rolloff** property to Linear Rolloff
  2) Drag the endpoint on the **Volume** curve (the red curve) from '0' on the y axis up to '1'
  3) To adjust the shape of the **Volume** curve to be flat, drag the white curve shape control to be parallel to the X axis

  :::image type="content" source="../media/3d-sound-settings.png" alt-text="Screenshot of Button 3D sound settings." lightbox="../media/3d-sound-settings.png":::

## Test the spatialize audio

To test the spatialize audio in the Unity editor you've to add an audio clip in the **Audio Source** component with **Loop** option checked in on **PressableButton_32x32mm_IconAndTextUnder** object.

In the play mode move the **PressableButton_32x32mm_IconAndTextUnder** object from left to right and compare with and without spatial audio enabled on your workstation. You can also change the Audio Source settings for testing by:

1) Moving the **Spatial Blend** property between 0 - 1 (2D non-spatialized and 3D spatialized sound)
2) Checking and unchecking the **Spatialize** property

Try out the app on HoloLens 2. In the app, you can click the button and hear the spatialized button interaction sounds.

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. Alternatively, you can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a device. Devices can be purchased at [HoloLens.com](http://hololens.com/).
