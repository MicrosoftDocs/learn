In earlier sections, you learned what an NPU is and how Copilot+ PCs use it to power real-world business scenarios. This section takes a closer look at *why* the NPU is a significant shift in PC architecture—and what it means for the future of Windows as a platform for AI.

## Seeing the difference: CPU vs. GPU vs. NPU

To understand why the NPU matters, it helps to see how all three processors handle the same AI task.

In the following demonstration, an AI model was asked to identify and count faces in a live video feed. The same task was run on a CPU, a GPU, and an NPU.

:::image type="content" border="true" source="../media/processor-speed.gif" alt-text="Illustrative comparison of image loading speeds on an NPU, GPU, and CPU.":::

All three processors completed the task—but the results were different:

| Processor | Speed | Energy use | Heat generated |
|---|---|---|---|
| **CPU** | Slowest | Highest | Most |
| **GPU** | Moderate | Moderate | Moderate |
| **NPU** | Fastest | Lowest | Least |

The NPU completed the task faster while generating less heat and using less energy. This efficiency is what enables Copilot+ PCs to run AI features continuously—like Live Captions or Windows Studio Effects during a video call—without draining battery life or slowing down other applications.

> [!TIP]
> This demonstration illustrates a key concept: the NPU isn't faster at AI tasks—it's more *efficient*. In a business context, efficiency means employees can use AI features throughout the workday without carrying a charger or closing other apps to free up resources.

## How on-device AI changes the computing model

Traditionally, AI processing has relied on cloud-based services—sending data to a remote server, processing it there, and returning the results. This approach works well for many scenarios, but it introduces latency, requires an internet connection, and means sensitive data leaves the device.

The NPU in Copilot+ PCs enables a different model: **on-device AI processing**. With an NPU capable of 40+ TOPS, many AI tasks can run locally—directly on the hardware—without sending data to the cloud. In many real-world workflows, AI processing happens in a hybrid model. Some tasks run locally on the device using the NPU for speed, privacy, or offline access, while more complex requests rely on cloud-based AI services. Copilot+ PCs are designed to support this approach by balancing on-device intelligence with cloud processing as needed.

| Processing model | How it works | Best suited for |
|---|---|---|
| **Cloud-based AI** | Data is sent to a remote service for processing and results are returned over the internet | Complex tasks requiring large models, cross-organizational data queries, scenarios where internet is available |
| **On-device AI** | Data is processed locally on the NPU without leaving the device | Low-latency tasks, offline scenarios, privacy-sensitive workloads, real-time features like captions and video effects |
| **Hybrid AI** | Some tasks run locally on the NPU while others are handled by cloud services, depending on the workload | Organizations that need both real-time on-device features and cloud-powered intelligence like Microsoft 365 Copilot |

Copilot+ PCs support all three models. On-device features like Live Captions, Windows Studio Effects, and Click to Do run on the NPU. Cloud-based features like Microsoft 365 Copilot use cloud processing. Many workflows combine both—for example, using on-device search to find a local file, then using Microsoft 365 Copilot to summarize its contents.

## Windows as a platform for AI

The NPU is part of a broader shift in how Windows supports AI across the organization. Windows 11 Pro serves as the platform that connects on-device AI capabilities with cloud-based intelligence and IT management tools.

This platform approach includes:

- **On-device AI processing** through the NPU, enabling faster response times and reducing dependency on cloud connectivity for supported features.
- **AI agents within Windows** that can reason, plan, and take actions on behalf of users—such as configuring device settings through natural language or suggesting next steps based on on-screen content.
- **Windows AI Foundry** for building custom AI-powered applications that take advantage of local hardware acceleration alongside cloud services.
- **IT governance and control** through Microsoft Intune, allowing organizations to manage which AI capabilities are available and how agents interact with organizational data.

> [!IMPORTANT]
> AI agents in Windows operate within the organization's existing management and security framework. IT administrators can govern agent behavior and data access through the same tools used to manage other Windows 11 Pro policies and configurations.

## What this means for organizations

The combination of on-device AI, cloud intelligence, and platform governance creates a practical model for organizations adopting AI at scale:

- **Employees** get faster, more responsive AI features that work even without an internet connection—improving productivity in the field, during travel, or in low-connectivity environments.
- **IT teams** maintain control over AI capabilities through familiar management tools, with security features enabled by default and agent behavior governed at the policy level.
- **Developers** can build custom AI solutions using Windows AI Foundry, integrating open-source and proprietary models that run locally on the NPU—keeping sensitive data on-device while still connecting to cloud services when needed.

When discussing Copilot+ PCs with business decision-makers, the platform story is often the most compelling angle: these aren't faster PCs—they're the foundation for how the organization builds, deploy, and manage AI going forward. The NPU is a critical piece of that foundation, enabling a new class of AI-powered experiences that are efficient, responsive, and secure.