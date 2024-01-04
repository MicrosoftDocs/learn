To enable MFA, go to the User Properties in Microsoft Entra ID, and then the multifactor authentication option. From there, you can select the users that you want to modify and enable for MFA. You can also bulk enable groups of users with PowerShell. User's states can be **Enabled**, **Enforced**, or **Disabled**.

:::image type="content" source="../media/multifactor-authentication-service-settings-2022-675591c3.jpg" alt-text="Screenshot of multifactor-authentication-service-settings.":::


> [!NOTE]
> On first-time sign-in, after MFA has been enabled, users are prompted to configure their MFA settings. For example, if you enable MFA so that users must use a mobile device, users will be prompted to configure their mobile device for MFA. Users must complete those steps, or they will not be permitted to sign in, which they cannot do until they have validated that their mobile device is MFA-compliant.

All users start out Disabled. When you enroll users in per-user Microsoft Entra multifactor authentication, their state changes to Enabled. When enabled users sign in and complete the registration process, their state changes to Enforced. Administrators may move users between states, including from Enforced to Enabled or Disabled.

## Enable MFA for Global Admins

Microsoft Entra multifactor authentication is included free of charge for global administrator security. Enabling MFA for global administrators provides an added level of security when managing and creating Azure resources like virtual machines, managing storage, or using other Azure services. Secondary authentication includes phone call, text message, and the authenticator app.

> [!IMPORTANT]
> Remember, you can only enable MFA for organizational accounts stored in Microsoft Entra ID. These are also called work or school accounts.
