Windows 11 Pro uses multiple execution models to deliver intelligent experiences. Rather than relying on a single processing approach, Windows dynamically selects where work runs based on the requirements of each task.

At a high level, Windows supports two primary execution models:

- **Cloud-based execution**, where processing occurs in Microsoft's cloud
- **On-device execution**, where processing runs locally on the PC using specialized hardware such as a Neural Processing Unit (NPU)

Understanding these execution models helps explain:

- Where processing takes place
- What types of tasks each model is best suited for
- How Windows blends local and cloud capabilities

:::image type="content" border="true" source="../media/cloud-neural-processing-unit-comparison.svg" alt-text="A flowchart showing Windows 11 Pro sending user actions to either cloud AI for reasoning or on-device NPU for fast local tasks.":::

## Cloud-based execution

Cloud-based execution relies on AI and compute services hosted in Microsoft's cloud. When a user initiates a task that requires deeper reasoning, broader context, or extended processing time, Windows can route that work to cloud services optimized for those scenarios.

Cloud-based execution is well suited for tasks that involve:

- **Reasoning and synthesis** across multiple inputs or data sources
- **Multi-step workflows** that run over time rather than completing instantly
- **Access to organizational data and permitted web information**
- **Scalable processing**, where complexity exceeds what's practical on a local device

Since cloud-based execution runs on continuously updated services, capabilities can improve over time without requiring changes to the Windows client or device hardware.

## NPU-based (on device) AI experiences

On-device execution runs locally on supported Windows PCs using a Neural Processing Unit (NPU). An NPU is a specialized processor designed to handle AI workloads efficiently without relying on cloud connectivity.

:::image type="content" border="true" source="../media/neural-processing-unit.png" alt-text="A depiction of a Neural Processing Unit, or NPU":::

On-device execution is optimized for scenarios where:

- **Low latency and responsiveness** are critical
- **Power efficiency** is important, especially on mobile devices
- **Real-time processing** is required, such as audio, video, or accessibility enhancements
- **Offline operation** is needed for supported features

These experiences run directly on the device, minimizing data transfer, and helping preserve battery life. NPU-based execution is commonly associated with Copilot+ PCs, which include dedicated AI hardware.

## How Windows 11 Pro blends execution models

Windows 11 Pro is designed to combine cloud-based and on-device execution, selecting the most appropriate model for each task.

| **Execution model** | **Runs where** | **Best suited for** | **Internet required** | **Power usage** |
| :--- | :--- | :--- | :--- | :--- |
| Cloud-based | Microsoft cloud | Reasoning, research, synthesis | Yes | Not device-dependent |
| On-device (NPU) | On the PC | Real-time and system features | No (for supported features) | Optimized for battery |

By supporting both models, Windows can deliver AI experiences that are:

- **Responsive** when speed matters
- **Powerful** when deeper reasoning is required
- **Adaptable** across different device types and configurations

Not all Windows 11 PCs include NPU hardware. To ensure broad access to advanced capabilities, Microsoft continues to expand cloud-based execution so that intelligent experiences are available across the Windows ecosystem.
