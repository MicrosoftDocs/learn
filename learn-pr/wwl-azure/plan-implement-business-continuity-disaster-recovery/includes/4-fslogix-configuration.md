The FSLogix agent can support multiple profile locations if you configure the registry entries for FSLogix.

To configure the registry entries:

1.  Open the **Registry Editor**.
2.  Go to **Computer &gt; HKEY\_LOCAL\_MACHINE &gt; SOFTWARE &gt; FSLogix &gt; Profiles**.
3.  Right-click on **VHDLocations** and select **Edit Multi-String**.
4.  In the **Value Data** field, enter the locations you want to use.
5.  When you're done, select **OK**.

If the first location is unavailable, the FSLogix agent will automatically fail over to the second, and so on.

It's recommended you configure the FSLogix agent with a path to the secondary location in the main region. Once the primary location shuts down, the FLogix agent will replicate as part of the VM Azure Site Recovery replication. Once the replicated VMs are ready, the agent will automatically attempt to path to the secondary region.

## Example scenario

Let's say your primary session host VMs are in the Central US region, but your profile container is in the Central US region for performance reasons.

In this case, you would configure the FSLogix agent with a path to the storage in Central US. You would configure the session host VMs to replicate in West US. Once the path to Central US fails, the agent will try to create a new path for storage in West US instead.

## S2D

Since S2D handles replication across regions internally, you don't need to manually set up the secondary path.

## Network drives (VM with extra drives)

If you replicate the network storage VMs using Azure Site Recovery like the session host VMs, then the recovery keeps the same path, which means you don't need to reconfigure FSlogix.

## Azure Files

Azure Files supports cross-region asynchronous replication that you can specify when you create the storage account. If the asynchronous nature of Azure Files already covers your disaster recovery goals, then you don't need to do additional configuration.

If you need synchronous replication to minimize data loss, then we recommend you use FSLogix Cloud Cache instead.
