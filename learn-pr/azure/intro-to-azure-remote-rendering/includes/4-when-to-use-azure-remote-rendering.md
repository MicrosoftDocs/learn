In this unit, you'll evaluate whether Azure Remote Rendering is suitable for your organizational needs. The criteria you'll consider are:

- Complexity of 3D models
- Required visual fidelity of images

## Decision criteria

| Criteria                | Analysis                                                     |
| ----------------------- | ------------------------------------------------------------ |
| Complex 3D models       | If you have 3D models that you want to view that are too large to view locally on your device, consider using Azure Remote Rendering. Azure Remote Rendering enables you to render the models remotely and view them locally on your device. |
| High fidelity of images | If you're working with complex 3D models that must have very high quality, you'll need a lot of processing power to achieve the required level of visual fidelity. Azure Remote Rendering can provide sufficient GPU power for your requirements. |

Note that in order to work with Azure Remote Rendering, you'll also need:

- A HoloLens 2
- A high-bandwidth, low-latency internet connection

## Apply the criteria

Consider using Azure Remote Rendering when you meet the following criteria:

- You have very detailed, complex 3D content.
- You require a high level of visual fidelity.

### Example of when to use

Imagine you're building an application for an automotive manufacturing company. The company is designing a new engine. They have a 3D model that represents the new engine, and they want to view it in their HoloLens 2. This will help them to fully understand how the engine will fit together, and review any recent changes. However, the model is too large to view locally on the HoloLens 2, and the company's engineers still need a way to see it in 3D.

In this situation, Azure Remote Rendering will help because the company has:

- Complex 3D content requiring a high level of visual fidelity
- A HoloLens 2
- Access to a high-bandwidth, low-latency internet connection

### Example of when not to use

Imagine you're building an application for the same automotive manufacturing company. The company wants to teach their engineers how to use specific manufacturing tools for the new engine. The 3D models of these tools are very basic and don’t require much visual detail. Because the models are not complex, you can render them locally on the device.

In this situation, Azure Remote Rendering is not helpful because the company has simple 3D content that requires only a low level of visual fidelity.
