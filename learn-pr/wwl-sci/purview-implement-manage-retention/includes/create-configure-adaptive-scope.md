Effectively managing the lifecycle of your organization's information is critical for compliance and operational efficiency. Microsoft Purview offers two types of scopes when setting up retention policies: adaptive and static. Understanding the differences and configurations of these scopes can significantly enhance your data governance strategy.

## Adaptive vs static scopes

When creating a retention policy, you need to decide between using an adaptive or static scope to define the policy's reach:

### Adaptive scopes

Adaptive scopes dynamically apply retention policies based on specified queries that reflect the attributes or properties of the data. This approach allows the policy to automatically adjust as the underlying data changes, making it ideal for environments where data attributes such as job titles or departmental affiliations frequently change.

**Example**: If you need a retention policy that applies specifically to executives whose data requires a longer retention period, you can set up an adaptive scope with a query that identifies users by the **Executive** job title. This scope automatically updates to include new executives, ensuring that no manual adjustments are needed when personnel changes occur.

### Static scopes

In contrast, static scopes are less flexible but easier to manage in certain contexts. They're set to include or exclude specific datasets and don't change unless manually updated. This makes them suitable for situations where the data doesn't change often.

**Example**: For a policy that needs to cover all users within a specific group without change, a static scope could be applied to ensure consistent policy enforcement without the need for frequent updates.

### Advantages of adaptive scopes

Adaptive scopes offer several benefits, particularly in dynamic environments:

- **Flexibility**: Automatically adjusts to include new data that matches the defined criteria without manual intervention.
- **Efficiency**: Reduces the need for numerous policies, as one adaptive scope can cover dynamically changing data sets.
- **Precision**: Enables precise application of policies based on detailed attributes, enhancing compliance and data management effectiveness.

## Configure adaptive scopes

Before configuring an adaptive scope, determine the necessary scope type and attributes. Assign administrators to roles with _Scope Manager_ permissions to create adaptive scopes, such as:

- Compliance Administrator
- Compliance Data Administrator
- Organization Management
- Records Management
- Communication Compliance
- Communication Compliance Admins

### Steps to create adaptive scopes

1. Navigate to **Adaptive scopes** in either the Microsoft Purview portal or Microsoft Purview compliance portal:

   - **Microsoft Purview portal**: [Sign in to the Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) > **Settings** card > **Roles and scopes** > **Adaptive scopes**.

        - If you don't see the **Settings** card, select **View all solutions** and find **Settings** under the **Core** section.

        :::image type="content" source="../media/purview-portal-settings-card.png" alt-text="Screenshot showing the Settings card in the Microsoft Purview portal.":::

   - **Microsoft Purview compliance portal**: [Sign in to the Microsoft Purview compliance portal](https://compliance.microsoft.com/?azure-portal=true) > **Solutions** > **Roles & scopes** > **Adaptive scopes**.
1. Select **+ Create scope**."
1. If your organization uses administrative units and you want to restrict the policy to specific users, select the appropriate units. If not, select **Full directory** to include all locations.
1. Select the scope type and the attributes or properties to define dynamic membership. Input the desired attribute or property values.

   Example: To set up a scope for users in Europe, select **Users** as the scope type, select **Country or region**, and enter **Europe**. This query, running daily, identifies users with Europe listed in the Country or region attribute.

   :::image type="content" source="../media/example-adaptive-scope.png" alt-text="Screenshot showing the Create the query to define users to determine scope.":::

   Use **Add attribute** for users and groups or **Add property** for sites to integrate attributes or properties with logical operators like **is equal to**, **is not equal to**, **starts with**, and **not starts with**.

      :::image type="content" source="../media/example-adaptive-scope-grouping.png" alt-text="Screenshot showing where to add attributes when creating an adaptive scope.":::

   Alternatively, the **Advanced query builder** allows more complex queries:
   - **Users and Microsoft 365 Groups**: Use OPATH syntax to create queries based on department, country/region, and state.
   - **SharePoint sites**: Use Keyword Query Language (KQL) for indexed site properties. Consult the KQL syntax reference for guidance.

1. Create as many adaptive scopes as you need. You can select one or more adaptive scopes when you create your policy.

Queries might take up to five days to fully populate, and changes aren't immediate. Allow a few days for updates before integrating a newly created scope into your policy.
