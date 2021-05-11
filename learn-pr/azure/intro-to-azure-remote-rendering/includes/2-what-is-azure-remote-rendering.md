<!-- 1. Topic sentence(s) ---------------------------------------------------------------

    Goal: briefly state that this unit will define the product.
    
    Heading: do not add an H1 or H2 title, an auto-generated H1 "What is <product>?" will appear above this content.
    
    Example: "Let's start with a few definitions and a quick tour of the core features of Logic Apps. This overview should help you see whether Logic Apps might be a good fit for your work."
-->

When you work with 3D visualization, every detail can matter. But untethered devices often have insufficient compute resource to render more complex models to the required detail level. By using Azure Remote Rendering, you shift your rendering workloads to high performance GPUs in Azure. In Azure, a cloud hosted graphics engine:

- Renders your image
- Encodes the image as a video stream
- Streams the image to your device in real time

> [!NOTE]
> You can not only view the rendered model, you can also interact with it.

## What is decimation?

<!-- 2. Background-concept definitions (optional) ----------------------------------------

    Goal:
        Define any needed underlying concepts or terms the learner must know to understand the product.
        Repeat this pattern multiple times if multiple concepts are needed.
    
    Heading:
        "What is <concept>?"
    
    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<concept> is..." (ensure this is a definition, do not give use cases like "<concept> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, blockquote, code sample, or list (image preferred).
    
    Example:
        (Note: the product "Logic Apps" implements business processes in the cloud; therefore, "business process" is a background concept.)
        Heading: "What is a business process?
        Lead sentence: "A business process or _workflow_ is a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification...."
-->

When viewing content on untethered devices, you might choose to use *decimation*. Decimation can simplify your 3D models by compressing them. Essentially, decimation removes polygons from your models.

> [!NOTE]
> Decimation simplifies your models to the level required to be able to render on your hardware.

But this approach reduces the quality of the resulting models. The following graphic displays a rendered model of an internal combustion engine, and demonstrates decimation. The image comprises a only 200,000 triangles. The image is not of a sufficient quality for the desired application. 

:::image type="content" source="../media/engine-model1.png" alt-text="A graphic depicting an image of an internal combustion engine. The image is rendered using decimation.":::

## Azure Remote Rendering definition

<!-- 3. Define the product -------------------------------------------------------------

    Goal:
        Give a formal and precise definition of the product.
    
    Heading:
        "<product> definition"
    
    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "<product> is..." (ensure this is a definition, do not give use cases like "<product> lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, blockquote, code sample, or list (image preferred).
    
    Example:
        Heading: "Azure Logic Apps definition
        Lead sentence: "Azure Logic Apps is a cloud service that automates the execution of your business processes."
-->

Azure Remote Rendering is a cloud service that enables you to render GPU-demanding, interactive 3D content. With Azure Remote Rendering, you can:

- Render hundreds of millions of polygons 
- Stream to mixed reality devices with low latency

> [!TIP]
> Even for a high-end GPU, some models can be too complex to render at interactive frame rates. In these situations, Azure Remote Rendering distributes your workload across multiple GPUs. It then merges the results into a single image. This process is transparent to the user.

The following table describes the key features of Azure Remote Rendering, and how you can benefit from them.

| Feature                        | Description                                                  |
| :----------------------------- | ------------------------------------------------------------ |
| Remote rendering               | Enables devices limited by compute or power to render complex, high-polygon count models. You can implement this capability in many industries that use 3D models, supporting scenarios such as design reviews, layout planning, and teaching. This is the primary capability. |
| Hybrid rendering               | Enables you to merge local and remotely rendered content. This means that the application with remote rendering can combine local holograms and remote holograms. This enables you to choose to render some content locally, and more demanding content remotely. For example, content like menus and instructions can be rendered locally while the complex 3D model can be streamed in with remote rendering. |
| Familiar interactions          | Enables you to interact with remote objects in the same way you do with local objects. |
| Software development kit (SDK) | Provides a powerful and simple to use SDK that enable you to integrate remotely rendered content into your existing apps. |


## How to reduce decimation 

<!-- 4. Solve the scenario -------------------------------------------------------------

    Goal:
        At a high level, describe how the <product> solves the <scenario>.
        Avoid the details of how a practitioner would actually do the work (you're not teaching them to use <product>).
    
    Heading:
        "How to <solve scenario>"
    
    Pattern:
        1. H2 heading.
        2. Lead sentence that summarizes how the <product> solved the <scenario>.
        3. Additional text as needed (typically 1-2 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, blockquote, code sample, or list (image preferred).
    
    Example:
        Heading: "How to implement a Twitter monitor"
        Lead sentence: "To implement a Twitter monitor, you map each task to a Logic Apps component and connect them with conditional logic."
-->

By using Azure Remote Rendering, you can:

- Reduce decimation when working with complex 3D models.
- Shift your complex rendering workloads to Azure to take advantage of high performance GPUs. 
- Distribute complex workloads across multiple GPUs. 

Using Azure Remote Rendering can help improve model detailing and quality. The following graphic displays a rendered model of an internal combustion engine, and demonstrates the benefit of avoiding decimation. The image is rendered with 18 million triangles to create the detail required. 

:::image type="content" source="../media/engine-model2.png" alt-text="A graphic depicting an image of an internal combustion engine. The image is rich with detail and looks almost real.":::

