Azure Stack Hub collects and groups usage data for resources that are used, then forwards this data to Azure Commerce. Azure Commerce bills you for Azure Stack Hub usage in the same way it bills you for Azure usage.

You can also get usage data and export it to your own billing or chargeback system by using a billing adapter, or export it to a business intelligence tool such as Microsoft Power BI.

## Usage pipeline

Each resource provider in Azure Stack Hub posts usage data per resource usage. The usage service periodically (hourly and daily) aggregates usage data and stores it in the usage database. Azure Stack Hub operators and users can access the stored usage data through the Azure Stack Hub resource usage APIs.

If you've registered your Azure Stack Hub instance with Azure, Azure Stack Hub is configured to send the usage data to Azure Commerce. After the data is uploaded to Azure, you can access it through the billing portal or by using Azure resource usage APIs.

The following figure shows the key components in the usage pipeline:

:::image type="content" source="../media/usage-bill-1-99b17d42.png" alt-text="Diagram showing normalized relational tables.":::


## How to find usage information

Azure Stack Hub resource providers (such as Compute, Storage, and Network) generate usage data at hourly intervals for each subscription. The usage data contains information about the resource used, such as resource name, subscription used, and quantity used.

After the usage data has been collected, it is reported to Azure to generate a bill, which can be viewed through the Azure billing portal.

To learn more about licensing in Azure Stack Hub, see the [packaging and pricing data sheet](https://azure.microsoft.com/mediahandler/files/resourcefiles/5bc3f30c-cd57-4513-989e-056325eb95e1/Azure-Stack-packaging-and-pricing-datasheet.pdf).

The Azure billing portal shows usage data for the chargeable resources. In addition to the chargeable resources, Azure Stack Hub captures usage data for a broader set of resources, which you can access in your Azure Stack Hub environment through REST APIs or PowerShell cmdlets. Azure Stack Hub operators can get the usage data for all user subscriptions. Individual users can only get their own usage details.

## Usage reporting for multi-tenant Cloud Solution Providers

A multi-tenant Cloud Solution Provider (CSP) using Azure Stack Hub might want to report each customer usage separately, so that the provider can charge usage to different Azure subscriptions.

Each customer has their identity represented by a different Microsoft Entra tenant. Azure Stack Hub supports assigning one CSP subscription to each Microsoft Entra tenant. You can add tenants and their subscriptions to the base Azure Stack Hub registration. The base registration is done for all Azure Stack Hub instances. If a subscription is not registered for a tenant, the user can still use Azure Stack Hub, and their usage is sent to the subscription used for the base registration.
