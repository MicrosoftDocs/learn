Azure Event Hubs is a scalable event processing service that ingests and processes large volumes of events and data, with low latency and high reliability.

Streaming and event-based solutions are supported, for both on-premises and Azure cloud processing. Whether your scenario is hybrid (connected), or disconnected, your solution can support processing of events/streams at large scale. Your scenario is bound only by cluster size, which you can provision according to your needs.

:::image type="content" source="../media/event-hubs-overview-b77b4d52.png" alt-text="Image of Event Hubs ingestion.":::


As an Operator you manage your Azure Stack Hub capacity using quotas on resources. You control Event Hubs resource consumption by setting quotas on the maximum number of cores use by Event Hubs clusters. Event Hubs clusters are created by users when they deploy an Event Hubs resource. There are also various resource consumption requirements for the resource provider, which are covered in this unit.

## Cluster resource consumption

To understand capacity consumption of Event Hubs deployments, it's important to note that users create Event Hubs clusters based on Capacity Units (CUs). They don't specify a CPU core count when creating an Event Hubs cluster. However, every CU directly maps to a specific number of cores consumed.

Your users will need to create Event Hubs clusters with CUs that meet their business requirements. To inform your decision on quota configuration, the following table shows:

 -  The total cores used by a 1 CU Event Hubs cluster.
 -  The approximate capacity required for consumption of other resources, including virtual machine storage, memory, and storage accounts.

|       **Cluster**       | **virtual machine Type** | **Cluster Nodes** | **Cores per virtual machine/node** | **Total Cores** | **virtual machine Storage** | **Memory** | **Storage Accounts** | **Public IPs** |
|:-----------------------:|:------------------------:|:-----------------:|:----------------------------------:|:---------------:|:---------------------------:|:----------:|:--------------------:|:--------------:|
| 1 CU Event Hubs cluster |         D11\_V2          |         5         |                 2                  |       10        |           500 GiB           |   70 GiB   |          4           |       1        |

All Event Hubs clusters use a D11\_V2 virtual machine type for their nodes. A D11\_V2 virtual machine type consists of 2 cores. So 1 CU Event Hubs cluster uses 5 D11\_V2 virtual machines, which translate into 10 cores used. In determining the number of cores to configure for a quota, use a multiple of the total cores used by 1 CU. This calculation reflects the maximum CU count you'll allow your users to use, when creating Event Hubs clusters. For example, to configure a quota that allows users to create a cluster with 2 CUs of capacity, set your quota at 20 cores.

For production deployments requiring high availability (HA), we recommend a 2 CU cluster. For non-HA and development/test, you can start with 1 CU.

## Resource provider resource consumption

The resource consumption by the Event Hubs resource provider is constant, and independent of the number or sizes of clusters created by users. The following table shows the core utilization by the Event Hubs resource provider on Azure Stack Hub, and the approximate resource consumption by other resources. The Event Hubs resource provider uses a D2\_V2 virtual machine type for its deployment.

|            **Hub**           | **virtual machine Type** | **Cluster Nodes** | **Cores** | **virtual machine Storage** | **Memory** | **Storage Accounts** | **Public IPs** |
|:----------------------------:|:------------------------:|:-----------------:|:---------:|:---------------------------:|:----------:|:--------------------:|:--------------:|
| Event Hubs resource provider |          D2\_V2          |         3         |     6     |           300 GiB           |   21 GiB   |          2           |       1        |

Resource provider consumption is not something that is controlled by quotas. You do not need to accommodate the cores used by the resource provider in your quota configurations. Resource providers are installed using an administrator subscription. The subscription does not impose resource consumption limits on operators, when installing their required resource providers.

## Total resource consumption

The total capacity consumed by the Event Hubs service includes resource consumption by the resource provider, and consumption by user-created clusters.

The following table shows the total Event Hubs consumption under various configurations, regardless if they're managed by quota. These numbers are based on the resource provider and Event Hubs cluster consumptions presented above. You can easily calculate your total Azure Stack Hub usage for other deployment sizes, using these examples.

|            **Cluster**           | **Cores** | **virtual machine Storage** | **Memory** | **Storage Accounts** | **Total Storage** | **Public IPs** |
|:--------------------------------:|:---------:|:---------------------------:|:----------:|:--------------------:|:-----------------:|:--------------:|
| 1-CU cluster + resource provider |    16     |           800 GiB           |   91 GiB   |          6           |     Variable      |       2        |
| 2-CU cluster + resource provider |    26     |           1.3 TB            |  161 GiB   |          10          |     Variable      |       2        |
| 4-CU cluster + resource provider |    46     |           2.3 TB            |  301 GiB   |          18          |     Variable      |       2        |
