# 5.Exercise :Creating a Holographic Remoting PC application

In this tutorial, you will learn how to create a PC app for Holographic Remoting and connect to HoloLens 2 at any point, providing a way to visualize 3D content in mixed reality.

## Configuring the capabilities
In the Project Settings window, expand the **Publishing Settings**, scroll down to the Capabilities section and select the below-shown capability checkbox in addition to the existing capabilities.

* Internet Clint server
* Private Network Client Server

:::image type="content" source="../media/a1.PNG" alt-text="Player settings." lightbox="a1.PNG":::

[!INCLUDE[](includes/switch-platform.md)]

# Build your application to PC

Legacy WSA
[!INCLUDE[](includes/Build-your-application-to-PC.md)]

# Testing Holographic Remoting remote application
To connect your PC application to your HoloLens 2, follow the below process:

## 1. Install the Remoting Player application on HoloLens 2 device
* On your HoloLens 2, visit the Store app and search for **"Remoting Player."**
* Select the **Remoting Player** app.
* Tap **Install** to download and install the app.

## 2. Connect the Holographic remoting PC app to the Remoting Player
* Start the **Remoting Player** on your HoloLens.
* Take note of the HoloLens **IP address**. It will be displayed as a hologram by the **Remoting Player** as soon as it launches.
* Open the Holographic Remoting PC application on your PC.
* Once the application is launched, enter the **IP address** and click on the **Connect** button to connect.