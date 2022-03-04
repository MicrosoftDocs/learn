Before you begin the migration project at Tailwind Traders, you should be familiar with the available tools and possible procedures that you can use during the migration. This unit discusses those tools and procedures.

### Describe migration tools

There are a range of tools and services that can help you plan and complete the four stages of your migration. However, in some migrations, you might need to use only one or two of these services or tools.

| **Service or tool**| **Stage**| **Description** |
| - | - | - |
| Service Map| Assess| Maps communication between app components on Windows or Linux. Can help you to identify dependencies when determining what to migrate. Service map requires an additional agent to be installed on the source environment VMs. |
| Azure TCO Calculator| Assess| Provides an estimate of your monthly running costs in Azure, which enables a comparison with on-premises costs. |
| Azure Migrate| Assess and migrate| Performs assessment and migration to Azure of VMs (Hyper-V and VMware), cloud based VMs, physical servers, databases, data, virtual desktop infrastructure, and web applications. |
| Data Migration Assistant (DMA)| Assess and Migrate| Performs assessment and migration specifically for Azure SQL database. |
| Azure Database Migration Service| Assess and Migrate| Performs assessment and migration for several different databases, not just Azure SQL database. |
| Data Migration Tool| Migrate| Migrates your existing databases to Azure Cosmos DB. |
| Azure Cost Management| Optimize| Helps you monitor, optimize, and control your ongoing Azure costs. |
| Azure Advisor| Optimize| Helps optimize your Azure resources for reliability, performance, cost, security, and operational excellence. |
| Azure Monitor| Monitor| Collects monitoring telemetry from both on-premises and Azure resources. Enables you to analyze data, setup alerts, and identify problems. |
| Microsoft Sentinel| Monitor| Provides intelligent security analytics for your applications enabling you to collect, detect, investigate, and respond to incidents. |


### Assess your environment

You can use several assessment tools to help in Tailwind Traders' migration to Azure. These are:

- Service Map

- Azure TCO Calculator

- Azure Migrate

### Use Azure Service Map

You use Service Map to automatically discover apps and their components in Tailwind Traders' on-premises environment. By doing so, you gain an invaluable insight into the app structure at Tailwind Traders. This insight lets you effectively plan and perform your migration. Service Map supports discovery on both Windows and Linux platforms.

By using Service Map, you can review the Tailwind Traders' server environment as a collection of interconnected systems. Service Map displays:

- Connections between servers

- Server processes

- Inbound and outbound connection latency

- TCP or UDP ports across any connected architecture

You'll need the following to use Service Map:

- A Log Analytics workspace

- The Log Analytics agent installed on the Windows or Linux computers. This agent collects events and performance data from the computer and delivers it to the Log Analytics workspace.

- The Dependency agent installed on the Windows or Linux computers. This agent collects discovered data about processes running on the computer, and its external process dependencies.

Service Map provides the following functions:

- Discovery, which helps:

	- Build a common reference of dependencies of your servers and their processes.

	- Review the discovered information as an intuitive graphical map.

	- Identify failed network connections.

- Incident management, which helps:

	- Eliminate guesswork around problem isolation.

	- Identify misconfigured systems and components.

- Migration assurance, which helps:

	- Plan, accelerate, and validate your Azure migrations.

	- Ensure that nothing is left behind and unexpected outages don't occur.

- Business continuity, which helps:

	- Identify how your systems rely on each other, thereby helping to ensure that your recovery plan is reliable.

	- Identify, which front-end systems you must recover after a server is restored and available once more.

- Patch management, which helps:

	- Identify, which other teams and servers depend on a service being patched.

	- Enable you to notify teams in advance before you take down your systems for patching.

### Use Azure TCO Calculator

You can use the Azure TCO Calculator to estimate and optimize Tailwind Traders expected Azure costs following your migration. You start by defining the characteristics of Tailwind Traders' existing workloads, including:

- Servers

- Databases

- Storage

- Networking

The following screenshot displays an example workload for servers:

 

:::image type="content" source="../media/calculator-estimate.png" alt-text="TCO calculator with cost estimates.":::



Next, you can adjust assumptions, including:

- Software Assurance coverage

- Geo-redundant storage

- Virtual machine costs

- Electricity costs

- Storage costs

- IT labor costs

- Other assumptions, including hardware and software costs, virtualization costs, datacenter costs, and so on.

Making these adjustments enables you to fine tune your workloads to reflect their actual cost to Tailwind Traders as closely as possible. Finally, on the View report page, you can review information about possible cost savings, as displayed in the following screenshot.

:::image type="content" source="../media/estimated-savings.png" alt-text="Example estimated cost savings.":::



The information available from the report can be useful in helping identify the benefits in moving from an on-premises content to one based in Azure.

### Use Azure Migrate

Using Azure Migrate, you can perform an agentless environment discovery or use agents to perform a dependency analysis. The Azure portal helps you:

- Assess your current on-premises workloads.

- Makes recommendations for the size of VM you'll need to provision.

You want to assess readiness for the move to Azure. You also want to identify estimated costs for the resources that those machines will consume, so the management team can set the budgets.

Azure Migrate helps with performance-based sizing calculations (VM sizing, compute/storage) for the machines that you'll migrate and estimate the ongoing cost of running these machines in Azure. Azure Migrate can assess both Hyper-V and VMware-based virtual machines, as well as physical servers.

Azure Migrate also supports the visualization of dependencies for those machines. It helps you create groups of machines that can be assessed together and ultimately migrated to Azure at the same time.

To perform an agentless discovery, the Azure Migrate: Server Assessment tool:

- Guides you through downloading a lightweight collector appliance. The appliance carries out the discovery of systems in your environment. 

- Uses data collected by the appliance to identify data about VM cores, memory, disk sizes, and network adapters. Where applicable, the collector also gathers performance data like CPU and memory usage, disk IOPS, disk throughput, and network output.

After the data collection is complete, it's pushed to your Azure Migrate project. On the Azure portal, you can now view all the discovered systems or download a report to review.

The process can be visualized as follows:

1. Download and configure the appliance

2. Start discovery

3. Create an assessment

4. Review the assessment

:::image type="content" source="../media/migrate-discovery.png" alt-text="Flowchart as described in the text.":::

 

You'll examine the role of Azure Migrate in more detail during the next unit.