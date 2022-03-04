Azure Stack Hub multi-node systems that use the consumption-based billing model should report usage data to Azure for billing purposes. Azure Stack Hub operators should configure their Azure Stack Hub instance to report usage data to Azure.

All workloads must be deployed under tenant subscriptions to comply with the licensing terms of Azure Stack Hub.

Usage data reporting is required for Azure Stack Hub multi-node users who license under the pay-as-you-use model. It's optional for customers who license under the capacity model. For Azure Stack Development Kit (ASDK) users, Azure Stack Hub operators can report usage data and test the feature. However, users won't be charged for any usage they incur.

Usage data is sent from Azure Stack Hub to Azure through the Azure Bridge. In Azure, the commerce system processes the usage data and generates the bill. After the bill is generated, the Azure subscription owner can view and download it from the [Azure Account Center](https://account.windowsazure.com/subscriptions).

## Set up usage data reporting

To set up usage data reporting, you must register your Azure Stack Hub instance with Azure. As part of the registration process, the Azure Bridge component of Azure Stack Hub is configured. The Azure Bridge component is what connects Azure Stack Hub to Azure. The following usage data is sent from Azure Stack Hub to Azure:

 -  **Meter ID** \- Unique ID for the resource that was consumed.
 -  **Quantity** \- Amount of resource usage.
 -  **Location** \- Location where the current Azure Stack Hub resource is deployed.
 -  **Resource URI** \- Fully qualified URI of the resource for which usage is being reported.
 -  **Subscription ID** \- Subscription ID of the Azure Stack Hub user, which is the local (Azure Stack Hub) subscription.
 -  **Time** \- Start and end time of the usage data. There is some delay between the time when these resources are consumed in Azure Stack Hub and when the usage data is reported to commerce. Azure Stack Hub aggregates usage data for every 24 hours, and reporting usage data to the commerce pipeline in Azure takes another few hours. Therefore, usage that happens shortly before midnight can appear in Azure the following day.

## Generate usage data reporting

 -  To test usage data reporting, create a few resources in Azure Stack Hub. For example, you can create a storage account, Windows Server virtual machine, and a Linux virtual machine with Basic and Standard SKUs to see how core usage is reported. The usage data for different types of resources are reported under different meters.
 -  Leave your resources running for a few hours. Usage information is collected approximately once every hour. After collecting, this data is transmitted to Azure and processed into the Azure commerce system. This process can take up to a few hours.

## View usage - CSP subscriptions

If you registered your Azure Stack Hub using a CSP subscription, you can view your usage and charges in the same way you view Azure consumption. Azure Stack Hub usage is included in your invoice and in the reconciliation file, which is available through the [Partner Center](https://partnercenter.microsoft.com/partner/home). The reconciliation file is updated monthly. If you need to access recent Azure Stack Hub usage information, you can use the Partner Center APIs.

## View usage - Enterprise Agreement subscriptions

If you registered your Azure Stack Hub using an Enterprise Agreement subscription, you can view your usage and charges in the [EA portal](https://ea.azure.com/). Azure Stack Hub usage is included in the advanced downloads along with Azure usage under the reports section in this portal.

## View usage - other subscriptions

If you registered your Azure Stack Hub using any other subscription type (for example, a pay-as-you-go subscription), you can view usage and charges in the Azure Account Center. Sign in to the Azure Account Center as the Azure account administrator and select the Azure subscription that you used to register Azure Stack Hub. You can view the Azure Stack Hub usage data and the amount charged for each of the used resources.
