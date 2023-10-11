Identity and access management (IAM) is key to granting access and to the security enhancement of corporate assets. To secure and control your cloud-based assets, you must manage identity and access for your Azure administrators, application developers, and application users.

## IAM security recommendations

The following sections describe the IAM recommendations that are in CIS Microsoft Azure Foundations Security Benchmark v. 1.3.0. Included with each recommendation are the basic steps to complete in the Azure portal. You should complete these steps for your own subscription and by using your own resources to validate each security recommendation. Keep in mind that **Level 2** options might restrict some features or activities, so carefully consider which security options you decide to enforce.

> [!IMPORTANT]
> You must be an administrator for the Microsoft Entra instance to complete some of these steps.

<a name='restrict-access-to-the-azure-ad-administration-portal---level-1'></a>

### Restrict access to the Microsoft Entra administration portal - Level 1

Users who aren't administrators shouldn't have access to the Microsoft Entra administration portal because the data is sensitive and under the rules of least privilege.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Users**.

1. In the left menu, select **User settings**.

1. In **User settings**, under **Administration portal**, ensure that **Restrict access to Microsoft Entra administration portal** is set to **Yes**. Setting this value to **Yes** prevents all non-administrators from accessing any data in the Microsoft Entra administration portal. The setting doesn't restrict access to using PowerShell or another client, such as Visual Studio.

1. If you change any settings, in the menu bar, select **Save**.

:::image type="content" source="../media/identity-access-management-azure-active-directory/restrict-access-admin-portal.png" alt-text="Screenshot of the Azure portal that shows the Restrict access to Microsoft Entra administration portal option set to Yes.":::

<a name='enable-multifactor-authentication-for-azure-ad-users'></a>

### Enable multifactor authentication for Microsoft Entra users

- **Enable multifactor authentication for Microsoft Entra ID privileged users - Level 1**
- **Enable multifactor authentication for Microsoft Entra non-privileged users - Level 2**

Enable multifactor authentication for all Microsoft Entra users.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Users**.

1. In the **All users** menu bar, select **Per-user MFA**.

    :::image type="content" source="../media/identity-access-management-azure-active-directory/multifactor-authentication-option-azure-portal.png" alt-text="Screenshot that shows the multifactor authentication option in the Microsoft Entra pane of the Azure portal.":::

1. In the **multifactor authentication** window, ensure that **multifactor authentication Status** is set to **Enabled** for all users. To enable multifactor authentication, select a user. Under **quick steps**, select **Enable** > **enable multifactor authentication**.

   :::image type="content" source="../media/identity-access-management-azure-active-directory/multifactor-authentication-window-enable.png" alt-text="Screenshot that shows how to turn on multifactor authentication for a user by using the quick steps link.":::

### Don't remember multifactor authentication on trusted devices - Level 2

Remembering the multifactor authentication feature for devices and browsers that are trusted by the user is a free feature for all multifactor authentication users. Users can bypass subsequent verifications for a specified number of days after they've successfully signed in to a device by using multifactor authentication.

If an account or device is compromised, remembering multifactor authentication for trusted devices can negatively affect security. A security recommendation is to turn off remembering multifactor authentication for trusted devices.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Users**.

1. In the **All users** menu bar, select **Per-user MFA**.

1. In the **multifactor authentication** window, select a user. Under **quick steps**, select **Manage user settings**.

    :::image type="content" source="../media/identity-access-management-azure-active-directory/multifactor-authentication-window.png" alt-text="Screenshot that shows the Microsoft Entra multifactor authentication users window and the manage user settings link.":::

1. Select the **Restore multifactor authentication on all remembered devices** checkbox, and then select **Save**.

    :::image type="content" source="../media/identity-access-management-azure-active-directory/multifactor-authentication-user-settings.png" alt-text="Screenshot that shows the Restore multifactor authentication on all remembered devices option selected.":::

### No or limited-access guest users - Level 1

Ensure that no guest users exist, or alternatively, if the business requires guest users, ensure that guest permissions are limited.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Users**.

1. Select the **Add filters** button.

