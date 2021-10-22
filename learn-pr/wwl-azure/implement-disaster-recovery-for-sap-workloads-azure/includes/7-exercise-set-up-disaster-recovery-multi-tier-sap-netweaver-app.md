You can use Azure Site Recovery to orchestrate the failover of full SAP deployment across Azure regions. This topic details the steps for replicating virtual machines for disaster recovery for a multi-tier SAP NetWeaver app deployment, and is part 1 of the setup for disaster recovery using Azure Site Recovery. When relying on Azure Site Recovery to implement disaster recovery for SAP deployments across Azure regions, you would use the following, full sequence of steps:

1.  Replicate virtual machines<br>
2.  Design a recovery network
3.  Replicate a domain controller
4.  Replicate database tier
5.  Perform a test failover
6.  Perform a failover

## Replicate virtual machines<br>

These steps describe how to set up disaster recovery for Azure VMs by replicating them from one Azure region to another:

1.  Create a Recovery Services vault.
2.  Verify target resource settings.
3.  Set up outbound network connectivity for VMs.
4.  Configure replication.

### Create a Recovery Services vault

Create the vault in any region, except the source region.

1.  Sign in to the Azure portal &gt; **Recovery Services**.
2.  Select **Create a resource** &gt; **Management Tools** &gt; **Backup and Site Recovery**.
3.  In **Name**, specify a friendly name to identify the vault. If you have more than one subscription, select the appropriate one.
4.  Create a resource group or select an existing one.
5.  Specify an Azure region.

### Verify target resource settings

1.  Verify that your Azure subscription allows you to create VMs in the target region. Contact support to enable the required quota.
2.  Make sure your subscription has enough resources to support VM sizes that match your source VMs. Site Recovery automatically selects the same size, or the closest possible size, for the target VM.

### Set up outbound network connectivity for VMs

For Site Recovery to work as expected, you need to allow outbound network connectivity from the VMs that you want to replicate. If you're using a URL-based firewall proxy to control outbound connectivity, allow access to these URLs.

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Commercial**
  :::column-end:::
  :::column:::
    **Government**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage
  :::column-end:::
  :::column:::
    `*.blob.core.windows.net`
  :::column-end:::
  :::column:::
    `*.blob.core.usgovcloudapi.net`
  :::column-end:::
  :::column:::
    Allows data to be written from the VM to the cache storage account in the source region.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Active Directory
  :::column-end:::
  :::column:::
    `login.microsoftonline.com`
  :::column-end:::
  :::column:::
    `login.microsoftonline.us`
  :::column-end:::
  :::column:::
    Provides authorization and authentication to Site Recovery service URLs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Replication
  :::column-end:::
  :::column:::
    `*.hypervrecoverymanager.windowsazure.com`
  :::column-end:::
  :::column:::
    `*.hypervrecoverymanager.windowsazure.com`
  :::column-end:::
  :::column:::
    Allows the VM to communicate with the Site Recovery service.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Service Bus
  :::column-end:::
  :::column:::
    `*.servicebus.windows.net`
  :::column-end:::
  :::column:::
    `*.servicebus.usgovcloudapi.net`
  :::column-end:::
  :::column:::
    Allows the VM to write Site Recovery monitoring and diagnostics data.
  :::column-end:::
:::row-end:::


> [!NOTE]
> Site Recovery doesn't support using an authentication proxy to control network connectivity.

### Verify Azure VM certificates

Check that the VMs you want to replicate have the latest root certificates. If they don't, the VM can't be registered to Site Recovery, due to security constraints.

 -  For Windows VMs, install all the latest Windows updates on the VM, so that all the trusted root certificates are on the machine. In a disconnected environment, follow the standard Windows Update and certificate update processes for your organization.
 -  For Linux VMs, follow the guidance provided by your Linux distributor, to get the latest trusted root certificates and certificate revocation list on the VM.

### Set permissions on the account

Azure Site Recovery provides three built-in RBAC roles to control Site Recovery management operations.

 -  Site Recovery Contributor - This role has all permissions required to manage Azure Site Recovery operations in a Recovery Services vault. A user with this role, however, can't create or delete a Recovery Services vault or assign access rights to other users. This role is best suited for disaster recovery administrators who can enable and manage disaster recovery for applications or entire organizations.
 -  Site Recovery Operator - This role has permissions to execute and manage Failover and Failback operations. A user with this role can't enable or disable replication, create or delete vaults, register new infrastructure, or assign access rights to other users. This role is best suited for a disaster recovery operator who can fail over virtual machines or applications when instructed by application owners and IT administrators. Post resolution of the disaster, the DR operator can reprotect and failback the virtual machines.
 -  Site Recovery Reader - This role has permissions to view all Site Recovery management operations. This role is best suited for an IT monitoring executive who can monitor the current state of protection and raise support tickets.

### Enable replication for a VM

#### Select the source

1.  In **Recovery Services vaults**, select the vault name &gt; **+Replicate**.
2.  In **Source**, select **Azure**.
3.  In **Source location**, select the source Azure region where your VMs are currently running.
4.  Select the **Source subscription** where the virtual machines are running. This can be any subscription within the same Azure Active Directory tenant where your recovery services vault exists.
5.  Select the **Source resource group**, and select **OK** to save the settings.

#### Select the VMs

Site Recovery retrieves a list of the VMs associated with the subscription and resource group/cloud service.

1.  In **Virtual Machines**, select the VMs you want to replicate.
2.  Select **OK**.

#### Configure replication settings

