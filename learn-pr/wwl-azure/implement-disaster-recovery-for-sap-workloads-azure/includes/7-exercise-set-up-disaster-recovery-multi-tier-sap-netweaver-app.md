You can use Azure Site Recovery to orchestrate the failover of full SAP deployment across Azure regions. This unit details the steps for replicating virtual machines for disaster recovery for a multi-tier SAP NetWeaver app deployment, and is part 1 of the setup for disaster recovery using Azure Site Recovery. When relying on Azure Site Recovery to implement disaster recovery for SAP deployments across Azure regions, you would use the following, full sequence of steps:

1. Replicate virtual machines
2. Design a recovery network
3. Replicate a domain controller
4. Replicate database tier
5. Perform a test failover
6. Perform a failover

## Replicate virtual machines

These steps describe how to set up disaster recovery for Azure Virtual Machines by replicating them from one Azure region to another:

1. Create a Recovery Services vault.
2. Verify target resource settings.
3. Set up outbound network connectivity for virtual machines.
4. Configure replication.

### Create a Recovery Services vault

Create the vault in any region, except the source region.

1. Sign in to the Azure portal &gt; **Recovery Services**.
2. Select **Create a resource** &gt; **Management Tools** &gt; **Backup and Site Recovery**.
3. In **Name**, specify a friendly name to identify the vault. If you have more than one subscription, select the appropriate one.
4. Create a resource group or select an existing one.
5. Specify an Azure region.

### Verify target resource settings

1. Verify that your Azure subscription allows you to create virtual machines in the target region. Contact support to enable the required quota.
2. Make sure your subscription has enough resources to support virtual machine sizes that match your source virtual machines. Site Recovery automatically selects the same size, or the closest possible size, for the target virtual machine.

### Set up outbound network connectivity for virtual machines

For Site Recovery to work as expected, you need to allow outbound network connectivity from the virtual machines that you want to replicate. If you're using a URL-based firewall proxy to control outbound connectivity, allow access to these URLs.

| Name | Commercial | Government | Description |
|--|--|--|--|
| Storage | `*.blob.core.windows.net` | `*.blob.core.usgovcloudapi.net` | Allows data to be written from the virtual machine to the cache storage account in the source region. |
| Microsoft Entra ID | `login.microsoftonline.com` | `login.microsoftonline.us` | Provides authorization and authentication to Site Recovery service URLs. |
| Replication | `*.hypervrecoverymanager.windowsazure.com` | `*.hypervrecoverymanager.windowsazure.com` | Allows the virtual machine to communicate with the Site Recovery service. |
| Service Bus | `*.servicebus.windows.net` | `*.servicebus.usgovcloudapi.net` | Allows the virtual machine to write Site Recovery monitoring and diagnostics data. |

> [!NOTE]
> Site Recovery doesn't support using an authentication proxy to control network connectivity.

### Verify Azure Virtual Machine certificates

Check that the virtual machines you want to replicate have the latest root certificates. If they don't, the virtual machine can't be registered to Site Recovery, due to security constraints.

- For Windows virtual machines, install all the latest Windows updates on the virtual machine, so that all the trusted root certificates are on the machine. In a disconnected environment, follow the standard Windows Update and certificate update processes for your organization.
- For Linux virtual machines, follow the guidance provided by your Linux distributor, to get the latest trusted root certificates and certificate revocation list on the virtual machine.

### Set permissions on the account

Azure Site Recovery provides three built-in RBAC roles to control Site Recovery management operations.

- Site Recovery Contributor - This role has all permissions required to manage Azure Site Recovery operations in a Recovery Services vault. A user with this role, however, can't create or delete a Recovery Services vault or assign access rights to other users. This role is best suited for disaster recovery administrators who can enable and manage disaster recovery for applications or entire organizations.
- Site Recovery Operator - This role has permissions to execute and manage Failover and Failback operations. A user with this role can't enable or disable replication, create or delete vaults, register new infrastructure, or assign access rights to other users. This role is best suited for a disaster recovery operator who can fail over virtual machines or applications when instructed by application owners and IT administrators. Post resolution of the disaster, the DR operator can reprotect and failback the virtual machines.
- Site Recovery Reader - This role has permissions to view all Site Recovery management operations. This role is best suited for an IT monitoring executive who can monitor the current state of protection and raise support tickets.

### Enable replication for a virtual machine

#### Select the source

1. In **Recovery Services vaults**, select the vault name &gt; **+Replicate**.
2. In **Source**, select **Azure**.
3. In **Source location**, select the source Azure region where your virtual machines are currently running.
4. Select the **Source subscription** where the virtual machines are running. This can be any subscription within the same Microsoft Entra tenant where your recovery services vault exists.
5. Select the **Source resource group**, and select **OK** to save the settings.

#### Select the virtual machines

Site Recovery retrieves a list of the virtual machines associated with the subscription and resource group/cloud service.

1. In **Virtual Machines**, select the virtual machines you want to replicate.
2. Select **OK**.

#### Configure replication settings

Site Recovery creates default settings and replication policy for the target region. You can change the settings as required.

