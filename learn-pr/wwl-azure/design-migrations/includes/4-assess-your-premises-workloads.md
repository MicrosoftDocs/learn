Before you begin the migration project at Tailwind Traders, we need to review the tools, procedures, and services that Azure offers to support your migration process.

### Things to know about migration tools and services

There are a range of tools and services that can help you plan and complete the four stages of your migration. Most migrations require several procedures and services. For some migrations, you might need only one or two services or tools. 

| Service or tool | Stage | Description |
| --- | --- | --- |
| **Azure Migrate** | _Assess_ & _Migrate_  | Azure Migrate performs assessment and migration to Azure of virtual machines (Hyper-V and VMware), cloud-based virtual machines, physical servers, databases, data, virtual desktop infrastructure, and web applications. |
| **Database Migration Service** | _Assess_ & _Migrate_  | The Azure Database Migration Service performs assessment and migration for several different databases, not just Azure SQL Database. |
| **Data Migration tool** |  _Migrate_ | The Azure Cosmos DB Data Migration tool migrates your existing databases to Azure Cosmos DB. |
| **Microsoft Cost Management** | _Optimize_ | Microsoft Cost Management helps you monitor, optimize, and control your ongoing Azure costs. |
| **Advisor** | _Monitor_ | Azure Advisor helps optimize your Azure resources for reliability, performance, cost, security, and operational excellence. |
| **Monitor** | _Monitor_ | Azure Monitor collects monitoring data from both on-premises and Azure resources that help you analyze data, set up alerts, and identify problems. |
| **Microsoft Sentinel** | _Monitor_ | Microsoft Sentinel provides intelligent security analytics for your applications that enable you to collect, detect, investigate, and respond to incidents. |

## Azure Migrate 

Azure Migrate lets you perform an agentless environment discovery or use agents to perform a dependency analysis. You can access Azure Migrate features in the Azure portal to help assess your current on-premises workloads. Azure Migrate makes recommendations for the size of virtual machine you need to create. You can identify estimated costs for the resources those machines consume, so the management team can set the budget.

Azure Migrate helps with performance-based sizing calculations (virtual machine sizing, compute/storage) for the machines to migrate and estimates the ongoing cost of running these machines in Azure. Azure Migrate can assess both Hyper-V and VMware-based virtual machines, and also physical servers.

Azure Migrate also supports the visualization of dependencies for those machines. It helps you create groups of machines that can be assessed together and ultimately migrated to Azure at the same time.

### Things to know about Server Assessment

Azure Migrate includes several assessment tools to help you prepare for your migration. To perform an agentless discovery, you use the Azure Migrate Server Assessment tool.

Server Assessment guides you through downloading a lightweight collector appliance. The appliance carries out the discovery of systems in your environment. The tool uses data collected by the appliance to identify data about virtual machine cores, memory, disk sizes, and network adapters. Where applicable, the collector also gathers performance data like CPU and memory usage, disk IOPS, disk throughput, and network output.

After data collection is complete, the data is pushed to your Azure Migrate project. In the Azure portal, you can view the discovered systems and download a report. The full process for assessing a server can be visualized as follows:

1. Download and configure the appliance.
1. Start discovery.
1. Create an assessment.
1. Review the assessment.

:::image type="content" source="../media/migrate-discovery.png" alt-text="Flowchart that shows how to do server assessment with the Azure Migrate Server Assessment tool." border="false":::

We examine Azure Migrate in more detail in the next unit.
