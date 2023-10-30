Now, let's walk through a real-world example to see how Advisor can work in your environment. In this unit, there are guided step-by-step instructions to review and apply some Advisor recommendations to help optimize your Azure workloads.

> [!NOTE]
> You'll need at least read access to one active Azure subscription with provisioned resources.

1. First, sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. Go to your Advisor dashboard by typing "advisor" in the search bar and then selecting **Advisor** from the list of services.

   :::image type="content" source="../media/advisor-from-search-bar.png" alt-text="Screenshot showing how to find Advisor by using the search bar." lightbox="../media/advisor-from-search-bar.png":::

1. Select **Overview**. The Advisor dashboard opens, showing personalized recommendations for all your subscriptions. The recommendations are divided into the five categories that you learned about in the previous unit.

1. You can select any one of the five categories that shows there are recommendations to address. Your dashboard looks different from the following screenshot, because Advisor is personalized for you.

   For this exercise, we're using an example from the cost category. If you have at least one recommendation in the cost category, select the **Cost** tile. Otherwise, select a tile that shows at least one recommendation.

   If you don't have any recommendations, it could mean that you're already following all our best practices for your deployed resources. It might also mean that you don't have any Azure subscriptions or resources, or that you don't have sufficient permissions to access them.

   :::image type="content" source="../media/azure-advisor-select-cost.png" alt-text="Screenshot of Advisor dashboard showing five recommendation tiles." lightbox="../media/azure-advisor-select-cost.png":::

   The page for the tile you selected opens, where you can view things like:

   - A description of your Advisor recommendations.
   - The number of impacted resources and the impact level for each resource.
   - The potential monthly cost savings if you resolve the issues.

1. Select a recommendation from the **Description** list to review it. The **Recommendation details** page suggests some ways that you can remediate the flagged issue. For this exercise, we're looking at the recommendation for **Right-size or shutdown underutilized virtual machines**, but feel free to select any active recommendation you see.

   :::image type="content" source="../media/azure-advisor-select-cost-recommendation.png" alt-text="Screenshot showing how to select a recommendation from the Advisor Cost page." lightbox="../media/azure-advisor-select-cost-recommendation.png":::

   When you select the recommendation, a more detailed page opens to show the impacted resources and the recommended actions you can take to resolve the issues. In our case, the **Shut down or resize your virtual machine** page also breaks down the cost savings you can achieve per resource.

   For this exercise, there are a few recommended actions you can apply for each virtual machine.

   :::image type="content" source="../media/azure-advisor-vm-resize-shutdown-recommendation.png" alt-text="Screenshot showing recommended actions you can take." lightbox="../media/azure-advisor-vm-resize-shutdown-recommendation.png":::

   > [!NOTE]
   > If you're not ready to take action during this exercise, simply close the Azure portal, and no changes will be made to your subscriptions or resources. The only way to undo a recommendation is to take the opposite action.

1. Select one of the **Recommended actions** from the list. On the next page, Advisor helps guide you through specific actions that you can take right now to apply the recommendation and resolve the issue.

   However, notice that you can also choose to **Postpone** or **Dismiss** the recommended action, as we discussed in a previous unit.

   :::image type="content" source="../media/advisor-details-dashboard-postpone-dismiss.png" alt-text="Screenshot highlighting postpone and dismiss options." lightbox="../media/advisor-details-dashboard-postpone-dismiss.png":::
