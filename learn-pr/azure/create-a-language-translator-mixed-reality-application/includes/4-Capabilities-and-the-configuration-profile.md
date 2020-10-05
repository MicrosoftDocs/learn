Integrating features into Mixed Reality apps that use APIs and input sources such as a microphone or camera requires that you enable specific capabilities in the Unity Project Settings. In the collaboration tools example, there's a need for a microphone to capture speech in addition to internet for using the Azure Cognitive Services Speech service. Here, you'll learn how to enable APIs and resources to access a Mixed Reality app created in Unity.

## MRTK Speech Commands Start Behavior

By default, the MRTK Speech Commands are configured to start automatically when a Unity scene loads. This enables you to use speech to manipulate holograms or perform other actions such as toggling the Diagnostics panel with the command "toggle diagnostics". Because of this, the MRTK Speech Commands must be configured to not interfere with the Cognitive Services Speech SDK unless manually enabled. The MRTK Speech Commands **Start Behavior** determines whether the Speech Commands are active when a scene starts. If your Mixed Reality experience uses the Cognitive Services Speech SDK, the MRTK Speech Commands Start Behavior should be set to **Manual Start**.

Since the default Configuration Profiles that come with MRTK cannot be modified, an existing profile must first be cloned. Cloning a profile creates a copy of the profile thus enabling you to change the configuration settings as you'd like.

## Capabilities

To enable APIs or resources (such as a microphone) to access your app, you must enable the capability in the Unity Project Settings. For creating a speech translation app, the following capabilities must be enabled:


|Capability  |Function  |
|---------|---------|
|InternetClient     |  Apps can receive incoming data from the Internet. The app cannot act as a server and there is also no local network access.       |
|InternetClientServer     |     This is the same as **InternetClient** but also enables peer-to-peer (P2P) scenarios where the app needs to listen for incoming network connections.    |
|PrivateNetworkClientServer     |    Provides inbound and outbound access to home and work networks through the firewall.     |
|Microphone     |   Accesses the microphone's audio feed, which allows the app to record audio from a connected microphone.      |

> [!TIP]
> If you intend to deploy the app to a Mixed Reality device, Spatial Perception should be enabled in the **Capabilities** settings. Spatial Perception provides access to spatial mapping data. This gives Mixed Reality apps information about surfaces in application-specified regions of space near the user.

To use a Mixed Reality app with speech translation integration, the user must use a device that has a microphone and is connected to the internet. For some devices, the user must give the app permission to use their microphone.

## Cognitive Services Speech Unity package

The Cognitive Services Speech Unity package enables you to use the Cognitive Services Speech SDK in a Unity project. This package must be imported into your Unity project prior to writing or using a C# script that uses the SDK. Failure to import the package will result in namespace errors within Visual Studio.