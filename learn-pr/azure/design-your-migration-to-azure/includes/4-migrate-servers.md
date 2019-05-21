After running Azure Migrate a decision can be made about which of your servers make good candidates to be migrated to Azure. Azure Site Recovery is another migration tool provided by Microsoft. It is normally used to manage disaster recovery of on-premise machines, but its ability to manage failing over between machines means it's a great tool for migration as well.

You have presented your findings to the IT Director and you now wish to proceed with several test migrations to assess the end to end process. You have chosen to use Azure Site Recovery as the tool to complete the migrations.

In this unit, you'll review Azure Site Recovery and how it can be used to migrate specific workloads to Azure.

## What is Azure Site Recovery?

Azure Site Recovery is designed to manage a disaster recovery plan, and has the ability to replicate workloads from a primary site to a secondary site in the event of an outage. When an issue occurs at the primary site, the Site Recovery service can be automatically invoked and the virtual machines that are protected will be replicated to a secondary location to continue running. The failover could be an on-premises to Azure failover, or a failover from one Azure region to another. In support of your objective, you'll use its ability to migrate VMware workloads to Azure, unlike a failover which can be reversed, a migration is a one time operation.

Some of the features of Site Recovery are:

- **On Premise VM Replication** - Replicate an on-premises environment to a secondary location such as Azure for disaster recovery
- **Flexible failovers** - The ability to failover to the secondary environment at any time, as part of a test without impacting the live environment or as part of a full disaster recovery scenario
- **Customized recovery plans** - Fully automated recovery plans that can automate a failover to a secondary environment using the support of scripts if required
- **Operating system support** - The ability to replicate and provide protection for Azure virtual machines, VMware virtual machines and physical Windows servers

## Preparation and Pre-requisites 

Before you can start to use Site Recovery for either a failover or a straight migration you need to ensure several things are in place to be able to use the service, they are:

- **Account Permissions** - Your Azure account must either be the administrator account or be an account with the permissions to 'Create a VM in the selected resource group', 'Create a VM in the selected virtual network', 'Write to an Azure storage account', and 'Write to an Azure managed disk'
- **Recovery Services vault**- Create a Recovery Services Vault which you'll use to store your virtual machines
- **Azure network** - The migrated virtual machines will connect using a virtual network, routing and firewall rules should be in place for it to be reachable internally from your on-premises network.

## Preparing the VMware environment

For your company you are primarly focused on moving VMware and database workloads to Azure. Azure Site Recovery also supports replicating on-premise hardware and Hyper-V workloads. Please see the summary for more information on moving these kinds of workloads to Azure.

The above section focused on Azure tasks, this section details the preparation that needs to take place on the on-premises VMware estate to ensure connectivity to Azure.

- **Automatic discovery account** - An account needs to be created at vCenter level, be given a name and then assigned the relevant permissions.
- **Mobility service account**- The Mobility service needs to be installed on each virtual machine which is done via a push installation from the Azure console or a manual install. If using the push installation the account needs permission to install software on to each of the virtual machines.
- **Connection after migration** - To be able to connect after the migration, you should ensure Remote Desktop Protocol (RDP) is enabled on each virtual machine and that the Windows Firewall is configured appropriately **before** migration.
- **Setup the configuration server** - The configuration server co-ordinates the communication between the on-premises environment and Azure. It is packaged in an 'Open Virtualization Application' (OVA) template which should be deployed to a highly available virtual machine on the VMware environment.

## Migrating on-premise to Azure

There are also several settings that need to be configured for the task of migrating on-premises virtual machines to Azure, they are:

- **Set a protection goal** - This sets the scope of the replication, what you want to replicate and where you wish to replicate it to. For VMware environments it would be a protection goal of, on-premise migration to Azure using the VMware vSphere Hypervisor
- **Setup the target environment** - The target environment is set in the portal by selecting the Azure subscription and Resource Manger deployment model you wish to use. Migrating VMware to Azure should be selected, Site Recovery verifies that a valid network exists in Azure that the virtual machines will be connected to post migration
- **Create a replication policy** - A replication policy contains settings such as a Recovery Point Objective (RPO) threshold. The policy is associated with the configuration server that has been deployed which is completed in the Azure portal, within the replication policy
- **Enable replication** - Once all the other tasks are complete replication can be enabled at the Recovery Service vault level. 
    - To enable replication the Source has to be configured, (the source is the configuration server, the machine type are 'virtual machines', the vSphere host is the vCenter server on-premises and the process server is the configuration server.)
    - The target has to be configured, (on the target selection, the target is Azure, the subscription is your Azure subscription, the resource group is your target resource group for the replicated virtual machines, the network selection is the target network you want migrated virtual machines to connect to, and the subnet is that of the target network)
    - Select the virtual machines to migrate, a filled white tick is visible next to the machine name when selected
    - Configure the properties by selecting the domain account used by the process server to install the Mobility service on the VMware machines, disks that are not required to be replicated can be de-selected, by default all disks associated with a virtual machine are migrated
    - Select the replication policy, this policy sets the App-consistent snapshot frequency, RPO threshold and recovery point retention period.

## Starting the migration

Once the steps to configure the source and target environments are complete the migration can take place.

In the Azure portal, **Settings > Replicated items, select the machine and then > Failover**. Select the recovery point from which the virtual machine should failover/migrate to, and then select to have the machine shut down before beginning failover. After a period of time, check to ensure the virtual machine appears in Azure, once it does, in the replicated items menu, right click the virtual machine and then select **Complete Migration** which will finish the current migration and tidy up any temporary migration data.

## Post migration steps

After the migration has taken place clean up tasks are needed to ensure that the re-platformed machines and the applications on them work as you would expect.

Cleanup tasks vary by environment but one example would be to ensure full connectivity to the machines via Remote Desktop Connection or updating any connection strings for databases or web apps, any applications installed should have full user acceptance testing before a sign off as a successful migration.

After the migration the security settings of the virtual machine should be reviewed and restrict any network access for unused services with Network Security Groups (NSGs) or deploying Azure Disk Encryption (ADE) to secure the disks from data theft and unauthorized access.

Consider improving the resilience of the migrated machines by adding a backup schedule using Azure Backup, and replicating the machines to at least a secondary region.

Tidy up tasks should be completed for the remaining on-premise servers, such as removing the servers from local backups, removing their raw disk files from SAN storage to free up space. Documentation related to that re-platformed servers should be updated to reflect their new IP addresses and locations in Azure.