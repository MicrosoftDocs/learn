For all availability configurations of availability groups (AGs), an underlying cluster is required. There are many aspects of setting up a cluster that you need to be aware of.

## Considerations for a Windows Server failover cluster in Azure

Deploying a Windows Server Failover Cluster (WSFC) in Azure is similar to configuring one on-premises, but there are some Azure-specific considerations to keep in mind. This section focuses on those unique aspects.

One of the most critical components is the witness resource, which is essential for the quorum mechanism that keeps the WSFC operational. If quorum is lost, the WSFC goes down, taking any Availability Group (AG) or Failover Cluster Instance (FCI) with it. The witness resource can be a disk, file share (SMB 2.0 or later), or cloud witness. It's recommended to use a cloud witness, especially for solutions spanning multiple Azure regions or hybrid environments, as it's fully Azure-based. The cloud witness feature is available in Windows Server 2016 and later.

Another consideration is the Microsoft Distributed Transaction Coordinator (DTC or MSDTC). While not all applications use DTC, those that do require it to be clustered if deploying an AG or FCI. Clustering DTC necessitates a shared disk, even if one isn't otherwise required, as in the case of an AG.

Most WSFC deployments require both Active Directory Domain Services (AD DS) and DNS; FCIs always do. AGs can be configured without AD DS but still need DNS. In Windows Server 2016, there's a variant called a Workgroup Cluster, which can be used with AGs only.

The WSFC itself needs a unique name in the domain (and DNS) and requires an object in AD DS called the cluster name object (CNO). Any named entity created within the WSFC needs a unique name and at least one IP address. If the configuration remains within a single region, IP addresses are in a single subnet. If the WSFC spans multiple regions, multiple IP addresses are associated with the WSFC and any AGs that are part of it.

A typical Azure-based WSFC will only require a single virtual network card (vNIC). Unlike on-premises setups, the IP address for the vNIC must be configured in Azure, not within the VM. Inside the VM, it appears as a dynamic (DHCP) address, which is expected. However, cluster validation generates a warning that can be safely ignored.

Considerations for the WSFC’s IP address also differ from on-premises setups. There's no way to reserve the IP address at the Azure level since it's fully maintained within the guest configuration. This means that if subsequent resources in Azure use DHCP, you must check for conflicts to avoid issues.

## Enable the failover clustering feature

To configure a WSFC, you need to enable the underlying Windows feature on each node that participates in the cluster. You can accomplish this using either the Server Manager or PowerShell.

In **Server Manager**, failover clustering must be enabled in the **Add Roles and Features Wizard**.

:::image type="content" source="../media/module-77-high-availability-final-08.png" alt-text="Using the Add Roles and Features Wizard to add the Failover Clustering feature":::

Run the following command to enable the feature via PowerShell, which will also install the utilities to administer a WSFC:

```powershell
Install-WindowsFeature Failover-Clustering -IncludeManagementTools
```

Once the feature is installed on the servers targeted as WSFC nodes, you must then validate the configuration.

## Validate the cluster

For a WSFC to be considered supported, it must pass cluster validation. Cluster validation is a built-in process that checks the nodes via a series of tests to ensure that the entire configuration is suitable for clustering. After the validation is complete, each of the tests will come back with an error, a warning, a pass, or a message that the test isn't applicable. Warnings are acceptable if that condition is expected in your environment. If not, it should be addressed. All errors must be resolved.

Validation can be run via Failover Cluster Manager or by using the Test-Cluster PowerShell cmdlet.

For FCIs, these tests also check the shared storage to ensure that the disks are configured correctly. For AGs with no shared storage, in Windows Server 2016 and later, the results come back as not applicable. For Windows Server 2012 R2, the disk tests show a warning when there are no shared disks. This state is expected.

Once the configuration is deemed valid by the cluster validation process, you can then create the WSFC.

## Create a Windows Server failover cluster

To create a WSFC properly in Azure, you can't use the Wizard in Failover Cluster Manager for FCIs or AGs deployed using Windows Server 2016 and earlier. Due to the DHCP issue mentioned earlier, currently the only way to create the WSFC is to use PowerShell and specify the IP address. This could change in future versions of Windows Server.

For a configuration that has shared storage, use the following syntax:

```powershell
New-Cluster -Name MyWSFC -Node Node1,Node2,…,NodeN -StaticAddress w.x.y.z
```

