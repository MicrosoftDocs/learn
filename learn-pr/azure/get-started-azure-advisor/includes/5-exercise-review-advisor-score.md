Now that you have a basic understanding of how Advisor Score can help you optimize your workloads, let's run through an example of how to use it in your environment. This unit guides you through step-by-step actions to review your Advisor Score and identify the best actions to take.

If you've still got your Advisor dashboard open, you can skip ahead to step 3.

1. First, sign in to the [Azure portal](https://portal.azure.com/?azure-portal=true).
1. Go to your Advisor dashboard by typing *Advisor* in the search bar and then selecting **Advisor** from the list of services.
1. The **Advisor Score** page opens, showing your overall Advisor Score and the individual category scores. Remember, your dashboard looks different from the screenshots in this exercise because Advisor is personalized for you.

   :::image type="content" source="../media/azure-select-advisor-score.png" alt-text="Screenshot showing the Advisor Score page." lightbox="../media/azure-select-advisor-score.png":::

1. Notice your overall **Advisor Score**.

   :::image type="content" source="../media/azure-overall-advisor-score.png" alt-text="Screenshot showing the overall Advisor Score." lightbox="../media/azure-overall-advisor-score.png":::

   Your personal Advisor Score is likely different from what's shown in our example.

   >[!Important]
   > Remember that your score gives you a quick snapshot that shows how closely the resources in your subscriptions follow our documented well-architected best practices.

   Next to the overall **Advisor Score** is your **Score history**. This valuable graphical representation shows how your score changes over a period of time. You can choose the time period by selecting it from the drop-down menu above the chart.

1. Now, let's look over at the Advisor category scores.

   :::image type="content" source="../media/azure-advisor-score-by-category.png" alt-text="Screenshot showing the category scores on the Advisor Score page." lightbox="../media/azure-advisor-score-by-category.png":::

   Right away, you can see that although the overall **Advisor Score** in this example might be considered good, two of the category scores are below 50% and really could use some attention.

1. Select the category with the lowest score. For our example, we're going to look at **Cost** because it's showing a score of 45%, but you have a different category in your environment that you want to address.

   The area at the bottom of the **Advisor Score** page shows recommendations for the category you chose.

   :::image type="content" source="../media/azure-advisor-score-recommendations.png" alt-text="Screenshot showing how to select a recommendation from the Advisor Score page." lightbox="../media/azure-advisor-score-recommendations.png":::

   Some of the fields shown in the table are familiar, such as **Potential yearly savings** and **Impacted resources**. But you'll also notice a new field called **Cost score impact**, which is the **Category score impact** for the **Cost** category. It shows you at a quick glance how much the corresponding recommendation impacts the category score when you address it. The higher the percentage, the greater benefit it has. That way, you can focus on the recommendations that improve your Advisor Score the most.

1. Select a recommendation from the **Description** list to review it in more detail and to see ways in which you can remediate the surfaced issue. For this exercise, we're looking at the recommendation for **Right-size or shutdown underutilized virtual machines** because its **Cost score impact** is greatest, but feel free to select any active recommendation you see.

   When you make your selection, a more detailed page opens, showing the impacted resources and recommended actions you can take to resolve the issues.

> [!NOTE]
> If you're not ready to take action during this exercise, simply close the Azure portal, and no changes will be made to your subscriptions or resources. The only way to undo a recommendation is to take the opposite action.

When you do apply any of the recommendations, your Advisor Score improves! It can take up to 24 hours for the score to change, so check back in a day or so to see how much higher it is.

We recommend that you use Advisor Score as a way to set goals for how closely you want to align with Azure best practices and then track your progress in achieving those goals over time.
