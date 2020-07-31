In this part, you'll learn how Azure services go from the preview phase to being generally available.

<div style="background:yellow;">
TODO: We're switching gears here for sure. Can we more strongly relate lifecycle to SLAs?

Perhaps we emphasize that you don't get an SLA for preview services (we already say we don't recommend using preview services in production applications).
</div>

For Tailwind Traders, migration from the datacenter to Azure is more about operational efficiency. The research and development team is looking into new features that will keep them ahead of the competition &mdash; features they can't achieve without the power of the cloud.

Tailwind Traders is experimenting with a custom drone delivery system for customers in rural areas. They need the ability to use real-time storm tracking in the drone guidance system, but the feature is not ready yet. They read about the new AI Storm Analyzer service that has just entered public preview. So Tailwind Traders has decided to incorporate it into the early stages of their application testing.

> [!NOTE]
> AI Storm Analyzer is a fictitious Azure service. We introduce it here for illustration.

Before the team moves forward, they want a better understanding of how preview features impact their SLA. Let's begin by defining the Azure services lifecycle.

## What is the services lifecycle?

Every Azure service has a lifecycle which defines how it's released for public use. We call this the *services lifecycle*.

An Azure service starts in the development phase. Next, it's released to the preview phase, which informs you that the new service is coming. Then, the service is released to public testing so that you can experiment with it and provide feedback. Finally the service becomes generally available to everyone.

<div style="background:yellow;">
TODO: Where does "public testing" fit in to remaining text?

TODO: Add a graphic of the lifecycle? Is there one we can borrow?
</div>

## What are Azure previews?

Microsoft provides early access to new Azure services, features, and functionality. With Azure Previews, you can test pre-release features, products, services, software, and even regions. When you provide feedback on these previews, you're helping Microsoft to improve their services.

<div style="background:yellow;">
TODO: "When you provide feedback" - is there anything else in it for me? Currently, it reads as a bit self-serving.
</div>

### What preview categories can I access?

There are two preview categories that you can access:

* **Preview feature**

    A preview feature is an Azure feature that's available to *select* Azure customers for evaluation purposes.
* **Public preview**

    Public preview is an Azure feature that's available to *all* Azure customers for evaluation purposes.

### What terms and conditions can I expect?

Each Azure preview defines its own terms and conditions. All preview-specific terms and conditions supplement your existing Azure service agreement.

Some previews are not covered by customer support. Therefore, previews are not recommended for business-critical workloads.

## What's general availability (GA)?

After a new Azure service or feature is validated and tested, it's released to all customers as a production-ready service. This is known as *general availability* (GA).

The graphic below show the general process for features (and bugs) during their development lifecycle. It's common for features to move from being an Azure preview feature to GA, based on customer evaluation and feedback.

<div style="background:yellow;">
TODO: Do we need this graphic or is the sentence enough? Though it is a text alternative.

TODO: Why are we talking about bugs?

TODO: (Tom) I think the graphic is a bit over the top. I would cut it and the paragraph above. That said, this section is kinda thin. Maybe that's fine.
</div>

:::image type="content" source="../media/4-service-lifecycle.png" alt-text="The typical lifecycle of a feature or bug." border="false":::

## How can I access preview services?

You can access preview services from the Azure portal.

Here's how to see what preview service are available. You can follow along if have an Azure subscription.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
1. Select **Create a resource**.
1. Enter *preview* in the search box and select <kbd>Enter</kbd>.
1. Select a service to learn more about it.

    You can also bring up the service if you'd like to try it out.

## How can I access new features for an existing service?

Some preview features relate to a specific area of an existing Azure service. For example, a compute or database service that you use might provide enhanced functionality. These preview features are accessible when you deploy, configure, and manage the service.

Although you can use an Azure preview feature in production, make sure you're aware of any limitations around its use before deploying to production.

## How can I access preview features for the Azure portal?

You can access preview features that are specific to the Azure portal from [preview.portal.azure.com](https://preview.portal.azure.com?azure-portal=true).

Typical portal preview features provide performance, navigation, and accessibility improvements to the Azure portal interface.

You see **Microsoft Azure (Preview)** near the menu bar to remind you that you're working with a preview version of the Azure portal.

:::image type="content" source="../media/4-azure-portal-preview.png" alt-text="A screenshot of the preview version of the Azure portal showing the menu bar.":::

## How can I provide feedback on the Azure portal?

You can provide feedback:

* From the **Feedback** tab in the Azure portal.

    :::image type="content" source="../media/4-azure-portal-feedback.png" alt-text="A screenshot of the Azure portal showing the Feedback tab.":::

* From the [Azure portal feedback forum](https://feedback.azure.com/forums/223579-azure-portal?azure-portal=true).

## How can I stay updated on the latest announcements?

The [Azure updates](https://azure.microsoft.com/updates?azure-portal=true) page provides information about the latest updates to Azure products, services, and features, as well as product roadmaps and announcements.

From the Azure updates page, you can:

* View details about all Azure updates.
* See which updates are in general availability, preview, or development.

    :::image type="content" source="../media/4-azure-updates-filter.png" alt-text="A screenshot of the Azure updates page showing how to filter services by now available, in preview, or in development.":::
* Browse updates by product category or update type.
* Search for updates by keyword.
* Subscribe to an RSS feed to receive notifications.
* Access the Microsoft Connect page to read Azure product news and announcements.

<div style="background:yellow;">
TODO: We define the TWT scenario but don't come back to it. If not here, maybe in the knowledge check?
</div>