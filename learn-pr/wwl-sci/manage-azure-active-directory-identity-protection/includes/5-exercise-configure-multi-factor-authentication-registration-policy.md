## Policy configuration

Microsoft Entra multifactor authentication provides a means to verify who you are using more than just a username and password. It provides a second layer of security to user sign-ins. For users to be able to respond to MFA prompts, they must first register for Microsoft Entra multifactor authentication.

1. Sign in to the [Azure portal](https://portal.azure.com/) using a Global administrator account.
1. Open the portal menu and then select **Microsoft Entra ID**.
1. On the Microsoft Entra blade, under **Manage**, select **Security**.
1. On the Security blade, in the left navigation, select **Identity protection**.
1. In the Identity protection blade, in the left navigation, select **MFA registration policy**.
    
    :::image type="content" source="../media/browse-registration-policy-36be502b.png" alt-text="Screenshot of the MFA registration policy page with browsing path highlighted.":::
    
1. Under **Assignments**, select **All users** and review the available options. You can select from **All users** or **Select individuals and groups** if limiting your rollout. Additionally, you can choose to exclude users from the policy.
1. Under **Controls**, notice that the **Require Microsoft Entra multifactor authentication registration** is selected and cannot be changed.
1. Under **Enforce Policy**, select **On** and then select **Save**.
