Now that the Tailwind Traders company has its applications up and running in Azure, it wants to start looking into new Azure capabilities. One option is to look at preview services. In this module, you'll learn how Azure services go from the preview phase to being generally available product integrated into Azure.

For Tailwind Traders, migration from the datacenter to Azure is more about operational efficiency. The research and development team is looking into new, cloud-based features that will keep them ahead of the competition.

Tailwind Traders is in the development stages of creating a drone delivery system for rural customers. The company needs real-time storm tracking in the drone guidance system, but the feature isn't available yet.  Tailwind Traders R&D team has decided to incorporate the preview service into the early stages of application testing.


Before the team moves forward, it wants a better understanding of how preview services affect its SLA. Let's begin by defining the Azure service lifecycle.

## What is the service lifecycle?

The *service lifecycle* defines how every Azure service is released for public use.

Every Azure service starts in the development phase. In this phase, the Azure team collects and defines its requirements, and begins to build the service.

Next, the service is released to the public preview phase. During this phase, the public can access and experiment with it and provide real-world feedback. Your feedback helps Microsoft improve services. More importantly, providing feedback gives you the opportunity to request new or different capabilities so that services better meet your needs.

After a new Azure service has been validated and tested, it's released to all customers as a production-ready service. This is known as *general availability* (GA).

## What terms and conditions can I expect?

Each Azure preview defines its own terms and conditions. All [preview-specific terms and conditions are excluded from the service level agreements and limited warranty](https://azure.microsoft.com/support/legal/preview-supplemental-terms/).

Some previews may not be covered by customer support, and may be subject to reduced or different security, compliance, and privacy commitments. For these reasons, previews are not recommended for business-critical workloads.

## How can I access preview services?

You can access preview services from the Azure portal.

Here's how to see what preview services are available. You can follow along if you have an Azure subscription.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. Select **Create a resource**.
1. Enter *preview* in the search box, and select **Enter**.
1. Select a preview service to learn more about it. You can also launch the service if you'd like to try it out.

## How can I access new features for an existing service?

Some preview features relate to a specific area of an existing Azure service. For example, a compute or database service that you use daily might provide enhanced functionality. These preview features are accessible when you deploy, configure, and manage the service.

Although you can use an Azure preview feature in production, make sure you're aware of any limitations before you deploy it to a production environment.

## How can I access preview features for the Azure portal?

You can access preview features that are specific to the Azure portal from [Microsoft Azure (Preview)](https://preview.portal.azure.com?azure-portal=true).

Typical portal preview features provide performance, navigation, and accessibility improvements to the Azure portal interface.

When you're using the preview version of the Azure portal, **Microsoft Azure (Preview)** displays in the page header to remind you what version of the Azure portal you're using. Public preview features that are optionally available are also labeled with *(preview)* on Azure pages.

:::image type="content" source="../media/5-azure-portal-preview.png" alt-text="Screenshot of Azure page header showing the global element Microsoft Azure (Preview) highlighted.":::

### How can I provide feedback on the Azure portal?

You can provide feedback:

* From any of the 124 forums for Azure services, go to the [Azure feedback community ideas page](https://feedback.azure.com/d365community)
* From the **Feedback** tab in the Azure portal.

   :::image type="content" source="../media/5-azure-portal-feedback.png" alt-text="Screenshot of the Azure portal showing the Feedback tab.":::


## How can I stay updated on the latest announcements?

The [Azure updates](https://azure.microsoft.com/updates?azure-portal=true) page provides information about the latest updates to Azure products, services, and features, and product roadmaps and announcements.

From the Azure updates page, you can:

* View details about all Azure updates.
* See which updates are now available, in preview, or in development.
    :::image type="content" source="../media/5-azure-updates-filter.png" alt-text="Screenshot of the Azure updates page showing how to filter services by now available, in preview, or in development.":::
* Browse updates by product category or update type.
* Search for updates by keyword.
* Subscribe to an RSS feed to receive notifications.
* Access the Microsoft Connect page to read Azure product news and announcements.
