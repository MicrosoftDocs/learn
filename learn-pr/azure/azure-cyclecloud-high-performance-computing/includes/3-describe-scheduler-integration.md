Using cloud agility allows companies to fully benefit from the hyperscale capabilities of Azure while minimizing the operational cost associated with the use of compute resources. The ability to automatically scale the amount of resources in response to their usage patterns is a core component of that agility. In the context of the Azure CycleCloud and HPC, this translates into implementing a close correlation between the resource demands of cluster jobs and the number of cluster compute nodes.

In general, the orchestration of cluster node scaling is the responsibility of schedulers. Schedulers need to be able to communicate their demands to the platform that provides compute resources. Azure CycleCloud helps implement this functionality. In this unit, you learn about the principles of this implementation.

## What is the role of Azure CycleCloud in cluster autoscaling?

Azure CycleCloud facilitates deployment of schedulers in Azure, which in turn, distribute and manage jobs running on clusters composed of Azure resources. Azure CycleCloud doesn't function as a scheduler. Instead, it functions as an intermediary between schedulers and the underlying platform. Azure CycleCloud also simplifies development of autoscaling functionality for the corresponding schedulers by providing a REST API-based programming interface and a Python-based client library.

Azure CycleCloud allows you to correlate the autoscaling behavior of managed clusters with the length of the cluster job queues. You can further customize this behavior by defining template parameters that control, for example, the amount of time after which idle nodes are terminated or the frequency of autostop checks.

All of the built-in templates expose the autoscaling settings directly in the Azure CycleCloud graphical interface. In each case, the settings include the option to specify the lower and upper limits of the autoscaling range, expressed in the number of CPU cores. The upper limit helps you to minimize the possibility of unanticipated charges. You can further mitigate this risk by setting budget alerts.

With the lower threshold set to 0, creating a cluster results in provisioning of the scheduler head node only. However, when the scheduler detects queued jobs, it initiates provisioning of the compute nodes that are necessary to execute the corresponding workload, up to the limit you defined. To support loosely coupled or parallel jobs, where individual tasks execute independently of each other, jobs start running as soon as the first node becomes available. For tightly coupled jobs, such as those using the Message Passing Interface (MPI) functionality, the wait time is longer, depending on the extent of internode dependencies. After the job queue has been empty for the amount of time exceeding the allowed idle time, the compute nodes begin to autostop and your cluster once again consists of the scheduler head node only.

> [!NOTE]
> The underlying concepts described in this unit are common among schedulers. However, their implementation details are scheduler specific. For in-depth information about each implementation, refer to individual scheduler documentation.

## How to integrate schedulers with Azure CycleCloud autoscaling

The two primary components that implement integration with Azure CycleCloud autoscaling are Azure CycleCloud Autoscale Library and Demand Calculator.

:::image type="content" source="../media/u2-cyclecloud-architecture.png" alt-text="Diagram of the high-level architecture of Azure CycleCloud." border="false" lightbox="../media/u2-cyclecloud-architecture.png":::

The *Azure CycleCloud Autoscale Library* is an open-source, GitHub-hosted project that allows Python helpers to simplify development of autoscaling for any scheduler deployed to Azure. The helpers use Azure CycleCloud REST API to orchestrate provisioning of Azure resources. The project uses Python 3 and has many Python dependencies. But its core functionality relies on the Azure CycleCloud Python Client Library. Autoscale integrates with the scheduler head nodes that monitor job queues. Autoscale increases or decreases the number of compute nodes by interacting with the autoscale REST API that's running on the Azure CycleCloud application server.

The *Demand Calculator* is responsible for evaluating resource requirements based on the compute node and job data collected by the scheduler. This evaluation considers compute and network constraints, such as the maximum cluster size or InfiniBand-related limits. The resulting resource requirements translate into a request for provisioning or deprovisioning of Azure VMs of a particular size and configuration. Autoscale Library relays these requests to the Azure CycleCloud REST API, which then delivers them through its orchestrator to Azure Resource Manager.

> [!NOTE]
> While scheduler integration accommodates loosely coupled or parallel workloads where managing the size of the cluster is the primary consideration, Azure CycleCloud also supports tightly coupled workloads, where node proximity and network latency are critical.
