SQL Server on Azure Virtual Machines is a version of SQL Server that runs on an Azure virtual machine. 

### Things to know about SQL Server on Azure Virtual Machines

Consider the following characteristics of the SQL Server on Azure Virtual Machines deployment option:

- When you run SQL Server on Azure Virtual Machines, you have access to the full capabilities of SQL Server.

- All of your SQL Server skills should directly transfer during the migration, and Azure can help automate backups and security patches.

- You're responsible for version update operations for the operating system and SQL Server.

#### Business scenario

Review the following business scenario for SQL Server on Azure Virtual Machines. AllScripts is a leading manufacturer of healthcare software. The company serves physician practices, hospitals, health plans, and the pharmaceutical industry. To transform its applications frequently, and host them securely and reliably, AllScripts wants to quickly move its data to Azure. In just three weeks, the company used Azure Site Recovery to migrate dozens of acquired applications running on approximately 1,000 VMs to Azure.

:::image type="content" source="../media/sql-server.png" alt-text="Illustration that shows a business scenario for SQL Server on Azure Virtual Machines." border="false":::

### Things to consider when using SQL Server on Azure Virtual Machines

As you think about how SQL Server on Azure Virtual Machines can be included in your relational data storage plan, review these points:

- **Consider server access**. Access your SQL Server and operating system server by implementing SQL Server on your virtual machines. Expansive support is provided for SQL Server and operating system versions.

- **Consider automated management**. Use the automated management features of SQL Server for your virtual machines.

- **Consider Azure Hybrid Benefit**. Exercise the [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/faq/) for existing on-premises Windows Server and SQL Server licenses.

## Compare Azure SQL deployment options

You've reviewed the different Azure SQL deployment options. Compare the solution features and recommended usage scenarios, and think about which options will support the Tailwind Traders organization.

| Compare | Azure SQL Database | Azure SQL Managed Instance | SQL Server on Azure Virtual Machines | 
| --- | --- | --- | --- |
| **Scenarios** | Best for modern cloud applications, hyperscale or serverless configurations | Best for most lift-and-shift migrations to the cloud | Best for migrations and applications that require operating system-level access |
| **Supported features and advantages** | _**Single database**_ <br> - Hyperscale storage (up to 100 TB) <br> - Serverless compute <br> - Fully managed service <br><br> _**Elastic pool**_ <br> - Resource sharing between multiple databases for price optimization <br> - Simplified performance management for multiple databases <br> - Fully managed service | _**Single instance**_ <br> - SQL Server surface area (vast majority) <br> - Native virtual networks <br> - Fully managed service <br><br> _**Instance pool**_ <br> - Pre-provision compute resources for migration <br> - Cost-efficient migration <br> - Host smaller instances (2Vcore) <br> - Fully managed service | _**Azure Virtual Machines**_ <br> - SQL Server access <br> - Operating system server access <br> - Expansive versions for SQL Server and operating systems <br> - Automated manageability features for SQL Server |