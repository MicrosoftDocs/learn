You needed to determine whether Azure CycleCloud would facilitate deployment and management of Slurm-based HPC clusters in Azure. You also wanted to ensure that you could address your management team's directives to keep the cluster's cost within the project's budget.

In this module, you set up Azure CycleCloud by using an Azure Marketplace image and configuring its access to your Azure subscription with a system-assigned managed identity. Your approach follows best practices for Microsoft, yielding the configuration that's straightforward to implement and maintain. You then used the graphical interface of the Azure CycleCloud application to create, configure, and start a Slurm-based cluster based on a predefined template, which also considerably simplified the implementation process. As part of the cluster configuration, you set up budget alerts to help keep the cluster's cost within the project's budget.

Implementing the equivalent functionality on your own, without the abstraction layer that Azure CycleCloud provides, would be more complex, requiring you to directly manage the lifecycle of Azure resources that form the building blocks of your HPC clusters. By managing resource provisioning, configuration, and monitoring, Azure CycleCloud allows you to focus on business needs instead of the underlying infrastructure.

## Related content

* [Azure CycleCloud documentation](/azure/cyclecloud/)
* [Azure CycleCloud product information](https://azure.microsoft.com/features/azure-cyclecloud/)
* [What is Azure CycleCloud?](/azure/cyclecloud/overview)
* [Quickstart: Install CycleCloud using the Marketplace image](/azure/cyclecloud/qs-install-marketplace)
* [Azure CycleCloud Tutorial: Create and Run a Simple HPC Cluster](/azure/cyclecloud/tutorials/create-cluster)
* [CycleCloud: Core Concepts](/azure/cyclecloud/concepts/core)
* [CycleCloud Scheduling and Autoscaling Concepts](/azure/cyclecloud/concepts/scheduling)
