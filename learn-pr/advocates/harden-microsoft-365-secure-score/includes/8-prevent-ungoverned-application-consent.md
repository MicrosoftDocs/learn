**Secure Score recommendation:** Prevent user consent to applications.

Consent phishing is an attack technique where a user is persuaded to authorize a malicious application. The application can receive delegated access to mail, files, profiles, calendars, or other organizational data without learning the user's password.

Disabling user consent prevents future user-granted permissions. Taking this step doesn't remove existing consent grants. Additionally, disabling user consent doesn't remove administrator consent. Existing permissions need a separate review.

## Understand permission types

Microsoft identity platform applications commonly use:

- **Delegated permissions**: The application acts as a signed-in user. Effective access is constrained by the permission grant and the user's own access.
- **Application permissions**: The application acts without a signed-in user. Administrator consent is normally required. The application can have broad tenant access.

The Secure Score action addresses ungoverned user consent. A complete governance program also reviews administrator consent, publisher verification, application ownership, credential lifetime, service principal activity, and high-risk permissions.

## Choose a consent model

The strict model used in this module sets user consent to **Do not allow user consent**. Users submit legitimate applications through the administrator consent workflow.

An alternative model permits consent only for selected low-impact permissions from verified publishers. Use that model only when the organization has defined low-risk permissions, verified publisher requirements, monitoring, and review.

## Configure the portal

To restrict user consent in the portal:

1. Sign in to the Microsoft Entra admin center with the required role.
1. Select **Identity** > **Applications** > **Enterprise apps**.
1. Select **Consent and permissions** > **User consent settings**.
1. Select **Do not allow user consent**.
1. Save the setting.
1. Open **Admin consent settings**.
1. Enable the administrator consent workflow.
1. Assign reviewers.
1. Set request expiry and reviewer notifications.
1. Publish user guidance for requesting legitimate applications.

The workflow preserves productivity without allowing direct user consent. Reviewers must assess the publisher, requested permissions, data sensitivity, business owner, user population, and application terms.

## Configure the authorization policy

The default user role contains permission grant policy assignments. Remove every assignment beginning with `ManagePermissionGrantsForSelf.`. Preserve `ManagePermissionGrantsForOwnedResource.*` assignments when application owners still need them. To accomplish this, use the following PowerShell script:

```powershell
Connect-MgGraph -Scopes 'Policy.ReadWrite.Authorization'

$authorizationPolicy = Get-MgPolicyAuthorizationPolicy

$currentGrantPolicies = @(
    $authorizationPolicy.DefaultUserRolePermissions.PermissionGrantPoliciesAssigned
)

$policiesToPreserve = @(
    $currentGrantPolicies |
        Where-Object {
            $_ -like 'managePermissionGrantsForOwnedResource.*'
        }
)

$params = @{
    defaultUserRolePermissions = @{
        permissionGrantPoliciesAssigned = $policiesToPreserve
    }
}

Update-MgPolicyAuthorizationPolicy -BodyParameter $params
```

To verify the result, use the following PowerShell script:

```powershell
$assignedGrantPolicies = @(
    (Get-MgPolicyAuthorizationPolicy).DefaultUserRolePermissions.PermissionGrantPoliciesAssigned
)

$assignedGrantPolicies

if (
    $assignedGrantPolicies |
        Where-Object { $_ -like 'managePermissionGrantsForSelf.*' }
) {
    throw 'A self-consent permission grant policy remains assigned.'
}
```

> [!NOTE]
> Remember that this change affects future consent decisions. It doesn't revoke grants already stored on service principals.

## Inventory existing delegated grants

Read existing OAuth 2.0 permission grants:

```powershell
Get-MgOauth2PermissionGrant -All |
    Select-Object `
        Id,
        ClientId,
        ConsentType,
        PrincipalId,
        ResourceId,
        Scope |
    Sort-Object ClientId, ResourceId
```

Interpret:

- `ClientId` identifies the client service principal.
- `ResourceId` identifies the resource service principal.
- `ConsentType` distinguishes tenant-wide and principal-specific grants.
- `PrincipalId` identifies the user for principal-specific consent.
- `Scope` lists delegated permissions.

Resolve identifiers to service principal and user names before review. Treat broad mail, file, directory, offline access, and tenant-wide grants as high priority. Don't revoke a grant until the application owner and business dependency are known.

Also review application role assignments for application permissions. The user-consent setting doesn't govern those assignments.

## Validate behavior

To validate that the policy works, use a standard test user and a test application:

1. Request a permission that requires consent.
1. Confirm direct user consent is blocked.
1. Confirm the user can submit an administrator consent request.
1. Confirm reviewers receive the request.
1. Approve only a controlled test request.
1. Confirm the audit log records the decision.
1. Reject another request and confirm the user experience.

Check that existing permission grants remain visible. 

When managing these application controls, ensure that you:

- Require a named business owner.
- Prefer verified publishers.
- Review requested permissions against actual application function.
- Limit administrator consent rights.
- Monitor new service principals, grants, credentials, and high-risk permissions.
- Expire unused applications.
- Revoke grants when ownership or business justification ends.
