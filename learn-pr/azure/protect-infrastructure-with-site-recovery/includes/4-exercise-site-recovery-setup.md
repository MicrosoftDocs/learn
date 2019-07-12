Think about your organizations BCDR plan, you need to prepare your Azure infrastructure in readiness for using Azure Site Recovery.

In this exercise, you'll complete the pre-requisite setup on a Virtual Machine for Azure Site Recovery using the portal.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the instructions so you understand how to use backup virtual machines with Azure Backup.
> If you want to complete this exercise, but you don't have an Azure subscription, or prefer not to use your own account, you will need to create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.


## Create a Recovery Services Vault

1. Sign into the [Azure portal](https://portal.azure.com) using the same account you activated the sandbox with.

1. Select **+ Create a resource** option on the top left hand side of the portal.
1. Under the **Azure Marketplace**, select **IT & Management Tools**, then select **Backup and Site Recovery**.
1. Create a new resource group named **east-coast-datacenter**, set the Region to **East US 2**. 
1. For the Vault name, type **lamna-vault**.
1. Select. **Review + create**, and then on the Summary page, select **Create**.

## Install the mobility Service

## Verify target resources

1. Head to subscription settings and quotas, list out steps.

## Configure outbound network connectivity

1. Login to VM and configure network connectivity through the firewall, list out steps.

## Verify Azure VM certificates

1. On the same VM, install the latest windows updates, list out steps.

## Enable replication

1. Select **All resources** in the upper left hand side of the portal.
1. Select the **Recovery Services vault** you created earlier.
1. In the Recovery Services vault blade, select **+Replicate**.
1. In the dialogue that opens select **Azure** as your source.
1. In the source location select a paired Azure datacentre, select **East US** (default is West US).
1. Select the default subscription and resource group.
1. In **Virtual Machines** select the **????** VM.
1. Click **OK** to move onto the replication settings.
1. Select **Settings** to view the target replication settings.
1. Leave the replication settings as default and Click **OK**.

In this unit you have configured disaster recovery using ASR for an Azure Virtual Machine.