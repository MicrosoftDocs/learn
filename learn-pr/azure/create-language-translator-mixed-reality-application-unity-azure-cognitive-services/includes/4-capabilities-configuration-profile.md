Integrating features into mixed reality apps that use APIs and input sources such as a microphone or camera requires you enable specific capabilities in the Unity Project Settings. In the example of collaboration tools, there's a need for a microphone to capture speech. The example also needs the internet for using the Azure Cognitive Services Speech service. 

Here, you'll learn about the APIs and resources that must be enabled to access a mixed reality app created in Unity.

## MRTK speech command for start behavior

By default, the Mixed Reality Toolkit (MRTK) speech commands are configured to start automatically when a Unity scene loads. This setting enables you to use speech to manipulate holograms or do other actions such as toggling the **Diagnostics** panel with the command **Toggle Diagnostics**. 

Because of this setting, the MRTK speech commands must be configured to not interfere with the Cognitive Services Speech SDK unless they're manually enabled. The MRTK speech command **Start Behavior** determines whether the speech commands are active when a scene starts. If your mixed reality experience uses the Cognitive Services Speech SDK, the MRTK speech commands' start behavior should be set to **Manual Start**.

Because the default configuration profiles that come with MRTK can't be modified, you first must clone an existing profile. Cloning a profile creates a copy of the profile so you can change the configuration settings as you'd like.

## Capabilities

To enable APIs or resources (such as a microphone) to access your app, you must enable the capability in the Unity Project Settings. In the next exercise, you'll be instructed to enable the following capabilities:


|Capability  |Function  |
|---------|---------|
|InternetClient     |  Apps can receive incoming data from the internet. The app can't act as a server, and there's no local network access.       |
|InternetClientServer     |     This capability is the same as **InternetClient** but also enables peer-to-peer (P2P) scenarios where the app needs to listen for incoming network connections.    |
|PrivateNetworkClientServer     |    Provides inbound and outbound access to home and work networks through the firewall.     |
|Microphone     |   Accesses the microphone's audio feed, which allows the app to record audio from a connected microphone.      |

> [!TIP]
> If you intend to deploy the app to a mixed reality device, enable Spatial Perception in the **Capabilities** settings. Spatial Perception provides access to spatial mapping data. This gives mixed reality apps information about surfaces in application-specified regions of space near the user.

To use a mixed reality app with speech translation integration, the user must use a device that has a microphone and is connected to the internet. For some devices, the user must give the app permission to use their microphone.

## Cognitive Services Speech Unity package

The Cognitive Services Speech Unity package enables you to use the Cognitive Services Speech SDK in a Unity project. This package must be imported into your Unity project before you write or use a C# script that uses the SDK. Failure to import the package will result in namespace errors within Visual Studio.