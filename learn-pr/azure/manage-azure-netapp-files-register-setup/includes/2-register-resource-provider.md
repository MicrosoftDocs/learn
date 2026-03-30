# Register for Azure Resource Provider

To use the Azure NetApp Files service, you need to register the NetApp Resource Provider.

You can do that using the Azure Cloud Shell from the Azure portal.

In the Azure Cloud Shell console, you can enter the following command to register the Azure Resource Provider.

az provider register --namespace Microsoft.NetApp –wait

Once the Azure Resource Provider is registered with your subscription, you can verify it from the Azure portal.

From the Azure portal, click the Subscriptions blade, click your subscription ID. In the settings of the subscription, click Resource providers to verify that Microsoft.NetApp Provider indicates the Registered status:

![This image shows a **resource provider registration entry** in what appears to be the **Azure Portal**. It displays: - **Provider name**: `Microsoft.NetApp` - **Status**: ✅ **Registered** (indicated by a green checkmark) - **Actions**: Two clickable links — **Re-register** and **Unregister** This is typically found in the **Azure Subscription > Resource providers** blade, where users can manage which Azure resource providers are registered for their subscription. In this case, the `Microsoft.NetApp` provider (used for **Azure NetApp Files**) is currently registered and active.](../media/manage-azure-netapp-files-register-setup/image_001.png)

Pic1
