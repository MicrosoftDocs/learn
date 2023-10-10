## Configure external collaboration settings

1.  Sign in to the [Azure portal](https://portal.azure.com/) as a tenant administrator.
2.  Select **Azure Active Directory**.
3.  Select **External Identities - External collaboration settings**.
4.  Under **Guest user access**, review access levels that are available and then select **Guest user access is restricted to properties and memberships of their own directory objects (most restrictive)**.
    
    > [!NOTE]
    > Guest users have the same access as members (most inclusive): This option gives guests the same access to Azure AD resources and directory data as member users.<br>\- Guest users have limited access to properties and memberships of directory objects: (Default) This setting blocks guests from certain directory tasks, like enumerating users, groups, or other directory resources. Guests can see membership of all non-hidden groups.<br>\- Guest user access is restricted to properties and memberships of their own directory objects (most restrictive): With this setting, guests can access only their own profiles. Guests are not allowed to see other users' profiles, groups, or group memberships.
5.  Under **Guest invite settings**, mark **Only user assigned to specific admin roles can invite guest users**.
6.  Inviting guests to collaborate moves the least restrictive option, where anyone can invite guests, to the most restrictive where no one can invite guests.
7.  Anyone in the organization can invite guests: Set to allow anyone to invite guest users, including users, admins, and even other guest users.
8.  Member users and users assigned to specific admin roles: Set to allow only full members of the organization or members of admin groups to invite guests.
9.  Only users assigned specific admin roles: Set to allow only those people included in specific admin roles to invite guests.
10. No one in organization can invite guests: Set to restrict all guest user invites by members.
11. Users in the **Guest Inviter role** will still be able to invite guests, if admin users can invite guest.
    
    :::image type="content" source="../media/guest-invite-settings-3dd14ea3.png" alt-text="Screenshot of the guest invite settings with the Guests can invite set to No and highlighted.":::
    
12. Under **Collaboration restrictions**, review the available options and accept the default settings.
    
    > [!IMPORTANT]
    > You can create either an allow list or a deny list. You can't set up both types of lists. By default, whatever domains are not in the allow list are on the deny list, and vice versa. You can create only one policy per organization. You can update the policy to include more domains, or you can delete the policy to create a new one. The number of domains you can add to an allow list or deny list is limited only by the size of the policy. The maximum size of the entire policy is 25 KB (25,000 characters), which includes the allow list or deny list and any other parameters configured for other features. This list works independently from OneDrive for Business and SharePoint Online allow/block lists. If you want to restrict individual file sharing in SharePoint Online, you need to set up an allow or deny list for OneDrive for Business and SharePoint Online. The list does not apply to external users who have already redeemed the invitation. The list will be enforced after the list is set up. If a user invitation is in a pending state, and you set a policy that blocks their domain, the user's attempt to redeem the invitation will fail.
13. When finished, save your changes.
