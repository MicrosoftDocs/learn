Azure Active Directory (Azure AD) B2B collaboration users are added as guest users to the directory, and guest permissions in the directory are restricted by default. Your business may need some guest users to fill higher-privilege roles in your organization. To support defining higher-privilege roles, guest users can be added to any roles you desire, based on your organization's needs.

## Add a B2B user to a role

Microsoft recommends that organizations use the rule of least privilege. You can use Privileged Identity Management (PIM) to grant access for B2B/guest users.

### Default role

:::image type="content" source="../media/default-role-414d62b2.png" alt-text="Screenshot showing the default directory role. You have choices of User, Global admin, and limited admin.":::


### Global Administrator role

:::image type="content" source="../media/global-admin-role-fac8f6ea.png" alt-text="Screenshot showing the global administrator role selected.  You get full admin rights to the tenant.":::


### Limited Administrator role

:::image type="content" source="../media/limited-admin-role-48bc9b98.png" alt-text="Screenshot showing the limited administrator role. You then get to pick what type of prebuilt Azure AD role needed.":::


## Understand the B2B user

B2B guest user objects in Azure AD have properties and states before and after invitation redemption. An Azure AD business-to-business (B2B) collaboration user is a user with UserType = Guest. This guest user typically is from a partner organization and has limited privileges in the inviting directory, by default.

Depending on the inviting organization's needs, an Azure AD B2B collaboration user can be in one of the following account states:

 -  State 1: Homed in an external instance of Azure AD and represented as a guest user in the inviting organization. In this case, the B2B user signs in by using an Azure AD account that belongs to the invited tenant. If the partner organization doesn't use Azure AD, the guest user in Azure AD is still created. The requirements are that they redeem their invitation and Azure AD verifies their email address. This arrangement is also called a just-in-time (JIT) tenancy or a "viral" tenancy.
 -  State 2: Homed in a Microsoft or other account and represented as a guest user in the host organization. In this case, the guest user signs in with a Microsoft account or a social account (google.com or similar). The invited user's identity is created as a Microsoft account in the inviting organization’s directory during offer redemption.
 -  State 3: Homed in the host organization's on-premises Active Directory and synced with the host organization's Azure AD. You can use Azure AD Connect to sync the partner accounts to the cloud as Azure AD B2B users with UserType = Guest.
 -  State 4: Homed in the host organization's Azure AD with UserType = Guest and credentials that the host organization manages.

Now, let's see what an Azure AD B2B collaboration user looks like in Azure AD.

### Before invitation redemption

State 1 and State 2 accounts are the result of inviting guest users to collaborate by using the guest users' own credentials. When the invitation is initially sent to the guest user, an account is created in your directory. This account doesn’t have any credentials associated with it because authentication is performed by the guest user's identity provider. The **Source** property for the guest user account in your directory is set to **Invited user**.

:::image type="content" source="../media/before-redemption-ec4e24cd.png" alt-text="Screenshot of the user properties before offer redemption. Invitation accepted field is set to No.":::


### After invitation redemption

After the guest user accepts the invitation, the **Source** property is updated based on the guest user’s identity provider.

For guest users in State 1, the **Source** is **External Azure Active Directory**.

:::image type="content" source="../media/after-redemption-state-1-bd1b4a6b.png" alt-text="Screenshot of State 1 guest user after offer redemption. Invitation is accepted and Source field is set.":::


For guest users in State 2, the **Source** is **Microsoft Account**.

:::image type="content" source="../media/after-redemption-state-2-ca536a91.png" alt-text="Screenshot of State 2 guest user after offer redemption. Invitation is accepted and Source field is set.":::


For guest users in State 3 and State 4, the **Source** property is set to **Azure Active Directory** or **Windows Server Active Directory**, as described in the next section.

## Key properties of the Azure AD B2B collaboration user

### UserType

This property indicates the relationship of the user to the host tenancy. This property can have two values:

 -  **Member**: This value indicates a user of the host organization and the user is considered internal to the organization. For example, this user expects to have access to internal-only sites. This user isn't considered an external collaborator.
 -  **Guest**: This value indicates a user who isn't considered internal to the company, such as an external collaborator, partner, or customer. Such a user isn't expected to receive a CEO's internal memo or receive company benefits, for example.
    
    > [!NOTE]
    > The UserType has no relation to how the user signs in, the directory role of the user, and so on. This property simply indicates the user's relationship to the host organization and allows the organization to enforce policies that depend on this property.

### Source

This property indicates how the user signs in.

 -  Invited User: This user has been invited but hasn't yet redeemed an invitation.
 -  External Azure Active Directory: This user is homed in an external organization and authenticates by using an Azure AD account that belongs to the other organization. This type of sign-in corresponds to State 1.
 -  Microsoft account: This user is homed in a Microsoft account and authenticates by using a Microsoft account. This type of sign-in corresponds to State 2.
 -  Windows Server Active Directory: This user is signed in from on-premises Active Directory that belongs to this organization. This type of sign-in corresponds to State 3.
 -  Azure Active Directory: This user authenticates by using an Azure AD account that belongs to this organization. This type of sign-in corresponds to State 4.
    
    > [!NOTE]
    > Source and UserType are independent properties. A value of Source does not imply a particular value for UserType.

### Can Azure AD B2B users be added as members instead of guests?

Typically, an Azure AD B2B user and guest user are synonymous. Therefore, an Azure AD B2B collaboration user is added as a user with UserType = Guest by default. However, in some cases, the partner organization is a member of a larger organization to which the host organization also belongs. If so, the host organization might want to treat users in the partner organization as members instead of guests. Use the Azure AD B2B Invitation Manager APIs to add or invite a user from the partner organization to the host organization as a member.

### Filter for guest users in the directory

:::image type="content" source="../media/filter-guest-users-b76a445c.png" alt-text="Screenshot of the Azure AD User's screen showing the filter for guest users.":::


### Convert UserType

It's possible to convert UserType from Member to Guest and vice-versa by using PowerShell. However, the UserType property represents the user's relationship to the organization. Therefore, you should change this property only if the relationship of the user to the organization changes. If the relationship of the user changes, should the user principal name (UPN) change? Should the user continue to have access to the same resources? Should a mailbox be assigned? We don't recommend changing the UserType by using PowerShell as an atomic activity. Also, in case this property becomes immutable by using PowerShell, we don't recommend taking a dependency on this value.

## Remove guest user limitations

There may be cases where you want to give your guest users higher privileges. You can add a guest user to any role and even remove the default guest user restrictions in the directory to give a user the same privileges as members. It's possible to turn off the default limitations so that a guest user in the company directory has the same permissions as a member user. Remove the limitation in the user settings within Azure AD menu.

:::image type="content" source="../media/remove-guest-limitations-6f8f344d.png" alt-text="Screenshot of the External users option in the user settings. Choose what restrictions are set for external users.":::


## Dynamic groups and Azure Active Directory B2B collaboration

### What are dynamic groups?

Dynamic configuration of security group membership for Azure AD is available in the [Azure portal](https://portal.azure.com/). Administrators can set rules to populate groups that are created in Azure AD based on user attributes (such as userType, department, or country/region). Members can be automatically added to or removed from a security group based on their attributes. These groups can provide access to applications or cloud resources (SharePoint sites, documents) and to assign licenses to members.

The appropriate Azure AD Premium P1 or P2 licensing is required to create and use dynamic groups.
