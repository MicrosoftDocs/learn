## 5.Exercise: Creating A Holographic Remoting PC Application

In this tutorial, you'll learn how to create a PC app for Holographic Remoting. That lets you connect to HoloLens 2 at any time, providing a way to visualize 3D content in Mixed Reality.

## Configuring The Capabilities
In the Project Settings window, expand the **Publishing Settings**, then scroll down to the Capabilities section and then select the following: 

* Internet Clint server
* Private Network Client Server

![Player settings](../media/a-1.png)

[!INCLUDE[](includes/switch-platform.md)]

## Build Your Application To PC

Legacy WSA
[!INCLUDE[](includes/Build-your-application-to-PC.md)]

## Testing Holographic Remoting Remote Application
To connect your PC application to your HoloLens 2, do the following:

## 1. Install The Remoting Player Application On HoloLens 2 Device
* On your HoloLens 2, visit the Store app and search for **"Remoting Player."**
* Select the **Remoting Player** app.
* Tap **Install** to download and install the app.

## 2. Connect The Holographic Remoting PC App To The Remoting Player
* Start the **Remoting Player** on your HoloLens.
* Take note of the HoloLens **IP address**. It will be displayed as a hologram by the **Remoting Player** as soon as it launches.
* Open the Holographic Remoting PC application on your PC.
* Once the application is launched, enter the **IP address** and click the **Connect** button to connect.