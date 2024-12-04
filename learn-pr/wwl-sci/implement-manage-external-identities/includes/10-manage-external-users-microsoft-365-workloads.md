:::image type="content" source="../media/admin-center-guest-users-a8119317.png" alt-text="Screenshot of the Microsoft 365 admin center, opened to the guest users page.":::


Similar to Microsoft Entra ID, Microsoft 365 can invite guest users into the directory for collaboration purposes. Those users show in the user list as external, and have limited to no rights in Microsoft 365. However, they can be assigned collaboration rights to any Microsoft 365 workload. Guest users can even be given licenses to allow them to perform specific operations.

### External collaboration options in Microsoft 365

With Microsoft 365, your users can collaborate with people outside your organization in a variety of ways. Users can share files, invite guests to teams, have meetings with external participants, and chat with people from other organizations. The following table shows the primary ways people from outside your organization can access your Microsoft 365 resources:

| **Activity**                            | **Account type**                        | **Default setting** |
| --------------------------------------- | --------------------------------------- | ------------------- |
| Authenticated file and folder sharing   | Guest account                           | Enabled             |
| Site sharing                            | Guest account                           | Enabled             |
| Team sharing                            | Guest account                           | Enabled             |
| Shared channel in Teams                 | Existing Microsoft 365 external account | Disabled            |
| External chat and meetings              | Existing Microsoft 365 external account | Enabled             |
| Anonymous meeting join                  | None                                    | Enabled             |
| Unauthenticated file and folder sharing | None                                    | Enabled             |

People outside your organization do not have access unless a user in your organization initiates one of these activities. You can disable any of these settings if you don't want to allow that activity in your organization.

### Governance and management

As with any account in Microsoft Entra ID, you need to review and manage them regularly. Set up procedures to validate all users accounts, especially guest users, regularly. If an account does not need a capability, then remove it. If a user, guest or member, no longer needs a license or access then remove it.

Tools to manage Microsoft 365 guest users:

 -  Microsoft 365 admin center: `https://admin.microsoft.com`
 -  Microsoft Entra admin center: `https://entra.microsoft.com`
 -  Microsoft Entra ID within the Azure portal
 -  By script in Microsoft Graph, PowerShell, or CLI
 -  Within most of the Microsoft 365 workloads
