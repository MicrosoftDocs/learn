SQL Server on Azure Virtual Machines is a version of SQL Server that runs on an Azure virtual machine (VM). This service lets you use full versions of SQL Server in the cloud without having to manage your on-premises machines. Azure VMs come in many sizes and can be run in diverse geographic regions. Each SQL Server VM can be created to meet specific version and operating system requirements, which make them a good option for handling different SQL Server workloads.

### Things to know about SQL Server on Azure Virtual Machines

Review the following characteristics of the SQL Server on Azure Virtual Machines deployment option:

- When you run SQL Server on Azure Virtual Machines, you have access to the full capabilities of SQL Server.

- All of your SQL Server skills should directly transfer during the migration, and Azure can help automate backups and security patches.

- Unlike the Azure SQL Database and Azure SQL Managed Instance deployment options, you're responsible for version update operations for the OS and SQL Server.

#### Business scenario

Let's explore a business scenario for SQL Server on Azure Virtual Machines. AllScripts is a leading manufacturer of healthcare software. The company serves physician practices, hospitals, health plans, and the pharmaceutical industry. To transform its applications frequently, and host them securely and reliably, AllScripts wants to quickly move its data to Azure. In just three weeks, the company used Azure Site Recovery to migrate dozens of acquired applications running on approximately 1,000 VMs to Azure.

:::image type="content" source="../media/sql-server.png" alt-text="Illustration that shows a business scenario for SQL Server on Azure Virtual Machines." border="false":::

### Things to consider when using SQL Server on Azure Virtual Machines

Consider how SQL Server on Azure Virtual Machines can be included in your relational data storage plan for Tailwind Traders:

- **Consider server access**. Access your SQL Server and operating system server by implementing SQL Server on your virtual machines. Expansive support is provided for SQL Server and operating system versions.

- **Consider automated management**. Use the automated management features of SQL Server for your virtual machines.

- **Consider Azure Hybrid Benefit**. Exercise the [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/faq/) for existing on-premises Windows Server and SQL Server licenses.

## Compare Azure SQL deployment options

You review the different Azure SQL deployment options. Compare the solution features and recommended usage scenarios, and think about which options support the Tailwind Traders organization.

| Compare | SQL Database | SQL Managed Instance | SQL Server on Azure Virtual Machines | 
| --- | --- | --- | --- |
| **Scenarios** | Best for modern cloud applications, hyperscale, or serverless configurations | Best for most lift-and-shift migrations to the cloud, instance-scoped features | Best for fast migrations, and applications that require OS-level access |
| **Features** | _**Single database**_ <br> - Hyperscale storage (for databases up to 100 TB) <br> - Serverless compute <br> - Fully managed service <br><br> _**Elastic pool**_ <br> - Resource sharing between multiple databases for price optimization <br> - Simplified performance management for multiple databases <br> - Fully managed service | _**Single instance**_ <br> - SQL Server surface area (vast majority) <br> - Native virtual networks <br> - Fully managed service <br><br> _**Instance pool**_ <br> - Pre-provision compute resources for migration <br> - Cost-efficient migration <br> - Host smaller instances (2vCore) <br> - Fully managed service | _**Azure Virtual Machines**_ <br> - SQL Server access <br> - OS-level server access <br> - Expansive version support for SQL Server <br> - Expansive OS version support <br> - File stream, Microsoft Distributed Transaction Coordinator (DTC), and Simple Recovery model <br> - SQL Server Integration Services (SSIS), SQL Server Reporting Services (SSRS), and SQL Server Analysis Services (SSAS) |