1. Select **Settings** to view the target and replication settings.
2. To override the default target settings, select **Customize** next to **Resource group, Network, Storage, and Availability**.
3. Customize target settings as summarized in the table.

    | Setting | Details |
    |--|--|
    | **Target subscription** | By default, the target subscription is the same as the source subscription. Select **Customize** to select a different target subscription within the same Microsoft Entra tenant. |
    | **Target location** | The target region used for disaster recovery. We recommend that the target location matches the location of the Site Recovery vault. |
    | **Target resource group** | The resource group in the target region that holds Azure Virtual Machines after failover. By default, Site Recovery creates a new resource group in the target region with an `asr` suffix. The location of the target resource group can be any region except the region in which your source virtual machines are hosted. |
    | **Target virtual network** | The network in the target region that virtual machines are located after failover. By default, Site Recovery creates a new virtual network (and subnets) in the target region with an `asr` suffix. |
    | **Cache storage accounts** | Site Recovery uses a storage account in the source region. Changes to source virtual machines are sent to this account before replication to the target location.<br><br>If you're using a firewall-enabled cache storage account, make sure that you enable **Allow trusted Microsoft services**. [Learn more](/azure/storage/common/storage-network-security). Also, ensure that you allow access to at least one subnet of the source virtual network. |
    | **Target storage accounts (source virtual machine uses non-managed disks)** | By default, Site Recovery creates a new storage account in the target region to mirror the source virtual machine storage account.<br><br>Enable **Allow trusted Microsoft services** if you're using a firewall-enabled cache storage account. |
    | **Replica managed disks (If source virtual machine uses managed disks)** | By default, Site Recovery creates replica managed disks in the target region to mirror the source virtual machine's managed disks with the same storage type (standard or premium) as the source virtual machine's managed disk. You can only customize Disk type. |
    | **Target availability sets** | By default, Azure Site Recovery creates a new availability set in the target region with name having `asr` suffix for the virtual machines part of an availability set in source region. In case availability set created by Azure Site Recovery already exists, it's reused. |
    | **Target availability zones** | By default, Site Recovery assigns the same zone number as the source region in target region if the target region supports availability zones.<br><br>If the target region doesn't support availability zones, the target virtual machines are configured as single instances by default.<br><br>Select **Customize** to configure virtual machines as part of an availability set in the target region.<br><br>You can't change the availability type (single instance, availability set, or availability zone) after you enable replication. To change the availability type, disable and enable replication. |

4. To customize replication policy settings, select **Customize next** to **Replication policy**, and modify the settings as needed.

    | Setting | Details |
    |--|--|
    | **Replication policy name** | Policy name. |
    | **Recovery point retention** | By default, Site Recovery keeps recovery points for 24 hours. You can configure a value between 1 and 72 hours. |
    | **App-consistent snapshot frequency** | By default, Site Recovery takes an app-consistent snapshot every 4 hours. You can configure any value between 1 and 12 hours.<br><br>An app-consistent snapshot is a point-in-time snapshot of the application data inside the virtual machine. Volume Shadow Copy Service (VSS) ensures that apps on the virtual machine are in a consistent state when the snapshot is taken. |
    | **Replication group** | If your application needs multi-virtual machine consistency across virtual machines, you can create a replication group for those virtual machines. By default, the selected virtual machines aren't part of any replication group. |

5. In **Customize**, select **Yes** for multi-virtual machine consistency if you want to add virtual machines to a new or existing replication group. Then select **OK**.

- All the machines in a replication group have shared crash consistent and app-consistent recovery points when failed over.
- Enabling multi-virtual machine consistency can impact workload performance (it's CPU intensive). It should be used only if machines are running the same workload, and you need consistency across multiple machines.
- You can have a maximum of 16 virtual machines in a replication group.
- If you enable multi-virtual machine consistency, machines in the replication group communicate with each other over port 20004. Make sure there's no firewall blocking the internal communication between the virtual machines over this port.
- For Linux virtual machines in a replication group, ensure the outbound traffic on port 20004 is manually opened in accordance with guidance for the Linux version.

### Configure encryption settings

If the source virtual machine has Azure disk encryption (ADE) enabled, review the settings.

1. Verify the settings:

     - **Disk encryption key vaults**: By default, Site Recovery creates a new key vault on the source virtual machine disk encryption keys, with an `asr` suffix. If the key vault already exists, it's reused.
     - **Key encryption key vaults**: By default, Site Recovery creates a new key vault in the target region. The name has an `asr` suffix and is based on the source virtual machine encryption keys. If the key vault created by Site Recovery already exists, it's reused.
2. Select **Customize** to select custom key vaults.

> [!NOTE]
> Only Azure Virtual Machines running Windows operating systems and enabled for encryption with Microsoft Entra app are currently supported by Azure Site Recovery.

### Track replication status

1. In **Settings**, select **Refresh** to get the latest status.
2. Track progress of the **Enable protection** job in **Settings** &gt; **Jobs** &gt; **Site Recovery Jobs**.
3. In **Settings** &gt; **Replicated Items**, you can view the status of virtual machines and the initial replication progress. Select the virtual machine to drill down into its settings.
