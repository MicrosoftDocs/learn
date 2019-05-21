After running Azure Migrate a decision can be made of which of your VMware servers are good candidates be migrated to Azure. You have presented your findings to the IT Director and you now wish to proceed with several test migrations to assess the end to end process. You have chosen to use Azure Site Recovery as the tool to perform the migrations.

In this unit you will look at Azure Site Recovery and how it can be used to migrate certain workloads to Azure.

## What is Azure Site Recovery?

Azure Site Recovery is designed to contribute to your disaster recovery plan and has the ability to replicate workloads from a primary site to a secondary site in the event of an outage. When an issue occurs at the primary site, the Site Recovery service can be automatically invoked and the virtual machines that are protected will be replicated to a secondary location to continue running. The failover could be an on-premises to Azure failover, or one Azure region to another. In support of our objective we will use its ability to migrate VMware workloads to Azure, unlike a failover which can be reversed, a migration is a once only thing that cannot be failed back.

Some of the features or Site Recovery are:

- **On Premise VM Replication** - Replicate an on-premises environment to a secondary location such as Azure for disaster recovery
- **Flexible failovers** - The ability to failover to the secondary environment at any time, as part of a test without impacting the live environment or as part of a ful disaster recovery scenario
- **Customized recovery plans** - Fully automated recovery plans that can automate a failover to a secondary environment using the support of scripts if required
- **Operating system support** - The ability to replicate and provide protection for Azure virtual machines, VMware virtual machines and physical Windows servers

## Preparation and Pre-requisites 

Before you can start to use Site Recovery for either a failover or a straight migration you need to ensure several things are in place to be able to use the service, they are:

- **Account Permissions** - Your Azure account must either be the administrator account or be an account with the permissions to 'Create a VM in the selected resource group', 'Create a VM in the selected virtual network', 'Write to an Azure storage account', and 'Write to an Azure managed disk'
- **Recovery Services Vault**- A Recovery Services Vault must be created which will be used to store your virtual machines once replicated, this would be created in your current region specifying an existing resource group or creating a new one when prompted
- **Azure Network** - This network will be the network that the migrated virtual machines connect to when the migration is complete, routing and firewall rules should be in place for it to be reachable from your on-premises network.

## Preparing the VMware environment

The above section focused on Azure tasks, this section details the preparation that needs to take place on the on-premises VMware estate to ensure connectivity to Azure.

- **Automatic discovery account** - An account needs to be created at vCenter level, be given a name and then assigned the relevant permissions.
- **Mobility service account**- The Mobility service needs to be installed on each virtual machine which is done via a push installation from the Azure console or a manual install. If using the push installation the account needs permission to install software on to each of the virtual machines.
- **Connection after migration** - To ensure connectivity after the migration, you should re-confirm that RDP is enabled on each virtual machine and that the Windows Firewall is configured appropriately.
- **Setup the configuration server** - The configuration server co-ordinates the communication between the on-premises environment and Azure. It is packaged in an 'Open Virtualization Application' (OVA) template which should be deployed to a highly available virtual machine on the VMware environment. 

## Migrating on-premise to Azure

There are also several settings that need to be configured for the task of migrating on-premises virtual machines to Azure, they are:

- **Set a replication goal**- This sets the scope of the replication, what you want to replicate and where you wish to replicate it to. For VMware environments it would be a Protection goal of, a migration **To Azure** > **Yes, with VMware vSphere Hypervisor**
- **Setup the target environment** - The target environment is set in the portal by selecting the Azure subscription and Resource Manger deployment model you wish to use. Migrating VMware to Azure should be selected, Site Recovery verifies that a valid network exists in Azure that the virtual machines will be connected to post migration
- **Create a replication policy** - A replication policy contains settings such as an RPO threshold which is the recovery point retention period which is how long recovery points are stored for, and the frequency for App consistent snapshots to be taken. The policy is associated with the configuration server that has been deployed which is completed in the Azure portal, within the replication policy
- **Enable replication**- Once all the other tasks are complete replication can be enabled at the Recovery Service vault level. 
        - To enable replication the Source has to be configured, (the source is the configuration server, the machine type are 'virtual machines', the vSphere host is the vCenter server on-premises and the process server is the configuration server.)
        - The target has to be configured, (on the target selection, the target is Azure, the subscription is your Azure subscription, the resource group is your target resource group for the replicated virtual machines, the network selection is the target network you want migrated virtual machines to connect to, and the subnet is that of the target network)
        - Select the virtual machines to migrate, a filled white tick is visible next to the machine name when selected
        - Configure the properties by selecting the domain account used by the process server to install the Mobility service on the VMware machines, disks that are not required to be replicated can be de-selected, by default all disks associated with a virtual machine are migrated
        - Select the replication policy, this policy sets the App-consistent snapshot frequency, RPO threshold and recovery point retention period. 

## Starting the migration

Once the steps to configure the source and target environments are complete the migration can take place.

In the Azure portal, **Settings > Replicated items, select the machine and then > Failover**. Select the recovery point from which the virtual machine should failover/migrate to, and then select to have the machine shut down before beginning failover. After a period of time, check to ensure the virtual machine appears in Azure, once it does, in the replicated items menu, right click the virtual machine and then select **Complete Migration** which will finish the current migration and tidy up any temporary migration data.

## Post migration steps

After the migration has taken place clean up tasks are needed to ensure that the re-platformed machines and the applications on them work as you would expect. Cleanup tasks vary by environment but one example would be to ensure full connectivity to the machines via Remote Desktop Connection or updating any connection strings for databases or web apps, any applications installed should have full user acceptance testing before a sign off as a successful migration. After the migration the security settings of the virtual machine should be reviewed and restrict any network access for unused services with Network Security Groups (NSG's) or deploying Azure Disk Encryption (ADE) to secure the disks from data theft and unauthorized access.

Tidy up tasks should be completed for the on-premise servers left behind also, such as removing the servers from local backups, removing their raw disk files from any SAN storage you have to free up space. Documentation related to that re-platformed server(s) should be updated to reflect its new IP address, location in Azure etc.

## Knowledge Check

quiz:
  title: Check your knowledge
  questions:
  - content: Which of the following are features provided by Azure Site Recovery?
    choices:
    - content: Customized recovery plans, Flexible Failovers, Storage Replication
      isCorrect: False
      explanation: Storage Replication is not a feature of Azure Site Recovery
    - content: On Premise VM Replication, Flexible failovers, Customized recovery plans
      isCorrect: Correct
      explanation: These are all valid features provided by Azure Site Recovery.
    - content: Network Integration, Flexible Failovers, Physical Unix Server Recovery
      isCorrect: False
      explanation: A physical Unix server is not a supported Operating System that can be used 	with Azure Site Recovery.
  - content: Which of these source server Operating Systems are supported by Azure Site Recovery?
    choices:
    - content: VMware VM's, Physical Unix, Physical Windows
      isCorrect: false
      explanation: Physical Unix servers are not supported by Azure Site Recovery
    - content: Azure VM's, Physical Unix, Physical Sun Solaris
      isCorrect: false
      explanation: Physical Unix or Physical Sun Operating systems are not supported
     - content: Azure VM's, Vmware VM's, Physical Windows
      isCorrect: true
      explanation: All three are supported source operating systems.