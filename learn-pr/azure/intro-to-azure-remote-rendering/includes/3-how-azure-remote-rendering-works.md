<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'describe' learning objective.
    
    Pattern:
        One paragraph of 2-3 sentences:
            Sentence 1: State that this unit addresses ("how it works").
            Sentence 2: State that this unit targets this learning objective: "Describe how <features> of <product> work to <solve problem>."
            Sentence 3-4 (optional): Give the rationale ("helps you decide if it will meet your needs").
        Table-of-contents as a bulleted list (do not simply list every heading you'll have on the page, group them into about 3 high-level areas).
    
    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content.
    
    Example: "Here, we'll discuss how Logic Apps works behind the scenes. You'll learn about all the pieces of Logic apps and see how they fit together into an app. This knowledge will help you decide whether Logic Apps will work for you without any customization. In cases where you do need to create custom components, you'll be able to determine how difficult it will be.
        * Connectors, triggers, actions
        * Control actions
        * Logic Apps Designer"
-->

Azure Remote Rendering consists of a number of components, which in turn consist of a a number of processes. In this unit, you'll learn about the following components of Azure Remote Rendering, and the underlying processes that operate within the context of each component.

| Component                | Description                                                  |
| ------------------------ | ------------------------------------------------------------ |
| Conversion               | Prepares your 3D assets for use with Azure Remote Rendering. |
| Rendering server session | Provides the connection between your client device and the server that performs the remote rendering. |
| Client SDK               | Combines local and remote holograms on your device, such as HoloLens 2. |

<!-- 2. Chunked content-------------------------------------------------------------------------------------

    Goal:
        Cover the components of <product> and how they work.
        Repeat this pattern multiple times as needed.
    
    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote.
    
    [Learning-unit structural guidance]
-->

## Conversion

Conversion is the process that prepares your 3D assets for use with Azure Remote Rendering. Conversion is required to make rendering as efficient as possible at runtime. You start this process by uploading your models to Azure Blob storage.

> [!NOTE]
> Currently, Azure Remote Rendering can convert both FBX and Graphics Language Transmission Format model formats.

Next, your model must be converted before use with Azure Remote Rendering.  After the model is converted, Azure writes the converted model back to your Blob storage.

> [!TIP]
> Models not being used for active rendering stay at rest in your Blob storage.

## Rendering server session

After conversion, you must establish a session between your client device and the server that will render your converted 3D model. There are two steps in this process:

1. Starting a session
1. Remote rendering

### What is a session?

Azure Remote Rendering works by offloading complex rendering tasks into the cloud. These rendering tasks can only be fulfilled by specialist cloud servers. These specialist servers are equipped with the type of GPUs required to render complex 3D models. You cannot use just any server, so you must reserve the use of a server with the required capabilities. You do so by requesting a *session*.

A session includes the following components:

- Lease request, which is a request to reserve a server for your use. During lease request, you choose what server size you want to run on. You can select Standard or Premium. This sizing cannot be changed within a running session.

   > [!IMPORTANT]
   > Remote Rendering with Standard size server has a maximum scene size of 20 million polygons. Remote Rendering with Premium size doesn't enforce a hard maximum, but performance might be degraded if your content exceeds the rendering capabilities of the service.

- All the commands for loading and manipulating models.
- A lease end request, which releases the lease on the cloud server after your rendering is complete.

A session consists of three basic phases. These are described in the following table.

| Phase           | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| Session startup | In this phase, Azure Remote Rendering creates a session on your behalf. You request a server size and specify the Azure region for the session. The session is then marked as **Starting**. After a suitable server is found, Azure copies the appropriate size VM onto the server to create an Azure Remote Rendering host. When the VM has started, the session state transitions to **Ready**. |
| Session connect | After your session state is **Ready**, you can connect your device to it. While it's connected, the device sends commands to load and modify your 3D models. |
| Session end     | When you no longer need the session, you should stop it. If you don't manually stop the session, it's automatically shut down when the session's lease time expires. |

> [!IMPORTANT]
> During the session startup phase, Azure Remote Rendering only reserves servers in your Azure region to help reduce latency.

### Rendering modes

When rendering, the server sends rendered frames back into your application that's running locally on the device. There are two rendering modes, which the following table describes.

| Mode     | Description     |
| ---- | ---- |
|  **TileBasedComposition** mode    | In this mode, every involved GPU renders specific tiles for display on the screen. The main GPU composes the final image using these tiles before Azure sends it as a video frame to your client device. The rendering quality of **TileBasedComposition** mode is slightly better than in **DepthBasedComposition** mode. |
|  **DepthBasedComposition** mode    | In this mode, every involved GPU renders at full-screen resolution, but only a subset of meshes. The final image composition on the main GPU helps ensure that<!--Andy, could we reword the "takes care that"? Is this edit OK?--> parts are properly merged according to their depth information.     |

> [!NOTE]
> You specify the remote rendering mode when you connect to your session.

## Client SDK

After the frames arrive on your device, they're composited with any local holograms that you might have in your image. This provides a truly hybrid rendering experience that enables you to mix and match both remote and local holograms. This means that you only have to render the remote objects that have a higher polygon count.

> [!TIP]
> For things like menus and smaller models, keep them local.
