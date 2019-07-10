Now you know about the capabilities of Azure Site Recovery, you can begin to think about preparation for disaster recovery in your Azure environment.

Think about your organizations BCDR plan, you now need to run through the ASR configurations and set a preparation plan in motion that fits with your organizations BCDR goals.

In this unit, you'll explore what you need to prepare for a disaster recovery scenario to take advantage of ASRs automated features.

## Environment setup

<!-- Activate the sandbox -->
[!INCLUDE [azure-sandbox-activate](../../../includes/azure-sandbox-activate.md)]

Run the following commands in the Cloud Shell. This will create an Azure Virtual Machine to use in the next exercise.

1. Run the following commands to save environment variables that will be used in the az cli calls later.

    ```bash
    
    ```

1. Copy the ARM and parameter json templates that create an Azure Virtual Machine.

    ```bash
    curl https://raw.githubusercontent.com/... > deploy.json
    curl https://raw.githubusercontent.com/... > parameters.json
    ```

    <!-- TODO replace with live github repo -->

1. Run the following command to create a new Azure Virtual Machine.

    ```azurecli
    az group deployment create \
        --name asrDeployment \
        --resource-group $RESOURCEGROUP \
        --template-file deploy.json \
        --parameters @parameters.json \
        --parameters resourceGroupName=$RESOURCEGROUP location=$LOCATION
    ```

    > [!NOTE]
    > This can take up to ten minutes to complete, continue with this module while the VM is created.

## Disaster recovery preparation with Azure Site Recovery

ASR is an important tool in Azure for protecting your infrastructure from outage. The service will manage and orchestrate your DR process for Azure VMs and also on-premises machines. However, to enable this there are several components you need to configure, such as:

- Adding a Recovery Services Vault.
- Organizing target resources.
- Configuring outbound network connectivity.
- Setting up replication on existing VMs

## Recovery Services Vault

To enable ASR to complete disaster recovery replication requires a recovery services vault. Recovery Services is a data storage service in Azure. It stores data backups, VM configuration settings and workloads. To meet ASR requirements is as simple as provisioning a recovery services vault using the portal or the Azure CLI.

## Target resources

The target for ASR replication is in a different Azure region. This requires you to check that the target region firstly allows you to create a virtual machine but secondly, that the region has enough resources to support matching the sizing of your existing VMs. ASR will select the same or nearest available size for the target machine.

## Outbound network connectivity & URLs

ASR requires you to configure outbound connectivity on the virtual machines that you wish to replicate. ASR does not support controlling network connectivity via an authentication proxy.

If your organization is using a URL-based firewall proxy in order to restrict outbound connectivity you will need to add access to several URLs:

- *.blob.core.windows.net - To write VM data to the source storage account cache
- login.microsoftonline.com - For the ASR URLs to authenticate
- *.hypervrecoverymanager.windowsazure.com - For ASR to communicate with the VM
- *.servicebus.windows.net - For ASR monitoring and diagnostic data from the VM

If you would prefer to control the connectivity using IP addresses instead then you need to add the following:

- The IP ranges for Azure Datacenters
- The IP ranges for Windows Azure Datacenters in Germany and China.
- The IP Ranges for Office 365
- The IP Ranges for teh ASR endpoints

## Updating Azure VM certs

Every Azure VM you wish to replicate requires the latest root certificates, without them you will not be able to register it with ASR. This is done to ensure security is kept watertight. A windows VM will need to have all the latest windows updates installed so that the machine has up to date trusted root certificates. A linux VM requires the same but you will need to contact your distributor. Where an environment is disconnected you can still use the standard windows update process.

## Account permissions

ASR by default uses Role Based Access Control (RBAC) in Azure. This enables fine grained access, ASR comes with several built-in roles:

- **Site Recovery Contributor:** Full permissions for ASR operations in a recovery services vault, suitable for disaster recovery admins.

- **Site Recovery Operator:** Permissions to run and administer ASR failover and failback operations, suitable for disaster recovery operators.

- **Site Recovery Reader:** Permissions to view ASR operations, suitable for IT monitoring executives.

To enable replication on a VM, a user must have permissions to create a VM in both the virtual network and resource group. In addition write access to the associated storage account is required.
