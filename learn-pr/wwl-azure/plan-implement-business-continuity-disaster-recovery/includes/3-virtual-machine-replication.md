You'll need to replicate your VMs to the secondary location for Azure Virtual Desktop. Your options for doing so depend on how your VMs are configured:

 -  You can configure all your VMs for both pooled and personal host pools with Azure Site Recovery. With this method, you'll only need to set up one host pool and its related app groups and workspaces.
 -  You can create a new host pool in the failover region while keeping all resources in your failover location turned off.
 -  You need to set up new app groups and workspaces in the failover region, then use an Azure Site Recovery plan to turn on host pools.
 -  You can create a host pool that's populated by VMs built in both the primary and failover regions while keeping the VMs in the failover region turned off.
 -  You only need to set up one host pool and its related app groups and workspaces.
 -  You can use an Azure Site Recovery plan to power on host pools with this method.

Use Azure Site Recovery to manage replicating VMs in other Azure locations, as described in [Azure-to-Azure disaster recovery architecture](https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/site-recovery/azure-to-azure-architecture.md).

Set up Azure Site Recovery by replicating an Azure VM to a different Azure region directly from the Azure portal. Site Recovery is automatically updated with new Azure features as they’re released.

:::image type="content" source="../media/azure-virtual-desktop-site-recovery-1-71f7b63a.png" alt-text="An image of an Azure virtual machine replicating to a different Azure region.":::


Use Azure Site Recovery for personal host pools, because Azure Site Recovery supports both server-based and client-based SKUs.

If you use Azure Site Recovery, you won't need to register VMs manually.

 -  The Azure Virtual Desktop agent in the secondary VM will automatically use the latest security token to connect to the service instance closest to it.
 -  The VM (session host) in the secondary location will automatically become part of the host pool.
 -  The end user will have to reconnect during the process.

If there are existing user connections during the outage, before the admin can start failover to the secondary region, you need to end the user connections in the current region.

Once you've signed out all users in the primary region, you can fail over the VMs in the primary region and let users connect to the VMs in the secondary region.
