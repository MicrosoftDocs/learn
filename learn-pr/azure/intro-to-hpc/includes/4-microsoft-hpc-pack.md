If you need more flexible control of your high-performance infrastructure, or you want to manage both cloud and on-premises VMs, consider using the Microsoft HPC Pack.

In your engineering company, you want to migrate high-performance infrastructure from on-premises data centers into Azure. Because these systems are business critical, you want to migrate gradually. You need to ensure that you can rapidly respond to demand and manage VMs flexibly during the migration, when there will be both on-premises and cloud VMs.

Here, you will learn how the HPC Pack can manage HPC infrastructure.

## What is HPC Pack?

In researching options for the engineering organization, you've looked at Azure Batch and Azure HPC Instances. But what if you want to have full control of the management and scheduling of your clusters of VMs? What if you have significant investment in on-premises infrastructure in your data center? HPC Pack offers a series of installers for Windows that allows you to configure your own control and management plane, and highly flexible deployments of on-premises and cloud nodes. By contrast with the exclusively cloud-based Azure Batch, HPC Pack has the flexibility to deploy to on-premises and the cloud. It uses a hybrid of both to burst to the cloud when your on-premises reserves are insufficient.

From the knowledge you've acquired in this module, try thinking about Microsoft HPC Pack as a version of the Azure Batch management and scheduling control layer over which you have full control, and for which you have responsibility. Deployment of HPC Pack isn't a trivial affair – it requires Windows Server 2012 or later.

## Planning for HPC Pack

Typically, you should prepare for the installation of HPC Pack with a full review of requirements. You need a SQL Server and an Active Directory (AD) controller. You must also plan a topology – that is, how many head or control nodes there should be, and how many worker nodes? Do you need to burst up to Azure? If so, you would pre-provision Azure nodes as part of the cluster. The size of the main machines that make up the control plane – head and control nodes, SQL Server, and AD Controller – will depend on the projected cluster size.

When you install HPC Pack, it shows a job scheduler with support for both HPC and parallel jobs. The scheduler is displayed in the Microsoft Message Passing Interface or MS-MPI. HPC Pack is highly integrated with Windows so you can use Visual Studio for parallel debugging. You'll see all the application, networking, and operating system events from the compute nodes in the cluster in a single, debugger view.

HPC Pack also offers an advanced job scheduler. You can rapidly deploy, even to nodes not exclusively dedicated to HPC Pack, to Linux-based nodes, and Azure nodes. That means you can use spare capacity within your data center. HPC Pack provides an ideal way to use existing infrastructure investments, and keep more discrete control over how work gets divided up, than is possible with Azure Batch.

## Using a mix of technologies

The options you're considering in this module aren't mutually exclusive. You can use the H-Series VMs, which you looked at in the last unit, as possible Azure nodes in an HPC configuration. While you've concentrated on hybrid use cases to highlight the differences with Azure Batch, HPC Pack is flexible. It allows for both exclusively on-premises deployments and exclusively cloud-based deployments. This flexibility is useful when you want more granular control than Azure Batch offers.