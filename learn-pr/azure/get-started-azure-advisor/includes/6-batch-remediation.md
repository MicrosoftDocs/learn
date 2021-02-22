Azure Advisor also lets you apply its recommendations in bulk so that you can quickly and easily resolve issues in batches.

As we ran through the exercises, you might have noticed a **Quick Fix** button next to some of the Advisor recommendations. **Quick Fix** offers a faster, easier method to remediate an issue that affects multiple resources.

It provides the capability for bulk remediations of resources, which helps you optimize your subscriptions faster by applying the recommendations at scale.

> [!NOTE]
> The **Quick Fix** feature is available for certain recommendations only.

## How does Quick Fix work?

Basically, you first select all of the resources you want to apply recommendations to. Then, when you select **Quick Fix**, the Advisor recommendations you specify are applied for all of the selected resources at the same time.

Now, let's walk through it to see how it works.

From your list of recommendations, you can identify any that allow batch remediation because they show the **Quick Fix** button next to the recommendation.

:::image type="content" source="../media/azure-advisor-quick-fix-button.png" alt-text="Screenshot showing location of Quick fix button" lightbox="../media/azure-advisor-quick-fix-button.png":::

By selecting the **Quick Fix** recommendation, you open a more detailed page that shows the impacted resources and the recommended actions you can take to resolve the issues.

Select the check box to the left of each recommendation you want to resolve. Then, select **Quick Fix (Preview)**. In this example, we are choosing to apply the recommended action **Shut down the virtual machine** to the two resources we have selected.

:::image type="content" source="../media/azure-advisor-quick-fix-select.png" alt-text="Screenshot showing how to select recommendations for quick fix." lightbox="../media/azure-advisor-quick-fix-select.png":::

After you select **Quick Fix (Preview)**, a new page opens that helps guide you through specific actions that you can take right now to apply the recommendation to all the resources you selected.

### Postpone and Dismiss

In the same way that you can apply Advisor recommendations to multiple resources at the same time, you can also choose to postpone or dismiss the recommendations in bulk as well.

Follow the same process outlined earlier for selecting resources. However, instead of using **Quick Fix**, select either **Postpone** or **Dismiss**.

:::image type="content" source="../media/azure-advisor-quick-fix-select-postpone-dismiss.png" alt-text="Screenshot showing how to bulk postpone or dismiss." lightbox="../media/azure-advisor-quick-fix-select-postpone-dismiss.png":::

You can then deal with those recommendations at a later time (postpone), or they'll be removed from the list altogether (dismiss).
