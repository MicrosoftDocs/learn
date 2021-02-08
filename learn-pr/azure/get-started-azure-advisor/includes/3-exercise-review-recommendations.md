Now, let's walk through a real world example to see how Advisor can work in your environment. Below you'll find guided step-by-step instructions that take you to your Azure subscription where you can review and apply some Advisor recommendations to help optimize your Azure workloads.

> [!NOTE]
> You’ll need at least read access to one Azure subscription with active subscriptions and provisioned resources.

1. First, log in to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. Go to your Advisor dashboard by typing "advisor" in the search bar and then selecting **Advisor** from the list of services.

   > [!div class="mx-imgBorder"]
   > [ ![Screenshot showing how to find Advisor by using the search bar.](../media/advisor-from-search-bar.png) ](../media/advisor-from-search-bar.png#lightbox)

    The Advisor dashboard opens showing personalized recommendations for all your subscriptions. The recommendations are divided into the five categories that you learned about in the previous unit.

1. You can select any one of the five categories that shows there are recommendations to address. Your dashboard will look different from the screenshot below because Advisor is personalized for you.

    For this exercise, we'll use an example from the cost category. If you have at least one recommendation in the cost category, go ahead select the **Cost** tile. Otherwise, select a tile that shows at least one recommendation.

    If you don’t have any recommendations, it could mean that you are already following all our best practices for your deployed resources. Or it might mean that you don’t have any Azure subscriptions or resources or sufficient permissions to access them.

    > [!div class="mx-imgBorder"]
    > [ ![Screenshot of Advisor dashboard showing five recommendation tiles.](../media/azure-advisor-select-cost.png) ](../media/azure-advisor-select-cost.png#lightbox)

   The page for the tile you selected opens, where you can view things like:

    - A description of the recommendations Advisor is making
    - How many resources are impacted and what the impact level is
    - The potential monthly cost savings if you resolve the issues

1. Select a recommendation from the **Description** list to review it in more detail and to see ways in which you can remediate the issue that was flagged. For this exercise, we are looking at the recommendation for **Right-size or shutdown underutilized virtual machines**, but feel free to select any active recommendation you see.

   > [!div class="mx-imgBorder"]
   > [ ![Screenshot showing how to select a recommendation from the Advisor Cost page.](../media/azure-advisor-select-cost-recommendation.png) ](../media/azure-advisor-select-cost-recommendation.png#lightbox)

    After selecting it, a more detailed page opens showing the resources affected and recommended actions you can take to resolve the issues. In our case, the **Shut down or resize your virtual machine** also breaks down the cost savings you can achieve per resource.

    For this exercise, there are a couple different recommended actions you can apply for each virtual machine.

   > [!div class="mx-imgBorder"]
   > [ ![Screenshot showing recommended actions you can take.](../media/azure-advisor-vm-resize-shutdown-recommendation.png) ](../media/azure-advisor-vm-resize-shutdown-recommendation.png#lightbox)

1. Select one of the **Recommended actions** from the list. The next page that opens helps guide you through specific actions that you can take right now to apply the recommendation and resolve the issue.

    However, you'll notice that you also have the option to **Postpone** or **Dismiss** the recommended action if you so choose, as we discussed in a previous unit.

   > [!div class="mx-imgBorder"]
   > [ ![Screenshot highlighting postpone and dismiss options.](../media/advisor-details-dashboard-postpone-dismiss.png) ](../media/advisor-details-dashboard-postpone-dismiss.png#lightbox)

> [!NOTE]
> If you’re not ready to take action during this exercise, simply close the Azure portal and no changes will be made to your subscriptions or resources.
