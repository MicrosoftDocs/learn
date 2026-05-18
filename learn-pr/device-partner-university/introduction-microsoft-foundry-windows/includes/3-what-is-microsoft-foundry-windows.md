Microsoft Foundry on Windows is a unified AI development platform that enables developers to build, customize, and deploy AI-powered applications that run locally on Windows devices while also supporting hybrid scenarios that connect to cloud services.

:::image type="content" source="../media/microsoft-foundry-on-windows-architecture.svg" alt-text="High-level architecture diagram showing Windows applications using Microsoft Foundry on Windows components—Windows AI APIs, Foundry Local, and Windows ML—running across CPU, GPU, and NPU hardware.":::

The platform brings together multiple technologies designed to simplify how AI applications are developed and deployed across Windows hardware. Instead of requiring developers to manage separate tools for models, hardware acceleration, and deployment, Microsoft Foundry on Windows provides an integrated stack that supports the full AI development lifecycle.

This unified approach allows developers to experiment with models, integrate AI features into applications, and deploy solutions that run efficiently across a wide range of Windows devices.

## A platform for local and hybrid AI development

Many modern AI solutions rely on both device and cloud capabilities. Large-scale model training and massive datasets are typically handled in the cloud, while certain AI workloads—such as real-time processing or privacy-sensitive tasks—are better suited to run directly on the device.

Microsoft Foundry on Windows supports this hybrid model by enabling developers to run AI workloads locally while still connecting to cloud services when needed. Developers can build applications that combine on-device intelligence with cloud-based capabilities, allowing them to optimize performance, cost, and scalability.

This approach gives developers flexibility when designing AI solutions. Some workloads may run entirely on the device, others may rely heavily on cloud infrastructure, and many applications will combine both approaches depending on the requirements of the scenario.

## Supporting the AI developer lifecycle

Microsoft Foundry on Windows supports the full lifecycle of AI application development, from experimentation to deployment.

Developers can explore and experiment with models, integrate AI capabilities into applications, and deploy solutions that run efficiently across different hardware configurations. Because the platform is designed for Windows, developers can rely on consistent APIs, runtime environments, and hardware acceleration across supported devices.

This consistency reduces the complexity of building AI-powered applications and allows developers to focus on designing intelligent experiences rather than managing infrastructure.

## Core platform components

Microsoft Foundry on Windows is built as a layered platform. Each layer addresses a different developer need and provides a different level of flexibility when integrating AI into applications.

Together, these layers enable developers to choose the approach that best fits their scenario—from simple AI features to fully customized AI models.

The platform includes three primary components:

- **Windows AI APIs**  
- **Foundry Local**  
- **Windows ML**  

Each component plays a different role in enabling AI development on Windows.

| Component | Primary purpose | Typical use |
|----------|-----------------|-------------|
| Windows AI APIs | Built-in task-based AI capabilities | Common AI features such as text and image processing |
| Foundry Local | Local execution of open-source models | Greater flexibility beyond inbox models |
| Windows ML | Runtime for custom models | Deploying and scaling proprietary or custom AI models |

## Windows AI APIs

[Windows AI APIs](/windows/ai/overview) provide the fastest and easiest way for developers to add AI capabilities to Windows applications.

These APIs allow developers to integrate capabilities such as:

- Text summarization and rewrite 
- Optical character recognition (OCR)  
- Image segmentation  
- Image and video super resolution  

Because these models are optimized for Windows devices, developers can add AI features without managing model deployment or infrastructure.

## Foundry Local

[Foundry Local](/windows/ai/foundry-local/get-started) enables developers to run open-source AI models directly on Windows devices.

Developers can access curated model catalogs and use tools such as command-line interfaces (CLI) and Software development kits (SDKs) to manage and run models locally.

This approach provides flexibility while ensuring models are optimized for Windows hardware.

## Windows ML

[Windows ML](/windows/ai/new-windows-ml/overview) provides a runtime environment that enables custom AI models to run efficiently across Windows hardware.

Windows ML integrates with ONNX Runtime and provides hardware abstraction across CPUs, GPUs, and NPUs.

This allows developers to deploy AI models across multiple hardware configurations without maintaining separate implementations for each vendor.

Together, these components form a unified platform that supports AI development across the Windows ecosystem.

> [!NOTE]
> ONNX Runtime is a high-performance inference engine that runs machine-learning models efficiently after they are converted to the Open Neural Network Exchange (ONNX) format. It enables fast, hardware-accelerated execution across CPUs, GPUs, and NPUs.

## How the platform layers work together

Microsoft Foundry on Windows uses a layered approach that allows developers to integrate AI capabilities at different levels, depending on application requirements.

The next section explores how these components operate within the platform architecture.