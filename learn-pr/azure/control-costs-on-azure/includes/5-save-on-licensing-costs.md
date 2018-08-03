We've talked through ways to reduce your infrastructure costs, but licensing can dramatically impact your cloud spend as well. There are some best practices that you can leverage to reduce your spend. Let's take a look at them.

## Azure Hybrid Benefit

**from blog** For customers who have made an investment in Windows Server licenses the Azure Hybrid Benefit gives customers usage rights for Virtual Machines on Azure. When applied to vitrual machines in Azure, you will not be charged for the Windows Server license and will instead be billed at the Linux rate. To be eligible for this benefit, current Windows licenses must be covered by Software Assurance. Each 2-processor license or each set of 16-core licenses are entitled to two instances of up to 8 cores, or one instance of up to 16 cores. The Azure Hybrid Benefit for Standard Edition licenses can only be used once either on-premises or in Azure. Datacenter Edition benefits allow for simultaneous usage both on-premises and in Azure. Most customers are typically licened by core, so you'll use that model for your calculation. If you have questions about what licenses you have, you can reach out to your license reseller or your Microsoft account team to get more information. Applying this benefit is easy, and can be done at deployment time for new VMs and can be enabled or disabled at any time on existing VMs.

## Use Dev/Test subscription offers

**from blog** The Enterprise Dev/Test and Pay-As-You-Go Dev/Test offers are a benefit you can take advanatage of to save costs on your non-production environments. This benefit gives you several discounts, most notably for Windows workloads, charging you the Linux rate for virtual machines. This also applies to SQL Server, and any other Microsoft software that is covered under Visual Studio subscription (formerly known as MSDN). There are a few requirements for this benefit, one being that it's only for non-production workloads, and another being that any users of these environments (excluding testers) must be covered under Visual Studio subscription. In short, for non-production workloads, this allows you save money on your Windows, SQL Server and other Microsoft Virtual Machine workloads.
Below are the full details of each offer. If you are a customer on an Enterprise Agreement, you'd leverage the Enterprise Dev/Test offer, and if you a customer without an Enterprise Agreement and are instead using PAYG accounts, you'd leverage the Pay-As-You-Go Dev/Test offer.
https://azure.microsoft.com/en-us/offers/ms-azr-0148p/
https://azure.microsoft.com/en-us/offers/ms-azr-0023p/

## Bring your own SQL Server license

**from blog** If you are a customer on an Enterprise Agreement and already have an investment in SQL Server licenses and they have freed up as part of moving resources to Azure, you can provision BYOL images off the Azure Marketplace, giving you the ability to take advantage of these unused licenses and reduce your Azure VM cost. You've always been able to do this by provisioning a Windows VM and manually installing SQL Server, but this simplifies the creation process by leveraging Microsoft certified images. Take a look at the following blog post from the initial announcement, and you'll find these marketplace images available for you today to take advantage of.

## Use SQL Server Developer Edition

**from blog** As of April 1, 2016, Microsoft has made SQL Server Developer Edition a free product for non-production use. This is yet another way you can save on Azure costs for your non-production environments. On the Azure Marketplace you can find SQL Server 2016 and SQL Server 2017 images for Developer Edition, which will eliminate the additional cost for SQL Server, and for previevious version you can provision a new Windows VM and download SQL Server Developer Edition from your Visual Studio Subscriber Downloads, provided you have a Visual Studio subscription. For full licensing infomration, take a look at the following links. Bottom line, for non-production workloads that use SQL Server you should look closely at taking advantage of this offer. One side note, there is no way to convert an existing SQL Server VM to another license type, you'll have to provision a new VM and migrate your databases to the new server.

https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-pricing-guidance

## Use constrained instance sizes

https://azure.microsoft.com/en-us/blog/announcing-new-azure-vm-sizes-for-more-cost-effective-database-workloads/

## Summary