Microsoft Entra B2B collaboration users are added as guest users to the directory, and guest permissions in the directory are restricted by default. Your business might need some guest users to fill higher-privilege roles in your organization. To support defining higher-privilege roles, guest users can be added to any roles you desire, based on your organization's needs.

## Add a B2B user to a role

Microsoft recommends that organizations use the rule of least privilege. You can use Privileged Identity Management (PIM) to grant access for B2B/guest users.

## Key properties of the Microsoft Entra B2B collaboration user<br>

### UserType

This property indicates the relationship of the user to the host tenancy. This property can have two values:

- **Member**: This value indicates an employee of the host organization and a user in the organization's payroll. For example, this user expects to have access to internal-only sites. This user isn't considered an external collaborator.
- **Guest**: This value indicates a user who isn't considered internal to the company, such as an external collaborator, partner, or customer. Such a user isn't expected to receive a CEO's internal memo or receive company benefits, for example.
    
   > [!NOTE]
   > The UserType has no relation to how the user signs in, the directory role of the user, and so on. This property simply indicates the user's relationship to the host organization and allows the organization to enforce policies that depend on this property.

### Identities

This property indicates the user’s primary identity provider. A user can have several identity providers, which can be viewed by selecting the link next to Identities in the user’s profile or by querying the identities property via the Microsoft Graph API.

| **Identities property value**   | **Sign-in state**                                                                                                                                                      |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| External Microsoft Entra tenant | This user is homed in an external organization and authenticates by using a Microsoft Entra account that belongs to the other organization.                            |
| Microsoft account               | This user is homed in a Microsoft account and authenticates by using a Microsoft account.                                                                              |
| \{host’s domain\}               | This user authenticates by using a Microsoft Entra account that belongs to this organization.                                                                          |
| google.com                      | This user has a Gmail account and has signed up by using self-service to the other organization.                                                                       |
| facebook.com                    | This user has a Facebook account and has signed up by using self-service to the other organization.                                                                    |
| mail                            | This user has signed up by using Microsoft Entra Email one-time passcode (OTP).                                                                                        |
| \{issuer URI\}                  | This user is homed in an external organization that doesn't use Microsoft Entra ID as their identity provider, but instead uses a SAML/WS-Fed-based identity provider. |

### Can Microsoft Entra B2B users be added as members instead of guests?

Typically, a Microsoft Entra B2B user and guest user are synonymous. Therefore, a Microsoft Entra B2B collaboration user is added as a user with UserType = Guest by default. However, in some cases, the partner organization is a member of a larger organization to which the host organization also belongs. If so, the host organization might want to treat users in the partner organization as members instead of guests. Use the Microsoft Entra user properties to change a guest into a member.

### Filter for guest users in the directory

:::image type="content" source="../media/filter-guest-users.png" alt-text="Screenshot of the Microsoft Entra ID User's screen showing the filter for guest users.":::

### Convert UserType

It's possible to convert UserType from Member to Guest and vice-versa by using PowerShell. However, the UserType property represents the user's relationship to the organization. Therefore, you should change this property only if the relationship of the user to the organization changes. If the relationship of the user changes, should the user principal names (UPN) change? Should the user continue to have access to the same resources? Should a mailbox be assigned? We don't recommend changing the UserType by using PowerShell as an atomic activity. Also, in case this property becomes immutable by using PowerShell, we don't recommend taking a dependency on this value.

## Remove guest user limitations

There might be cases where you want to give your guest users higher privileges. You can add a guest user to any role and even remove the default guest user restrictions in the directory to give a user the same privileges as members. It's possible to turn off the default limitations so that a guest user in the company directory has the same permissions as a member user. Remove the limitation in the user settings within Microsoft Entra ID menu.

:::image type="content" source="../media/remove-guest-limitations.png" alt-text="Screenshot of the External users option in the user settings. Choose what restrictions are set for external users.":::

## Dynamic groups and Microsoft Entra B2B collaboration

### What are dynamic groups?

Dynamic configuration of security group membership for Microsoft Entra ID is available in the [Azure portal](https://portal.azure.com/). Administrators can set rules to populate groups that are created in Microsoft Entra ID based on user attributes (such as userType, department, or country/region). Members can be automatically added to or removed from a security group based on their attributes. These groups can provide access to applications or cloud resources (SharePoint sites, documents) and to assign licenses to members.

The appropriate Microsoft Entra ID Premium P1 or P2 licensing is required to create and use dynamic groups.
