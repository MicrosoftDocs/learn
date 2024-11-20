## Manage Microsoft Entra smart lockout values

Based on your organizational requirements, you can customize the Microsoft Entra smart lockout values. Customization of the smart lockout settings, with values specific to your organization, requires Microsoft Entra ID Premium P1 or higher licenses for your users.

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) using a Global administrator account.
2.  Open the portal menu and then select **Protection**.
3.  On the Protection menu, select **Authentication Methods**.
4.  On Authentications methods menu, select **Password protection**.
    
    :::image type="content" source="../media/browse-password-protection-d00ab077.png" alt-text="Screenshot of the Authentication methods dialog with the highlighted selections to browse to Password authentication.":::
    
5.  In the Password protection settings, in the **Lockout duration in seconds** box, set the value to 120.
6.  Next to **Mode**, select **Enforced**.
7.  Save your changes.
    
    > [!NOTE]
    > When the smart lockout threshold is triggered, you will get the following message while the account is locked:<br><br>Your account is temporarily locked to prevent unauthorized use. Try again later, and if you still have trouble, contact your admin.
