Before you begin the migration project at Tailwind Traders, we need to review the tools, procedures, and services that Azure offers to support your migration process.

### Things to know about migration tools and services

There are a range of tools and services that can help you plan and complete the four stages of your migration. Most migrations require several procedures and services. For some migrations, you might need only one or two services or tools. 

| Service or tool | Stage(s) | Description |
| --- | --- | --- |
| **Service Map** | _Assess_ | The Service Map feature of Azure Monitor maps communication between application components on Windows or Linux. Use this feature to identify dependencies when determining what data to migrate. Service Map requires another agent to be installed on the source environment virtual machines. |
| **Azure TCO Calculator** | _Assess_ | The Azure Total Cost of Ownership (TCO) Calculator estimates the cost savings you can realize by migrating your workloads to Azure. |
| **Azure Migrate** | _Assess_ & _Migrate_  | Azure Migrate performs assessment and migration to Azure of virtual machines (Hyper-V and VMware), cloud-based virtual machines, physical servers, databases, data, virtual desktop infrastructure, and web applications. |
| **Data Migration Assistant (DMA)** | _Assess_ & _Migrate_  | SQL Server Data Migration Assistant helps you upgrade to a modern data platform. It detects compatibility issues that might impact database functionality in newer versions of SQL Server or Azure SQL Database. |
| **Database Migration Service** | _Assess_ & _Migrate_  | The Azure Database Migration Service performs assessment and migration for several different databases, not just Azure SQL Database. |
| **Data Migration tool** |  _Migrate_ | The Azure Cosmos DB Data Migration tool migrates your existing databases to Azure Cosmos DB. |
| **Microsoft Cost Management** | _Optimize_ | Microsoft Cost Management (formerly known as Azure Cost Management and Billing) helps you monitor, optimize, and control your ongoing Azure costs. |
| **Advisor** | _Monitor_ | Azure Advisor helps optimize your Azure resources for reliability, performance, cost, security, and operational excellence. |
| **Monitor** | _Monitor_ | Azure Monitor collects monitoring telemetry from both on-premises and Azure resources that help you analyze data, set up alerts, and identify problems. |
| **Microsoft Sentinel** | _Monitor_ | Microsoft Sentinel provides intelligent security analytics for your applications that enable you to collect, detect, investigate, and respond to incidents. |

Let's examine three Azure services and tools to support the assessment stage of migrating Tailwind Traders workloads to Azure:

- Azure Migrate
- The Azure TCO Calculator
- The Service Map feature of Azure Monitor

## Service Map

The Service Map feature of Azure Monitor lets you automatically discover applications and their components in your on-premises environment. Use the feature to gain valuable insights into the app structure at Tailwind Traders to effectively plan and perform your migration. Service Map supports discovery on both Windows and Linux platforms.

You can use Service Map to review the Tailwind Traders server environment as a collection of interconnected systems. Service Map displays the environment details in several formats:

- Connections between servers
- Server processes
- Inbound and outbound connection latency
- TCP or UDP ports across any connected architecture

### Things to know about Service Map

The Service Map feature of Azure Monitor supports several critical assessment functions:

- **Discovery**: Build a common reference of dependencies of your servers and their processes. Review discovered information as an intuitive graphical map. Identify failed network connections.

- **Incident management**: Eliminate guesswork around problem isolation. Identify misconfigured systems and components.

- **Migration assurance**: Plan, accelerate, and validate your Azure migrations. Ensure nothing is left behind and unexpected outages don't occur.

- **Business continuity**: Identify how your systems rely on each other, thereby helping to ensure that your recovery plan is reliable. Identify, which front-end systems you must recover after a server is restored and available again.

- **Patch management**: Identify which other teams and servers depend on a service being patched. Notify teams in advance before you take down your systems for patching.

To use Azure Service Map, you need the following configuration:

- A Log Analytics workspace defined in the Azure portal.

- Azure Monitor Agent installed on the Windows or Linux computers. This agent collects events and performance data from the computer and delivers it to the Log Analytics workspace.

- The Dependency Agent installed on the Windows or Linux computers. This agent collects discovered data about processes running on the computer, and external process dependencies. The Dependency Agent requires Azure Monitor Agent to be installed on the same machine.

## Azure TCO Calculator

The Azure TCO Calculator helps you estimate and optimize your expected Azure costs following your migration. The calculator guides you through three steps to prepare the estimates:

1. Define your workloads
1. Adjust any assumptions
1. View the estimates report

### Things to know about Azure TCO Calculator

You start by defining the characteristics of your existing workloads. You enter information about your servers, databases, storage, and networking. The following screenshot shows an example workload definition for servers:

:::image type="content" source="../media/calculator-estimate.png" alt-text="Screenshot of the Azure TCO Calculator with cost estimates." lightbox="../media/calculator-estimate.png" border="false":::

After you define your existing workloads, you adjust any assumptions, such as:

- Software Assurance coverage
- Geo-redundant storage
- Virtual machine costs
- Costs for electricity, storage, and IT labor
- Other assumptions, including hardware and software costs, virtualization costs, datacenter costs, and so on

By making these adjustments, you can fine tune your workloads to reflect their actual cost to Tailwind Traders as closely as possible.

In the last step, you review information about possible cost savings on the View report page.

:::image type="content" source="../media/estimated-savings.png" alt-text="Screenshot that shows the estimated cost savings in the Azure TCO Calculator." border="false":::

The information available from the report can be useful in helping identify the benefits in moving from an on-premises content to one based in Azure.

## Azure Migrate and assessment

Azure Migrate lets you perform an agentless environment discovery or use agents to perform a dependency analysis. You can access Azure Migrate features in the Azure portal to help assess your current on-premises workloads. Azure Migrate makes recommendations for the size of virtual machine you need to provision to assess readiness for your move to Azure. You can identify estimated costs for the resources that those machines will consume, so the management team can set the budgets.

Azure Migrate helps with performance-based sizing calculations (virtual machine sizing, compute/storage) for the machines to migrate and estimates the ongoing cost of running these machines in Azure. Azure Migrate can assess both Hyper-V and VMware-based virtual machines, and also physical servers.

Azure Migrate also supports the visualization of dependencies for those machines. It helps you create groups of machines that can be assessed together and ultimately migrated to Azure at the same time.

### Things to know about Server Assessment

Azure Migrate includes several [assessment tools](/azure/migrate/how-to-assess) to help you prepare for your migration. To perform an agentless discovery, you use the Azure Migrate Server Assessment tool.

Server Assessment guides you through downloading a lightweight collector appliance. The appliance carries out the discovery of systems in your environment. The tool uses data collected by the appliance to identify data about virtual machine cores, memory, disk sizes, and network adapters. Where applicable, the collector also gathers performance data like CPU and memory usage, disk IOPS, disk throughput, and network output.

After data collection is complete, the data is pushed to your Azure Migrate project. In the Azure portal, you can view the discovered systems and download a report. The full process for assessing a server can be visualized as follows:

1. Download and configure the appliance
1. Start discovery
1. Create an assessment
1. Review the assessment

:::image type="content" source="../media/migrate-discovery.png" alt-text="Flowchart that shows how to do server assessment with the Azure Migrate Server Assessment tool." border="false":::

We examine Azure Migrate in more detail in the next unit.