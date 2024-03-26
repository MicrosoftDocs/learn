You’re now certain that access tiers offer the ability to help control the excessive storage costs you’ve identified in your company. Your primary concern is identifying the approach that allows you to simplify their implementation in a manner that minimizes administrative overhead. In this unit, you'll learn about Azure Storage Blob lifecycle management, which allows you to automate switching between access tier types based on customizable rules.

### Describe Azure Blob Storage lifecycle management

Maintaining the optimal access tier assignments is a continuous process because storage usage patterns and the data’s relevance change over time. Addressing this challenge requires an automated solution. Fortunately, Azure Blob Storage includes support for lifecycle management policies by offering this very functionality.

### Configure Azure Blob Storage lifecycle management

Azure Storage lifecycle management consists of a JSON-formatted policy. This policy consists of custom-defined rules that determine the intended blob management tasks. Most commonly, those tasks evaluate when blobs were last modified or accessed and depending on the outcome of that evaluation, either retain the current access tier assignment, transition the blobs to a different tier, or delete them. Lifecycle management also integrates with blob versioning and snapshots. This allows you to automatically transition older versions of blobs and snapshots to cool, cold, and archive storage tiers and also delete them where appropriate to minimize costs. You can scope rules to specific containers based on the name prefixes or blob-index tags.

To implement support for evaluations based on the last-accessed date, you need to enable blob access time tracking. The last-accessed date represents both read and write operations, unlike the last-modified date, which designates writes only. The corresponding metadata is updated daily.

:::image type="content" source="../media/5-enable-access-tracking.png" alt-text="Screenshot of the Azure portal Lifecycle management pane has Enable access tracking selected." border="false" lightbox="../media/5-enable-access-tracking.png":::

:::image type="content" source="../media/5-lifecycle-rule-move-to-cool-fifteen-days.png" alt-text="Screenshot of a lifecycle management rule in code view is designed to moves blobs to cool tier after 15 days after the last accessed date." border="false" lightbox="../media/5-lifecycle-rule-move-to-cool-fifteen-days.png":::

A performance-related measure the lifecycle management policy supports is the ability to transition blobs from the cool to hot tier as soon as they’re accessed. This is accomplished by setting the **enableAutoTierToHotFromCool** property to true within the policy rules.

> [!NOTE]
> In this case as well, keep in mind the potential cost implications as a result of the early deletion charge.

:::image type="content" source="../media/5-lifecycle-rule-enable-auto-tier-hot-cool.png" alt-text="Screenshot of a lifecycle management rule is designed to move blobs to cool tier after 15 days following the last accessed date." border="false" lightbox="../media/5-lifecycle-rule-enable-auto-tier-hot-cool.png":::

Policy rules also integrate with index tags. This allows you to author rules that target specific blobs based on the match on their index tags values. The following example illustrates a rule that deletes blobs based on the match on an index tag.

:::image type="content" source="../media/5-lifecycle-rule-index-tag-match.png" alt-text="Screenshot of the Azure portal Lifecycle management pane has a lifecycle management rule that removes blobs based on the index tag." border="false" lightbox="../media/5-lifecycle-rule-index-tag-match.png":::