1. For **Filters**, select **User type**. For **Value**, select **Guest**. Select **Apply** to verify that no guest users exist.

    :::image type="content" source="../media/identity-access-management-azure-active-directory/guest-users-verification.png" alt-text="Screenshot of the Azure portal that shows Microsoft Entra ID filtering for guest users.":::

1. If you change any settings, in the menu bar, select **Save**.

### Password options

- **Notify users on password resets - Level 1**
- **Notify all admins when other admins reset passwords - Level 2**
- **Require two methods to reset passwords - Level 1**

With multifactor authentication set, an attacker would have to compromise both identity authentication forms before they could maliciously reset a user's password. Ensure that password reset requires two forms of identity authentication.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Users**.

1. In the left menu, select **Password reset**.

1. In the left menu under **Manage**, select **Authentication methods**.

1. Set the **Number of methods required to reset** to **2**.

1. If you change any settings, In the menu bar, select **Save**.

:::image type="content" source="../media/identity-access-management-azure-active-directory/require-two-authentication-methods.png" alt-text="Screenshot of the Azure portal that shows the Microsoft Entra password reset authentication methods pane with number of methods required to reset set to 2.":::

### Establish an interval for reconfirming user authentication methods - Level 1

If authentication reconfirmation is turned off, registered users aren't prompted to reconfirm their authentication information. The more secure option is to turn on authentication reconfirmation for a set interval.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Users**.

1. In the left menu pane, select **Password reset**.

1. In the left menu under **Manage**, select **Registration**.

1. Ensure that **Number of days before users are asked to re-confirm their authentication information** is *not* set to **0**. The default is 180 days.

1. If you change any settings, in the menu bar, select **Save**.

:::image type="content" source="../media/identity-access-management-azure-active-directory/days-until-reconfirm.png" alt-text="Screenshot of the Azure portal that shows the form for number of days to reconfirm authentication information.":::

### Guest invite setting - Level 2

Only administrators should be able to invite guest users. Restricting invitations to administrators ensures that only authorized accounts have access to Azure resources.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Users**.

1. In the left menu, select **User settings**.

1. In the **User settings** pane, under **External users**, select **Manage external collaboration settings**.

1. In **External collaboration settings**, under **Guest invite settings**, select **Only users assigned to specific admin roles can invite guest users**.

    :::image type="content" source="../media/identity-access-management-azure-active-directory/members-invite-guests.png" alt-text="Screenshot that shows the Guest invite settings with Only users assigned to specific admin roles can invite guest users selected.":::

1. If you change any settings, in the menu bar, select **Save**.

### Users can create and manage security groups - Level 2

When this feature is enabled, all users in Microsoft Entra ID can create new security groups. Security group creation should be restricted to administrators.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Groups**.

1. In the **All groups** pane, in the left menu under **Settings**, select **General**.

1. For **Security Groups**, ensure that **Users can create security groups in Azure portals, API or PowerShell** is set to **No**.

   :::image type="content" source="../media/identity-access-management-azure-active-directory/security-group-settings.png" alt-text="Screenshot that shows the Groups General settings pane, with the Users can create security groups option set to No.":::

1. If you change any settings, in the menu bar, select **Save**.

### Self-service group management enabled - Level 2

Unless your business requires delegating self-service group management to various users, a safety recommendation is to disable this feature.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Groups**.

1. In the **All groups** pane, in the left menu under **Settings**, select **General**.

1. Under **Self Service Group Management**, ensure that all options are set to **No**.

1. If you change any settings, in the menu bar, select **Save**.

:::image type="content" source="../media/identity-access-management-azure-active-directory/self-service-groups.png" alt-text="Screenshot that shows Microsoft Entra self-service group options set to No.":::

### Application options - Allow users to register apps - Level 2

Require administrators to register custom applications.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Microsoft Entra ID**.

1. In the left menu under **Manage**, select **Users**.

1. In the left menu, select **User settings**.

1. In the **User settings** pane, ensure that **App registrations** is set to **No**.

1. If you change any settings, in the menu bar, select **Save**.

:::image type="content" source="../media/identity-access-management-azure-active-directory/app-registrations.png" alt-text="Screenshot that shows Microsoft Entra users with app registrations set to No.":::
