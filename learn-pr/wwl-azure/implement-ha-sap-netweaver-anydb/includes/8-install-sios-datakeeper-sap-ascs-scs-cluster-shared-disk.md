You now have a working Windows Server failover clustering configuration in Azure. To install an SAP ASCS/SCS instance, you need either a shared disk resource or a highly available share. There's no built-in support for shared disk resources for Azure Virtual Machines. SIOS DataKeeper Cluster Edition is a third-party solution that you can use to emulate a shared disk.

Implementing SIOS DataKeeper Cluster Edition for the SAP ASCS/SCS cluster share disk involves these tasks:

- Adding Microsoft .NET Framework 3.5
- Installing SIOS DataKeeper
- Configuring SIOS DataKeeper

The goal of the configuration is to implement synchronous data replication between the extra disks that are attached to each of the virtual machines.

For details regarding setting up a highly available file share in Azure by using Storage Spaces Direct (S2D) Scale-Out File Server (SOFS), refer to [Deploy a two-node Storage Spaces Direct scale-out file server for UPD storage in Azure](/windows-server/remote/remote-desktop-services/rds-storage-spaces-direct-deployment).
