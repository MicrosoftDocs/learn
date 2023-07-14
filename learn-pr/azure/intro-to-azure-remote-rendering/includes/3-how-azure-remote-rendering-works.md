Azure Remote Rendering consists of a number of components, which in turn consist of a number of processes. In this unit, you'll learn about the following components within Azure Remote Rendering and the underlying processes that operate within each component.

| Component         | Description                                                  |
| ----------------- | ------------------------------------------------------------ |
| Conversion        | Prepares your 3D assets for use with Azure Remote Rendering. |
| Rendering session | Provides the connection between your client device and the server that performs the remote rendering. |
| Client SDK        | Combines local and remote holograms on your device, such as HoloLens 2. |

## Conversion

The conversion process prepares your 3D assets for use with Azure Remote Rendering and is required to make rendering as efficient as possible at runtime. Begin the process by uploading your models to Azure Blob storage.

> [!NOTE]
> Currently, Azure Remote Rendering can convert both Filmbox (FBX) and Graphics Language Transmission Format model formats.

After uploading your models, perform the conversion process. After conversion completes, Azure writes the converted model back to your Blob storage.

> [!TIP]
> Models that you aren't actively rendering remain unchanged within Blob storage.

## Rendering session

After conversion, you must establish a session between your client device and the server that will render your converted 3D model. There are three steps in this process:

1. Request a session.
1. Connect to the session to perform remote rendering.
1. End the session.

### What is a session?

Azure Remote Rendering works by offloading complex rendering tasks to the cloud. These rendering tasks must be performed by specific cloud servers. The servers are equipped with the type of GPUs required to render complex 3D models. You can't use just any server, so you must reserve the use of a server with the required capabilities. You do so by requesting a *session*.

A session includes the following components:

- Lease request to reserve a server for your use. During a lease request, you choose the server size on which you want to run. You can select Standard or Premium. You can't change this sizing during a running session.

   > [!IMPORTANT]
   > Remote Rendering with a Standard-sized server has a maximum scene size of 20 million polygons. Remote Rendering with a Premium-sized server doesn't enforce a hard maximum; however, performance might be degraded if your content exceeds the rendering capabilities of the service.

- All the commands for loading and manipulating models.
- A lease-end request to release the cloud server after rendering is complete.

A session consists of three basic phases, described in the following table:

| Phase           | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| Session startup | In this phase, Azure Remote Rendering creates a session on your behalf. You request a server size and specify the Azure region for the session. The session is then marked as **Starting**. After a suitable server is found, Azure copies the appropriate size VM onto the server to create an Azure Remote Rendering host. When the VM has started, the session state transitions to **Ready**. |
| Session connect | After your session state is **Ready**, you can connect your device to it. While it's connected, the device sends commands to load and modify your 3D models. |
| Session end     | When you no longer need the session, you should stop it. If you don't manually stop the session, it's automatically shut down when the session's lease time expires. |

### Rendering modes

When rendering, the server sends rendered frames back into the application that's running locally on the device. The following table describes the two rendering modes:

| Mode     | Description     |
| ---- | ---- |
|  TileBasedComposition    | In this mode, every involved GPU renders specific tiles for display on the screen. The main GPU composes the final image using these tiles before Azure sends it as a video frame to your client device. The rendering quality for this mode is slightly better than for DepthBasedComposition mode. |
|  DepthBasedComposition    | In this mode, every involved GPU renders at full-screen resolution but only for a subset of meshes. The final image composition on the main GPU helps ensure that parts are properly merged according to their depth information.     |

> [!NOTE]
> Specify the remote rendering mode when you connect to your session.

## Client SDK

After the frames arrive on your device, they're composited with any local holograms that you might have in your image. This provides a truly hybrid rendering experience that allows you to mix and match both remote and local holograms. This means that you only have to render the remote objects that have a higher polygon count.

> [!TIP]
> Keep content such as menus and smaller models local.
