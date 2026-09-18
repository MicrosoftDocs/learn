**Secure Score recommendation:** Require multifactor authentication for administrative roles.

An administrator has the ability to change identities, applications, mail, files, roles, and security controls within Microsoft 365. A stolen administrative password therefore has a larger blast radius than a standard user compromise. This is a strong reason for you to ensure that privileged accounts have strong security controls applied.

## Understand authentication strength

Multifactor authentication proves identity with more than one factor. Not every authentication method is phishing resistant. Telephone calls, text messages, one-time codes, and push approvals can be relayed or socially engineered.

Phishing-resistant methods bind authentication to the legitimate service or use cryptographic challenge-response. Built-in Microsoft Entra authentication strengths include:

- **Multifactor authentication** for broad compatibility.
- **Passwordless multifactor authentication** for supported passwordless methods.
- **Phishing-resistant multifactor authentication** for Windows Hello for Business, passkeys based on Fast Identity Online version 2, and certificate-based authentication configured to meet the strength.

You should deploy and test authentication methods before enforcing the authentication strength. An administrator without a permitted authentication method is blocked.

## Define policy scope

When constructing Conditional Access policies, target administrative directory roles rather than a manually maintained administrator group. Role targeting automatically covers current members of the selected roles.

At minimum, ensure the following roles are subject to policies:

- Global Administrator
- Application Administrator
- Authentication Administrator
- Billing Administrator
- Cloud Application Administrator
- Conditional Access Administrator
- Exchange Administrator
- Helpdesk Administrator
- Password Administrator
- Privileged Authentication Administrator
- Privileged Role Administrator
- Security Administrator
- SharePoint Administrator
- User Administrator

Target **Microsoft Admin Portals** for the minimum recommendation scope. Target **All resources** for stronger coverage of administrative access outside browser portals. The scripted lab targets all resources.

Exclude only emergency access accounts. Review role additions over time. A role omitted from the policy remains a privileged gap.

## Create the policy in the portal

To create a policy in the Microsoft Entra admin center:

1. Sign in to the Microsoft Entra admin center as a Conditional Access Administrator.
1. Select **Entra ID** > **Conditional Access** > **Policies** > **New policy**.
1. Enter `CA001-Require-Phishing-Resistant-MFA-Admins`.
1. Under **Users or workload identities**, select **Directory roles**.
1. Select the administrative roles in scope.
1. Exclude both emergency access accounts.
1. Under **Target resources**, select **All resources**.
1. Under **Grant**, select **Require authentication strength**.
1. Select **Phishing-resistant MFA**.
1. Set **Enable policy** to **Report-only**.
1. Review the summary, then create the policy.

If registration is incomplete, use the built-in **Multifactor authentication** strength temporarily. Treat that setting as a migration stage. Record the date for enforcing phishing-resistant methods.

## Create the policy with Microsoft Graph PowerShell

You can create Conditional Access policies with PowerShell. To do this, first resolve role template identifiers. this is because Conditional Access role targeting uses role template identifiers, not active role instance identifiers.

```powershell
$adminRoleNames = @(
    'Global Administrator',
    'Application Administrator',
    'Authentication Administrator',
    'Billing Administrator',
    'Cloud Application Administrator',
    'Conditional Access Administrator',
    'Exchange Administrator',
    'Helpdesk Administrator',
    'Password Administrator',
    'Privileged Authentication Administrator',
    'Privileged Role Administrator',
    'Security Administrator',
    'SharePoint Administrator',
    'User Administrator'
)

$adminRoleTemplates = @(
    Get-MgDirectoryRoleTemplate -All |
        Where-Object DisplayName -In $adminRoleNames
)

$missingRoleNames = @(
    $adminRoleNames |
        Where-Object { $_ -notin $adminRoleTemplates.DisplayName }
)

if ($missingRoleNames.Count -gt 0) {
    throw "Role templates not found: $($missingRoleNames -join ', ')"
}

$adminRoleTemplateIds = @(
    $adminRoleTemplates |
        Select-Object -ExpandProperty Id
)
```

To create a report-only policy, run the following script:

```powershell
$params = @{
    displayName = 'CA001-Require-Phishing-Resistant-MFA-Admins'
    state = 'enabledForReportingButNotEnforced'
    conditions = @{
        clientAppTypes = @('all')
        users = @{
            includeRoles = $adminRoleTemplateIds
            excludeUsers = $breakGlassObjectIds
        }
        applications = @{
            includeApplications = @('All')
        }
    }
    grantControls = @{
        operator = 'OR'
        authenticationStrength = @{
            id = '00000000-0000-0000-0000-000000000004'
        }
    }
}

$adminPolicy = New-MgIdentityConditionalAccessPolicy `
    -BodyParameter $params

$adminPolicy |
    Select-Object Id, DisplayName, State
```

The built-in phishing-resistant authentication strength identifier is `00000000-0000-0000-0000-000000000004`. You'll need to resolve custom authentication strength identifiers from the tenant instead of embedding an assumed value.

## Validate report-only results

Use **Conditional Access** > **What If**:

1. Select a pilot administrator.
1. Select a target resource in scope.
1. Set representative device, location, client, and risk values.
1. Run the evaluation.
1. Confirm that `CA001-Require-Phishing-Resistant-MFA-Admins` applies.
1. Confirm that no unexpected blocking policy applies.

Then perform a real pilot sign-in. Open the sign-in event and inspect the **Report-only** tab. Confirm the policy result and authentication details.

Test:

- A pilot administrator with a permitted phishing-resistant method.
- A pilot administrator without that method.
- A non-administrator.
- Each emergency access account through the documented recovery path.

The first user should satisfy the policy. The second should show the expected report-only failure. The non-administrator should be outside this policy. Emergency access should be excluded and should generate monitoring alerts.

## Enforce safely

Before changing the state of a Conditional Access policy from report-only to enforcement:

- Confirm role template resolution.
- Confirm method registration for every affected administrator.
- Confirm two emergency accounts.
- Review at least one normal work cycle of report-only events.
- Notify the service desk.
- Define the rollback operator and communication channel.

Enable the policy during a monitored window:

```powershell
Update-MgIdentityConditionalAccessPolicy `
    -ConditionalAccessPolicyId $adminPolicy.Id `
    -State enabled
```

If access fails unexpectedly, use one of the emergency accounts to set the policy state to `disabled`. Preserve the policy and sign-in evidence so that you can debug why it hasn't behaved as expected.

## Common Conditional Access policy failure modes

Avoid the following choices when constructing Conditional Access policies:

- Don't exclude all administrators to simplify rollout.
- Don't depend on push approval as the final privileged method.
- Don't target only one administrative portal when privileged clients access other resources.
- Don't assume role membership is static.
- Don't enable the policy before method registration.
- Don't use emergency accounts for routine administration.