Where *MyWSFC* is the name of the WSFC you want, *Node1, Node2,…, NodeN* are the names of the nodes that participate in the WSFC, and *w.x.y.z* is the IP address of the WSFC. If you're creating a WSFC that spans multiple subnets, you can specify more than one IP address for **-StaticAddress** separated by commas.

For a configuration that doesn't have shared storage, add the -NoStorage option.

```powershell
New-Cluster -Name MyWSFC -Node Node1,Node2,…,NodeN -StaticAddress w.x.y.z -NoStorage
```

For a Workgroup Cluster that will only use DNS, the syntax is also slightly different.

```powershell
New-Cluster -Name MyWSFC -Node Node1,Node2,…,NodeN -StaticAddress w.x.y.z -NoStorage -AdministrativeAccessPoint DNS
```

A distributed network name is one that creates just a network name, but the IP address is tied to the underlying nodes. You no longer need to specify an IP address as shown above if it isn't needed or necessary. A distributed network name is for the WSFC’s name only; it can't be used with the name of an AG or FCI.

The WSFC creation mechanism detects if it's running in Azure or not and will create the cluster using a distributed network name unless you specify it differently. However, there are cases you may want to consider deploying a WSFC traditionally using PowerShell. For this, you need to add one more option: `-ManagementPointNetwork` with a value of `Singleton`. An example would look like this:

```powershell
New-Cluster -Name MyWSFC -Node Node1,Node2,…,NodeN -StaticAddress w.x.y.z -NoStorage -ManagementPointNetwork Singleton
```

For a Workgroup Cluster, you need to ensure the name and IP address are in DNS for any name or IP address created in the context of the WSFC such as the WSFC itself, an FCI name and IP address, and an AG listener name and IP address.

With Windows Server 2019, Microsoft changed how WSFCs are created by default in Azure. Instead of creating a network name and an IP address, it uses a distributed network name.

## Understand failover cluster instance

Failover Cluster Instances uses Windows Server Failover Clustering (WSFC) functionality to provide high availability through redundancy at the instance level.

An FCI is an instance of SQL Server that is installed across WSFC nodes and, possibly, across multiple subnets. On the network, an FCI appears as a single local instance that uses a virtual network name. Therefore, it becomes transparent for the application, since it doesn't know which node the instance is currently running on. As a result, there's no need to reconfigure clients and applications during or after a failover.

The multi-subnet support eliminates the need for a virtual LAN, which increases the protection and flexibility of a multi-subnet FCI. 

When you use multi-subnet, each subnet of the FCI is assigned a virtual IP address, and a failover occurs as follows.

- Virtual network names on DNS server are updated with virtual IP addresses corresponding to the respective subnets
- After a multi-subnet failover, clients and applications can then connect to the FCI via the same virtual network name.

To learn more about how multi-subnet works on FCI, see [SQL Server Multi-Subnet Clustering (SQL Server)](/sql/sql-server/failover-clusters/windows/sql-server-multi-subnet-clustering-sql-server).

### Distributed Network Name (DNN)

The distributed network name (DNN) replaces the virtual network name (VNN) as the connection point when used with FCI. As a result, the VNN no longer requires an Azure Load Balancing service.

The VNN still exists in an FCI deployment, but the clients connect to the DNN DNS name instead of the VNN name.

To learn how to configure a distributed network name for FCI, see [Configure a DNN for failover cluster instance](/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-distributed-network-name-dnn-configure).

## Test the Windows Server Failover Cluster

After creating the WSFC, but before configuring FCIs or AGs, ensure the WSFC is functioning correctly. For clusters requiring shared storage, like those supporting a SQL Server Failover Cluster Instance, test that all nodes can access and take ownership of the shared storage as they would during a failover.

You can do this by selecting **Storage**, then **Disks** in Failover Cluster Manager, as shown in the following image. If you right-click on each clustered disk device, you'll see the option **Move Available Storage**. If you choose the **Select Node...** option, you can force the storage to fail over to the other nodes in the cluster to confirm this functionality.

:::image type="content" source="../media/module-77-high-availability-final-09.png" alt-text="Testing the ability of nodes to access shared storage":::

Now that you understand the considerations for a WSFC in Azure, let’s look at the considerations for deploying the Always On features on top of a WSFC in Azure.
