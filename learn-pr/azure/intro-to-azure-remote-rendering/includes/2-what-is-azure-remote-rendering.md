When you work with 3D visualization, every detail can matter. However, untethered devices often have insufficient compute resources to render more complex models to the required detail level. By using Azure Remote Rendering, you shift your rendering workloads to high-performance GPUs in Azure.

In Azure, a cloud hosted service:

- Renders your image.
- Encodes the image as a video stream.
- Streams the image to your device in real time.

> [!NOTE]
> You can not only view the rendered model, you can also interact with it.

## What is decimation?

3D models are comprised of polygons. *Decimation* is a process that compresses a model and removes polygons, so the model doesn't render in full detail. When viewing content on untethered devices, you might choose to use decimation to simplify your 3D models by removing polygons from them.

> [!NOTE]
> Decimation simplifies your models to the level required to be able to render on your hardware.

However, this approach reduces the quality of the resulting models. The following graphic displays a rendered model of an internal combustion engine and demonstrates decimation. The image comprises approximately 200,000 triangles. The image is not of a sufficient quality for desired applications, such as a 3D design review or factory layout visualization.

:::image type="content" source="../media/engine-model1.png" alt-text="An image of an internal combustion engine. The image is rendered using decimation.":::

## Azure Remote Rendering definition

Azure Remote Rendering is a cloud service that enables you to render GPU-demanding, interactive 3D content. With Azure Remote Rendering, you can:

- Render hundreds of millions of polygons.
- Stream to mixed-reality devices with low latency.

> [!TIP]
> Even for a high-end GPU, some models can be too complex to render at interactive frame rates. In these situations, Azure Remote Rendering distributes your workload across multiple GPUs. It then merges the results into a single image. This process is transparent to the user.

The following table describes the key features of Azure Remote Rendering, and how you can benefit from them.

| Feature                        | Description                                                  |
| :----------------------------- | ------------------------------------------------------------ |
| Remote rendering               | Enables devices limited by compute or power to render complex, high-polygon count models. You can implement this capability in many industries that use 3D models, supporting scenarios such as design reviews, layout planning, and teaching. This is the primary capability. |
| Hybrid rendering               | Enables you to merge local and remotely rendered content. This means that the application with remote rendering can combine local holograms and remote holograms. This enables you to choose to render some content locally, and more demanding content remotely. For example, content such as menus and instructions can be rendered locally while the complex 3D model can be streamed in with remote rendering. |
| Familiar interactions          | Enables you to interact with remote objects in the same way you do with local objects. |
| Software development kit (SDK) | Provides a powerful and simple-to-use SDK that enables you to integrate remotely rendered content into your existing apps. |


## How Azure Remote Rendering can remove the need for decimation 

By using Azure Remote Rendering, you can:

- Remove the need for decimation when working with complex 3D models.
- Shift your complex rendering workloads to Azure to take advantage of high performance GPUs.
- Distribute complex workloads across multiple GPUs.

Using Azure Remote Rendering can help improve model detailing and quality. The following graphic displays a rendered model of an internal combustion engine, and demonstrates the benefit of avoiding decimation. The image is rendered with 18 million triangles to create the detail required.

:::image type="content" source="../media/engine-model2.png" alt-text="A graphic depicting an image of an internal combustion engine. The image is rich with detail and looks almost real.":::
