Azure Advisor scans and analyses your Azure resource configuration and usage telemetry to provide recommendations and proposed actions.

## Access Advisor's recommendations

You can access Advisor through the Azure portal. Sign in to the portal and locate Advisor in the navigation menu or search for it in the **All services** menu. Open Advisor to see the recommendations, which are divided into five categories: **Cost**, **Security**, **Reliability**, **Operational excellence**, and **Performance**.

For all recommendations provided, you can postpone the display, for a specific time period (one day, one week, one month, three months), or indefinitely. You also can choose to dismiss the recommendation.

You need to be an *Owner*, *Contributor*, or *Reader* for the subscription, resource group, or resource, to have permissions to access Advisor.

## Configure Advisor's recommendations

It's possible to choose which subscriptions and resource groups you want to receive recommendations on. Advisor provides this functionality through the **Configuration** option, under **Settings**.

:::image type="content" source="../media/3-advisor-configuration.png" alt-text=" Screenshot showing the Configuration pane in Azure Advisor.":::

Under  the **Rules** option, it is possible to configure the average CPU utilization rule for the low usage virtual machine recommendation. The CPU utilization rule can be set to 5%, 10%, 15%, or 20%.

> [!Note]
> To adjust the average CPU utilization rule for identifying low usage virtual machines, you must be a subscription Owner. If you do not have the required permissions for a subscription or resource group, the option to include or exclude it will be disabled in the user interface.

## Download Advisor's recommendations

You can download a summary of the recommendations from Advisor in a CSV or PDF format. Downloading the file makes easy to share with your coworkers, or you can perform your own analysis. You can choose to download only data for specific recommendations or categories that you are viewing. It can help you target actions that may be necessary on specific areas of your subscription.

:::image type="content" source="../media/3-advisor-download-recommendations.png" alt-text="A screenshot depicting the location of the download buttons for the .csv or PDF options.":::

## Alerts based on recommendations

You can choose to receive alerts from Advisor. When a new recommendation is detected by Advisor, it will be store in the Azure Activity Log. You are then able to set up alerts for the stored events. To create alerts for recommendations, you would open Azure Advisor and go to **Alerts** under **Monitoring**. Selecting the **New Advisor Alert** button at the top of that pane, allows you to configure the advisor alert.

:::image type="content" source="../media/3-advisor-alert.png" alt-text="Screenshot depicting where the Alerts option is, and where the New Advisor Alert button is located.":::

Configuring the alert requires that you define a scope by selecting a subscription and, optionally, a resource group.

Alerts are driven by conditions. Here you have two mutually exclusive options:

* Category and impact level: In this option, you could select one of the categories (Cost, Performance, Reliability, and Operational excellence) and an impact level (Low, Medium, and High). Both of these are optional configurations.
* Recommendation Type: If you choose by recommendation type, you would select the recommendation type that is most appropriate for your needs. You can view the available selections from the dropdown list.

You can also configure **action groups**.  An action group is a collection of notification preferences defined by the owner of an Azure subscription. The Azure Monitor, Service Health and Azure Advisor use action groups to notify users that an alert has been triggered.

Finally, you can also specify some important alert details such as an alert rule name, description (optional), choose whether the alert is enabled or not upon creation, and specify a resource group where the alert will be saved.

:::image type="content" source="../media/3-create-alert.png" alt-text="Screenshot depicting the dialog for creating an Advisor alert as described in the preceding paragraphs.":::

## Configuration of the recommendations summary

Accessing the Azure Advisor regularly to check recommendations is a good practice. Receiving an alert when some recommendation is triggered is a good practice. You might also consider the use of a weekly digest, by e-mail, that lists a summarization of the recommendations.

Azure Advisor can send recommendation summaries through the **Recommendation digests** option, under the **Monitoring** section. If there are no existing digests configured, you get started by selecting the **New Recommendation Digest** button.

:::image type="content" source="../media/3-advisor-create-digest.png" alt-text="Screenshot depicting the configuration options for creating an Advisor recommendation digest.":::

After selecting the subscription, under Scope, you would configure the frequency, recommendation category, and language options.

* Frequency: Options include weekly, bi-weekly, or monthly.
* Recommendation category: A multiple selection option where you can choose the main categories of Reliability, Security, Performance, Operational Excellence, and Cost.
* Language: You can select a language you prefer to receive the digest text in. The available languages are displayed in the language dropdown list.

You can also select an existing action group, or create a new one, in which the recommendations will be received. The last option allows you to name your digest and determine whether it is enabled or not. You can disable a recommendation digest if you want to pause the summaries.

:::image type="content" source="../media/3-advisor-digest.png" alt-text="Screenshot depicting the available options for configuring a recommendation digest.":::

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
