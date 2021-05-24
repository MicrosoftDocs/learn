<!--
Editors: The use of visual and viewing is acceptable IMO as a non sighted person cannot use this technology. We're also using a tool which is specifically designed to enable a visual through a device which is designed for a sighted person. Global across all units. 

-->
Standalone computing devices (sometimes referred to as *untethered devices*) have limited compute processing power. This limitation can affect your ability to render complex visual models. One possible solution is to reduce the required complexity through a process called *decimation*. Decimation can be time-consuming and removes detail from the model. For many applications, reducing the visual fidelity is not acceptable.

Remote Rendering enables you to address this dilemma. You can use cloud-based processing to render complex models to the desired visual fidelity without compromise<!-- "without compromise" is awkward, unclear. How about "without compromising their quality"? -->. Azure Remote Rendering is a mixed reality Azure service that enables you to render high-quality, interactive 3D content in Azure. You can then stream this rendered content in real time to devices such as HoloLens 2.

## Example scenario

Suppose you work for an automotive manufacturer. You have a highly complex 3D model that you need to view in HoloLens 2. You've learned that the computing resource available in your local device is insufficient to render the model to the desired detail quickly enough. You must either scale down the detail or increase the available compute resources. By using Azure Remote Rendering, you can render the model to the desired detail level for display on your device.

:::image type="content" source="../media/arr-engine.png" alt-text="An internal combustion engine with its internal detail exposed.":::

## What will we be doing?

By the end of this module, you'll be able to explain how Azure Remote Rendering can render images, encode them, and stream them to target devices. You'll evaluate whether Azure Remote Rendering, a cloud-hosted service, can help you complete complex rendering workloads.

## What is the main goal?

The main goal is to determine how Azure Remote Rendering can help you render and live-stream complex models to the desired visual fidelity without compromise.<!--If you expanded this thought "without compromise" above, readers will understand exactly what you mean here. No adjustment needed. -->
