<a name='create-an-azure-ad-tenant-and-a-global-administrator'></a>

## Create a Microsoft Entra tenant and a global administrator

In this exercise, you create a Microsoft Entra tenant and a global administrator. This unit completes the basic hybrid environment.

:::image type="content" source="../media/5-exercise-1.png" alt-text="Diagram shows progression of this module with the third exercise highlighted.":::

<a name='create-an-azure-ad-tenant'></a>

## Create a Microsoft Entra tenant

You need to create a Microsoft Entra tenant so that you can synchronize our users to the cloud. To create a new Microsoft Entra tenant, do the following steps.

1. Browse to the [Microsoft Entra admin center](https://entra.microsoft.com) and sign in with an account that has an Azure subscription.
1. On the right, select **Identity** > **Overview**.
1. At the top, select **Manage tenants**.
1. On the tenants screen, select **Create**.
1. Under **Select tenant type**, choose **Workforce**, then select **Next: Configuration**.
1. Enter the **Organization name** and an **Initial domain name** for your tenant.
1. Choose your **Country/Region**.
1. Select **Review + create**. Review the information and select **Create**.

<a name='create-a-global-administrator-in-azure-ad'></a>

## Create a global administrator in Microsoft Entra ID

After you create a Microsoft Entra tenant, create a global administrator account. To create the global administrator account, do the following steps.

1. On the left, select **Identity** > **Users** > **All users**.
1. On the users page, at the top, select **New user** > **Create new user**.
1. Provide a name and username for this user. Because this account is the global administrator for your Microsoft Entra tenant, record the account name.
1. Select **Review + create**, then **Create**.
1. Double-click on the user that you created.
1. Under **Manage**, select **Assigned roles**.
1. Select **Add assignments**, then for **Select role**, select **Global Administrator**.
1. Select **Next**, then **Assign**.

## Check your work

You should now have a Microsoft Entra tenant and a global administrator account.

To verify this exercise, do the following tasks.

1. Open a new web browser and sign-in to *myapps.microsoft.com* using the new global administrator account and the temporary password.
2. Change the password for the global administrator.
3. You've now verified the tenant and the global administrator account.

> [!VIDEO https://msit.microsoftstream.com/embed/video/8e890840-98dc-b478-5c62-f1ecf242bf6c?autoplay=false&amp;showinfo=true]
