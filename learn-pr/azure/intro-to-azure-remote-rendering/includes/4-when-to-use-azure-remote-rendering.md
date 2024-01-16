In this unit, you'll evaluate whether Azure Remote Rendering is suitable for your organizational needs. The criteria you'll consider are:

- Complexity of your 3D models.
- Required visual fidelity for images.

## Decision criteria

| Criteria                | Analysis                                                     |
| ----------------------- | ------------------------------------------------------------ |
| Complex 3D models       | If you have 3D models that are too large to view locally on your device, consider using Azure Remote Rendering. Azure Remote Rendering enables you to render the models remotely and view them locally on your device. |
| High fidelity images | Complex 3D models that must be high quality require significant processing power to achieve the required level of visual fidelity. Azure Remote Rendering can provide sufficient GPU power for your requirements. |

To work with Azure Remote Rendering, you'll also need:

- A HoloLens 2.
- A high-bandwidth, low-latency internet connection.

## Apply the criteria

Consider using Azure Remote Rendering when you meet the following criteria:

- You have highly detailed, complex 3D content.
- You require a high level of visual fidelity.

### Example of when to use

Imagine you're building an application for an automotive manufacturing company. The company is designing a new engine. They have a 3D model that represents the new engine. They want to view it in their HoloLens 2 to study how the engine will fit together and review recent changes. However, the model is too large to view locally on the HoloLens 2, so the company's engineers still need a way to view it in 3D.

In this situation, Azure Remote Rendering can help, because the company has:

- Complex 3D content requiring a high level of visual fidelity.
- A HoloLens 2.
- Access to a high-bandwidth, low-latency internet connection.

### Example of when not to use

Imagine you're building an application for the same automotive manufacturing company. The company wants to teach their engineers how to use specific manufacturing tools for the new engine. The 3D models of these tools are basic and don’t require much visual detail. Because the models aren't complex, you can render them locally on the device.

In this situation, Azure Remote Rendering is unhelpful, because the company has simple 3D content that doesn't require high visual fidelity.
