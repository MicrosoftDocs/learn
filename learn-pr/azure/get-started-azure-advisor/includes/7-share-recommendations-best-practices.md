Now let's look at some ways you can manage your Advisor recommendations to more easily apply the documented best practices we've learned about so far.

Let's say you have gone through Advisor and either resolved, postponed, or dismissed all of your recommendations. Now what do you do?

Well, in addition to regularly checking back in to Advisor to look at your Advisor Score and see your recommendations, you can also set up alerts and recommendation digests to help you manage your Advisor process.

- **Alerts:** Informs you when you have new recommendations to investigate.
- **Recommendation digests:** Periodically sends you a summary of your active recommendations.

## Advisor alerts

You can configure Azure Advisor to send you an alert whenever a new recommendation is available for one of your resources. You select a subscription and optionally a resource group to specify those resources for which you want to receive alerts.

You  can also use these properties to further identify the types of recommendations you are alerted to:

- Category
- Impact level
- Recommendation type

> [!NOTE]
> Advisor alerts are currently not supported for **Security** recommendations.

### How do I set up alerts

You can set up alerts from the Advisor dashboard by first selecting **Alerts (Preview)** from the left panel.

:::image type="content" source="../media/azure-advisor-alerts-select.png" alt-text="Screenshot showing how to open the Alerts page." lightbox="../media/azure-advisor-alerts-select.png":::

In the **Advisor - Alerts** page that opens, you would select **New Advisor Alert** to start creating a new alert. Or, if you already have alerts set up, you can select one to edit it.

:::image type="content" source="../media/azure-advisor-alerts-new-alert.png" alt-text="Screenshot showing how to create a new Advisor alert." lightbox="../media/azure-advisor-alerts-new-alert.png":::

When creating or editing an alert, you would specify the following configurations:

- **SCOPE:** Specify the subscription (and optionally the resource group) for which you want to receive an alert.
- **CONDITION:** Select a specific category, impact level, or recommendation type for the alert.
- **ACTION GROUPS:** Select an existing action group or create a new one to define the list of notifications that are sent when an alert is triggered, such as through email or SMS.
- **ALERTS DETAILS:** Provide a name and description for the alert. You can also choose to have the alert enabled or disabled when you save your changes.

That's it! Once the alert is configured and saved, you'll be notified whenever a new recommendation that matches those settings is available.

## Recommendation digests

Another useful tool in managing your Advisor recommendations is through recommendation digests. This feature lets you configure periodic notifications that summarize all your active recommendations, across different categories. And similar to Advisor alerts, you can choose how you want to be notified, such as through email, sms or action groups.

### How do I set up a recommendation digest?

You can set up a recommendation digest from the Advisor dashboard by first selecting **Recommendation digests** from the left panel.

:::image type="content" source="../media/azure-advisor-recommendation-digest-select.png" alt-text="Screenshot showing how to open the recommendation digest page." lightbox="../media/azure-advisor-recommendation-digest-select.png":::

In the **Advisor - Recommendation digests** page that opens, you would select **New Recommendation Digest** to start creating a new one. Or, if you already have one set up, you can select it to edit.

Specify similar configurations as you did for Advisor Alerts:

- **SCOPE:** Specify the subscription for which you want to receive recommendation digest notifications.
- **CONDITION:** Specify how often you are notified, which categories you want to include, and in what language you want to receive the recommendation digest.
- **ACTION GROUPS:** Select an existing action group or create a new one to define the list of notifications that are sent for the recommendation digest, such as through email or SMS.
- **ALERTS DETAILS:** Provide a name for the recommendation digest. You can also choose to have it enabled or disabled when you save your changes.

:::image type="content" source="../media/azure-advisor-recommendation-digest.png" alt-text="Screenshot showing the Add and Advisor recommendation digest page." lightbox="../media/azure-advisor-recommendation-digest.png":::

After you've configured and saved the recommendation digest, you'll receive your notification as often as you indicated. The recommendation digest will provide you a summary of all your active recommendations, across the different categories you specified.

## API

As with many features in Azure, a REST API is also available to help you manage most of these things you've just learned about Azure Advisor. For example, enterprises use our API to manage recommendations at scale by integrating with their existing work management systems.

For more information, see [Azure Advisor REST API](https://docs.microsoft.com/rest/api/advisor/?azure-portal=true).
