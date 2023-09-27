In this tutorial, you'll learn how to create a PC app for Holographic Remoting. That lets you connect to HoloLens 2 at any time, providing a way to visualize 3D content in Mixed Reality.

## Configure the capabilities

In the Project Settings window, expand the **Publishing Settings**, then scroll down to the Capabilities section and then select the following:

* Internet Client server
* Private Network Client Server

:::image type="content" source="../media/player-settings.png" alt-text="Screenshot of Player settings." lightbox="../media/player-settings.png":::

[!INCLUDE[](includes/switch-platform.md)]

## Build your application to pc

[!INCLUDE[](includes/build-your-application-to-pc.md)]

## Test holographic remoting remote application

> [!Note]
> Building and testing on HoloLens 2 is not mandatory. Alternatively, you can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a device. Devices can be purchased at [HoloLens.com](http://hololens.com/).

To connect your PC application to your HoloLens 2, do the following:

### 1. Install the remoting player application on HoloLens 2 device

1. On your HoloLens 2, visit the Store app and search for **"Holographic Remoting Player."**
2. Select the **Holographic Remoting Player** app.
3. Tap **Install** to download and install the app.

### 2. Connect the holographic remoting pc app to the remoting player

1. Start the **Holographic Remoting Player** on your HoloLens.
2. Take note of the HoloLens **IP address**. It will be displayed as a hologram by the **Holographic Remoting Player** as soon as it launches.
3. Open the Holographic Remoting PC application on your PC.
4. Once the application is launched, enter the **IP address** and select the **Connect** button to connect.

## Holographic Remoting For Play Mode

In MRTK 3 you can skip the step of making a build in order to speed up your development iterations.
This is done by going back to the Project Settings > XR Plug-in Management > OpenXR and selecting
the checkbox **Holographic Remoting for Play Mode**.

:::image type="content" source="../media/enable-play-mode-remoting.png" alt-text="Screenshot of Enabling Holographic Remoting for Play Mode." lightbox="../media/enable-play-mode-remoting.png":::

After enabling this you will most likely get a Project Validation error:

:::image type="content" source="../media/remote-host-error.png" alt-text="Screenshot of remote host validation error." lightbox="../media/remote-host-error.png":::

This is because the IP address of your HoloLens must be set before playing. This is done with the menu
**Mixed Reality > Remoting > Holographic Remoting for Play Mode**.
 Enter the IP address shown in the **Holographic Remoting Player** into the "Remote Host Name" field.

:::image type="content" source="../media/playmode-ip.png" alt-text="Screenshot of remote host connection configuration." lightbox="../media/playmode-ip.png":::
