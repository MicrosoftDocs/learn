This unit describes how to add a tenant to an Azure Stack Hub deployment managed by a Cloud Solution Provider (CSP). When the new tenant uses resources, Azure Stack Hub reports usage to their CSP subscription.

CSPs often offer services to multiple end customers (tenants) on their Azure Stack Hub deployment. Adding tenants to the Azure Stack Hub registration ensures that each tenant's usage is reported and billed to the corresponding CSP subscription. If you don't complete the steps in this unit, tenant usage is charged to the subscription used in the initial registration of Azure Stack Hub. Before you can add an end customer to Azure Stack Hub for usage tracking and to manage their tenant, you must configure Azure Stack Hub as a CSP.

:::image type="content" source="../media/add-tenant-usage-and-bill-image-3-a62bd9ca.png" alt-text="Diagram showing how to set up Cloud Solution Provider for usage tracking and to manage the end customer account.":::


The following figure shows the steps that a CSP needs to follow to enable a new end customer to use Azure Stack Hub, and to set up usage tracking for the customer. By adding the end customer, you're also able to manage resources in Azure Stack Hub. You have two options for managing their resources:

 -  You can maintain the end customer and provide credentials for the local Azure Stack Hub subscription to the end customer.
 -  The end customer can work with their subscription locally and add the CSP as a guest with owner permissions.

## Add an end customer

Before you add an end customer, you must enable multi-tenant billing on your registration. In order to enable multi-tenant billing, send the registration subscription ID, resource group name, and registration name to `azstcsp@microsoft.com`. It usually takes 1-2 business days to enable multi-tenancy.

### Create a new customer in Partner Center

In Partner Center, create a new Azure subscription for the customer.

### Create an Azure subscription for the end customer

After you've created a record of your customer in Partner Center, you can sell them subscriptions to products in the catalog.

### Create a guest user in the end customer directory

By default, you, as the CSP, do not have access to the end customer's Azure Stack Hub subscription. However, if your customer wants you to manage their resources, they can then add your account as owner/contributor to their Azure Stack Hub subscription. In order to do that, they must add your account as a guest user to their Microsoft Entra tenant. It's advised that you use a different account from your Azure CSP account to manage your customer's Azure Stack Hub subscription to ensure you don't lose access to your customer's Azure subscription.

### Update your registration with the new customer subscription

Azure reports the customer usage using the customer identity from Partner Center. This step ensures that each customer's usage is reported under that customer's individual CSP subscription. This makes tracking usage and billing easier. To perform this step, you must first register Azure Stack Hub.

1.  Open Windows PowerShell in an elevated prompt, and run:

```powershell
Add-AzAccount

```

2.  Type your Azure credentials.
3.  In the PowerShell session, run:

```PowerShell
New-AzResource -ResourceId "subscriptions/{registrationSubscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.AzureStack/registrations/{registrationName}/customerSubscriptions/{customerSubscriptionId}" -ApiVersion 2017-06-01

```

### New-AzResource PowerShell parameters

The following section describes the parameters for the **New-AzResource** cmdlet:

| **Parameter**              | **Description**                                                                                                                                                                                                                                                                                                                                                                          |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| registrationSubscriptionID | The Azure subscription that was used for the initial registration of the Azure Stack Hub.                                                                                                                                                                                                                                                                                                |
| customerSubscriptionID     | The Azure subscription (not Azure Stack Hub) belonging to the customer to be registered. Must be created in the CSP offer. In practice, this means through Partner Center. If a customer has more than one Microsoft Entra tenant, this subscription must be created in the tenant that will be used to log into Azure Stack Hub. The customer subscription ID is case-sensitive. |
| resourceGroup              | The resource group in Azure in which your registration is stored.                                                                                                                                                                                                                                                                                                                        |
| registrationName           | The name of the registration of your Azure Stack Hub. It's an object stored in Azure.                                                                                                                                                                                                                                                                                                    |

Tenants must be registered with each Azure Stack Hub they use. If you have two Azure Stack Hub deployments, and a tenant uses both of them, you must update the initial registrations of each deployment with the tenant subscription.

### Onboard tenant to Azure Stack Hub

Configure Azure Stack Hub to support users from multiple Microsoft Entra tenants to use services in Azure Stack Hub.

### Create a local resource in the end customer tenant in Azure Stack Hub

Once you've added the new customer to Azure Stack Hub, or the end customer tenant has enabled your guest account with owner privileges, verify that you can create a resource in their tenant.
