You need to add member user accounts for the new developer team in your organization.

In this exercise, you'll create a new Azure Active Directory (Azure AD) organization to hold all of your user accounts. You'll also create a user account, delete a user account, and learn how to recover a deleted user account.

## Create an Azure AD organization

To hold all of the users you create in this exercise, create a new organization.

1. Sign in to the [Azure portal](<https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true>) with the same account you used to activate the sandbox.

1. On the Azure portal home page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the search box, search for and select **Azure Active Directory**. The **Azure Active Directory** pane appears.

1. Select **Create**. The **Create tenant** pane appears.

1. Enter the following values for each setting.

   - **Organization name**: _Contoso Marketing Company_
   - **Initial domain name**: _contosomarketingXXXX_ where you replace XXXX with numbers or letters to make your domain name unique

1. Select **Create**. Wait for the creation of your tenant to be completed.

1. Go to the new tenant by selecting **Click here to manage your new tenant**. The **Overview** pane for *Contoso Marketing Company* appears.

    :::image type="content" source="../media/3-switch-directory.png" alt-text="Screenshot that shows the link to manage your new organization.":::

## Get a free trial for Azure AD Premium

For Azure AD Premium to complete all the exercises in this module, you'll need to activate a free trial.

1. In the left menu pane, select **Getting started**.

1. Under **Getting started with Azure AD**, select **Get a free trial for Azure AD Premium**.

    ![Screenshot that shows the link to create free trial.](../media/3-ad-get-started-get-trial.png)

1. Under **Azure AD Premium 2**, select **Free trial** > **Activate**. If you don't have that option, that's ok. You can complete most of the exercises without it.

1. In the left menu pane, select **Overview**.

1. Refresh the browser until you see **Azure AD Premium P2** under the organization name. It may take a couple of minutes.

    :::image type="content" source="../media/3-azure-ad-premium-2.png" alt-text="Screenshot that shows Azure AD Premium P2 on the Overview page under Tenant information.":::

   You should also see *Your role* listed as the **Global administrator**.

1. Copy the **Primary domain** name to use in the next section.

## Add a new user

Now, let's create a user account.

1. In the Azure AD organization you created, in the left menu pane, under **Manage**, select **Users**. The **All users** pane appears.

1. In the top menu bar, select **New user**. The **New user** pane appears for *Contoso Marketing Company*.

1. Enter the following values for each setting.

    **Identity**
    - **User name**: chris@contosomarketingXXXXXX.onmicrosoft.com. The domain name should match the primary domain you copied in the previous section.
    - **Name**: *Chris Green*

    **Password**
    - **Show Password**, (*check*), and copy it somewhere you can refer to it later.

1. Select **Create**. The **All users** pane reappears for *Contoso Marketing Company - Azure Active Directory*. The user is now created and registered to your organization.

## Delete a user

You can delete users after they're created.

1. In your **All users** pane for Azure AD organization, from the list, select **Chris Green**.

1. In the top menu bar, select **Delete user**. If you don't see that option, select **More**.

1. When you're prompted to confirm your deletion, select **OK**.

## Recover a deleted user

You can restore deleted users. View the list of the deleted users, and then restore one.

1. In your **All users** pane for Azure AD organization, in the left menu pane, select **Deleted users**. You now see all of the users that were deleted within the last 30 days.

1. Select **Chris Green** and in the top menu bar, select **Restore user**.

1. To confirm, select **OK**. The **All users** pane reappears.

1. Verify that Chris Green's account is recovered by selecting **All users** in the left menu pane. You should see Chris Green restored as a user.
