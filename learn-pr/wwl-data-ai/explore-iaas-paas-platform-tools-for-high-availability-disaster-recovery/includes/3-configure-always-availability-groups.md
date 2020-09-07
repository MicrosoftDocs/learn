For all availability configurations of availability groups (AGs), an underlying cluster is required, whether or not it uses AD DS. By the end of this unit, you will understand the considerations for deploying an AG in Azure.

## Considerations for Always On availability groups in Azure

Configuring an AG is nearly the same in Azure as it is on premises as are most of the considerations, such as how to initialize secondary replicas. Most of the Azure-specific considerations were discussed earlier, such as needing an ILB. Same as the WSFC itself, you cannot reserve the listener’s IP address in Azure so you need to ensure something else does not come along and grab it otherwise there could be a conflict on the network, which in turn could cause availability headaches.

Do not place any permanent database on the ephemeral storage. All virtual machines (VMs) that are participating in an AG should have the same storage configuration. You must size disks appropriately for performance depending on the application workload.

Before an AG can be configured, the AG feature must be enabled. This can be done in SQL Server Configuration Manager as shown in the image below or via PowerShell with the cmdlet [Enable-SqlAlwaysOn](https://docs.microsoft.com/powershell/module/sqlps/enable-sqlalwayson?view=sqlserver-ps). Enabling the AG feature will require a stop and start of the SQL Server service.

:::image type="content" source="../media/module-77-high-availability-final-10.png" alt-text="Enabling the Availability Groups Feature in SQL Server Configuration Manager":::

## Create the Availability group

Creating an AG in Azure is the same as it is on premises. SQL Server Management Studio (SSMS), T-SQL, or PowerShell can be used.

The only difference is that whether or not you create the listener as part of the initial AG configuration, as the listener requires the creation of an Azure load balancer and has some additional configuration in the WSFC related to the load balancer.

## Create an Internal Azure load balancer

Once the listener is created, an internal load balancer (ILB) must be used. Without configuring an ILB, applications, end users, administrators, and others cannot use the listener unless they were connected to the VM that hosts an AG’s primary replica.

You can use a basic or a standard load balancer depending on your preference or configuration. Deployments using Availability Zones require the use of a standard load balancer. The listener IP address and the port used for the listener are what is configured as part of the load balancer. A single load balancer supports more than one IP address, so depending on your standards, you may not need a different load balancer for each AG configured on those nodes.

Another consideration for the load balancer is the probe port. Without the probe port, the listener will not work properly as it is not enough just to create the load balancer. Each IP address that will use the load balancer requires a unique probe port. If there are going to be two listeners, there must be two probe ports. Probe ports are high numbers such as 59999.

The probe port is set on the IP address(es) associated with the listener with the following syntax:

```powershell
Get-ClusterResource IPAddressResourceNameForListener | Set-ClusterParameter ProbePort PortNumber
```

Adding the probe port will require a stop and start of the IP address of the listener, which will also temporarily cause the AG to be brought offline, so it is best to get this configured before deploying in production.

If you have a multi-subnet configuration, a load balancer will need to be configured in each subnet (whether or not the other subnet is deployed to different region) and the probe port for that region associated with the IP resource for that subnet in the WSFC.

Without directly connecting to the listener, the only way to ensure that the listener is configured correctly is to use the PowerShell cmdlet Test-NetConnection with the specific port. The syntax is as follows:

```powershell
Test-NetConnection NameOrIPAddress -Port PortNumber
```

You should run this command from somewhere other than the VM that is hosting the primary replica.

Some environments may also require that the IP address for the WSFC and selected ports (such as 445) must be accessible for administration or other purposes, which mean configuring those as part of the same or a different load balancer.

Once the load balancer is confirmed to be working, you can begin to test AG failover and connectivity to the AG via the listener.

## Distributed availability groups

Planning for and configuring a distributed AG is the same on premises as it is in Azure, with any Azure-specific considerations for the individual AGs. The main difference between an on-premises configuration and an Azure configuration for a distributed AG is that as part of the load balancer configuration in each region, the endpoint port for the AG needs to be added. The default port is 5022.

## Azure Site Recovery

Azure Site Recovery is an option that work with the Virtual Machine, whether or not SQL Server is running inside of it. It works with SQL Server but is not designed specifically to account for nuances that may be required when you have a specific RPO. The disks of a VM configured to use Azure Site Recovery are replicated to another region. This replication can be seen in the image below, noted by the “Data flow” arrow.

:::image type="content" source="../media/module-77-high-availability-final-11.png" alt-text="Replication of disks configured to use Azure Site Recovery":::

This means that all changes to a disk are replicated as soon as they occur, but this process knows nothing of database transactions. This is why recovering to a specific data point may not be possible with Azure Site Recovery in the same way it is for a SQL Server-centric solution such as when using an AG.

If it is not possible to deploy one of the in-guest options for IaaS solutions, Azure Site Recovery is a viable option to manage disaster recovery.

Additionally, Azure Site Recovery can potentially protect you against ransomware. If infected, you could roll the VM back to a point before the infection was introduced. That could also mean data loss from a SQL Server perspective, but some data loss, especially in this case, may be more than acceptable. Up and running is often better than down for hours, days, or weeks trying to remove ransomware from your network.

The key things to know when replication is enabled on a VM:

- There is a Site Recovery Mobility extension configured on the VM.

- Changes are sent continually unless Azure Site Recovery is unconfigured or replication is disabled

- Crash consistent recovery points are generated every five minutes, and application-specific recovery points are generated according to what is configured in the replication policy.

:::image type="content" source="../media/module-77-high-availability-final-12.png" alt-text="An example replication policy":::

For SQL Server, the ‘App consistent snapshot frequency’ value is what you may want to adjust to reduce your RPO. However, due to the nature of how Azure Site Recovery works – it is using Volume Shadow Service (VSS) – lowering this value could potentially cause problems for SQL Server since there is a brief freeze and thaw of I/O when the snapshots are taken. The impact of the freeze and thaw could be magnified if other options such as an AG are configured. Most will not encounter issues, but if Azure Site Recovery interferes with SQL Server, you may want to consider other availability options.

If multiple VMs are part of an overall solution, they can be replicated together to create a shared crash- and application-consistent recovery points. This is known as multi-VM consistency and will impact performance. Unless VMs must be restored in this way, it is recommended not to configure this option.

One major benefit of Azure Site Recovery is that you can test disaster recovery without needing to bring down production.

A consideration for Azure Site Recovery is that in the event of a failover to another region, the replica VMs are not protected when they are brought online. They will have to be reprotected.
