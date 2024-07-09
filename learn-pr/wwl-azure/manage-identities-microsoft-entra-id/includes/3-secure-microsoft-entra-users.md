Microsoft Entra ID allows you to create several types of users in your tenant, which provides greater flexibility in how you manage your organization's users.

> [!NOTE]
> For information about viewing or deleting personal data, please review Microsoft's guidance on the Windows data subject requests for the General Data Protection Regulation (GDPR) site.

## Prerequisites

The required role of least privilege varies based on the type of user you're adding and if you need to assign Microsoft Entra roles at the same time. Global Administrator can create users and assign roles, but whenever possible you should use the least privileged role.

:::image type="content" source="../media/all-users-page-1e07f848.png" alt-text="Screenshot showing the all users page in the Microsoft Entra administration center.":::


| **Task**                     | **Role**                      |
| ---------------------------- | ----------------------------- |
| Create a new user            | User Administrator            |
| Invite an external guest     | Guest Inviter                 |
| Assign Microsoft Entra roles | Privileged Role Administrator |

## Types of users

Before you create or invite a new user, take some time to review the types of users, their authentication methods, and their access within the Microsoft Entra tenant. For example, do you need to create an internal guest, an internal user, or an external guest? Does your new user need guest or member privileges?

 -  **Internal member**: These users are most likely full-time employees in your organization.<br>
 -  **Internal guest**: These users have an account in your tenant, but have guest-level privileges. It's possible they were created within your tenant prior to the availability of B2B collaboration.
 -  **External member**: These users authenticate using an external account, but have member access to your tenant. These types of users are common in multitenant organizations.
 -  **External guest**: These users are true guests of your tenant who authenticate using an external method and who have guest-level privileges.

Authentication methods vary based on the type of user you create. Internal guests and members have credentials in your Microsoft Entra tenant that can be managed by administrators. These users can also reset their own password. External members authenticate to their home Microsoft Entra tenant and your Microsoft Entra tenant authenticates the user through a federated sign-in with the external member's Microsoft Entra tenant. If external members forget their password, the administrator in their Microsoft Entra tenant can reset their password. External guests set up their own password using the link they receive in email when their account is created.
