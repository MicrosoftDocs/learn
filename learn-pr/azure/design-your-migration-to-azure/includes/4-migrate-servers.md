After running Azure Migrate, a decision can be made about which of your servers make good candidates to be migrated to Azure. Azure Site Recovery is a service that can be used for disaster recovery for on-premises and Azure virtual machines, but can also be used to migrate virtual machines into Azure.

You've presented your findings to the IT Director and you now wish to continue with a test migration to assess the end to end process. You have chosen to use Azure Site Recovery as the tool to complete the migration of virtual machines.

In this unit, you'll review Azure Site Recovery and how it can be used to migrate specific workloads to Azure.

## What is Azure Site Recovery?

![The flow of migration from on-premises vCenter VMWare virtual machines to Azure with Azure Site Recovery](../media/4-vm-migration.svg)

Azure Site Recovery is designed to manage a disaster recovery plan, and can replicate workloads from a primary site to a secondary site if there's an outage. When an issue occurs at the primary site, the Site Recovery service can be automatically invoked and the virtual machines that are protected will be replicated to a secondary location to continue running. The failover could be an on-premises to Azure failover, or a failover from one Azure region to another.

In support of your objective, you'll use its ability to migrate VMware workloads to Azure, but unlike a failover, which can be reversed, a migration is a one time operation.

## Preparation and prerequisites

Before you can start to use Site Recovery for either a failover or a straight migration you need to ensure several things are in place to use the service, they are:

- **Account Permissions**: Your Azure account must either be the administrator account or be an account with the permissions to 'Create a VM in the selected resource group', 'Create a VM in the selected virtual network', 'Write to an Azure storage account', and 'Write to an Azure managed disk'.
- **Recovery Services vault**: Create a Recovery Services Vault, which you'll use to store your virtual machines.
- **Azure network**: The migrated virtual machines will connect to each other using a virtual network. Routing and firewall rules should be in place for it to be reachable from your on-premises network.

## Prepare the VMware environment

For your company, you are focused on moving VMware and database workloads to Azure. The above section focused on Azure tasks, this section details the preparation that needs to take place on the on-premises VMware estate to ensure connectivity to Azure.

- **Automatic discovery account**: Create an account at vCenter level and then assign the relevant permissions.
- **Mobility service account**: Install the Mobility service on each virtual machine. You can do the service by a push installation from the Azure console, or a manual install. If using the push installation, the account needs permission to install software on each of the virtual machines.
- **Connection after migration**: Enable Remote Desktop Protocol (RDP) on each virtual machine, and configure the Windows Firewall appropriately **before** migration.
- **Setup the configuration server**: The configuration server coordinates the communication between the on-premises environment and Azure. Deploy the Open Virtualization Application (OVA) template to a highly available virtual machine in your VMware environment.

## Migrate on-premises VMs to Azure

There are also several settings that need to be configured for the task of migrating on-premises virtual machines to Azure, they are:

- **Set a protection goal**: For VMware environments set the goal to, on-premises migration to Azure using the VMware vSphere Hypervisor.
- **Setup the target environment**: The target environment is set in the portal by selecting the Azure subscription and Resource Manager deployment model you wish to use. Select migrating VMware to Azure, Site Recovery will then verify a valid network exists in Azure that the migrated virtual machines will connect to.
- **Create a replication policy**: A replication policy contains settings such as a Recovery Point Objective (RPO) threshold. The policy is associated with the configuration server that has been deployed.
- **Enable replication**: Enable the replication at the Recovery Service vault level.
  - **Configure the Source**: The source is the configuration server, the machine type is 'virtual machines', the vSphere host is the vCenter server on-premises, and the process server is the configuration server.
  - **Configure the target**: On the target selection, the target is Azure, the subscription is your Azure subscription, the resource group is your target resource group, the network selection is the target network you want migrated virtual machines to connect to, and the subnet is that of the target network.
  - Select the virtual machines to migrate.
  - **Configure the properties**: Select the domain account used by the process server to install the Mobility service on the VMware machines. Disks that aren't required to be replicated can be de-selected. By default, all the disks used by a virtual machine are migrated.
  - **Select the replication policy**: The replication policy sets the App-consistent snapshot frequency, RPO threshold, and recovery point retention period.

## Start the migration

Once the steps to configure the source and target environments are complete, the migration can take place.

In the Azure portal, select the recovery point from which the virtual machine should failover/migrate to, and then select to have the machine shut down before beginning failover. After a period of time, check to ensure the virtual machine appears in Azure. Once it appears, right-click the virtual machine, and then select **Complete Migration**, which will finish the current migration and tidy up any temporary migration data.

![Screenshot of the Azure Site Recovery dashboard](../media/4-azure-site-recovery-dashboard.png)

## Post migration steps

After the migration has taken place, clean up tasks are needed to ensure that the migrated machines and the applications on them work as you expect.

Review the security settings of the virtual machine after the migration. Restrict network access for unused services with network security groups, and deploy Azure Disk Encryption to secure the disks from data theft and unauthorized access.

Consider improving the resilience of the migrated machines by adding a backup schedule using Azure Backup, and replicating the machines to a secondary region.

Complete clean up tasks for the remaining on-premises servers, such as removing the servers from local backups, removing their raw disk files from SAN storage to free up space. Documentation related to that migrated servers should be updated to reflect their new IP addresses and locations in Azure.
