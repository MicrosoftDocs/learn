Your organization needs to grant administrator access for a subscription to a new administrator. The previous administrator left the company without assigning administrator access to another employee. No one else has access to this subscription.

In this unit, you'll temporarily elevate your own permissions to get access to this subscription. You'll look at how to assign subscription ownership to the new administrator. You'll then revoke your elevated access.

This exercise is optional. To complete it, you need access to an Azure subscription where you have the Global Administrator role for your account. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Elevate your access

1. Sign in to the [Azure portal](<https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true>) as Azure Active Directory (Azure AD) Global Administrator.

1. Select **Azure Active Directory** > **Properties**.

    ![The Azure AD Properties pane](../media/4-azure-ad-properties.png)

1. Under **Access management for Azure resources**, select **Yes**.

    ![The "Access management for Azure resources" option](../media/4-access-management-azure-resources.png)

1. Select **Save**.
1. Sign out of the Azure portal, and sign in again to refresh your access.

### Verify that you have the User Access Administrator role

1. At the top of the Azure portal, search for **Subscriptions**.
1. Select the relevant subscription. Now that you have elevated access at the root scope, you should see all subscriptions in your directory.
1. Select **Access control (IAM)** > **Role assignments**.
1. Under **User Access Administrator**, ensure that you have the **Root (inherited)** scope.

    ![Screenshot displaying the User Access Administrator role assigned](../media/4-check-role.png)

## Assign a user as an administrator of a subscription

Because you're using your own subscription, you might want to walk through the following procedure without saving the Owner role assignment in step 5.

1. At the top of the **Access control (IAM)** pane, select **Add**.
1. Select **Add role assignment**.
1. In the **Role** drop-down list, select **Owner**.
1. In the **Select** box, enter the username or email address of the user you want to grant access to. Select that user.

    ![The "Add role assignment" pane for assigning the Owner role to a user](../media/4-add-owner-role.png)

1. If you want to complete the Owner role assignment, select **Save**. Otherwise, select **Discard**.

## Revoke your elevated access

1. In the Azure portal, select **Azure Active Directory** > **Properties**.
1. Under **Access management for Azure resources**, select **No**.
1. Select **Save**.
1. Sign out of the Azure portal, and sign in again to refresh your access.
