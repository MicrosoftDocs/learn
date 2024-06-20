Effectively managing your organization's data is critical. Microsoft Purview helps with this through retention policies, which ensure data is handled in compliance with regulatory requirements. These policies dictate whether to keep, delete, or retain data temporarily.

## Understand retention policies

A retention policy in Microsoft Purview helps your organization manage its data more effectively. It can be applied to various services such as emails, documents, and chats, simplifying compliance with legal requirements.

### Permissions for managing retention policies

To manage retention policies and retention labels in Microsoft Purview, you need the appropriate access permissions. This includes access to the Microsoft Purview portal or the Microsoft Purview compliance portal. To obtain these permissions, you should be added to the **Compliance Administrator** role group.

If the default role doesn't suit your needs, a new role group can be created to include the **Retention Management** role for active policy management. For viewing settings without the ability to make changes, the **View-Only Retention Management** role is recommended.

## Create and configure a retention policy

Microsoft Purview enables you to apply retention policies across various services, identified as "locations," within your organization. However, it's important to understand that a single retention policy can't include all locations in a single retention policy. Here are the locations you can manage with these policies:

- **Exchange mailboxes**
- **SharePoint sites** or **SharePoint classic and communication sites**
- **OneDrive accounts**
- **Microsoft 365 Group mailboxes & sites**
- **Exchange public folders**
- **Teams channel messages**
- **Teams chats and Copilot interactions**
- **Teams private channel messages**
- **Viva Engage community messages**
- **Viva Engage user messages**

Selecting either Teams or Viva Engage as a location automatically excludes the other locations from the same policy. This exclusion highlights the importance of careful planning and strategic decision-making when setting up your retention policies.

### Steps to create a retention policy

1. Navigate to **Retention polices** in either the Microsoft Purview portal or Microsoft Purview compliance portal:

   - **Microsoft Purview portal**: [Sign in to the Microsoft Purview portal](https://purview.microsoft.com/) > **Data Lifecycle Management** card > **Policies** > **Retention policies**.

        If you don't see the **Data Lifecycle Management** card, select **View all solutions** and find **Data Lifecycle Management** under the **Data Governance** section.

        :::image type="content" source="../media/purview-portal-data-lifecycle-management-card.png" alt-text="Screenshot showing the Data Lifecycle card in the Microsoft Purview portal.":::

   - **Microsoft Purview compliance portal**: [Sign in to the Microsoft Purview compliance portal](https://compliance.microsoft.com/) > **Solutions** > **Data lifecycle management** > **Microsoft 365** > **Retention Policies**.

1. Select **New retention policy** to start the **Create retention policy** configuration, and name your new retention policy.

1. On the **Assign admin units** page: If your organization uses administrative units in Microsoft Entra ID, you can restrict the retention policy to specific users by selecting these units. If administrative units are assigned to your account, choose the relevant ones.

    If you don't want to use administrative units or if they aren't set up in your organization, keep the default setting as **Full directory**.

1. Select the scope type for your retention policy.

1. On the **Decide if you want to retain content, delete it, or both** page:

   - **Retain items for a specific period**: Items are retained for a defined time frame. After this period, they are automatically deleted, helping manage data efficiently and ensuring compliance.

   - **Retain items forever**: Items are kept indefinitely without an automatic deletion timeline.

   - **Only delete items when they reach a certain age**: Items aren't retained but are scheduled for automatic deletion once they reach a specified age, helping manage data lifecycle without long-term retention.

1. Complete the configuration and save your settings.

### Specific configurations for services

**Teams and Copilot for Microsoft 365**:

- For Teams, including shared channels, configure retention settings that inherit from the parent team.
- For Copilot interactions, apply settings that manage the data lifecycle of chat and interaction records.

**Viva Engage**:

- Configure policies that address both community messages and private interactions.
- Ensure that retention settings don't inform users directly about data deletions.

**Other Services (Exchange, SharePoint, OneDrive)**:

- Tailor policies to handle email, site content, and personal storage in ways that meet organizational and regulatory needs.
- Consider the unique aspects of each service to ensure comprehensive coverage.

## How long it takes for retention policies to take effect

:::image type="content" source="../media/retention-policy-timings.png" alt-text="Diagram illustrating retention policy timing.":::

It can take up to seven days for a retention policy to be fully applied. During this period, the policy is distributed to the specified locations and begins to affect the data. Regularly monitor the policy's application to address any issues promptly.

Retention policies are essential for robust data governance. By carefully setting up and managing these policies, organizations can ensure compliance, mitigate risks, and optimize their data management strategies.
