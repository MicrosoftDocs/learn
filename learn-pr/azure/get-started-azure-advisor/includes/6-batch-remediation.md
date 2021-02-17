Another nice feature of Azure Advisor is that it lets you apply its recommendations in bulk so that you can quickly and easily resolve issues in batches.

As we ran through the exercises, you might have noticed a **Quick fix** button next to some of the Advisor recommendations. **Quick fix** offers a faster, easier method to remediate a recommendation on multiple resources.

It provides the capability for bulk remediations of resources, which helps you optimize your subscriptions faster by applying the recommendations at scale.

> [!NOTE]
> The **Quick fix** feature is available for certain recommendations only.

## How does Quick fix work?

Basically, you first select all of the resources you want to apply recommendations to. Then, when you select **Quick fix**, the Advisor recommendations you specify are applied for all of the selected resources at the same time.

Now, let's walk through it to see how it works.

From your list of recommendations, you can identify any that allow batch remediation because they show the **Quick fix** button next to the recommendation.

:::image type="content" source="../media/azure-advisor-quick-fix-button.png" alt-text="Screenshot showing location of Quick fix button" lightbox="../media/azure-advisor-quick-fix-button.png":::

When you select the recommendation associated with **Quick fix**, a more detailed page opens showing the resources affected and the recommended actions you can take to resolve the issues.

Here, you can select a check box on the left for each recommendation you want to resolve. Then, select **Quick Fix (Preview)**. In this example, we are choosing to apply the recommended action **Shut down the virtual machine** to the two resources we have selected.

:::image type="content" source="../media/azure-advisor-quick-fix-select.png" alt-text="Screenshot showing how to select recommendations for quick fix." lightbox="../media/azure-advisor-quick-fix-select.png":::

After you select **Quick Fix (Preview)**, a new page opens that helps guide you through specific actions you can take right now to apply the recommendation to all the resources you selected.

### Postpone and Dismiss

Just as you can apply Advisor recommendations to multiple resources at the same time, you can also choose to postpone or dismiss the recommendations in bulk as well.

To do this, you would follow the same process for **Quick fix** that we just discussed. However, instead of quickly fixing the resources you choose, you would select either **Postpone** or **Dismiss**.

:::image type="content" source="../media/azure-advisor-quick-fix-select-postpone-dismiss.png" alt-text="Screenshot showing how to bulk postpone or dismiss." lightbox="../media/azure-advisor-quick-fix-select-postpone-dismiss.png":::


You can then deal with those recommendations at a later time (postpone), or they will be removed from the list altogether (dismiss).
