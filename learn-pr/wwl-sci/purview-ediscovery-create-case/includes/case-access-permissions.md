Access control is essential in Microsoft Purview eDiscovery. Case access is restricted to designated users and role groups, helping ensure sensitive investigations stay secure and traceable. Before someone can contribute to or review case content, they must have the appropriate permissions and be added to the case.

## Add users to a case

Before a user can access any eDiscovery case, they must be assigned to the **eDiscovery Manager** role group. This gives them access to the **eDiscovery** area of the Microsoft Purview portal.

After role group assignment, you can add them to individual cases. Being added to a case grants access to its searches, review sets, exports, and other investigation data.

To add users to a case:

1. Go to the [Microsoft Purview portal](https://purview.microsoft.com) and sign in with eDiscovery permissions.
1. Navigate to **Solutions** > **eDiscovery** > **Cases**.
1. Select a case, then open **Case settings**.

      :::image type="content" source="../media/case-settings-button.png" alt-text="Screenshot showing the Case settings button in Microsoft Purview." lightbox="../media/case-settings-button.png":::

1. Select the **Permissions** tab.
1. Under **Users**, select **Add**, then choose the users you want to assign.

You can also assign a role group to a case. However, you can only assign role groups that you're a member of. If a role is removed from a role group after assignment, the group is automatically removed from the case to prevent overexposure.

## Remove users from a case

Only users in the **eDiscovery Administrator** role group can remove other users from a case. Even if you originally created the case or are part of the **eDiscovery Manager** role group, you won't be able to remove users without elevated permissions.

To remove users:

1. From the case, go to **Case settings** > **Permissions**.
1. Under **Users** or **Role groups**, select **Remove**, then confirm your changes.

## Manage guest access

You can invite external users to participate in a case as guests. This is useful when external reviewers, such as legal counsel, need access.

Guest access must first be enabled in your environment. For more information, see [Enable guest access in eDiscovery](/purview/edisc-settings-guest-users).

Once enabled, follow these steps to invite a guest:

1. Open the case, then go to **Case settings** > **Permissions**.
1. In the **Guest users** section, select **Invite**.
1. Provide the guest's full name, email, organization, and justification.
1. Assign the guest the **Reviewer** role (the only available role for guests).
1. Submit the request for admin approval.

   :::image type="content" source="../media/ediscovery-guest-access.png" alt-text="Screenshot showing where to add guest users to an eDiscovery case." lightbox="../media/ediscovery-guest-access.png":::

### Approve and manage guest access

Only **eDiscovery Administrators** can approve or deny guest access. Admins can manage guest requests from **Settings** > **eDiscovery** > **Guest users**.

   :::image type="content" source="../media/guest-access-request.png" alt-text="Screenshot showing a guest access request." lightbox="../media/guest-access-request.png":::

If the guest is new to the tenant, a two-step approval is required. After their account is created, a second approval step is needed to assign case access.

Once approved, the guest receives an email invitation with a unique link to access the case.

Guests with a Microsoft Entra ID account can authenticate immediately. Others receive a one-time passcode, assuming this is enabled in your organization.

To remove guest access:

1. Go to **Settings** > **eDiscovery** > **Guest users**.
1. Select the guest and choose **Remove**.

The guest's Microsoft Entra account remains active, but they lose access to the case. Regular cleanup of inactive guest accounts is recommended in Microsoft Entra ID.
