If you need more flexible control of your high-performance infrastructure, or you want to manage both cloud and on-premises VMs, consider using the Microsoft HPC Pack.

In your engineering company, you want to migrate high-performance infrastructure from on-premises datacenters into Azure. Because these systems are business critical, you want to migrate gradually. You need to ensure that you can rapidly respond to demand and manage VMs flexibly during the migration, when there will be both on-premises and cloud VMs.

Here, you will learn how the HPC Pack can manage HPC infrastructure.

## What is HPC Pack?

In researching options for the engineering organization, you've looked at Azure Batch and Azure HPC Instances. But what if you want to have full control of the management and scheduling of your clusters of VMs? What if you have significant investment in on-premises infrastructure in your datacenter? HPC Pack offers a series of installers for Windows that allows you to configure your own control and management plane, and highly flexible deployments of on-premises and cloud nodes. By contrast with the exclusively cloud-based Batch, HPC Pack has the flexibility to deploy to on-premises and the cloud. It uses a hybrid of both to expand to the cloud when your on-premises reserves are insufficient.

![Diagram of HPC Pack hybrid.](../media/4-hpc-pack-hybrid.svg)

Think of Microsoft HPC Pack as a version of the Batch management and scheduling control layer, over which you have full control, and for which you have responsibility. Deployment of HPC Pack requires Windows Server 2012 or later, and takes careful consideration to implement.

## Plan for HPC Pack

Typically, you should prepare for the installation of HPC Pack with a full review of requirements. You need SQL Server and an Active Directory controller. You must also plan a topology. How many head or control nodes should there be, and how many worker nodes? Do you need to expand up to Azure? If so, you pre-provision Azure nodes as part of the cluster. The size of the main machines that make up the control plane (head and control nodes, SQL Server, and Active Directory domain controller) will depend on the projected cluster size.

When you install HPC Pack, it shows a job scheduler with support for both HPC and parallel jobs. The scheduler appears in the Microsoft Message Passing Interface. HPC Pack is highly integrated with Windows, so you can use Visual Studio for parallel debugging. You'll see all the application, networking, and operating system events from the compute nodes in the cluster in a single, debugger view.

HPC Pack also offers an advanced job scheduler. You can rapidly deploy, even to nodes not exclusively dedicated to HPC Pack, to Linux-based nodes, and Azure nodes. That means you can use spare capacity within your datacenter. HPC Pack provides an ideal way to use existing infrastructure investments, and keep more discrete control over how work gets divided up than is possible with Batch.

## Use a mix of technologies

The options you're considering in this module aren't mutually exclusive. You can use the H-Series VMs, which you looked at in the last unit, as possible Azure nodes in an HPC configuration. While you've concentrated on hybrid use cases to highlight the differences with Batch, HPC Pack is flexible. It allows for both exclusively on-premises deployments and exclusively cloud-based deployments. This flexibility is useful when you want more granular control than Batch offers.
