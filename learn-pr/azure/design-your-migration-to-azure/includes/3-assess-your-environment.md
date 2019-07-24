Azure Migrate enables you to assess your current On-premises workloads. Once assessed, Azure Migrate will then make recommendations on the size of VM you'll need to provision.

In your role in the business, you've been asked to plan the migration of their on-premises environment to Azure. As the server workloads are primarily VMware-based, you want to begin with those machines. You want to assess readiness for the move to Azure and identify estimated costs for the resources those machines will consume, so that the management team can set the budgets.

In this unit, you'll look at Azure Migrate, a service you use to assess readiness and assist with migration to Azure from an On-premises environment.

## What is Azure Migrate?

Azure Migrate is a free service provided by Microsoft that assesses on-premises VMware virtual machines for running in Azure. The service helps with the performance-based sizing calculations (virtual machine sizing, compute/storage) of the machines that you'll migrate, allowing you to estimate the ongoing cost of running these machines in Azure. Finally, the service allows the visualization of dependencies for those machines and helps you to create groups, so they can be assessed and ultimately migrated to Azure at the same time. Giving you confidence that nothing will be left behind.

Azure Migrate has limitations, and currently only assess VMware-based virtual machines. When you use Azure Migrate, the assessments produced are created within a **Project**, which is set up within the Azure portal. Each project has a collector appliance, which discovers up to 1,500 VMs. You'll need to create additional projects if your company has more than 1,500 VMs or multiple vCenter Server instances. Up to 20 projects are supported per Azure subscription.

## Working with Azure Migrate

Before creating a **Project**, you can group the VMs into the various types of VM workloads you have, assessing and potentially migrating them together. For example, you might group all servers that run a common application. Once you've defined any groups you need, create your project.

After you create a **Project**, Azure Migrate needs you to complete two phases to produce an assessment:

1. Discover your virtual machines.
1. Create assessments.

### Discover machines

![Azure Migrate Architecture](../media/3-azure-migrate-architecture.svg)

The Azure portal will guide you through the process of downloading a collector appliance, which carries out the discovery of VMs in your environment. The collector appliance is available to download to your vCenter Server in the OVA (Open Virtualization Appliance) format. Import, and spin up, the collector appliance, and complete its configuration to connect it to the Azure Migrate project.

The collector uses VMware PowerCLI cmdlets to do agentless data collection on your VMware estate. The collector collects data about VM cores, memory, disk sizes, and network adapters. Where applicable the collector also gathers performance data like CPU and memory usage, disk IOPS, disk throughput, and network output.

To receive and store the collected data, Azure Migrate requires that you open port 443 between your internal network and Azure for:

- The collector and the Azure Migrate service.
- The collector and the vCenter Server.
- The on-premises VM and Log Analytics Workplace.

When the data collection is complete, it's pushed to your Azure Migrate project. On the Azure portal, you can now view all the discovered VMs, or download a report to review.

If your company wants details on how the VMs are related to each other (via a visualization of dependencies), you can install agents to collect that data. Azure Migrate will prompt you to install the **Microsoft Monitoring Agent** and **Dependency Agent** on each VM. The agents are available for both Windows and Linux.

![Screenshot of the Azure Migrate assessment showing missing agents](../media/3-machines-no-agent.png)

After these agents are installed and configured, they collect data like FQDN, OS, IP addresses, MAC addresses, running processes, and incoming/outgoing TCP connections.

### Create an assessment

Azure Migrate can now assess your environments readiness to be migrated to Azure. In the portal, select the Assessments section, and then select **Create assessment**. An assessment with default settings will be created. These default settings can be edited later by editing the properties of the assessment.

![Azure Migrate Assessment Overview screen](../media/3-assessment-overview.png)

