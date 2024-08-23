Here, you explore the capabilities of centrally managing your GitHub enterprise members through GitHub Enterprise Managed Users.

GitHub Enterprise Managed Users (EMUs) are GitHub Enterprise Cloud accounts owned by companies and not individual users. The company’s GitHub administrators, control, manage, and audit these accounts. Using EMUs, you can connect your GitHub Enterprise Account to an identity provider (IdP); either Microsoft Entra ID or Okta. From there, you're able to centrally manage the user provisioning lifecycle and create a true single sign-on experience for your members and contractors. To ensure everything works smoothly, Admins have complete jurisdiction over the EMU accounts and their corresponding private repositories.

Because the company owns these EMU accounts, an administrator of the company can grant EMU access to any organization within the enterprise. In addition, you can control the profile information of your EMUs, including usernames, display names, and emails, all from your connected IdP. In short, With an EMU account, you can reduce the number of tasks that need to be manually duplicated from your IdP on GitHub.

Once provisioning is enabled in your IdP, you're able to accomplish the following tasks.

- Managing team membership and repository access.
- Controlling profile and personal data.
- Provisioning, updating, and deprovisioning IdP security groups to team and user memberships in GitHub EMU.
- Simplifying authentication with single sign-on (SSO).

:::image type="content" source="../media/emu-sso-example.png" alt-text="screenshot of the enterprise managed user sso" :::

### Access of managed users within your enterprise

In addition to what we mentioned about EMU access, permissions, and restrictions. Here's a high-level overview of the differences between managed users and regular users within GitHub Enterprise.

|                | GitHub Enterprise Managed Users (EMU)                      | GitHub Enterprise Account                                    |
| -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Ownership**  | Created for and controlled by the identity provider. | Multiple authorization and authentication initiatives required in GitHub to ensure secure enterprise access. |
| **Membership** | Automated user provisioning syncs IdP group membership with GitHub teams. | Administrators manage user membership on teams in the enterprise's organizations on GitHub. |
| **Policies**   | You can create policies at the enterprise level that apply to all users on the account. | Users are required to confirm compliance with GitHub user policies. |
| **Audit log**  | Enterprise owners can audit all of the managed users' actions on GitHub.com | Only audit log activity that happens in the enterprise account is available for your review. |
| **Privacy**    | No public repositories on EMU-enabled enterprises.           | Enterprise users can create public repositories.             |
| **SSO**        | True single sign-on experience for your users.               | Multiple authentication steps required for your users to sign on. |
| **Metadata**   | The enterprise controls user GitHub metadata. Managed users can't modify it. This metadata includes email addresses, display names, and usernames. | Enterprise users create their own account, provide email, and choose their GitHub handle. |

### Authentication and user provisioning

With managed users, you provision user accounts for your enterprise's members on GitHub.com directly from your IdP. To access resources in your enterprise, all members must authenticate to GitHub.com solely through your IdP.

To manage identity and access for your enterprise, you need to configure an application on your IdP and your enterprise on GitHub.com. Authentication requires Security Assertion Markup Language (SAML) SSO and user provisioning requires System for Cross-domain Identity Management (SCIM). After you complete the configuration, your IdP communicates with GitHub.com each time you make the following changes.

- Assigning an application to a user on your IdP. Your IdP creates a user account as a member of your enterprise on GitHub.com and sends a notification email to the user.
- Updating information associated with a user's identity on your IdP. Your IdP updates the user's account on GitHub.com.
- Unassigning the application from a user or deactivating a user's account on your IdP. Your IdP communicates with GitHub.com to invalidate any SAML sessions and disable the member's account.

### Other use cases for EMU accounts

There are several unique ways you can use EMU accounts within your organization, let's look at some common use cases for EMUs found within most companies.

#### Onboard new employees

Employees are constantly joining the company all across the organization, departments, and teams. As an administrator, you can provision an EMU account for a new employee with all of their required permissions in the morning of their first day. EMU accounts also allow you to assign a GitHub handle that matches their work email to make identification easy across all systems. All of this setup occurs within the IdP and not within GitHub. The benefit of this configuration is to configure these settings in the same automatic flow as their benefits, HR, and expense systems to create a fast, efficient, and consistent onboarding.

#### Off board employees

On the contrary to onboarding, when an employee leaves the company, an administrator can instantly suspend their GitHub account with the same flow used to turn off the rest of their work access and systems. This turn-off includes HR, email, internal documents, and benefits. Since the IdP governs EMUs, the setup creates an efficient, fast, and secure method to remove access to sensitive source code when an employee leaves the company. This automatic turn-off prevents any lingering GitHub access.

#### Reduce accidental IP leakage

With the rise of open-source software contributions, employees might need to switch between projects with different user identities and permissions throughout the day. This situation leads to the possibility of accidental IP (Intellectual Property) leakage and contributions made to a project using the wrong credentials. EMUs reduce this risk by clearly identifying the current account and ensuring that the employee can't accidentally expose IP to personal or open-source repositories. This setup secures the company, IP, and the employee from accidental leakage.

#### Consultant administration

Similar to granting access to new employees with an EMU account, consultants can be granted access to an EMU account through the company's IdP. When their project is finished, they lose access to GitHub using the same flow that they would lose access to everything else. This automatic removal prevents lingering access for days or even weeks after their contract expires. In addition, if the consultant is working with multiple clients at the same time, by using an EMU account the consultant can't accidentally leak the company's IP into the other clients' repositories. This setup allows for tight control over access to the company's source code and IP while reducing lingering access or accidental IP leakage.
