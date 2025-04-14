Retention policies in Microsoft Purview help you manage the lifecycle of data across Microsoft 365. These policies define whether to retain or delete content, and for how long. By using retention policies, you can meet regulatory requirements, reduce risk, and apply consistent governance across workloads.

## Understand retention policies

Retention policies apply broad retention settings to containers such as mailboxes, sites, and Microsoft 365 Groups. They help you automatically retain or delete content based on age or events, supporting regulatory compliance and consistent lifecycle management across your organization.

Unlike retention labels, which apply to individual items and offer more granularity, retention policies are best for applying uniform rules across entire workloads.

> [!TIP]
> If content is subject to multiple retention settings, whether through policies, labels, or both, Microsoft Purview follows a defined precedence order. For details, see Principles of retention.

## Supported locations

Retention policies can apply to these locations. You can't include all of them in a single policy, so plan your policy scope accordingly:

- Exchange mailboxes and public folders
- SharePoint sites, including classic and communication sites
- OneDrive accounts
- Microsoft 365 Group mailboxes and sites
- Teams chats, private channel messages, and channel messages
- Microsoft Copilot interactions
- Enterprise AI apps
- Viva Engage user messages and community messages
- Skype for Business

> [!NOTE]
> If you select Teams or Viva Engage locations, the other locations will be excluded from the same policy unless you use an adaptive scope.

### Static and adaptive scopes

Before you begin, make sure you've selected the right scope type for your policy: **static** or **adaptive**. Scope type controls how policy membership is defined and whether it updates automatically.

Some locations only support static scopes, and others behave differently depending on the scope you choose.

## Create a retention policy

To configure a new retention policy:

1. Go to **Data lifecycle management**, then select **Policies** > **Retention policies**.

1. Select **New retention policy**.

1. On the **Name your retention policy** page, enter a name and optional description.

1. On the **Policy scope** page, optionally add admin units.

1. On the **Choose the type of retention policy to create​** page, choose between an **Adaptive** or **Static** policy scope.

   - Adaptive scopes require separate setup and allow targeting by user, site, or group attributes.

1. On the **Choose where to apply this policy** page, select the locations where the labels should be available.

   :::image type="content" source="../media/retention-policy-locations.png" alt-text="Screenshot showing locations available to apply a retention label policy." lightbox="../media/retention-label-policy-locations.png":::

1. On the **Decide if you want to retain content, delete it, or both** page, choose whether to retain items, delete them, or do both. Options include:

   - **Retain content for a specific period**, with optional deletion after that period.
   - **Retain content forever**.
   - **Delete content when it reaches a specified age**.

1. Review your settings, then create the retention label policy.

## Policy deployment timing and troubleshooting

It can take up to seven days for a newly created retention policy to be fully distributed and applied to content.

:::image type="content" source="../media/retention-policy-timings.png" alt-text="Diagram illustrating when retention policies are available to apply." lightbox= "../media/retention-policy-timings.png":::

If a policy doesn't take effect as expected:

- Check the **Status** on the **Retention policies** page in the Microsoft Purview portal.
- If deployment is stuck, retry distribution using PowerShell:

   ```powershell
   Set-RetentionCompliancePolicy -Identity "<PolicyName>" -RetryDistribution
   ```

   For Teams private channel messages or Viva Engage content, use:

   ```powershell
   Set-AppRetentionCompliancePolicy -Identity "<PolicyName>" -RetryDistribution
   ```

## Updating or deleting a policy

While most settings can be edited later, a few can't be changed once the policy is created:

- Policy name
- Scope type (static or adaptive)
- Retention action type (retain, delete, or both)

If you no longer need a policy to apply retention settings, release the policy instead of modifying it.

## Limitations and considerations

- Some retention settings, such as starting retention when content is last modified, might not be enforced. For example, Teams always uses the creation date instead.
- When configuring Copilot and AI app locations, all subcategories must be selected. Individual configuration isn't supported.
- Draft items in SharePoint aren't supported by retention policies.
- Teams, Copilot, and Viva Engage might require separate policies unless adaptive scopes are used.
- You might need more policies to manage files, chats, or meeting recordings that aren't stored directly in the primary app.
- Retention behavior and timing can vary across services. Always consult the latest Microsoft guidance when accuracy is critical.
