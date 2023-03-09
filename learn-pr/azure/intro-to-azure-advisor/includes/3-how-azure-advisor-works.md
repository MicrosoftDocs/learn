Azure Advisor scans and analyses your Azure resource configuration and usage telemetry to provide recommendations and proposed actions.

## Access Advisor's recommendations

You can access Advisor through the Azure portal. Sign in to the portal and locate Advisor in the navigation menu or search for it in the **All services** menu. Open Advisor to see the recommendations, which are divided into five categories: **Cost**, **Security**, **Reliability**, **Operational excellence**, and **Performance**.

For all recommendations provided, you can postpone the display, for a specific time period (one day, one week, one month, three months), or indefinitely. You also can choose to dismiss the recommendation.

You need to be an *Owner*, *Contributor*, or *Reader* for the subscription, resource group, or resource, to have permissions to access Advisor.

## Configure Advisor's recommendations

It's possible to choose which subscriptions and resource groups you want to receive recommendations on. Advisor provides this functionality through the **Configuration** option, under **Settings**.

:::image type="content" source="../media/3-advisor-configuration.png" alt-text=" Screenshot showing the Configuration pane in Azure Advisor." lightbox="../media/3-advisor-configuration.png":::

You can configure the CPU utilization rule by subscription from the **VM right sizing** tab. Select the subscription to configure and choose **Edit**. You can set the CPU utilization rule to 5%, 10%, 15%, or 20%.

:::image type="content" source="../media/3-configure-vm-right-sizing.png" alt-text=" Screenshot showing the VM right sizing tab and the option to edit the CPU utilization rule." lightbox="../media/3-configure-vm-right-sizing.png":::

> [!Note]
> To adjust the average CPU utilization rule for identifying low usage virtual machines, you must be a subscription Owner. If you don't have the required permissions for a subscription or resource group, the option to include or exclude it is disabled in the user interface.

## Download Advisor's recommendations

You can download a summary of Advisor's recommendations in a CSV or PDF format. Downloading the file makes it easy for you to share recommendations with your coworkers, or you can perform your own analysis. You can download all recommendations from the **Overview** pane, or you can download data for specific categories to help you target specific areas of your subscription that might need action.

:::image type="content" source="../media/3-advisor-download-recommendations.png" alt-text="Screenshot showing the options to download CSV and PDF files." lightbox="../media/3-advisor-download-recommendations.png":::

## Receive alerts based on recommendations

When Advisor detects a new recommendation, it's stored in the Azure activity log. You can then set up alerts for the stored events. Select **Alerts** from the **Monitoring** option on the menu and choose **New Advisor Alert**.

:::image type="content" source="../media/3-advisor-alert.png" alt-text="Screenshot showing the Alerts option in the main menu and the option to create a new advisor alert." lightbox="../media/3-advisor-alert.png":::

You'll need to define a scope by selecting a subscription and, optionally, a resource group. 

Alerts are driven by conditions. Here you have two mutually exclusive options:

* **Category and impact level**: In this option, you can choose between the categories of *Cost*, *Performance*, *Reliability*, and *Operational excellence*, with an impact level of (*High*, *Medium*, or *Low*). Both of these are optional configurations.
* **Recommendation Type**: If you select recommendation type, you can choose the most appropriate option for your needs from the dropdown list. 

:::image type="content" source="../media/3-create-alerts-scope-condition.png" alt-text="Screenshot showing the scope and condition sections of the dialog for creating an Advisor alert." lightbox="../media/3-advisor-alerts-scope-condition.png":::

You can also configure action groups. An action group is a collection of notification preferences defined by the *owner* of an Azure subscription. Azure Monitor, Azure Service Health and Azure Advisor use action groups to notify users that an alert has been triggered.

Finally, you can also specify some important details such as an alert rule name and an optional description (optional). You can also choose whether the alert is enabled or not when you create it, and specify a resource group where the alert will be saved.

:::image type="content" source="../media/3-create-alerts-action-groups.png" alt-text="Screenshot showing the action groups and alert details sections of the dialog for creating an Advisor alert.":::

