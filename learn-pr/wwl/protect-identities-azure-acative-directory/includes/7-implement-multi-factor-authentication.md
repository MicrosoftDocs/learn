

Multifactor authentication (MFA) adds an extra security layer in the authentication process by requiring more than one method of authentication to detect and validate user identity. Users still require usernames and passwords to sign in to your data and applications, but you can add another access method as a second method of authentication. The multifactor authentication technology combines something that you know, such as a password or a PIN, with something that you have, such as your phone or a token, and even possibly something that you are (biometric technologies).

You can implement multifactor authentication in different ways based on users’ demands and the level of extra security that they need. The following are some ways to implement MFA:

 -  You can use the Microsoft Authenticator mobile app as a software token to provide one-time passwords or to receive push notifications from the application.
 -  You can authenticate by using a phone call.
 -  You can authenticate by using text messages, which is similar to mobile app authentication, but the push notifications or the codes will come via text messages.
 -  You can use third-party OAuth tokens.

Microsoft Entra multifactor authentication helps safeguard access to data and applications while maintaining simplicity for users. It provides extra security by requiring a second form of authentication and delivers strong authentication via a range of easy to use authentication methods.

Multifactor authentication comes as part of the following offerings:

 -  Microsoft Entra ID P1 or P2 licenses - Full featured use of Microsoft Entra multifactor authentication (Cloud) or Azure Multi-Factor Authentication Server (On-premises).
    
     -  Microsoft Entra multifactor authentication Service (Cloud) - This option is the recommended path for new deployments. Microsoft Entra multifactor authentication in the cloud requires no on-premises infrastructure and can be used with your federated or cloud-only users.
     -  Azure Multi-Factor Authentication Server - If your organization wants to manage the associated infrastructure elements and has deployed AD FS in your on-premises environment this way may be an option.
 -  Multifactor authentication for Microsoft 365 - A subset of Microsoft Entra multifactor authentication capabilities is available as a part of your subscription.
 -  Microsoft Entra Global Administrators - A subset of Microsoft Entra multifactor authentication capabilities is available as a means to protect global administrator accounts.

:::image type="content" source="../media/azure-verify-identity-9a3ddc3b.png" alt-text="Screenshot of authentication methods in use at the sign-in screen.":::


 -  If you have Microsoft Entra ID P1 or P2 or Enterprise Mobility + Security licenses, you already have Microsoft Entra multifactor authentication. Your organization doesn't need anything extra to extend the two-step verification capability to all users. You only need to assign a license to a user, and then you can turn on MFA.
 -  When setting up MFA, consider the following tips:
    
     -  Don't create a per-authentication multifactor authentication Provider. If you do, you could end up paying for verification requests from users that already have licenses.
     -  If you don't have enough licenses for all your users, you can create a per-user multifactor authentication Provider to cover the rest of your organization.
     -  Microsoft Entra Connect is only required if you're synchronizing your on-premises Active Directory environment with a Microsoft Entra directory. If you use a Microsoft Entra directory that isn't synchronized with an on-premises instance of Active Directory, you don't need Microsoft Entra Connect.

<a name='enable-mfa-for-a-single-azure-ad-user'></a>

### Enable MFA for a single Microsoft Entra user

1.  Sign in to the Azure portal as an administrator.
2.  Go to **Microsoft Entra ID** > **Users and groups** > **All users**.
3.  Select **multifactor authentication**.
4.  A new page that displays the user states appears.
5.  Find the user you want to enable for Microsoft Entra multifactor authentication. You might need to change the view at the top.
6.  Select the checkbox for each user’s name.
7.  On the right, under Quick Steps, select **Enable** or **Disable**.
8.  Confirm your selection in the pop-up window that appears.

After you enable users, notify them via email. Tell them that they'll be asked to register the next time they sign in. Also, if your organization uses non-browser apps that don't support modern authentication, they need to create app passwords. You can also include a link to the Microsoft Entra multifactor authentication end-user guide to help them get started.
