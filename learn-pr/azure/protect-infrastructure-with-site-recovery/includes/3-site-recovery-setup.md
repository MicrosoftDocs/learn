In the previous unit, we explore the capabilities of Azure Site Recovery. Our next step is to prepare for disaster recovery in our Azure environment.

Using our organization's business continuity and disaster recovery (BCDR) plan, we can run through the Azure Site Recovery configurations and set a preparation plan in motion that fits with our organization's BCDR goals. Let's assume we're using the East US Azure region for our existing solution, and we've decided to use the West US region for replication.

Here, we'll explore how to take advantage of Azure Site Recovery's automated features to prepare for a disaster recovery scenario.

## Environment setup

We need to set up our environment for our later exercises. As this setup takes a few minutes to complete, we'll start the process now, and then we can work through some of the theory while the configuration completes in the background.

> [!NOTE]
> If you want to complete the following set up, but you don't have an Azure subscription, or prefer not to use your account, you will need to create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

Let's assume, we have two VMs configured in the organization. We'll configure the following services in the East US region to simulate this configured VMs.

- A virtual network
- Two VMs
- A storage account

We'll also configure a resource group in West US. We'll later configure Azure Site Recovery to use the West US region as our target environment.

Our first step is to create our exercise environment. We'll run a script that creates our companies infrastructure in Azure.  Once the script completes, we'll have a virtual network, two VMs, and a storage account that we'll use for our Recovery Services Vault.

1. Sign in to the [Azure portal](https://portal.azure.com) with your credentials, and start a Cloud Shell session.

1. Make sure you're running a Bash session in Cloud Shell.

1. Copy the Azure Resource Manager JSON templates to create your company's infrastructure.

    ```bash
    curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-protect-infrastructure-with-azure-site-recovery/master/deploy.json > deploy.json
    ```

1. Run the following command to create resource groups and the company's infrastructure.

    ```bash
    az group create --name west-coast-rg --location westus2
    az group create --name east-coast-rg --location eastus2

    az group deployment create \
        --name asrDeployment \
        --template-file deploy.json \
        --parameters storageAccounts_asrcache_name=asrcache$RANDOM \
        --resource-group west-coast-rg
    ```

Keep in mind that configuring the environment can take up to five minutes to complete. We're now ready to continue with the rest of this unit while the deployment completes.

## Disaster recovery preparation with Azure Site Recovery

Azure Site Recovery will manage and orchestrate our DR process for Azure VMs or on-premises machines. However, to enable it, there are several components we need to configure. We'll need to:

- Add a Recovery Services Vault
- Organize target resources
- Configure outbound network connectivity
- Set up replication on existing VMs

![Diagram showing how Azure Site Recovery keeps an updated version of VM disks to enable replication from a source region to a target region.](../media/3-enable-replication-step-2.svg)

### What is a Recovery Services vault?

A Recovery Services vault enables Azure Site Recovery to complete disaster recovery replication. These vaults use storage accounts to store data backups, VM configuration settings, and workloads. To meet Azure Site Recovery requirements, provision a recovery services vault using the portal or the Azure CLI.

### What are the target resources?

Target resources are all the Azure services that are created once our existing resources replicate. In our scenario, the West US region is the region where all our target resources get created. There are a few considerations to keep in mind when selecting the target resources region.

- The target resources for Azure Site Recovery replication have to be in a different Azure region.
- The storage account that stores the backed-up data must also be in a different region to the resources being protected.
- The target region allows the creation of virtual machines and has enough resources to match the size of the existing VMs.

### Configure Outbound network connectivity & URLs

Azure Site Recovery requires outbound connectivity on the virtual machines that we wish to replicate.

The required network connectivity is set up for us automatically when using Virtual Machines created in Azure. However, when we migrate on-premises VMs to Azure, we may need to update your network connectivity.

Azure Site Recovery doesn't support controlling network connectivity via an authentication proxy. If our organization is using a URL-based firewall proxy to restrict outbound connectivity, we'll need to add access to several URLs.

| URL | Description |
| --- | --- |
| login.microsoftonline.com | For the Azure Site Recovery URLs to authenticate |
| *.blob.core.windows.net | To write VM data to the source storage account cache |
| *.hypervrecoverymanager.windowsazure.com | For Azure Site Recovery to communicate with the VM |
| *.servicebus.windows.net | For Azure Site Recovery monitoring and diagnostic data from the VM |
|||

If you prefer to control the connectivity using IP addresses instead, then you need to add the IP address ranges for:

- The Azure Datacenters
- The Azure Site Recovery endpoints

### Update Azure VM root certificates

Every Azure VM we wish to replicate has to register with Azure Site Recovery. For a VM to register, Azure Site Recovery requires the latest root certificates installed on the VM. On a Windows VM, we'll need to make sure we install all the latest windows updates. The process for updating root certificates on Linux VM varies from distribution to distribution. We'll need to follow the guidance published by the distributor.

### Configure Account permissions

Azure Site Recovery uses Role-Based Access Control (RBAC) in Azure by default. RBAC enables fine-grained access control and allows us to use several built-in Azure Site Recovery roles:

| Role | Description |
|---|---|
| **Site Recovery Contributor:** | A contributor has full permissions for Azure Site Recovery operations in a recovery services vault, suitable for disaster recovery admins.|
| **Site Recovery Operator:** | An operator has Permissions to run and administer Azure Site Recovery failover and failback operations, suitable for disaster recovery operators.|
| **Site Recovery Reader:** | A Reader has permissions to view Azure Site Recovery operations, suitable for IT monitoring executives.|
|  |  |

To enable replication on a VM, a user must have permission to create a VM in both the virtual network and resource group.

### What is Azure Mobility Service?

Every VM that is to be replicated needs the Azure Mobility Service to be installed. This client is available for Windows and Linux VMs and will be installed and configured automatically by Site Recovery. If the automatic installation fails, you can install the service manually.

The mobility service works in partnership with Azure Site Recovery to keep an up-to-date cache of the VMs' data. The cache is replicated to the target environment's storage account. The replicated data will be used if Azure Site Recovery fails over the environment.
