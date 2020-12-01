You need to add member user accounts for the new developer team in your organization.

In this exercise, you'll create a new Azure Active Directory (Azure AD) organization to hold all of your user accounts. You'll also create a user account, delete a user account, and learn how to recover a deleted user account.

## Create an Azure AD organization

To hold all of the users you create in this exercise, create a new organization.

1. Sign in to the [Azure portal](<https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true>) with the same account you used to activate the sandbox.

1. In the left navigation pane, select **Create a resource**.
1. In the **Azure Marketplace**, search for **Azure Active Directory**.
1. Select **Create**.
1. On the **Create tenant** pane, enter the following values:

   - **Organization name**: _Contoso Marketing Company_
   - **Initial domain name**: _contosomarketingXXXX_ where you replace XXXX with numbers or letters to make your domain name unique

1. Select **Create**.

1. Wait for the creation of your tenant to be completed.
1. Switch to the new tenant.

    :::image type="content" source="../media/3-switch-directory.png" alt-text="Screenshot that shows the link to manage your new organization.":::

## Get a free trial for Azure AD Premium

For Azure AD Premium to complete all the exercises in this module, you'll need to activate a free trial.

1. In the organization you just created, select **Getting started**.
1. Under **Getting started with Azure AD**, select **Get a free trial for Azure AD Premium**.

    ![Screenshot that shows the link to create trial.](../media/3-ad-get-started-get-trial.png)

1. Under **Azure AD Premium 2**, select **Free trial** > **Activate**. If you don't have that option, that's ok. You can complete most of the exercises without it.
1. In the left pane, select **Overview**.
1. Refresh the browser until you see **Azure AD Premium P2** under the organization name. It may take a couple of minutes.

    :::image type="content" source="../media/3-azure-ad-premium-2.png" alt-text="Screenshot that shows trial enabled.":::

   You should also see your role listed as the **Global administrator**.
1. Copy the **Primary domain** name to use in the next section.

## Add a new user

Now, let's create a user account.

1. In the Azure AD organization you created, under **Manage**, select **Users** > **New User**.
1. The **User** pane now appears. Enter the following values:

    - **User Name**: chris@contosomarketingXXXXXX.onmicrosoft.com. The domain name should match the primary domain you copied in the previous section.
    - **Name**: *Chris Green*

1. Select **Show Password**, and copy it somewhere you can refer to it later.

1. Select **Create**. The user is now created and registered to your organization.

## Delete a user

You can delete users after they're created.

1. In your Azure AD organization, under **Manage**, select **Users**.
1. From the list, select **Chris Green**.
1. Select **Delete user**. If you don't see that option, select **More**.
1. When you're asked to confirm your deletion, select **OK**.

## Recover a deleted item

You can restore deleted users. View the list of the deleted users, and then restore one.

1. In your Azure AD organization, under **Manage**, select **Users** > **Deleted users**.
1. You now see all of the users that were deleted within the last 30 days.
1. Select **Chris Green** and **Restore user**.
1. To confirm, select **OK**.
1. Verify that Chris Green's account is recovered by selecting **All users**.
