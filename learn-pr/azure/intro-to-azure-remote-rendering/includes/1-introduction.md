Standalone computing devices (sometimes referred to as *untethered devices*) have limited compute processing power, which can affect your ability to render complex visual models. To overcome this limitation, you could reduce the complexity through a process called *decimation*. However, decimation can be time-consuming, and it removes detail from the model. For many applications, reducing the visual fidelity isn't acceptable.

Remote Rendering addresses this dilemma. You can use cloud-based processing to render complex models to the desired visual fidelity without compromising their quality. Azure Remote Rendering is a mixed-reality service that lets you render high-quality, interactive 3D content. You can then stream this rendered content in real time to devices such as HoloLens 2.

## Example scenario

Suppose you work for an automotive manufacturer. You have a complex 3D model that you want to view in 3D using HoloLens 2. Viewing the car engine in its full detail will allow you to ensure all the parts of the engine come together. Unfortunately, the computing resource available on your device is insufficient to render the model to the desired detail. You have two choices: scale down the complexity of the 3D model through decimation, or increase the available compute resources. By using Azure Remote Rendering, you can use cloud resources to render the model without losing valuable detail.

:::image type="content" source="../media/arr-engine.png" alt-text="Rendering of an internal combustion engine with its internal detail exposed.":::

## What will we be doing?

By the end of this module, you'll be able to explain how Azure Remote Rendering can render and encode images, and stream them to target devices. You'll evaluate whether Azure Remote Rendering, a cloud-hosted service, can help you complete complex rendering workloads.

## What is the main goal?

The main goal is to determine how Azure Remote Rendering can help you render and stream complex models to the desired visual fidelity without compromise.
