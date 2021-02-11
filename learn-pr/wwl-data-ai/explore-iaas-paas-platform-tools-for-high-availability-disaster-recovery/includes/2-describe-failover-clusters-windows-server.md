For all availability configurations of availability groups (AGs), an underlying cluster is required. There are many aspects of setting up a cluster that you need to be aware of.

## Considerations for a Windows Server Failover Cluster in Azure

Deploying a Windows Server Failover Cluster (WSFC) in Azure is similar to configuring one on premises. There are some Azure-specific considerations, which is what this section will focus on.

One of the most important aspects is deciding what to use for a witness resource. Witness is a core component of the quorum mechanism. Quorum is what helps ensure that everything in the WSFC stays up and running. If you lose quorum, the WSFC will go down taking an AG or FCI with it. The witness resource can be a disk, file share (SMB 2.0 or later), or cloud witness. It is recommended that you use a cloud witness as it is fully Azure-based, especially for solutions that will span multiple Azure regions or are hybrid. The cloud witness feature is available in Windows Server 2016 and later.

The next consideration is the Microsoft Distributed Transaction Coordinator (DTC or MSDTC). Some applications use it, but the majority of applications do not. If you require DTC and are deploying an AG or FCI, you should cluster DTC. Clustering DTC requires a shared disk to work properly even though you may not require one otherwise, as in the case of an AG.

Most WSFC deployments require the use of both AD DS and DNS; FCIs always do. AGs can be configured without requiring AD DS but still needing DNS. In Windows Server 2016, there is a variant of a WSFC called a Workgroup Cluster, which can be used with AGs only.

The WSFC itself needs a unique name in the domain (and DNS) and requires an object in AD DS called the cluster name object (CNO). Anything created in context of the WSFC that has a name will require a unique name, as well as at least one IP address. If the configuration will stay in a single region, IP addresses will be in a single subnet. If the WSFC will span multiple regions, more than one IP address will be associated with the WSFC, as well as an AG if it spans multiple regions as part of the WSFC.

A typical Azure-based WSFC will only require a single virtual network card (vNIC). Unlike the setup for an on-premises physical or virtual server, the IP address for the vNIC has to be configured in Azure, not in the VM. That means inside the VM it will show up as a dynamic (DHCP) address. This is expected, however cluster validation will generate a warning that can safely be ignored.

Considerations for the WSFC’s IP address is also different from on premises. There is no way to reserve the IP address at the Azure level since it is fully maintained within the guest configuration. This means that if subsequent resources that use an IP address in Azure use DHCP, you must check for conflicts.

## The failover clustering feature

Before a WSFC can be configured, the underlying Windows feature must be enabled on every node that will participate in the WSFC. This can be done in one of two ways: using the Server Manager or via PowerShell.

In Server Manager, Failover Clustering must be enabled in the Add Roles and Features Wizard.

:::image type="content" source="../media/module-77-high-availability-final-08.png" alt-text="Using the Add Roles and Features Wizard to add the Failover Clustering feature":::

To enable the feature via PowerShell, use the following command, which will also install the utilities, which will be used to administer a WSFC:

```powershell
Install-WindowsFeature Failover-Clustering -IncludeManagementTools
```

Once the feature is installed on the servers targeted as WSFC nodes, you must then validate the configuration.

## Cluster validation

For a WSFC to be considered supported, it must pass cluster validation. Cluster validation is a built-in process that checks the nodes via a series of tests to ensure that the entire configuration is suitable for clustering. After running validation, each of the tests will come back with an error, a warning, a pass, or a message that the test is not applicable. Warnings are acceptable if that condition is expected in your environment. If not, it should be addressed. All errors must be resolved.

Validation can be run via Failover Cluster Manager or by using the Test-Cluster PowerShell cmdlet.

For FCIs, these tests also check the shared storage to ensure that the disks are configured correctly. For AGs with no shared storage, in Windows Server 2016 and later, the results will come back as not applicable. For Windows Server 2012 R2, the disk tests will show a warning when there are no shared disks. This state is expected.

Once the configuration is deemed valid by the cluster validation process, you can then create the WSFC.

## Create a Windows Server Failover Cluster

To create a WSFC properly in Azure, you cannot use the Wizard in Failover Cluster Manager for FCIs or AGs deployed using Windows Server 2016 and earlier. Due to the DHCP issue mentioned earlier, currently the only way to create the WSFC is to use PowerShell and specify the IP address. This could change in future versions of Windows Server.

For a configuration that has shared storage, use the following syntax:

```powershell
New-Cluster -Name MyWSFC -Node Node1,Node2,…,NodeN -StaticAddress w.x.y.z
```

where MyWSFC is the name of the WSFC you want, Node1, Node2,…, NodeN are the names of the nodes that will participate in the WSFC, and w.x.y.z is the IP address of the WSFC (for example: 10.252.1.100.) If you are creating a WSFC that spans multiple subnets, you can specify more than one IP address for -StaticAddress separated by commas.

For a configuration that does not have shared storage, add the -NoStorage option.

```powershell
New-Cluster -Name MyWSFC -Node Node1,Node2,…,NodeN -StaticAddress w.x.y.z -NoStorage
```

For a Workgroup Cluster that will only use DNS, the syntax is also slightly different.

```powershell
New-Cluster -Name MyWSFC -Node Node1,Node2,…,NodeN -StaticAddress w.x.y.z -NoStorage -AdministrativeAccessPoint DNS
```

Windows Server 2019 by default will use a distributed network name for IaaS. A distributed network name is one that creates just a network name, but the IP address is tied to the underlying nodes. You no longer need to specify an IP address as shown above if it is not needed or necessary. A distributed network name is for the WSFC’s name only; it cannot be used with the name of an AG or FCI.

The WSFC creation mechanism in Windows Server 2019 detects if it is running in Azure or not and will create the cluster using a distributed network name unless you tell it to do something else. Currently, distributed network names are incompatible with FCIs and while they do work with AGs, if you encounter an issue, you may want to consider deploying a WSFC traditionally using PowerShell. You need to add one more option: `-ManagementPointNetwork` with a value of `Singleton`. An example would look like this:

```powershell
New-Cluster -Name MyWSFC -Node Node1,Node2,…,NodeN -StaticAddress w.x.y.z -NoStorage -ManagementPointNetwork Singleton
```

For a Workgroup Cluster, you will need to ensure the name and IP address(es) are in DNS for any name or IP address created in the context of the WSFC such as the WSFC itself, an FCI name and IP address, and an AG listener name and IP address.

With Windows Server 2019, Microsoft changed how WSFCs are created by default in Azure. Instead of creating a network name and an IP address, it uses a distributed network name. This is not yet supported with either of the Always On features, so it is still required to create the WSFC using the method described above.

## Test the Windows Server Failover Cluster

After the WSFC is created but before configuring FCIs or AGs, test that the WSFC is working properly For clusters that require shared storage, such as for those supporting a SQL Server Failover Cluster Instance, it is important that your test the ability for all of the nodes in the cluster to access any shared storage, and to take ownership of the storage as they would in a failover. You can do this by clicking on Storage, then Disks in Failover Cluster Manager, as shown in the image below. If you right-click on each clustered disk device, you will see the option **Move Available Storage.** If you choose the Select Node option, you can force the storage to fail over to the other nodes in the cluster to confirm this functionality.

:::image type="content" source="../media/module-77-high-availability-final-09.png" alt-text="Testing the ability of nodes to access shared storage":::

Now that you understand the considerations for a WSFC in Azure, let’s look at the considerations for deploying the Always On features on top of a WSFC in Azure.
