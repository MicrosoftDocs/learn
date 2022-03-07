## SQL Server on Azure VMs

SQL Server on Azure Virtual Machines is a version of SQL Server that runs in an Azure VM. This means:

- All your SQL Server skills should directly transfer, though Azure can help automate backups and security patches.

- You have access to the full capabilities of SQL Server

- You're responsible for updating and patching the OS and SQL Server

Consider the following image. Allscripts is a leading manufacturer of healthcare software, serving physician practices, hospitals, health plans, and the pharmaceutical industry.

To transform its applications frequently and host them securely and reliably, Allscripts wanted to move to Azure quickly.

In just three weeks, the company used Azure Site Recovery to migrate dozens of acquired applications running on approximately 1,000 VMs to Azure.

:::image type="content" source="../media/sql-server.png" alt-text="How Allscripts used SQL Server on Azure VMs to solve business problems.":::


> [!Tip]
> If you have existing on-premises Windows Server and SQL Server licenses, you can leverage [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit/faq/).

 

Now that we have reviewed the different deployment options, let's compare the different requirements and the solutions recommended.

| **Recommendation**| **Requirement** |
| - | -| 
| SQL Virtual machines| When considering migrations and applications requiring OS level access |
| Managed Instances| When considering Lift and Shift migrations to the cloud |
| Databases| When considering modern cloud applications solution |
