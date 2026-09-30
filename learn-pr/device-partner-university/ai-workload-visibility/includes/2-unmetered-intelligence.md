Many AI services use a metered, or consumption-based, pricing model, where organizations pay for the cloud computing resources needed to process AI requests. While cloud-based AI is well suited for complex workloads and scenarios that depend on powerful centralized resources, not every AI task requires cloud processing. As AI use grows and more requests are processed in the cloud, those costs can increase. As a result, organizations are looking for ways to make better use of the computing power already available on employee devices.

Microsoft describes this concept as *unmetered intelligence*.

> [!NOTE]
> While unmetered intelligence encompasses a broader approach to delivering AI across devices and the cloud, this module focuses specifically on how local AI processing works on Windows devices and how IT teams can verify that workloads are running locally.

Unmetered intelligence refers to running appropriate AI workloads locally on devices, using existing hardware resources. Rather than sending every task to the cloud, routine workloads can run on a device, while cloud AI can be reserved for more complex scenarios that require larger models or additional computing power.

Unmetered doesn't mean free. It means making better use of hardware organizations already own. By processing suitable workloads locally, organizations can reduce cloud computing costs while still using cloud AI when additional scale or capabilities are needed. However, organizations can't assume workloads are running locally. Monitoring and validation provide the visibility needed to verify that AI workloads are using local device resources where appropriate, helping organizations put the principles of unmetered intelligence into practice.

## Hardware for local AI processing

Local AI processing requires hardware capable of efficiently running AI workloads. Modern Windows devices can include hardware designed to accelerate these workloads.

In addition to traditional CPUs and GPUs, some devices include dedicated AI processing resources, such as Neural Processing Units (NPUs) and GPU neural engines. These specialized resources are designed to perform AI operations efficiently and can help improve performance and power efficiency for suitable workloads.

As more AI processing happens locally, organizations also need ways to understand how applications use available hardware resources. IT administrators might need to investigate performance issues, developers might want to check how an AI workload is being processed, and users might want to understand how AI-enabled applications affect system performance and battery life.

> [!NOTE]
> AI-enabled applications might influence system power behavior, but actual battery impact requires appropriate measurement.

Windows Task Manager can provide this visibility on supported devices. The information it reports can help show where AI processing is occurring and provide context for investigating workload behavior.

In the next unit, you'll explore the processors and specialized hardware that can power AI experiences on modern Windows devices.

> [!IMPORTANT]
> The AI monitoring capabilities discussed in this module are available on supported Windows devices and hardware configurations. Availability of specific metrics and views might vary depending on device hardware, drivers, and AI acceleration capabilities. Refer to Microsoft documentation for current requirements and support information.
