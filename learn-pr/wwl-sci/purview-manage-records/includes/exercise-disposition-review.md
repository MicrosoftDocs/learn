Retention labels help manage how long content is kept and what happens when that period ends. When content requires review before deletion, you can configure labels to trigger a disposition review. This ensures important items are reviewed by the right people before they're permanently deleted.

In this exercise, you first create a role group that allows selected users to review items marked for disposition. Then you create a retention label for vendor contracts and configure it to start a disposition review after five years. You'll define a review stage, assign a reviewer, and publish the label so it's available in Microsoft 365.

**Estimated time to complete**: 15-20 minutes

> [!IMPORTANT]
> To complete this exercise, you need access to Microsoft Purview features through one of these Microsoft 365 licenses:
>
> - A Microsoft 365 E3 license is required to create and publish retention labels.
> - A Microsoft 365 E5 license, or the E5 Information Protection and Governance add-on, is required for disposition review.
>
> If your tenant doesn't include these features, some tasks in the exercise might not be available. You can still follow the steps to understand how the configuration works or skip any unsupported tasks.
>
> If you don't have access to these features, you can join the **[Microsoft 365 Developer Program](https://developer.microsoft.com/microsoft-365/dev-program)**. This program provides a free Microsoft 365 E5 developer subscription with access to many Purview capabilities.

## Create a role group for disposition reviewers

Before assigning someone as a disposition reviewer, they must be in a role group with the necessary permissions. Use this task to create a role group and assign members who will review content marked for deletion.

1. Navigate to [Microsoft Purview](https://purview.microsoft.com) and sign in.
1. In the Microsoft Purview portal, go to **Settings**
1. Expand **Roles and scopes**, then select **Role groups**.
1. Select **Create role group**.
1. On the **Name the role group** page, enter:

   - **Name**: `Disposition Reviewers`
   - **Description**: `Grants members permission to review and take action on content marked for disposition.`

1. Select **Next**.
1. On the **Add roles to the group** page, select **Choose roles**.
1. On the **Choose roles** page, select **Disposition Management**, then select **Select** at the bottom of the page.
1. Select **Next**.
1. On the **Add members to the role group** page, select **Choose users** and add the users needed to conduct a disposition review, then select **Select** at the bottom of the page.
1. Select **Next**.
1. On the **Review the role group and finish** page, confirm your settings, then select **Create**.
1. After your role group is created, select **Done**.

The users you added to this role group can now be selected as reviewers when you configure a disposition stage in a retention label. This ensures they have permission to view and act on content pending deletion.

## Create and publish a retention label with disposition review

Use this task to configure a retention label that applies to vendor contracts. The label keeps content for five years, then starts a disposition review so a reviewer can decide whether to delete or retain the item. After you create the label, you’ll publish it so it's available across Microsoft 365.

1. In the Microsoft Purview portal, go to **Solutions** > **Data Lifecycle Management**.
1. Select **Retention labels**.
1. Select **+ Create a label**.
1. On the **Name your retention label** page, enter:

   - **Name**: `Vendor agreements - disposition review`
   - **Description for admins**: `Applies to vendor contracts. Retains for 5 years, then requires disposition review.`
   - **Description for users**: `Use for vendor contracts. Retention ends with review.`

1. Select **Next**.
1. On the **Define label settings** page, select **Retain items forever or for a specific period**, then select **Next**.
1. On the **Define the retention period** page:

   - Set the retention period to **5 years**.
   - Start retention based on **when items were created**.

1. Select **Next**.
1. On the **Choose what happens after the retention period** page, select **Start a disposition review**, then select **Create stages and assign reviewers**.
1. On the **Create stages and assign reviewers** page:

   - Enable **Automatic stage approval**
   - Set the automatic disposition approval to **14 days**.
   - Select **Add a stage**
   - Name the stage `Vendor agreement review`, then select **OK**.
   - Choose a user who is a member of the Disposition Reviewers role group you created earlier.
   - Select **OK** at the bottom of the reviewers page.

1. Back on the **Choose what happens after the retention period** page, select **Next**.
1. On the **Review and finish** page, confirm your settings, then select **Create label**.
1. After your label is created, select **Publish this label to Microsoft 365 locations**, then select **Done**.
1. On the **Choose labels to publish** page, make sure the **Vendor agreements - disposition review** label is selected, then select **Next**.
1. On the **Policy Scope** page, leave the default selected, then select **Next**.
1. On the **Choose the type of retention policy to create​**, select **Static**.
1. On the **Choose where to publish labels** page, select **All locations. Includes content from Exchange email, Office 365 groups, OneDrive and SharePoint documents.**, then select **Next**.
1. On the **Name your policy** page, enter:

   - **Name**: `Vendor agreements disposition policy`
   - **Description**: `Apply to vendor contracts that need to be kept and reviewed later.`

1. On the **Finish** page, confirm your settings, then select **Submit**.
1. After your policy is created, select **Done**.

This configuration helps ensure vendor contracts are reviewed before deletion. Disposition review gives your organization a chance to keep important content longer when needed, supporting more flexible retention decisions.

## Check your work

Review the role group, label, and policy you created to make sure they're configured as expected.

1. Go to **Settings** > **Roles and scopes** > **Role groups**.
1. Confirm that `Disposition Reviewers` is listed and includes:

   - The **Disposition Management** role
   - At least one assigned user

1. Go to **Data Lifecycle Management** > **Retention labels**.
1. Confirm that `Vendor agreements - disposition review` is listed.
1. Open the label and check that:

   - The retention duration is set to 5 years
   - Retention starts when items are created
   - The action after the period is **Disposition review**
   - The review stage is named `Vendor agreement review` with automatic approval after 14 days

1. Go to **Retention policies** and confirm that `Vendor agreements disposition policy` is listed.
1. Open the policy and check that:

   - The correct label is included
   - The policy type is **Static**
   - All Microsoft 365 content locations are selected

These steps help ensure that disposition review is properly configured. Verifying the label, policy, and reviewer permissions helps avoid gaps that could delay or block retention decisions.
