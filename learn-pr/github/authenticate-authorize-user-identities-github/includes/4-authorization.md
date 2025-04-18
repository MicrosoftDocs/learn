After a user successfully authenticates through your identity provider (IdP) using SAML single sign-on (SSO), the next critical step is authorization—granting tools like personal access tokens (PATs), SSH keys, or OAuth apps the ability to access organization resources.

## Automating User Authorization with SAML SSO and SCIM

SAML SSO enables enterprise and organization owners to control access to GitHub resources like repositories, issues, and pull requests. Integrating SCIM (System for Cross-domain Identity Management) enhances this by automating user provisioning and deprovisioning.

:::image type="content" source="../media/enable-scim-user-provisioning-example.png" alt-text="Screenshot of the SCIM setting." :::

With SCIM, new employees added to your IdP are granted access to GitHub automatically, while departing users are removed, reducing manual steps and improving security.

> [!NOTE]
> Without SCIM, SAML SSO alone does not support automatic deprovisioning of organization members.

SCIM also revokes stale tokens after a session ends, reducing security risks. Without SCIM, this must be done manually.

## Managing SSH Keys and PATs with SAML SSO

SAML SSO and SCIM work together to reflect identity changes in GitHub. To support this:
- `NameID` and `userName` must match between the SAML IdP and SCIM client.
- Group changes in your IdP trigger SCIM updates in GitHub.

Users accessing APIs or Git must use an authorized PAT or SSH key. These are auditable and securely tied to SAML SSO.

:::image type="content" source="../media/saml-sso-ssh-key-example.png" alt-text="Screenshot of the SSH key." :::

To simplify onboarding, provision users using: `https://github.com/orgs/ORGANIZATION/sso/sign_up`. Display this link in your IdP dashboard.

When users first authenticate, GitHub links their account and SCIM data to your organization. Admins can later audit or revoke sessions and credentials to automate offboarding.

## SCIM Integration with GitHub

SCIM streamlines identity management in GitHub Enterprise Cloud by supporting both native integrations and custom configurations.

### Supported SCIM Providers

GitHub natively supports:
- Okta
- Azure AD
- OneLogin
- Ping Identity
- Google Workspace

These integrations ensure reliable configuration and compatibility.

### Custom SCIM Integrations

If your IdP isn't natively supported, use GitHub’s SCIM API to build custom integrations.

#### SCIM API Overview

The SCIM 2.0 API allows you to:
- Create, update, and delete users
- Manage groups

#### Example Request to Provision a User:
```http
POST /scim/v2/Users
Content-Type: application/json

{
  "userName": "jdoe",
  "name": {
    "givenName": "John",
    "familyName": "Doe"
  },
  "emails": [
    {
      "value": "jdoe@example.com",
      "primary": true
    }
  ]
}
```

GitHub processes this request and adds the user to your organization.

### Getting Started

#### For Supported Providers:
1. Log into your IdP admin console.
2. Enable SCIM provisioning.
3. Provide GitHub’s SCIM base URL and bearer token.

:::image type="content" source="../media/image-6.png" alt-text="Screenshot of SCIM configuration steps in IdP's administrative console." :::

#### For Custom IdPs:
1. Use GitHub's SCIM REST API.
2. Authenticate with a PAT.
3. Test the integration with sample requests.

### Key Benefits of SCIM Integration

- **Provisioning:** Automatically create accounts.
- **Updates:** Synchronize roles and departments.
- **Deprovisioning:** Remove access promptly upon user exit.

## SCIM vs. Manual User Management

| Aspect       | SCIM-Based Management                                                                 | Manual Management                                                            |
|--------------|-----------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| **Automation**  | Automates provisioning and deprovisioning                                             | Manual intervention required                                                  |
| **Consistency**  | Standardized user data across systems                                                  | Risk of inconsistencies                                                       |
| **Security**     | Timely deactivation of access                                                         | Delayed or missed revocations                                                 |
| **Scalability**  | Scales with large user bases                                                          | Cumbersome at scale                                                           |
| **Compliance**  | Helps meet policy and audit requirements                                               | Harder to track and report                                                    |

## Connecting Your IdP to GitHub

You can use a supported identity provider or bring your own SAML 2.0 IdP.

### Supported (Paved Path) IdPs:
- Okta
- Azure Active Directory
- Google Workspace

Some advantages of using the supported IdPs are:
- Seamless integration
- GitHub-supported
- Lower setup effort

### Bring Your Own IdP:
Bringing your own IdP requires it isSAML 2.0 support. The advantage of this is that if allows for full flexibility.

### Integration Steps
| Type               | Steps                 |
|--------------------|-----------------------|
| **Paved Path:**    | 1. Navigate to enterprise security settings. <br>2. Select your IdP. <br>3. Follow setup instructions. |
| **Custom IdP:**    | 1. Go to security settings. <br>2. Choose custom IdP. <br>3. Enter SAML metadata. 4. Validate the connection. |

:::image type="content" source="../media/image-7.png" alt-text="Diagram showing the steps to integrate a pre-configured identity provider." :::

## Comparing IdP Integration Paths

| Feature               | Paved Path                        | Bring Your Own IdP               |
|----------------------|------------------------------------|----------------------------------|
| Setup Process        | ✅ Guided setup                    | ⚠️ Manual configuration            |
| Flexibility          | ⚠️ Limited to listed IdPs           | ✅ Any SAML 2.0 IdP                |
| Maintenance          | ✅ GitHub-managed                  | ⚠️ Organization-managed            |
| Customization        | ⚠️ Minimal                        | ✅ Fully customizable             |
| Support & Updates    | ✅ GitHub-supported                | ⚠️ Self-managed                    |

## Managing Identities and Access

### SAML SSO Configuration
1. Configure your SAML SSO URL.
2. Provide your public certificate.
3. Add IdP metadata.

### Credential Management

PATs and SSH keys must be explicitly authorized and linked to IdP identities to access organization resources securely.

### Auditing SAML Sessions
- View active sessions in settings.
- Revoke individual sessions as needed.

## GitHub Membership Considerations

| Type                 | Consideration            |
|-------------------------|----------------------------|
| GitHub Instance Membership | - Access to public repositories <br>- Create personal projects <br> - Public profile visibility |
| Organization Membership | - Role-based internal access <br> - Profile visible to org admins <br> - May affect billing |
| Multiple Organization Memberships| - Different roles across orgs <br>- Broader resource access <br>- Complex permission and billing <br> - Requires strict governance |