## Configure the recommendations summary

It's good practice to check Advisor recommendations regularly and set up alerts. You might also consider getting a regular summary of recommendations sent you by e-mail.

You can configure e-mail reports in the **Recommendation digests** option, under the **Monitoring** section of the menu. Select **New Recommendation Digest** to get started.

:::image type="content" source="../media/3-advisor-recommendation-digests.png" alt-text="Screenshot showing the recommendation digests option in the main menu and the option to configure a digest." lightbox="../media/3-advisor-recommendation-digests.png":::

Choose a subscription and select the frequency, recommendation category, and language options for your first digest.

* Frequency: Choose from *Weekly*, *Bi-weekly*, and *Monthly*.
* Recommendation category: Choose all or some of the categories *Reliability*, *Security*, *Performance*, *Operational excellence*, and *Cost*.
* Language: Choose your preferred language from the dropdown list.

You can also select an existing action group, or create a new one, in which the recommendations will be received. The last option allows you to name your digest and determine whether it's enabled or not. You can disable a recommendation digest if you want to pause the summaries.

:::image type="content" source="../media/3-create-recommendation-digests.png" alt-text="Screenshot depicting the available options for configuring a recommendation digest." lightbox="../media/3-create-recommendation-digests.png":::

## Recommendation types

Let's explore the recommendation types in a little more detail.

### Costs Recommendations

Azure Advisor helps to identify idle and underutilized resources. You can get cost recommendations from the Cost tab on the Advisor dashboard. As an example, consider usage surrounding virtual machines. Advisor can make recommendations such as:

* Shut down of a virtual machine (VM) if it is not being utilized. Advisor can make this recommendation if it detects network utilization less than 2% over a seven-day period or a P95th of the maximum value of CPU utilization less than 3%.
* Resize the VM to save resource utilization. Advisor will recommend a resize if the current load doesn't go above 80% utilization for non-user facing workloads. For user-facing workloads, the threshold is measured at above 40%.

The estimate cost savings will be displayed for the recommended actions to help you make a decision on the recommended action.

### Security Recommendations

Security recommendations are integrated with Microsoft Defender for Cloud. You can get security recommendations from the Security tab on the Advisor dashboard.

:::image type="content" source="../media/3-advisor-security.png" alt-text="A screenshot depicting some security recommendations for a subscription. Displayed information indicates impact (high, medium, or low), a description of the recommendation, the impacted resource, and a date-time stamp for when the recommendation was last updated.":::

### Reliability Recommendations

Azure Advisor helps you ensure and improve the continuity of your business-critical applications. You can get reliability recommendations from Advisor on the **Reliability** tab of the Advisor dashboard. Some of the reliability recommendations available with Advisor are:

* Check Point virtual network appliance - Advisor can check if your VM is running this image.
* Ensuring application gateway fault tolerance.
* Protection from accidental VM deletion.
* Create Azure Service Health alerts.
* Configure Traffic Manager endpoints for resiliency.
* See the full list on the [Reliability Guide](/azure/advisor/advisor-high-availability-recommendations)

### Operational excellence Recommendations

Operational excellence recommendations in Azure Advisor can help you with:

* Process and workflow efficiency.
* Resource manageability.
* Deployment best practices.
* You can get these recommendations on the Operational Excellence tab of the Advisor dashboard.

Recommendations to ensure operational excellence on my subscriptions:

:::image type="content" source="../media/3-advisor-operational-excellence.png" alt-text="Screenshot depicting some operational excellence recommendations. These recommendations include the impact level, a description, the benefit of choosing the recommendation, and the impacted resources.":::

### Performance Recommendations

The performance recommendations in Azure Advisor can help improve the speed and responsiveness of your business-critical applications. You can get performance recommendations from Advisor on the Performance tab of the Advisor dashboard.

Many of these recommendations are concerned with Traffic Manager performance, database performance for SQL Database, app service performance reliability, and managed disk I/O throttling, among many others. The entire list is available on the [Performance efficiency recommendation page](/azure/advisor/advisor-performance-recommendations).
