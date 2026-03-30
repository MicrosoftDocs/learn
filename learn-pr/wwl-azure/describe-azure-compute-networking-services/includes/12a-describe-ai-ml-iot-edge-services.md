Azure includes service categories that help you build intelligent and connected solutions without starting from scratch.

## Azure AI services

Azure AI services provides prebuilt capabilities for common AI scenarios, such as language, speech, vision, and document processing. These services are useful when you want to add intelligent features through APIs instead of training your own model first.

Azure OpenAI Service is another AI option in Azure that supports generative AI scenarios, such as chat and content generation, with built-in security and governance controls.

## Agentic AI patterns

Agentic applications combine an AI model with instructions, context, and tool use to complete multistep goals. In Azure, you usually build these patterns by combining Azure AI services and Azure OpenAI Service with your own application logic.

At a fundamentals level, treat agentic AI as an application pattern built from Azure AI capabilities, not as a separate compute service category.

## Azure Machine Learning

Use Azure Machine Learning when you need to build, train, and manage custom machine learning models. This option is a better fit when your scenario requires model development, experimentation, and lifecycle management.

## IoT and Edge services

Azure IoT services help you connect, monitor, and manage devices.

 -  Azure IoT Hub enables secure, bi-directional communication between cloud services and IoT devices.
 -  Azure IoT Central provides a simplified software as a service (SaaS) IoT platform for solution builders.
 -  Azure IoT Edge extends cloud capabilities to edge devices so some workloads can run closer to where data is generated.

This flow commonly starts with devices sending telemetry through IoT Hub, then uses cloud analytics to generate insights and model updates that IoT Edge runtime applies near the devices. IoT Central can simplify solution management for these connected-device scenarios.

:::image type="content" source="../media/ai-ml-iot-edge-telemetry-path.png" alt-text="Diagram showing devices sending telemetry through IoT Hub to cloud analytics and IoT Edge runtime for local processing.":::

## Choosing the right option

At a fundamentals level, use this decision pattern:

:::image type="content" source="../media/ai-ml-iot-edge-decision-triad.png" alt-text="Decision triad: AI services, Azure ML, and IoT services.":::

 -  Use Azure AI services when you need prebuilt AI features exposed through APIs.
 -  Use Azure Machine Learning when you need custom model development and management.
 -  Use Azure IoT services when your solution centers on connected devices and telemetry.

