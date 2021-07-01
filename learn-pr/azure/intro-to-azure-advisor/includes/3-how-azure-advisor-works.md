# How Azure Advisor works?

## How access the recommendations?

You can access Advisor through the Azure portal. Sign in to the portal, locate Advisor in the navigation menu, or search for it in the All services menu. Then you will be able to see the recommendations divided into five categories: Cost, Security, Reliability, Operational excellence and Performance.

### Costs Recommendations

Azure Advisor help to identify idle and underutilized resources. You can get cost recommendations from the Cost tab on the Advisor dashboard. Here you can see a list of recommendations to reduce costs:

![Costs on Azure Advisor.](../media/3-advisor-cost.png)

In this case I chosen the recommendation to shut down or resize my virtual machine. I can have more details regarding the recommendation, rules used, another details over the potential savings, related subscription, and options to take an action.

![Recommendation from costs on Azure Advisor.](../media/3-advisor-cost-shutdown-vm.png)

### Security Recommendations

Security recommendations are integrated with Azure Security Center. You can get security recommendations from the Security tab on the Advisor dashboard. Full list of security recommendations to selected subscriptions: 

![Security on Azure Advisor.](../media/3-advisor-security.png)

Example of a recommendation about system updates available for my virtual machines, affected resources, and more:

![Recommendation from security on Azure Advisor.](../media/3-advisor-security-updates.png)

### Reliability Recommendations

Azure Advisor helps you ensure and improve the continuity of your business-critical applications. You can get reliability recommendations from Advisor on the Reliability tab of the Advisor dashboard. List of recommendations to my subscriptions:

![Reliability on Azure Advisor.](../media/3-advisor-reliability.png)

Example of a recommendation suggesting upgrade virtual machines to Managed Disks in order to improve the reliability of my virtual machines:

![Recommendation from reliability on Azure Advisor.](../media/3-advisor-reliability-upgradedisks.png)

### Operational excellence Recommendations

Operational excellence recommendations in Azure Advisor can help you with:

* Process and workflow efficiency.
* Resource manageability.
* Deployment best practices.
* You can get these recommendations on the Operational Excellence tab of the Advisor dashboard.

Recommendations to ensure operational excellence on my subscriptions:

![Operational excellence on Azure Advisor.](../media/3-advisor-operational-excellence.png)

Example of a recommendation to assign a policy to restrict the allowed SKUs for virtual machines:

![Example of a recommendation from operational excellence on Azure Advisor.](../media/3-advisor-operational-excellence-policy.png)

### Performance Recommendations

The performance recommendations in Azure Advisor can help improve the speed and responsiveness of your business-critical applications. You can get performance recommendations from Advisor on the Performance tab of the Advisor dashboard.

Recommendations to ensure performance improvements:

![Performance on Azure Advisor.](../media/3-advisor-performance.png)

Recommendation warning about an unsupported Kubernetes version detected, which can affect the overall performance on the workload:

![Example of a recommendation from performance on Azure Advisor.](../media/3-advisor-performance-aks.png)

## How to configure recommendations

It's possible to choose for which Subscriptions and Resource Groups you want receive recommendations from Azure Advisor. To do this, open Advisor then select on **Configuration** under **Settings** and apply.

![Configuration of Azure Advisor.](../media/3-advisor-configuration.png)

Also is possible configure the average CPU utilization rule for the low usage virtual machine recommendation. The CPU utilization rule can be set to 5%, 10%, 15%, or 20%.

> Please note that to adjust the average CPU utilization rule for identifying low usage virtual machines, you must be a subscription Owner. If you do not have the required permissions for a subscription or resource group, the option to include or exclude it will be disabled in the user interface.

![Configuration of Rules on Azure Advisor.](../media/3-advisor-rules.png)

## How to download the recommendations

You can download a summary of the recommendations from Advisor in a CSV or PDF format. This makes easy share with your coworkers or perform your own analysis

![Download recommendations.](../media/3-advisor-download-recommendations.png)

Example of a PDF file generated:

![PDF recommendations.](../media/3-summary-recommendations.png)

## How to create alerts on new recommendations

To create alerts for recommendations, you should open Azure Advisor and go to **Alerts**Alerts under **Monitoring**. Then select **New Advisor Alert**

![Create alerts on Azure Advisor.](../media/3-advisor-alert.png)

The first step is to define a scope. Then select the subscription and optionally an resource group.

The second step is to define the conditions for the alert. Here you have two options:

* Category and impact level: In this option, optionally you could select one of the categories (Cost, Performance, Reliability, and Operational excellence) and a impact level (Low, Medium, and High)
* Recommendation Type: If you choose by recommendation type, you should select the recommendation type that have more fit with your needs from a full  dropdown list.

The third step is to select an existing action group or create a new one. An action group is a collection of notification preferences defined by the owner of an Azure subscription. The Azure Monitor, Service Health and Azure Advisor use action groups to notify users that an alert has been triggered.

The fourth and final step is to specify an alert rule name, description (optional), choose to be enabled or not upon creation and a resource group where to save.

![Alerts on Azure Advisor.](../media/3-create-alert.png)

## How to configure recommendations summary

Access the Azure Advisor regularly to check recommendations is a good practice. Receive an alert when some recommendation is triggered also is great. But what about receive a weekly digest by e-mail with all of them?

To do that, access Advisor, select **Recommendation digests** under **Monitoring** then select **New Recommendation Digest**:

![Create a digests on Azure Advisor.](../media/3-advisor-create-digest.png)

After define the subscription under Scope, you should set the frequency, recommendation category and language:

* Frequency: Choose between Weekly, Bi-weekly, or Monthly
* Recommendation category: You can pick all options that make sense for you between Reliability, Security, Performance, Operational Excellence, and Cost
* Language: You can select a language you prefer receive the digest from a dropdown list.

Then select an existing or create e new action group then give a name for your digest and create!

![Digests on Azure Advisor.](../media/3-advisor-digest.png)
