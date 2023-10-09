When you work with 3D visualization, every detail matters. However, untethered devices often have insufficient compute resources to render more complex models to the required level of detail. When you use Azure Remote Rendering, you shift your rendering workloads to high-performance GPUs in Azure. In Azure, a cloud hosted service:

- Renders your image.
- Encodes the image as a video stream.
- Streams the image to your device in real time.

> [!NOTE]
> You can interact with the rendered model in addition to viewing it.

## What is decimation?

3D models can be made up of polygons. *Decimation* is a process that compresses a model by removing its polygons, which means the model won't render in full detail. You might choose to simplify your 3D models using decimation when you're viewing content on untethered devices.

> [!NOTE]
> Decimation simplifies your models to the level required for rendering on your hardware.

Unfortunately, this approach reduces the quality of the resulting models. The following graphic displays a rendered model of an engine and demonstrates decimation. The image has approximately 200,000 triangles. The image quality is insufficient for desired applications, such as a 3D design review or factory-layout visualization.

:::image type="content" source="../media/engine-model-1.png" alt-text="Illustration of an engine rendered using decimation.":::

## Azure Remote Rendering definition

Azure Remote Rendering is a cloud service that enables you to render GPU-intensive, interactive 3D content. With Azure Remote Rendering, you can:

- Render hundreds of millions of polygons.
- Stream to mixed-reality devices with low latency.

> [!TIP]
> Even for a high-end GPU, some models might be too complex to render at interactive frame rates. If this is the case, Azure Remote Rendering distributes your workload across multiple GPUs. It then merges the results into a single image. This process is transparent to the user.

The following table describes the key features of Azure Remote Rendering and how you can benefit from them:

| Feature                        | Description                                                  |
| :----------------------------- | ------------------------------------------------------------ |
| Remote rendering               | Enables devices limited by compute or power to render complex, high-polygon count models. You can use this capability in industries that use 3D models for scenarios such as design reviews, layout planning, and teaching. Remote rendering is the primary capability. |
| Hybrid rendering               | Enables you to merge local and remotely rendered content. The application with remote rendering can combine local holograms and remote holograms. You can render some content locally and more demanding content remotely. For example, you can render content such as menus and instructions locally while using remote rendering to stream in complex 3D models. |
| Familiar interactions          | Enables you to interact with remote objects the same way you do with local objects. |
| Software development kit (SDK) | Provides a powerful and simple-to-use SDK that enables you to integrate remotely rendered content into your existing apps. |

## How Azure Remote Rendering can remove the need for decimation

By using Azure Remote Rendering, you can:

- Remove the need for decimation when working with complex 3D models.
- Shift your complex rendering workloads to Azure to take advantage of high-performance GPUs.
- Distribute complex workloads across multiple GPUs.

Using Azure Remote Rendering can improve model detailing and quality. The following graphic displays a rendered model of an engine and demonstrates the benefit of avoiding decimation. The image is rendered with 18 million triangles to create the detail required.

:::image type="content" source="../media/engine-model-2.png" alt-text="An image of an engine. The image is rich with detail and looks almost real.":::
