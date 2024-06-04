In this exercise, you'll prepare your Microsoft Entra environment by completing prerequisites. 

You'll enable remote employees for Microsoft Authenticator and start a registration campaign to nudge them to set up Microsoft Authenticator when they sign in.

:::image type="content" border="true" source="../media/registration-campaign.png" alt-text="Screenshot of how to enable a registration campaign for Microsoft Authenticator.":::

When you're finished, you'll be ready to validate the user experience. You'll create a Microsoft Entra account for testing and add the account to the remote employees group. Then, you'll sign in and perform MFA. After MFA completes, you'll set up Microsoft Authenticator as the default sign-in method.

> [!NOTE]
> Completing the exercises in this module is optional, but if you want to follow along, you'll need your own Azure subscription. If you don't already have one, you can [sign up for a free subscription](https://azure.microsoft.com/free/). Make sure you clean up any resources or organizations you create to avoid charges.

## Verify remote employees are enabled for Microsoft Authenticator

Before enabling a registration campaign, make sure prerequisites are complete. You need to enable your users to use Microsoft Authenticator for authentication.

> [!NOTE]
> This exercise assumes you already have an organization set up, with a user group for your remote workers. You can learn how to set up your organization in the [Create Azure users and groups in Microsoft Entra ID](/training/modules/create-users-and-groups-in-azure-active-directory/) module.

1. In the [Azure portal](https://portal.azure.com), search for and select **Microsoft Entra ID**.
1. In the Microsoft Entra admin center, select **Security** > **Authentication methods** > **Policies**.
1. Select **Microsoft Authenticator** in the list.
1. Move the **Enabled** slider to the **on** position, then select **Remote employees** (or whatever group name you set up for your remote workers).
1. Select **Push** in the **Authentication mode** drop-down.
1. In the contextual menu, select the **Configure** tab and enable any options you want.
1. Select **Save**.

<a name='exercise-enable-the-registration-campaign-using-the-azure-ad-portal'></a>

## Exercise: Enable the registration campaign using the Microsoft Entra admin center

The easiest way to create the registration campaign is to use the Microsoft Entra admin center. You can also use Microsoft Graph API if you want to include the task of registering users for Microsoft Authenticator in any automation you use for adding new employees.

Your company is concerned about sign-ins from users in your **Remote employees** security group. Let's use the Azure portal to enable a registration campaign for that group. You'll want to nudge remote employees to set up Microsoft Authenticator every time they sign in by setting the snooze to *0*.

1. In the [Azure portal](https://portal.azure.com), sign in as either authentication policy administrator or global administrator, then search for and select **Microsoft Entra ID**.
1. In the Microsoft Entra admin center, select **Security** > **Authentication methods** > **Registration campaign**.
1. Change **State** to **Enabled**.
1. For **Days allowed to snooze**, select **0 days**, then set **Limited number of snoozes** to **Disabled**. Remote employees will be prompted to set up Microsoft Authenticator every time they sign in.
1. Select **Add users and groups**, search for **Remote employees**, check the box next to the group name, and select the **Select** button.
1. Select **Save** in the taskbar.

   :::image type="content" border="true" source="../media/remote-employees.png" alt-text="Screenshot of adding remote employees group.":::

In the next unit, you'll walk through the user experience in more detail.
