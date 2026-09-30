AI workloads can run on several types of processors and hardware, each with different capabilities and performance characteristics. Understanding these components provides context for the AI metrics available in Windows Task Manager.

Consider an administrator who wants to understand how AI workloads are processed on a supported Windows device. Throughout the next several units, you'll use Windows Studio Effects during a Microsoft Teams call as an example workload and explore how Task Manager can be used to observe AI hardware utilization.

## Central Processing Unit (CPU)

Traditionally, most computing tasks were handled by the CPU. CPUs are highly versatile and can run a wide variety of workloads, including AI tasks. However, they aren't specifically optimized for the mathematical operations commonly used by modern AI models. As a result, AI workloads that run exclusively on the CPU can consume significant system resources and power.

## Graphics Processing Unit (GPU)

GPUs can also run AI workloads. They excel at performing many calculations in parallel and have long been used to accelerate AI and machine learning tasks. Compared to CPUs, GPUs can often process AI workloads more efficiently because of their highly parallel design.

### GPU neural engine

Some newer GPUs also include dedicated AI acceleration hardware called a GPU neural engine. Rather than being a separate processor, a GPU neural engine is a specialized part of the GPU that's designed specifically for AI operations.

GPU neural engines can accelerate AI operations more efficiently than traditional GPU compute resources and can help improve the performance and efficiency of AI workloads.

## Neural Processing Unit (NPU)

Many modern Windows devices also include a Neural Processing Unit (NPU). An NPU is specialized hardware designed specifically for AI operations. NPUs can perform AI computations efficiently, helping AI-enabled applications deliver strong performance while reducing power consumption.

## Where AI workloads run

Not all AI workloads run in the same location or on the same hardware. Depending on the application, device capabilities, and processing requirements, an AI workload might run in the cloud or locally on a device. When a workload runs locally, it might use:

- The **CPU**
- The **GPU** or **GPU neural engine**, if available
- The **NPU**

For example, a cloud-based AI assistant that analyzes large amounts of organizational data might process requests in the cloud. In contrast, Background Blur during a video call may run on an NPU, while AI image generation could run on a GPU. Smaller AI features integrated into business applications might run on the CPU.

The hardware used can affect how a workload uses system resources. For example, a workload processed by dedicated AI hardware might have a different impact on CPU utilization, power consumption, or battery life than the same workload processed by a general-purpose processor.

Understanding where a workload runs and which processor is handling it provides important context when reviewing AI-related activity in Task Manager.

In the next unit, you'll explore the AI-specific metrics available in Windows Task Manager and learn what they can tell you about AI processing activity.
