To use the Azure NetApp Files service, you need to register the NetApp Resource Provider.

You can do that using the Azure Cloud Shell from the Azure portal.

In the Azure Cloud Shell console, you can enter the following command to register the Azure Resource Provider.

`az provider register --namespace Microsoft.NetApp --wait`

Once the Azure Resource Provider is registered with your subscription, you can verify it from the Azure portal.

From the Azure portal, click the Subscriptions blade, click your subscription ID. In the settings of the subscription, click Resource providers to verify that Microsoft.NetApp Provider indicates the Registered status:

![Screenshot of Azure portal interface. A row from an Azure portal interface is shown displaying a Resource Provider registration entry: Provider name: Microsoft.NetApp Status: Registered Actions available: Two clickable links — Re-register and Unregister. This is typically seen in the Azure subscription's Resource providers settings blade, where users can manage which Azure services (resource providers) are registered for use within their subscription.](../media/managing-azure-netapp-files-register-setup/resource-provider-status.png)
