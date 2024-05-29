Let's get started by going to your Azure account on the Azure portal.

## Where can I find Advisor?

Advisor is available on the [Azure portal](https://portal.azure.com/?azure-portal=true). Here are a couple of different ways you can get to it:

- Select **Advisor** from the left pane of the portal.

   :::image type="content" source="../media/advisor-from-azure-portal.png" alt-text="Screenshot showing how to find Advisor from the portal left pane." lightbox="../media/advisor-from-azure-portal.png":::

- Select **All services** from the left pane of the portal. Then select **Advisor** under **Management + governance**

   :::image type="content" source="../media/advisor-from-all-services.png" alt-text="Screenshot showing where to find Advisor under All services." lightbox="../media/advisor-from-all-services.png":::

After you take one of the previous steps, you'll see the Advisor dashboard.

:::image type="content" source="../media/azure-advisor-overview.png" alt-text="Screenshot of Advisor dashboard." lightbox="../media/azure-advisor-overview.png":::

### Areas where Advisor can help

The Advisor dashboard gives you recommendations for each of the five categories of the Azure Well-Architected Framework:

| Category | Description |
|---------|---------|
| **Cost** | Helps optimize and reduce your overall Azure spend by identifying idle and underutilized resources |
| **Security** | Integrates with [Microsoft Defender for Cloud](/azure/defender-for-cloud/review-security-recommendations) to identify potential vulnerabilities that can lead to security breaches |
| **Reliability** | Helps to ensure and improve the continuity of your business-critical applications |
| **Operational excellence** | Makes recommendations for process and workflow efficiency, resource manageability, and deployment best practices.|
| **Performance** | Helps improve the speed and responsiveness of your business-critical applications |

## How does Advisor work?

Think of Azure Advisor as your personalized cloud consultant. It gives you recommendations on best practices to optimize your Azure services' setup and to help you achieve your well-architected goals.

Advisor analyzes your *resource configuration* and *usage telemetry*, then gives you actionable recommendations that can help you improve your Azure resources' cost effectiveness, performance, reliability, and security, as well as your operational excellence.

Advisor operates at the subscription and resource level, either in aggregate or individually. You can access Advisor recommendations as Owner, Contributor, or Reader of a subscription or resource. These levels of access also apply to partners who manage Azure resources on your behalf.

:::image type="content" source="../media/how-advisor-works.svg" alt-text="Diagram showing how Azure Advisor makes custom recommendations for resource optimization based on your workloads.":::

### Examples of Advisor recommendations

Advisor gives you several recommendations for each of these categories. Here are just a few examples for each category, most of which are fairly self-explanatory:

#### Cost

- Resize or shut down underutilized virtual machine instances
- Eliminate unprovisioned ExpressRoute circuits
- Delete or reconfigure idle virtual network gateways

#### Reliability

- Ensure application gateway fault tolerance
- Enable backup to protect your virtual machine data from accidental deletion
- Configure Traffic Manager endpoints for resiliency

#### Operational excellence

- Create Azure Service Health alerts to notify you when Azure problems affect you
- Design your storage accounts to prevent reaching the maximum subscription limit
- Check if validation environment is enabled

#### Performance

- Improve App Service performance and reliability
- Use managed disks to prevent disk I/O throttling
- Improve MySQL connection management

#### Security

- Virtual-machine management ports should be protected with just-in-time network access control
- FTPS should be required in your web app
- Container images should be deployed from trusted registries only

Advisor integrates with Microsoft Defender for Cloud to provide security recommendations on the Advisor dashboard's Security tab, and with Microsoft Cost Management to offer cost recommendations on the Advisor dashboard's Cost tab.

## Remediating issues found by Advisor recommendations

Now that you've learned a little about your Advisor recommendations, we'll show you the typical process you can follow to resolve them.

First, on your Advisor dashboard, you can select a category that shows recommendations to resolve. You can also choose to see **All recommendations**, which shows a list of every Advisor recommendation across all five categories.

You'll notice that each of the five category tiles shows:

- The number of Advisor recommendations.
- The number of impacted resources.
- Their impact level (low, medium, or high).

:::image type="content" source="../media/azure-advisor-five-categories.png" alt-text="Screenshot of Advisor dashboard showing five recommendation tiles." lightbox="../media/azure-advisor-five-categories.png":::

By making a selection, you open a new page that shows details about the recommendations for the chosen category. Under a summary of the recommendations, you'll see a table that provides more information, such as:

- A linked description of each recommendation
- The impact level of each recommendation
- The potential annual savings for fixing each issue
- The number of resources affected

In addition, on the left side of the page under **Recommendations**, you can select a different category to quickly open a page where you can see the Advisor recommendations for that  selection.

:::image type="content" source="../media/azure-advisor-cost-recommendations.png" alt-text="Screenshot of Advisor Performance window with recommendation details." lightbox="../media/azure-advisor-cost-recommendations.png":::

After you select a linked description for a recommendation, a window opens showing some suggestions for actions you can take. At this point in the flow, you have several options for how you want to handle the recommendation.

- You can select a linked **Recommended action** and another page opens that helps you take the necessary steps to resolve the issue.
- If you'd prefer to handle the recommendation at a later time, you can select **Postpone**. Advisor removes it from the list, but will recommend it again if the issue hasn't been resolved.
- If you know that you don't want to resolve that issue, you can select **Dismiss**, and Advisor removes it from the list and no longer shows it as a recommendation for that resource. You can always revisit your dismissed recommendations in the **Postponed & Dismissed** tab under any of your recommendations.

   :::image type="content" source="../media/azure-advisor-vm-resize-postpone-dismiss.png" alt-text="Screenshot showing a recommended action in Azure Advisor." lightbox="../media/azure-advisor-vm-resize-postpone-dismiss.png":::
