In Microsoft Purview, a single item can be subject to multiple retention settings at once. That includes retention policies, retention labels, or both. These settings can be configured to retain content, delete content, or do both.

When multiple settings apply, it's not a matter of one label or policy "winning." Instead, Microsoft Purview evaluates all settings to decide:

- How long the item should be retained
- When the item should be deleted

These outcomes are calculated separately. For example, an item might be retained under one setting and deleted under another. If those settings conflict, the principles of retention help determine what happens.

## Principles that determine retention and deletion

Microsoft Purview follows a consistent set of rules when deciding how retention and deletion actions interact:

:::image type="content" source="../media/principles-of-retention.png" alt-text="Diagram illustrating the principles of retention in Microsoft Purview." lightbox="../media/principles-of-retention.png":::

### 1. Retention takes priority over deletion

If an item has both retention and deletion settings, the retention setting always takes precedence. The item is retained until the retention period ends, even if another setting is trying to delete it sooner.

**Example**: An email is subject to one policy that deletes items after three years and a label that retains items for five years. The email is preserved for five years before it's permanently deleted.

### 2. The longest retention period applies

When multiple settings require content to be retained, the one with the longest duration is used. This ensures that the content is preserved for the full period required by any setting.

**Example**: A document is subject to two retention policies. One keeps content for five years, and the other for ten years. The document is retained for ten years.

> [!NOTE]
> Retention periods might begin at different times, such as when an item is created or last modified. This affects the total retention time for the item.

### 3. Deletion settings from labels take priority over policies

If retention settings conflict on when to delete content, Microsoft Purview favors the more specific setting:

- A retention label applied to an item takes precedence over a policy applied to the container.
- Between policies, those scoped to specific users or locations take precedence over policies that apply broadly to an entire service.

**Example (label)**: A document has a retention label that deletes it after seven years and is also subject to two policies with delete actions after five and ten years. The document is deleted after seven years.

**Example (policies)**: An email is included in two retention policies. One applies to all mailboxes and deletes content after ten years. The other applies only to a specific mailbox and deletes content after five years. The email is deleted after five years.

### 4. If deletion settings are equal, the shortest deletion period wins

If there are multiple scoped policies with different delete actions, and none of the earlier principles apply, the shortest delete period is used.

**Example**: A file in OneDrive is included in two scoped policies. One deletes after ten years, the other after seven. The file is deleted after seven years.

## Use the flowchart to determine outcomes

If multiple retention settings apply to the same item, you can use the Microsoft Purview retention flowchart to walk through what happens. The flowchart presents a step-by-step decision process using yes-or-no questions to determine:

- Whether an item is retained
- When it will be deleted

This tool helps you apply the principles covered above to more complex scenarios.

:::image type="content" source="../media/retention-flowchart.svg" alt-text="Flowchart for determining retention and deletion outcomes when multiple settings apply." lightbox="../media/retention-flowchart.svg":::

## Special case: eDiscovery holds

If an item is subject to an eDiscovery hold, it can't be permanently deleted. Once the hold is removed, the other retention settings resume.

## Tips for applying these principles

- Retention and deletion are determined separately, not by which setting "wins."
- Retention labels always take precedence over policies for deletion.
- Use scoped policies when you need more precise control.
- Understand how the start of the retention period is configured. This affects how long content is kept.
