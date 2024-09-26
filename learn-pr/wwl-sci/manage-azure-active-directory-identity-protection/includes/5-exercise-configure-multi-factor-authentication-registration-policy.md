## Policy configuration

Multifactor authentication provides a means to verify who you are using more than just a username and password. It provides a second layer of security to user sign-ins. For users to be able to respond to MFA prompts, they must first register for multifactor authentication.

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) using a Global administrator account.
2.  Open the portal menu and then select **Identity**.
3.  On the Identity men, select **Protection**.
4.  On the Security blade, in the left navigation, select **Identity protection**.
5.  In the Identity protection blade, in the left navigation, select **Multifactor authentication registration policy**.
    
    :::image type="content" source="../media/browse-registration-policy-36be502b.png" alt-text="Screenshot of the MFA registration policy page with browsing path highlighted.":::
    
6.  Under **Assignments**, select **All users** and review the available options. You can select from **All users** or **Select individuals and groups** if limiting your rollout. Additionally, you can choose to exclude users from the policy.
7.  Under **Controls**, notice that the **Require Microsoft Entra ID multifactor authentication registration** is selected and cannot be changed.
8.  Under **Enforce Policy**, select **Enabled** and then select **Save**.
