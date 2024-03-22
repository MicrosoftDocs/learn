In this tutorial, you'll learn how to create a PC app for Holographic Remoting that lets you connect to HoloLens 2 at any time, providing a way to visualize 3D content in Mixed Reality.

## Configure the capabilities

Select **Player** in the Project Settings window, expand the **Publishing Settings**, then scroll down to the Capabilities section and then select the following:

* InternetClientServer
* PrivateNetworkClientServer

:::image type="content" source="../media/player-settings.png" alt-text="Screenshot of Player settings." lightbox="../media/player-settings.png":::

[!INCLUDE[](includes/switch-platform.md)]

## Build your application to pc

[!INCLUDE[](includes/build-your-application-to-pc.md)]

## Test holographic remoting remote application

> [!NOTE]
> Building and testing on HoloLens 2 is not mandatory. Alternatively, you can test on the [HoloLens 2 Emulator](/windows/mixed-reality/develop/advanced-concepts/using-the-hololens-emulator) if you don't have a device. You can purchase devices at [HoloLens.com](https://hololens.com/).

To connect your PC application to your HoloLens 2:

### 1. Install the remoting player application on HoloLens 2 device

1. On your HoloLens 2, visit the Store app and search for **Holographic Remoting Player**.
2. Select the **Holographic Remoting Player** app.
3. Select **Install** to download and install the app.

### 2. Connect the holographic remoting pc app to the remoting player

1. Start the Holographic Remoting Player on your HoloLens.
2. Take note of the HoloLens IP address. The Holographic Remoting Player will display it as a hologram as soon as it launches.
3. Open the Holographic Remoting PC application on your PC.
4. Once the application is launched, enter the IP address and select the **Connect** button to connect.

## Holographic Remoting For Play Mode

In MRTK 3, you can skip the step of making a build in order to speed up your development iterations by going back to the **Project Settings** > **XR Plug-in Management** > **OpenXR** menu and selecting
the checkbox for **Holographic Remoting for Play Mode**.

:::image type="content" source="../media/enable-play-mode-remoting.png" alt-text="Screenshot of enabling Holographic Remoting for Play Mode." lightbox="../media/enable-play-mode-remoting.png":::

After enabling this option, you'll most likely get a Project Validation error:

:::image type="content" source="../media/remote-host-error.png" alt-text="Screenshot of remote host validation error." lightbox="../media/remote-host-error.png":::

This is because the IP address of your HoloLens must be set before playing. To set the IP address, go to **Mixed Reality > Remoting > Holographic Remoting for Play Mode** and enter the IP address shown in the Holographic Remoting Player into the **Remote Host Name** field.

:::image type="content" source="../media/playmode-ip.png" alt-text="Screenshot of remote host connection configuration." lightbox="../media/playmode-ip.png":::
