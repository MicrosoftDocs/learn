An Azure landing zone is the recommended way to set up and manage your Azure IaaS environment at scale. It gives your organization a consistent foundation for deploying and operating workloads, including AI.

You don’t need a separate 'AI landing zone' to get started. AI services can be deployed right alongside your other application workloads. From an Azure landing zone perspective, AI is just another workload. A workload that can be governed, secured, and managed with the same architecture, design principles, and tools your platform team already uses.

:::image type="content" source="../media/landing-zones.png" alt-text="Diagram of a landing zone with AI workloads.":::

### Compute (IaaS)

:::image type="content" source="../media/virtual-machine-concepts.png" alt-text="Diagram of a virtual machine with platform concepts.":::


[AI workloads](/azure/cloud-adoption-framework/scenarios/ai/infrastructure/compute) rely on specialized virtual machines (VMs) to handle intensive computation, large datasets, and accelerated training or inferencing. When you use curated VM images, such as Data Science Virtual Machines, your team gets started quickly with preinstalled AI tools and frameworks.

Choosing the right VM size is critical to balancing performance and cost, especially when distinguishing between training and inference workloads. As AI solutions scale, compute orchestration improves efficiency and reproducibility across VM clusters, while containers provide a consistent, portable way to package and run AI workloads across environments.

### Storage (IaaS)

:::image type="content" source="../media/storage-concepts-1.png" alt-text="Diagram of a storage account with platform concepts.":::


AI workloads demand [storage](/azure/cloud-adoption-framework/scenarios/ai/infrastructure/storage) that delivers high throughput and low latency for fast training and inferencing, while also supporting data consistency and versioning across distributed systems. To meet these needs, balance performance, data movement, cost, and service integration.

Use high-performance file storage for hot data actively used during AI jobs to support real-time processing and experimentation. After jobs are completed, move inactive datasets and artifacts to Azure Blob Storage for durable, cost-efficient retention. Apply lifecycle management policies to automatically tier older data to Cool or Archive storage, keeping data accessible while controlling costs.

### Networking (IaaS)

:::image type="content" source="../media/network-concepts.png" alt-text="Diagram of a virtual network with platform concepts.":::

AI workloads can move a ton of data, so you want a connection that doesn’t slow everything down. Consider Azure ExpressRoute that gives you a dedicated, high-bandwidth path that keeps data flowing quickly and reliably.

It also helps to keep latency as low as possible. Placing your VMs and resources close together—ideally in the same region or in a Proximity Placement Group—cuts down on the travel time for data and makes training jobs run more efficiently.

And if you’re working with multiple GPUs or multiple VMs, fast networking between nodes becomes essential. InfiniBand-enabled Azure VMs make GPU-to-GPU communication super-fast, and tools like Azure Batch can handle the setup for you automatically.

> [!NOTE]
>  The [Introduction to AI Landing Zones](/training/modules/intro-ai-landing-zones/) training module provides details on Azure landing zones with AI workloads.

 
