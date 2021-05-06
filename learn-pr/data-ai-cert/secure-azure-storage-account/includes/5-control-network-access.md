By default, storage accounts accept connections from clients on any network. To limit access to selected networks, you must first change the default action. You can restrict access to specific IP addresses, ranges, or virtual networks.

> [!IMPORTANT]
> Changing network rules can affect your application's ability to connect to Azure Storage. If you set the default network rule to *deny*, you'll block all access to the data unless specific network rules *grant* access. Before you change the default rule to deny access, be sure to use network rules to grant access to any allowed networks.

## Manage default network access rules

Manage default network access rules for storage accounts through the Azure portal, PowerShell, or the Azure CLI.

Follow these steps to change default network access in the Azure portal.

1. Go to the storage account you want to secure.

1. Select **Networking**.

1. To restrict traffic from selected networks, select **Selected networks**. To allow traffic from all networks, select **All networks**.

1. To apply your changes, select **Save**.

![Screenshot showing the firewall options for storage accounts](../media/5-firewall.png)