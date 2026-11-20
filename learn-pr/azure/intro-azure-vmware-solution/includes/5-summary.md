Azure VMware Solution lets you keep a compatible application on vSphere while moving it to dedicated Azure hosts. For the healthcare scenario, use these four criteria to decide where each workload belongs:

- **Workload fit:** Check application support, dependencies, and where the application data and recovery copies may reside. Choose a migration method that meets the cutover window and test the application before retiring its source.
- **Operations and recovery:** Microsoft maintains the hosts and VMware platform. Your team manages the guests, application access, backups, and tested recovery plans.
- **Capacity and connectivity:** Size for management overhead, host failures, and usable storage. Gen 1 uses an AVS-managed ExpressRoute circuit for VNet access; Gen 2 attaches directly to a VNet. Plan on-premises connectivity separately if you need it.
- **Cost:** Estimate Azure host charges, the portable VMware Cloud Foundation subscription, guest licensing, and the gateways, circuits, and data transfer your workloads require. Check the [eligible guest license types](/azure/azure-vmware/license-sql-windows-in-avs#type-of-licenses) and the [Microsoft Product Terms for your agreement](https://www.microsoft.com/licensing/terms/productoffering/MicrosoftAzure) to determine whether Azure Hybrid Benefit applies to your Windows Server or SQL Server workloads.

Add the cost of the Azure services you plan to use. For example, estimate the volume of [VMware syslog you export](/azure/azure-monitor/reference/supported-logs/microsoft-avs-privateclouds-logs). If you use Azure NetApp Files, price the [capacity you provision](/azure/azure-netapp-files/azure-netapp-files-cost-model#billing-fundamentals), not just the space your files use. [Compare the total AVS cost](/azure/cloud-adoption-framework/azure-vmware-solution/strategy#what-does-azure-vmware-solution-cost) with the cost of refreshing your hosts and running the same workloads in your datacenter over the same period.

Continue with [Run VMware resources on Azure VMware Solution](/training/paths/run-vmware-workloads-azure-vmware-solution/) to learn how to deploy a private cloud and migrate workloads.

## More info

Use these resources to explore AVS and plan a VMware migration:

- [Azure VMware Solution documentation](/azure/azure-vmware/)
- [Run your VMware workloads natively on Azure](https://azure.microsoft.com/services/azure-vmware/)
- [VMware to Azure Migration Solutions](https://www.vmware.com/cloud-solutions/azure.html)