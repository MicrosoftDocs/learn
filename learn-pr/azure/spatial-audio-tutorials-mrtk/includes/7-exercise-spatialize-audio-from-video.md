In this unit, you'll learn how to spatialize audio from a video source and test this in the Unity editor and HoloLens 2.

## Import a video and add a video player to the scene

For this unit, you can use [this video](https://github.com/microsoft/spatialaudio-unity/blob/develop/Samples/MicrosoftSpatializerSample/Assets/Microsoft%20HoloLens%20-%20Spatial%20Sound-PTPvx7mDon4.mp4?raw=true) from the spatial audio sample project.

1. To import the video into the unity project, select **Assets** > **Import New Asset** in the Unity menu.

    :::image type="content" source="../media/import-asset.png" alt-text="Screenshot of Importing Asset." lightbox="../media/import-asset.png":::

2. In the **Import New Asset...** window, select the **Microsoft HoloLens - Spatial Sound-PTPvx7mDon4** file you downloaded and select the **Import** button to import the asset into the project.

    :::image type="content" source="../media/select-asset.png" alt-text="Screenshot of Selecting Asset." lightbox="../media/select-asset.png":::

3. Adjusting the quality settings on the video clip can ensure smooth playback on HoloLens 2. Select the video file in the **Project** window. In the Inspector window, select the **Windows** tab, check the box for **Override for Windows**, and configure the rest of the settings as follows:

    1) Check the box for **Transcode**.
    2) Set **Codec** to **H264**.
    3) Set **Bitrate Mode** to **Low**.
    4) Set **Spatial Quality** to **Medium Spatial Quality**.

4. Select **Apply** to change the quality setting on the video clip.

    :::image type="content" source="../media/video-property-change.png" alt-text="Screenshot of Video property Change." lightbox="../media/video-property-change.png":::

5. Right-click in the Hierarchy window, then select **Video** > **Video Player** to add the Video player component.

    :::image type="content" source="../media/add-video-player.png" alt-text="Screenshot of adding a Video Player." lightbox="../media/add-video-player.png":::

## Play video onto a quadrangle

The **Video Player** object needs a textured game object to render the video.

1. Right-click in the Hierarchy window, then select **3D Object** > **Quad** to create a quad and configure its **Transform** component as follows:

    * **Position**: X = 0, Y = 2.1, Z = 2
    * **Rotation**: X = 0, Y = 0, Z = 0
    * **Scale**: X = 1.28, Y = 0.72, Z = 1

    :::image type="content" source="../media/add-quad.png" alt-text="Screenshot of adding a Quad." lightbox="../media/add-quad.png":::

2. Now you need to texture the **Quad** with the video. Right-click in the **Project** window and choose **Create** > **Render Texture** to create a Render Texture component. Enter a suitable name to the Render Texture; for example, _Spatial Audio Texture_.

    :::image type="content" source="../media/create-render-texture.png" alt-text="Screenshot of creating a Render Texture." lightbox="../media/create-render-texture.png":::

3. Select the **Render Texture** and in the Inspector window set the **Size** property to match the video's native resolution of **1280x720**. Then, to ensure good rendering performance on HoloLens 2, set the **Depth Stencil Format** property to **D16_UNORM** or higher.

    :::image type="content" source="../media/render-texture-property.png" alt-text="Screenshot of Render Texture properties." lightbox="../media/render-texture-property.png":::

4. Next, use the created Render Texture **Spatial Audio Texture** as the texture for the **Quad**:

    1) Drag the **Spatial Audio Texture** from the **Project** window onto the **Quad** in the Hierarchy to add the Render Texture to the Quad.
    2) To ensure good performance on HoloLens 2, select the Quad in the Hierarchy and in the Inspector window, select **Graphics Tools** > **Standard** in the **Shader** field.

    :::image type="content" source="../media/quad-texture-property.png" alt-text="Screenshot of Quad texture properties." lightbox="../media/quad-texture-property.png":::

5. To set **Video Player** and **Render Texture** to play the video clip, select the **Video Player** in the **Hierarchy** and configure the settings in the **Inspector** window as follows:

    1) Set the **Video Clip** property to the downloaded video file: **Microsoft HoloLens - Spatial Sound-PTPvx7mDon4**.
    2) Check the **Loop** checkbox.
    3) Set the **Target Texture** to your new render texture, **Spatial Audio Texture**.

    :::image type="content" source="../media/video-player-property.png" alt-text="Screenshot of Video player properties." lightbox="../media/video-player-property.png":::

## Spatialize the audio from the video

1. In the Hierarchy window, select the **Quad** object. In the Inspector window, use the **Add Component** button to add an **Audio Source**, to which you'll route the audio from the video.

1. In the **Audio Source**:
    1) Set **Output** to the **Spatial Audio Mixer** > **Master**.
    2) Check the **Spatialize** box.
    3) Move the **Spatial Blend** slider to **1** (**3D**).

    :::image type="content" source="../media/quad-audio-source.png" alt-text="Screenshot of Quad audio source inspector." lightbox="../media/quad-audio-source.png":::

1. To set the Video Player to route its audio to the **Audio Source**, select the **Video Player** in the Hierarchy window. In the Inspector window, configure the Video Player object as follows:

    1) Set the **Audio Output Mode** to **Audio Source**
    2) Set the **Audio Source** property to the **Quad**

    :::image type="content" source="../media/video-player-set.png" alt-text="Screenshot of setting the Video player audio source." lightbox="../media/video-player-set.png":::
