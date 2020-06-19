## What is Unity

Often referred to as a game engine, Unity is a real-time development platform. You can create and test mixed reality apps in Unity without the need for a mixed reality device.

Unity has two modes: Edit and Play. As you create your own mixed reality apps, you will do so in Edit mode. When you're ready to test your scene, you can do so in Play mode.

Unity is equipped with a collection of 3D objects, known as primitives, that can be added to your project. For the exercises in this module, you will use Unity primitives.

## Create an immersive view
An immersive view gives your app the ability to create holograms in the world around you or immerse the user in a virtual environment. Apps that have at least one immersive view are categorized as mixed reality apps. In Unity, you can configure your project to create an immersive view by enabling **Virtual Reality Supported**. When virtual reality support is enabled, a virtual reality SDK must be added. As there is no separate SDK for Windows Mixed Reality development, the Windows 10 SDK is used instead.

## How are holograms rendered

In Mixed Reality apps, the scene is rendered twice, once for each eye to the user. This rendering method is referred to as *stereoscopic vision*. Compared to traditional 3D development, stereoscopic vision doubles the amount of work that needs to be computed. Therefore, it is important to select the most efficient rendering path in Unity to save both on CPU and GPU time. **Single pass instanced** rendering optimizes the Unity rendering pipeline for mixed reality apps and thus it is recommended to enable this setting by default for every project.

## How to stabilize holograms

To achieve better hologram stability from the perception of the user, **Depth Buffer Sharing** should be enabled. By turning this on, Unity will share the depth map produced by your app with the Windows Mixed Reality platform. The platform will then be able to better optimize hologram stability specifically for your scene for any given frame being rendered by your app.

With regards to performance, selecting the **16-bit depth** format compared to 24-bit will significantly reduce the bandwidth requirements as less data will need to be moved/processed.
