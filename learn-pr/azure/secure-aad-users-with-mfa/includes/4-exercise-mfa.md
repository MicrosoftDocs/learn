<a name='configure-azure-ad-mfa-for-applications'></a>

You can walk through the basic steps necessary to configure and enable Microsoft Entra multifactor authentication using Conditional policies. *Keep in mind that a real deployment requires significant thought and planning*. Make sure that you review the documentation links at the end of this module before you enable MFA for your environments.

> [!IMPORTANT]
> You need Microsoft Entra ID P1 or P2 for this exercise. You can use a [30-day free trial](https://azure.microsoft.com/trial/get-started-active-directory/) to try this feature out, or just read through the following instructions to understand the flow.

<a name='configure-multi-factor-authentication-options'></a>

## Configure multifactor authentication options

1. Sign in to the [Azure portal](https://portal.azure.com/) using an Authentication Administrator account.
1. Search for **Microsoft Entra ID** and navigate to the Microsoft Entra ID dashboard.
1. Select **Security** in the left-hand menu.
1. Under the **Manage** menu, select **Multifactor authentication**. Here, you find options for multifactor authentication.

    :::image type="content" source="../media/4-mfa-options.png" alt-text="Screenshot showing MFA options in the dashboard.":::

1. Under **Configure**, select **Additional cloud-based multifactor authentication settings**. On the resulting page, you can see all the MFA options for Azure under **Service Settings**.

    :::image type="content" source="../media/4-set-mfa.png" alt-text="Screenshot showing MFA configuration.":::

    You can enable or disable *app passwords* here, which allow users to create unique account passwords for apps that don't support multifactor authentication. This feature lets the user authenticate with their Microsoft Entra identity, using a different password specific to that app.

## Set up Conditional Access rules for MFA

Next, examine how to set up Conditional Access policy rules that would enforce MFA for guest users accessing specific apps on your network.

1. Switch back to the Azure portal and select **Microsoft Entra ID** > **Security** > **Conditional Access**.

1. Select **Create new policy** from the top menu.

    :::image type="content" source="../media/4-new-policy.png" alt-text="Screenshot highlighting the New Policy button in the Azure portal.":::

1. Name your policy, for example, *All guests*.

1. Under **Users**, select **0 users and groups selected**.

   1. Under **Include**, choose **Select users and groups**.
   1. Select users and groups and then choose **Select**.

1. Under **Target resources**, select **No target resources selected**.

   1. Select **Cloud apps**.
   1. Under **Include**, choose **Select apps**.
   1. Under **Select**, choose **None**. Select apps from the options on the right and then choose **Select**.

1. Under **Conditions**, select **0 conditions selected**.

   1. Under **Locations**, select **Not configured**.
   1. Under **Configure**, select **Yes**, then select **Any location**.

1. Under **Grant**, select **0 controls selected**.

   1. Make sure that **Grant access** is selected.
   1. Select **Require multifactor authentication** and choose **Select**. This option enforces MFA.

1. Set **Enable policy** to **On**, and then **Create**.

    :::image type="content" source="../media/4-create-policy.png" alt-text="Screenshot showing the complete Add Policy dialog.":::

MFA is now enabled for your selected applications. The next time a user or guest tries to sign into that app, they're prompted to register for MFA.
