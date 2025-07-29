Retention policies let you manage how long content is kept across Microsoft 365 services. In some cases, a single policy might be enough to cover your organization's needs. In others, you might need different policies for different groups of users.

In this exercise, you'll create one retention policy that applies broadly across the organization and another that targets specific departments. The first policy uses a static scope to apply to common workloads. The second uses an adaptive scope that targets users based on their department attribute.

**Estimated time to complete**: 30-40 minutes

> [!IMPORTANT]
> To complete this exercise, you need access to Microsoft Purview features through one of these Microsoft 365 licenses:
>
> - A Microsoft 365 E3 license is required to create and manage static retention policies.
> - A Microsoft 365 E5 license, or the E5 Information Protection and Governance add-on, is required to use adaptive scopes.
>
> If your tenant doesn't include these features, some tasks in the exercise might not be available. You can still follow the steps to understand how the configuration works or skip any unsupported tasks.
>
> If you don't have access to these features, you can join the [Microsoft 365 Developer Program](https://developer.microsoft.com/microsoft-365/dev-program). This program provides a free Microsoft 365 E5 developer subscription with access to many Purview capabilities.

## Create a retention policy for all users

Start by creating a retention policy that applies to the most commonly used Microsoft 365 locations. This policy uses a static scope and sets a consistent retention period across mail, files, and group content.

1. Navigate to [Microsoft Purview](https://purview.microsoft.com) and sign in.
1. Select **Solutions** > **Data lifecycle management**.
1. Expand **Policies**, then select **Retention policies**.
1. Select **+ New retention policy**.
1. On the **Name your retention policy** page, enter:

   - **Name**: `Core retention - 5 years`
   - **Description**: `Retains content for 5 years, then deletes. Used to meet baseline compliance needs.`

1. Select **Next**.
1. On the **Policy Scope** page, leave the default selected, then select **Next**.
1. On the **Choose the type of retention policy to create​** page, select **Static**, then select **Next**.
1. On the **Choose where to apply this policy** page, select:

   - **Exchange mailboxes**
   - **SharePoint classic and communication sites**
   - **OneDrive accounts**
   - **Microsoft 365 Groups**

1. Select **Next**.
1. On the **Decide if you want to retain content, delete it, or both** page:

   - Retain items for **5 years**
   - Start the retention period based on **when items were last modified**.
   - Delete items automatically at the end of the retention period.
1. Select **Next**.
1. On the **Review and finish** page, confirm your settings, then select **Submit**.
1. After your policy is created, select **Done**.

This policy now applies a five-year retention period across your organization's core workloads.

## Create an adaptive scope for legal and HR departments

Now create an adaptive scope that targets users in the Legal and HR departments. This scope lets you apply retention settings to those users automatically based on their Microsoft Entra ID attributes, without assigning accounts one by one.

1. In the Microsoft Purview portal, go to **Settings**.
1. Expand **Roles and scopes**, then select **Adaptive scopes**.
1. Select **+ Create scope**.
1. On the **Name your adaptive policy scope** page, enter:

   - **Name**: `Legal and HR departments`
   - **Description**: `Applies to users in the Legal and HR departments.`

1. Select **Next**.
1. On the **Assign admin unit** page, leave the default selected, then select **Next**.
1. On the **What type of scope do you want to create?​** page, select **Users**, then select **Next**.
1. On the **Create the query to define users** page, configure the query:

   - **Attribute**: Department
   - **Operator**: is equal to
   - **Value**: Legal

1. Select **+ Add attribute**, then add:

   - **Query operator**: Or
   - **Attribute**: Department
   - **Operator**: is equal to
   - **Value**: HR

1. Select **Next**.

1. On the **Review and finish** page, confirm your settings, then select **Submit**.
1. After your adaptive scope is created, select **Done**.

The adaptive scope now targets users in either the Legal or HR department based on their Microsoft Entra ID attributes.

## Create a retention policy with an adaptive scope

Use the adaptive scope you created to apply a targeted retention policy. This lets you enforce different retention settings for specific departments without applying them to all users.

1. Return to **Data lifecycle management** in the Microsoft Purview portal.
1. Select **Policies** > **Retention policies**, then select **+ New retention policy**.
1. On the **Name your retention policy** page, enter:

   - **Name**: `Legal data retention`
   - **Description**: `Applies retention settings to Legal and HR departments.`

1. Select **Next**.
1. On the **Policy Scope** page, leave the default selected, then select **Next**.
1. On the **Choose the type of retention policy to create​** page, select **Adaptive**, then select **Next**.
1. On the **Choose adaptive policy scopes and locations** page:

   - Select **+ Add scopes**, then choose the **Legal and HR departments** scope you created earlier.
   - Select **Add**.
   - Under **Choose locations**, enable:

     - **Exchange mailboxes**
     - **OneDrive accounts**
1. Select **Next**.
1. On the **Decide if you want to retain content, delete it, or both** page, configure the retention settings:

   - Retain items for **7 years**.
   - Start the retention period based on **when items were created**.
   - Choose to **do nothing** at the end of the retention period.
1. Select **Next**.
1. On the **Review and finish** page, confirm your settings, then select **Submit**.
1. After your policy is created, select **Done**.

This policy now applies a seven-year retention period to mail and files for users in the Legal and HR departments only.

## Check your work

To make sure everything is configured correctly, review both the policies and the adaptive scope you created.

1. In the Microsoft Purview portal, go to **Data lifecycle management**, then select **Policies** > **Retention policies**.
1. Confirm that both of the following policies appear in the list:

   - `Core retention - 5 years`
   - `Legal data retention`

1. Select each policy and review the settings:

   - For the **Core retention - 5 years** policy, verify that it uses a static scope and includes all main locations.
   - For the **Legal data retention** policy, confirm that it uses an adaptive scope and applies only to Exchange mailboxes and OneDrive accounts.
1. Go to **Settings** > **Roles and scopes** > **Adaptive scopes**.
1. Confirm that the adaptive scope named `Legal and HR` appears and includes the department filters for Legal and HR.

If everything appears as expected, you've successfully applied retention policies using both static and adaptive scopes.
