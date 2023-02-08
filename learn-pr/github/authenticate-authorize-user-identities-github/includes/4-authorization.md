Here, you'll be introduced to the authorization for GitHub users, which is the next step after user authentication.

As we learned previously, a user can be granted access to a GitHub organization that uses SAML single sign-on (SSO) by authenticating through the identity provider (IdP). But after you authenticate the user with the IdP successfully from GitHub, you must now authorize any personal access token, SSH key, or OAuth App that you would like the user to use to access your organization's resources. Let's look a little deeper into this authentication process with SAML single sign-on.

## Authorization with SAML SSO through SCIM

SAML single sign-on (SSO) gives organization owners and enterprise owners on GitHub a way to control and secure access to organization resources like repositories, issues, and pull requests. If you use SAML SSO in your organization, you can implement SCIM or *System for Cross-domain Identity Management*. SCIM lets you add, manage, or remove organization member access within GitHub. SCIM was developed to allow synchronization of information between an IdP and multiple applications.

:::image type="content" source="../media/enable-scim-user-provisioning-example.png" alt-text="Screenshot of the SCIM setting." :::

SCIM is a protocol that tells the directory an account has been created and allows you to automate the exchange of user identity information between systems. For example, while onboarding a new employee, using a central directory allows you to automatically provision the user to access services like GitHub. An administrator can deprovision an organization member using SCIM and automatically remove the member from the organization.

> [!NOTE]
> If you use SAML SSO without implementing SCIM, you won't have automatic deprovisioning.

SCIM integrations allow the secure exchange of user identity data between your IdP and your enterprise on GitHub. SCIM was developed to allow the synchronization of information between an IdP and multiple applications. When organization members' sessions expire after their access is removed from the IdP, they aren't automatically removed from the organization. Authorized tokens grant access to the organization even after their sessions expire. To remove this access, you can either manually remove the authorized token from the organization or automate its removal with SCIM.

### SSH key and PAT with SAML SSO

Once these systems are implemented, user lifecycle-management changes made in your IdP will be reflected in your GitHub enterprise automatically. The SAML IdP and the SCIM client must use matching NameID and userName values for each user. This process allows a user authenticating through SAML to be linked to their provisioned SCIM identity. Each time you make changes to group membership in your IdP, the IdP will make a SCIM call to GitHub.com to update the corresponding organization's membership. Each time an enterprise member accesses a resource protected by your enterprise account's SAML configuration, that SAML assertion will trigger provisioning.

To access your organization's protected resources using the API and Git on the command line, your users will need to authorize and authenticate with a PAT (personal access token) or SSH key. Users can authorize an existing PAT or SSH key, or create a new PAT or SSH key and then authorize it. As the administrator, you're able to review each personal access token and SSH key that a member has authorized for API and Git access.

:::image type="content" source="../media/saml-sso-ssh-key-example.png" alt-text="Screenshot of the SSH key." :::

After you enable SAML SSO, there are multiple ways you can add new members to your organization. Organization owners can invite new members manually on GitHub or by using the API. To provision new users without an invitation from an organization owner, you can use the URL `https://github.com/orgs/ORGANIZATION/sso/sign_up`, replacing *ORGANIZATION* with the name of your organization. For example, you can configure your IdP so that anyone with access to the IdP can click a link on the IdP's dashboard to join your GitHub organization.

SCIM and SAML SSO also have security benefits. The first time a member uses SAML SSO to access your organization, GitHub automatically creates a record that links your organization, the member's GitHub account, and the member's account on your IdP. You can review the SAML SSO identity that a member has linked to their GitHub account. When available, the entry will include SCIM data for the user. You can also view and revoke the linked SAML identity, active sessions, and authorized credentials for members of your organization or enterprise account. When an employee leaves the company, the off-boarding process is automated and deprovisioning happens automatically. When you unassign the application from a user or deactivate a user's account on your IdP, it will communicate with GitHub.com to invalidate any SAML sessions for that user. The automation of these tasks reduces the time required for an administrator to manage user credentials, and the risk of error associated with manually entering and updating user information is also mitigated.

### Connect your IdP to your organization

To use SAML single sign-on and SCIM, you must connect your identity provider to your GitHub organization. When you enable SAML SSO for your GitHub organization, you connect your identity provider to your organization. Keep in mind that not all SAML identity providers are currently supported by GitHub for SCIM. Following is a list of the GitHub supported identity providers for SCIM:

- Azure AD
- Okta
- OneLogin

If your support request is outside of the scope of what our team can help you with, we may recommend next steps to resolve your issue outside of GitHub Support. Your support request is possibly out of GitHub Support's scope if the request is primarily about:

- Third-party integrations
- Hardware setup
- CI/CD, such as Jenkins
- Writing scripts
- Configuration of external authentication systems, such as SAML identity providers
- Open-source projects

Some companies may have built their own system and synchronize their accounts in a custom way. GitHub doesn't support these custom-created accounts with technical assistance. Technical support by GitHub for changes in the way GitHub.com uses SCIM and SAML is available for enterprises that are using one of the providers listed previously.

If you're uncertain if the issue is out of scope, open a ticket with GitHub support, and they'll be happy to help you determine the best way to continue.
