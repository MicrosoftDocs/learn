**Secure Score recommendation:** Configure user risk protection.

User risk is the probability that an identity is compromised. It aggregates risk detections associated with the account. A high-risk user should regain access only after a secure remediation flow or administrator investigation.

## Understand remediation behavior

Microsoft recommends **Require risk remediation** when user risk is **High**.

The control adapts to the authentication model:

- A password-backed user completes multifactor authentication, then performs a secure password change.
- A passwordless user has sessions revoked, then authenticates again with an approved method.

When **Require risk remediation** is selected, Microsoft Entra applies an authentication strength requirement and **Sign-in frequency - Every time**.

A normal password change outside the risky-user remediation flow doesn't satisfy secure risk remediation. The user must complete the controlled flow or an administrator must investigate and remediate the account.

Before enforcement:

- Confirm affected users have a capable multifactor or passwordless method.
- Enable password writeback for synchronized users who must change an on-premises password.
- Test writeback against the on-premises password policy.
- Confirm help desk procedures for blocked users.
- Investigate current high-risk users.
- Define incident response for confirmed compromise.

Without registration, the user can be blocked. Without password writeback, a synchronized password-backed user can't complete cloud-initiated remediation correctly.

## Create the policy in the portal

To create the policy using the portal:

1. Create `CA005-Remediate-High-User-Risk`.
1. Include **All users**.
1. Exclude both emergency access accounts.
1. Include **All resources**.
1. Under **Conditions** > **User risk**, select **High**.
1. Under **Grant**, select **Require risk remediation**.
1. Choose the authentication strength appropriate for the population.
1. Confirm that **Sign-in frequency - Every time** is present.
1. Set the policy to **Report-only**.
1. Create the policy.

Use the current portal control for mixed password-backed and passwordless populations. It expresses the adaptive remediation intent directly.

## Automate the password-backed equivalent

The following Microsoft Graph policy uses the established combination of multifactor authentication and secure password change. It's suitable only for a password-backed population. It doesn't reproduce the adaptive passwordless behavior of the current portal control.

```powershell
$params = @{
    displayName = 'CA005-Remediate-High-User-Risk'
    state = 'enabledForReportingButNotEnforced'
    conditions = @{
        clientAppTypes = @('all')
        userRiskLevels = @('high')
        users = @{
            includeUsers = @('All')
            excludeUsers = $breakGlassObjectIds
        }
        applications = @{
            includeApplications = @('All')
        }
    }
    grantControls = @{
        operator = 'AND'
        builtInControls = @(
            'mfa',
            'passwordChange'
        )
    }
    sessionControls = @{
        signInFrequency = @{
            authenticationType = 'primaryAndSecondaryAuthentication'
            frequencyInterval = 'everyTime'
            isEnabled = $true
        }
    }
}

$userRiskPolicy = New-MgIdentityConditionalAccessPolicy `
    -BodyParameter $params

$userRiskPolicy |
    Select-Object Id, DisplayName, State
```

> [!NOTE]
> Don't use this script for a mixed environment without separating passwordless users. Prefer the portal's current **Require risk remediation** control when adaptive behavior is required.

## Investigate risky users

To investigate risky users, perform the following steps:

Open **ID Protection** > **Risky users**. For each high-risk user:

1. Review risk detections and sign-in history.
1. Contact the user through a trusted channel.
1. Inspect devices, mailbox activity, application grants, role changes, and session activity when compromise is plausible.
1. Confirm compromise or dismiss risk only with evidence.
1. Revoke sessions for confirmed compromise.
1. Reset credentials or complete the passwordless recovery process.
1. Remove malicious authentication methods or application grants.
1. Document the incident.

Risk remediation reduces the risk state. It doesn't reverse attacker actions already completed.

## Validate both identity models

Test password-backed and passwordless users separately:

- A high-risk password-backed test user should complete multifactor authentication and secure password change.
- A synchronized test user should complete password writeback.
- A high-risk passwordless test user should have sessions revoked and reauthenticate.
- A user without a capable method should follow the documented support path.

Confirm that the sign-in risk policy remains separate. A sign-in can trigger one or both policies, but each policy should express one risk condition.
