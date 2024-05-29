Another nice Azure Advisor feature is that it lets you apply its recommendations in bulk so that you can quickly and easily resolve issues in batches.

As we ran through the exercises, you might have noticed a **Quick Fix** button next to some of the Advisor recommendations. **Quick Fix** offers a faster, easier method to remediate an issue affecting multiple resources.

It provides the capability to remediate resources in bulk, which helps you optimize your subscriptions faster by applying the recommendations at scale.

> [!NOTE]
> The **Quick Fix** feature is available for certain recommendations only.

## How does Quick Fix work?

Basically, you first select all of the resources to which you want to apply recommendations. Then, when you select **Quick Fix**, the Advisor recommendations you specify are applied for all of the selected resources at the same time.

Now, let's walk through it to see how it works.

From your list of recommendations, you can identify any that allow batch remediation, because they show the **Quick Fix** button next to the recommendation.

:::image type="content" source="../media/azure-advisor-quick-fix-button.png" alt-text="Screenshot showing location of Quick fix button." lightbox="../media/azure-advisor-quick-fix-button.png":::

When you select the recommendation associated with **Quick Fix**, a more detailed page opens showing the resources affected and the recommended actions you can take to resolve the issues.

Here, you can select the check box next to each recommendation you want to resolve, then select **Quick Fix**.

:::image type="icon" source="../media/quickfix.png" border="false":::

In this example, we're choosing to apply the recommended action **Shut down the virtual machine** to the two resources we've selected.

:::image type="content" source="../media/azure-advisor-quick-fix-select.png" alt-text="Screenshot showing how to select recommendations for quick fix." lightbox="../media/azure-advisor-quick-fix-select.png":::

After you select **Quick Fix (Preview)**, a new page opens that helps guide you through specific actions you can take right now to apply the recommendation to all the resources you selected.

### Postpone and Dismiss

Just as you can apply Advisor recommendations to multiple resources at the same time, you can also choose to postpone or dismiss the recommendations in bulk as well.

For this option, follow the same process for **Quick Fix** that we just discussed. However, instead of quickly fixing the resources you choose, select either **Postpone** or **Dismiss**.

:::image type="icon" source="../media/postpone.png" border="false"::: &nbsp; &nbsp; &nbsp; :::image type="icon" source="../media/dismiss.png" border="false":::

:::image type="content" source="../media/azure-advisor-quick-fix-select-postpone-dismiss.png" alt-text="Screenshot showing how to bulk postpone or dismiss." lightbox="../media/azure-advisor-quick-fix-select-postpone-dismiss.png":::

You can then deal with those recommendations at a later time (Postpone), or remove them from the list altogether (Dismiss). You can always review your postponed or dismissed recommendations in the **Postponed & Dismissed** tab under any recommendation. As a reminder, postponed and dismissed recommendations aren't counted toward your Advisor Score.
