Remote rendering requires a 3D model and a session which manages the tasks involved for interacting with the cloud server. In the truck engine design example, a session would be created to enable viewing the engine model and query information about the scene. Here, you will learn how to manage a session, convert models, and load models for rendering.

## Create a session

Only a single device may connect to a session at a time. The following command creates a new session:

```csharp
Invoke-WebRequest -Uri "$endPoint/v1/accounts/$accountId/sessions/create" -Method Post -ContentType "application/json" -Body "{ 'maxLeaseTime': '4:0:0', 'models': [], 'size': 'standard' }" -Headers @{ Authorization = "Bearer $token" }
```

The response from the request returns a **sessionID**. The **sessionID** persists for 30 days and is used to query information about the session. When you create a new session, you can specify a maximum lease time, typically in the range of one to eight hours. The maximum release time is reflected in the **maxLeaseTime** value. This is the duration during which the host will accept your input. If necessary, you can extend the lease time of an active session.

## Connect to a session

Once the session is ready, you can connect to it. While connected, the device can send commands to load and modify models. Every Azure Remote Rendering host only ever serves one client device at a time, so when a client connects to a session, it has exclusive control over the rendered content. That also means that rendering performance will never vary for reasons outside of your control.

You can create, observe and shut down as many sessions as you like from a single application. Given that only one device can connect to a session at a time, attempts by other devices to connect will fail. Only after a session stops can another device connect to the session.

## Stop a session

The session can be stopped either manually or when the maximum lease time expires. To manually stop a session, ``RenderingSession.StopAsync`` must be called. The session may also be stopped because of some failure. In any case, once the session stops, you are no longer billed for the service. Furthermore, when a session stops, all previous state (loaded models and such) is discarded.

However, after a session stops the persistent **sessionID** can be queried via ``RenderingSession.SessionUuid()`` and cached locally. With this ID, an application can call ``RemoteRenderingClient.OpenRenderingSessionAsync`` to bind to that session. When ``RenderingSession.IsConnected`` is true, ``RenderingSession.Connection`` returns an instance of ``RenderingConnection``, which contains the functions to load models, manipulate entities, and query information about the rendered scene.

## Models

A model in Azure Remote Rendering refers to a full object representation, made up of entities and components. Models are the main way to get custom data into the remote rendering service. The renderer on the server requires the model to be in a proprietary format.  Thus, creating models for runtime is achieved by converting input models from file formats such as FBX and GLTF. The conversion process extracts all the resources, such as textures, materials and meshes, and converts them to optimized runtime formats. It will also extract the structural information and convert that into Azure Remote Rendering's entity/component graph structure. 

Conversion is achieved in one of three ways:

- The Azure Remote Rendering Tool (ARRT)
- A PowerShell Script
- API calls

An Azure Blob storage resource is required for conversion. Models are consumed from Azure Blob Storage and the service writes converted models back to a provided Azure Blob Storage container.

Once a model is converted, it can be loaded from Azure Blob Storage into the runtime. You can load models with one of two functions:
- ``LoadModelAsync`` with parameter ``LoadModelOptions``
- ``LoadModelFromSasAsync`` with the parameter ``LoadModelFromSaSOptions``

``LoadModelAsync`` addresses the model by blog storage parameters directly, in case the blog storage account is linked. ``LoadModelFromSasAsync`` enables you to address the model by its SaS URI. This variant is used when loading built-in models. Alternately, you can load a model using a SaS token.

Loading the same model multiple times creates multiple instances, each with their own copy of the entity/component structure. Since meshes, materials, and textures are shared resources, their data will not be loaded again. Therefore instantiating a model more than once incurs relatively little memory overhead.

> [!TIP]
> The Khronos Group maintains a set of glTF sample models for testing. ARR supports the glTF format both in text (.gltf) and in binary (.glb) form. We suggest using the PBR models for best visual results. To learn more, refer to the repository available in the module Resources.

## Rendering models

Remote Rendering offers two main modes of operation:
-  ``TileBasedComposition``
-  ``DepthBasedComposition``

These modes determine how the workload is distributed across multiple GPUs on the server. The mode has to be specified at connection time and cannot be changed during runtime. 

The rendering quality in ``TileBasedComposition`` mode is slightly better since multisample anti-aliasing (MSAA) can work on a full set of geometry for every GPU. 

:::image type="content" source="../media/tile-based-composition.png" alt-text="A screenshot of objects in an 3D environment rendered in tile based composition mode. The render quality of the models reflects is significantly detailed. ":::

In ``DepthBasedComposition`` mode, every involved GPU renders at full screen resolution but only a subset of meshes. Every single GPU uses MSAA to antialias local content. Although the final image is post-processed, MSAA quality is still worse than in ``TileBasedComposition`` mode.

:::image type="content" source="../media/depth-based-composition.png" alt-text="A screenshot of 3 D objects rendered in depth based composition mode. The render quality of the models is not distinctively detailed.":::