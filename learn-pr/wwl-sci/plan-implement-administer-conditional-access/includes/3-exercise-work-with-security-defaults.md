## Enabling security defaults

To enable security defaults in your directory:

1. Browse to the [Azure portal](https://portal.azure.com/) and sign in as a security administrator, Conditional Access administrator, or global administrator.
1. Select the Show portal menu hamburger icon and then select Azure Active Directory.
    
    :::image type="content" source="../media/azure-portal-menu-azure-active-directory-33e41fde.png" alt-text="Screenshot of the Azure portal menu with Azure Active Directory selected.":::
    
1. In the left navigation, in the Manage section, select **Properties**.
1. At the bottom of the Properties blade, select **Manage Security defaults**.
1. Set the **Enable Security defaults** toggle to **Yes**. This may already be enabled.
1. Select **Save**.

### Disabling security defaults

Organizations that choose to implement Conditional Access policies that replace security defaults must disable security defaults.

To disable security defaults in your directory:

1. Browse to the [Azure portal](https://portal.azure.com/) and sign in using a Global administrator account for the directory.
1. Select the Show portal menu hamburger icon and then select Azure Active Directory.
1. At the bottom of the Properties blade, select **Manage Security defaults**.
1. Set the **Enable security defaults** toggle to **No**.
    
    :::image type="content" source="../media/security-defaults-disable-before-conditional-access-4d662366.png" alt-text="Screenshot of the security defaults being disabled and selection of the required reason for disabling.":::
    
1. Select **Save**.
