Think about your organizations BCDR plan, you need to prepare your Azure infrastructure in readiness for using Azure Site Recovery.

In the unit, you'll complete the pre-requisite setup on a Virtual Machine for Azure Site Recovery using the portal.

## Create a Recovery Services Vault

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select **Create a Resource** option on the upper left hand side of the portal.
1. Type in **Recovery Services**, and select **Recovery Services vaults**.
1. Select **Create**.
1. Give the vault a name.
1. Select the default subscription, resource group and location. Click **Create**

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