Site Recovery creates default settings and replication policy for the target region. You can change the settings as required.

1.  Select **Settings** to view the target and replication settings.
2.  To override the default target settings, select **Customize** next to **Resource group, Network, Storage, and Availability**.
3.  Customize target settings as summarized in the table.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Details**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Target subscription**
      :::column-end:::
      :::column:::
        By default, the target subscription is the same as the source subscription. Select **Customize** to select a different target subscription within the same Azure Active Directory tenant.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Target location**
      :::column-end:::
      :::column:::
        The target region used for disaster recovery.
    
    We recommend that the target location matches the location of the Site Recovery vault.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Target resource group**
      :::column-end:::
      :::column:::
        The resource group in the target region that holds Azure VMs after failover.
    
    By default, Site Recovery creates a new resource group in the target region with an `asr` suffix. The location of the target resource group can be any region except the region in which your source virtual machines are hosted.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Target virtual network**
      :::column-end:::
      :::column:::
        The network in the target region that VMs are located after failover.
    
    By default, Site Recovery creates a new virtual network (and subnets) in the target region with an `asr` suffix.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Cache storage accounts**
      :::column-end:::
      :::column:::
        Site Recovery uses a storage account in the source region. Changes to source VMs are sent to this account before replication to the target location.
    
    If you're using a firewall-enabled cache storage account, make sure that you enable **Allow trusted Microsoft services**. [Learn more](/azure/storage/common/storage-network-security). Also, ensure that you allow access to at least one subnet of the source Vnet.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Target storage accounts (source VM uses non-managed disks)**
      :::column-end:::
      :::column:::
        By default, Site Recovery creates a new storage account in the target region to mirror the source VM storage account.
    
    Enable **Allow trusted Microsoft services** if you're using a firewall-enabled cache storage account.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Replica managed disks (If source VM uses managed disks)**
      :::column-end:::
      :::column:::
        By default, Site Recovery creates replica managed disks in the target region to mirror the source VM's managed disks with the same storage type (standard or premium) as the source VM's managed disk. You can only customize Disk type.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Target availability sets**
      :::column-end:::
      :::column:::
        By default, Azure Site Recovery creates a new availability set in the target region with name having `asr` suffix for the VMs part of an availability set in source region. In case availability set created by Azure Site Recovery already exists, it's reused.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Target availability zones**
      :::column-end:::
      :::column:::
        By default, Site Recovery assigns the same zone number as the source region in target region if the target region supports availability zones.
    
    If the target region doesn't support availability zones, the target VMs are configured as single instances by default.
    
    Select **Customize** to configure VMs as part of an availability set in the target region.
    
    You can't change the availability type (single instance, availability set, or availability zone) after you enable replication. To change the availability type, disable and enable replication.
      :::column-end:::
    :::row-end:::
    
4.  To customize replication policy settings, select **Customize next** to **Replication policy**, and modify the settings as needed.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Details**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Replication policy name**
      :::column-end:::
      :::column:::
        Policy name.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Recovery point retention**
      :::column-end:::
      :::column:::
        By default, Site Recovery keeps recovery points for 24 hours. You can configure a value between 1 and 72 hours.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **App-consistent snapshot frequency**
      :::column-end:::
      :::column:::
        By default, Site Recovery takes an app-consistent snapshot every 4 hours. You can configure any value between 1 and 12 hours.
    
    An app-consistent snapshot is a point-in-time snapshot of the application data inside the VM. Volume Shadow Copy Service (VSS) ensures that app on the VM are in a consistent state when the snapshot is taken.
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Replication group**
      :::column-end:::
      :::column:::
        If your application needs multi-VM consistency across VMs, you can create a replication group for those VMs. By default, the selected VMs are not part of any replication group.
      :::column-end:::
    :::row-end:::
    
5.  In **Customize**, select **Yes** for multi-VM consistency if you want to add VMs to a new or existing replication group. Then select **OK**.

 -  All the machines in a replication group have shared crash consistent and app-consistent recovery points when failed over.
 -  Enabling multi-VM consistency can impact workload performance (it's CPU intensive). It should be used only if machines are running the same workload, and you need consistency across multiple machines.
 -  You can have a maximum of 16 VMs in a replication group.
 -  If you enable multi-VM consistency, machines in the replication group communicate with each other over port 20004. Make sure there's no firewall blocking the internal communication between the VMs over this port.
 -  For Linux VMs in a replication group, ensure the outbound traffic on port 20004 is manually opened in accordance with guidance for the Linux version.

### Configure encryption settings

If the source VM has Azure disk encryption (ADE) enabled, review the settings.

1.  Verify the settings:
    
     -  **Disk encryption key vaults**: By default, Site Recovery creates a new key vault on the source VM disk encryption keys, with an "asr" suffix. If the key vault already exists, it is reused.
     -  **Key encryption key vaults**: By default, Site Recovery creates a new key vault in the target region. The name has an "asr" suffix and is based on the source VM encryption keys. If the key vault created by Site Recovery already exists, it's reused.
2.  Select **Customize** to select custom key vaults.

> [!NOTE]
> Only Azure VMs running Windows operating systems and enabled for encryption with Azure AD app are currently supported by Azure Site Recovery.

### Track replication status

1.  In **Settings**, select **Refresh** to get the latest status.
2.  Track progress of the **Enable protection** job in **Settings** &gt; **Jobs** &gt; **Site Recovery Jobs**.
3.  In **Settings** &gt; **Replicated Items**, you can view the status of VMs and the initial replication progress. Select the VM to drill down into its settings.
