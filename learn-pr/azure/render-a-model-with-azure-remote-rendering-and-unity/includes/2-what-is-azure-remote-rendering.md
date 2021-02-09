In scenarios where every detail matters—industrial plant management, design review for assets like truck engines, pre-operative surgery planning, and more—3D visualization brings that detail to life. It's what helps designers, engineers, doctors, and students better understand complex information and make the right call.

However, untethered devices have limited computational power for rendering complex models. Although you could potentially reduce the quality of a model, this simplification can result in a loss of important detail that's needed in key business and design decisions.

Azure Remote Rendering (ARR) solves this problem by moving the rendering workload to high-end GPUs in the cloud. A cloud-hosted graphics engine renders the image, encodes it as a video stream, and streams the image in real time to devices, such a HoloLens 2. Not only can a user view the model, they can interact with the model as well.

## Quality

A traditional approach to viewing 3D content on untethered devices is called decimation, which compresses the models and removes polygons. This simplifies the model to a point where it can run on slower GPU hardware. The following example provides a side-by-side comparison of an engine model at full detail and a decimated model.

:::image type="content" source="../media/engine-model-decimated.png" alt-text="A screenshot of two engine models. The engine model on the left is at full detail. The engine model on the right is decimated.":::

The reduced model consists of approximately 200,000 triangles (including the detailed inner parts), versus more than 18 million triangles in the original model.  With Azure Remote Rendering, you're able to render hundreds of millions of polygons and stream to mixed reality devices with low latency.

Some models are too complex to render at interactive frame rates, even for a high-end GPU. In this case, Azure Remote Rendering can distribute the workload to multiple GPUs. The results are merged into a single image, making the process entirely transparent to the user.

## Hybrid rendering

Most likely, your application requires some variation of custom UI to provide functionality to users. Azure Remote Rendering supports **Hybrid Rendering** which automatically combines locally rendered content with the remote image at the end of a frame. The flexibility to use your desired UI enables you to create suitable UI for your application without limiting yourself to a dedicated UI framework.