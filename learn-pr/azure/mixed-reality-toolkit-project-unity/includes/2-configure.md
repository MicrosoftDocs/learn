The first step to creating an immersive experience for Windows Mixed Reality requires configuring your Unity project for Windows Mixed Reality development. Configuring Unity for Windows Mixed Reality development is a manual process, which must be completed whenever you create a new Unity project or open a project shared with you. Once your project is configured, your app will be able to do basic holographic rendering and spatial input. Here you'll learn the specifics of configuring your Unity project for Windows Mixed Reality development.

> [!VIDEO https://channel9.msdn.com/Shows/Docs-Mixed-Reality/Configure-Unity-for-Mixed-Reality-Development/player?format=ny]

## Universal Windows Platform

To target Windows Mixed Reality, your Unity project must be set to export as a Universal Windows Platform app. By default, the build settings for the Universal Windows Platform target any device - this includes support for immersive headsets. However, you could select the appropriate device by changing the setting for **Target device**.

## Create an immersive view

Windows apps can contain two kinds of views, **2D views** and **immersive views**. Apps can switch between their various immersive views and 2D views, showing their 2D views on a monitor as a window or in a headset as a slate.

An immersive view gives your app the ability to create holograms in the world around you or immerse the user in a virtual environment. Apps that have at least one immersive view are categorized as mixed reality apps. Apps that never have an immersive view are **2D apps**.

In Unity, you can configure your project to create an immersive view by enabling **Virtual Reality Supported**. When virtual reality support is enabled, a virtual reality SDK must be added. As there is no separate SDK for Windows Mixed Reality development, the Windows 10 SDK is used instead.

## How are holograms rendered

In mixed reality apps, the scene is rendered twice, once for each eye to the user. This rendering method is referred to as *stereoscopic vision*. Compared to traditional 3D development, stereoscopic vision doubles the amount of work that needs to be computed. Therefore, it's important to select the most efficient rendering path in Unity to save both on CPU and GPU time. **Single pass instanced** rendering optimizes the Unity rendering pipeline for mixed reality apps and therefore it's recommended to enable this setting by default for every project.

## How to stabilize holograms

To achieve better hologram stability from the perception of the user, **Depth Buffer Sharing** should be enabled. By turning this on, Unity will share the depth map produced by your app with the Windows Mixed Reality platform. The platform will then be able to better optimize hologram stability specifically for your scene for any given frame being rendered by your app.

With regards to performance, selecting the **16-bit depth** format compared to 24-bit will significantly reduce the bandwidth requirements as less data will need to be moved/processed.

## Porting an existing Unity app to Windows Mixed Reality

If you have an existing Unity project that you're porting to Windows Mixed Reality, refer to the Unity porting guide to get started. Bringing existing content over to Windows Mixed Reality involves retargeting the usage of other platform SDKs to the Windows APIs. If your app is not already built for the Universal Windows Platform, changing over to the platform will be part of the porting experience.
