In this exercise, try enabling security defaults.

 > [!Note] 
 > Security Defaults are enabled on new subscriptions, so you can review the process of enabling and disabling.

To enable security defaults in your directory:

1. Browse to the [Microsoft Entra admin center](https://entra.microsoft.com/) and sign in as a Security administrator, or a Conditional Access administrator.
2. Select the Show portal menu hamburger icon and then select Identity - Overview.
    
   :::image type="content" source="../media/azure-portal-menu-azure-active-directory.png" alt-text="Screenshot of the Microsoft Entra admin center menu with Identity - Overview - Properties selected.":::
    
3. In the left navigation, in the Manage section, select **Properties**.
4. At the bottom of the Properties dialog, select **Manage Security defaults**.
5. Set the **Enable Security defaults** toggle to **Yes.**
6. Select **Save**.

### Disabling security defaults

Organizations that choose to implement Conditional Access policies that replace security defaults must disable security defaults.

To disable security defaults in your directory:

1. Browse to the [Azure portal](https://portal.azure.com/) and sign in using an Administrator account for the directory.
2. Select the Show portal menu hamburger icon and then select Microsoft Entra ID.
3. At the bottom of the Properties dialog, select **Manage Security defaults**.
4. Set the **Enable security defaults** toggle to **No**.
    
   :::image type="content" source="../media/security-defaults-disable-before-conditional-access.png" alt-text="Screenshot of the security defaults being disabled and selection of the required reason for disabling.":::
    
5.  Select **Save**.
