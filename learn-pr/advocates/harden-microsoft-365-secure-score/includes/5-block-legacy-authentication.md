**Secure Score recommendation:** Block legacy authentication.

Legacy authentication clients don't support modern authentication controls such as multifactor authentication, device claims, or authentication strength. Password spray and credential stuffing frequently target these protocols. You should ensure that clients interact with Microsoft 365 services using the strongest authentication protocols possible.

## Identify legacy authentication

Legacy authentication can include older mail protocols, older Office clients, Exchange ActiveSync implementations, and applications that use basic credentials instead of modern authentication. To determine protocol use, review both interactive and non-interactive sign-in logs over a period that includes infrequent business processes.

In the Microsoft Entra admin center:

1. Select **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Add the **Client App** filter.
1. Select legacy client categories.
1. Review **User sign-ins**, **Non-interactive user sign-ins**, and service principal sign-ins where relevant.
1. Export the results.
1. Identify the user, device, application owner, protocol, frequency, and business purpose.

Conditional Access client app conditions classify legacy clients as **Exchange ActiveSync clients** and **Other clients**. Modern browser and mobile client traffic must remain outside the block condition.

## Remediate dependencies

For each legacy sign-in:

- Upgrade the client.
- Enable modern authentication in the application.
- Replace basic credentials in scripts.
- Move unattended work to a managed identity, service principal, certificate, or supported workload identity.
- Disable unused protocols at the service where possible.
- Remove app passwords.
- Test the replacement.

Use a temporary exclusion only when migration can't complete before enforcement. Give the exclusion an owner, reason, expiry date, and compensating control.

## Create the policy in the portal

1. Create `CA003-Block-Legacy-Authentication`.
1. Include **All users**.
1. Exclude emergency access accounts.
1. Add only approved temporary migration exclusions.
1. Include **All resources**.
1. Under **Conditions** > **Client apps**, configure the condition.
1. Select **Exchange ActiveSync clients** and **Other clients** only.
1. Under **Grant**, select **Block access**.
1. Set the policy to **Report-only**.
1. Create the policy.

Don't select modern client categories. The purpose is to block protocols that can't meet modern controls, not to block all sign-ins.

## Create the policy with Microsoft Graph PowerShell

To create the policy using PowerShell, run the following script:

```powershell
$params = @{
    displayName = 'CA003-Block-Legacy-Authentication'
    state = 'enabledForReportingButNotEnforced'
    conditions = @{
        clientAppTypes = @(
            'exchangeActiveSync',
            'other'
        )
        users = @{
            includeUsers = @('All')
            excludeUsers = $breakGlassObjectIds
        }
        applications = @{
            includeApplications = @('All')
        }
    }
    grantControls = @{
        operator = 'OR'
        builtInControls = @('block')
    }
}

$legacyPolicy = New-MgIdentityConditionalAccessPolicy `
    -BodyParameter $params

$legacyPolicy |
    Select-Object Id, DisplayName, State
```

## Review impact

In report-only results, distinguish:

- **Would block**: The legacy condition matched.
- **Not applied**: The sign-in used a modern client or was outside scope.
- **Report-only interrupted**: Another control affected the sign-in.
- **Failure before Conditional Access**: Authentication failed before policy evaluation.

Trace every recurring **Would block** result to an owner. Don't rely on the user principal name alone. One account can drive several workloads.

## Enforce the block

Enforce the block on legacy authentication protocols after:

- The observation period covers monthly or scheduled jobs.
- Critical clients have moved to modern authentication.
- Temporary exclusions are approved.
- Monitoring can identify blocked attempts.
- Support staff know the expected error pattern.

After enforcement:

1. Sign in with a modern client. Confirm success.
1. Attempt an approved legacy test in a controlled account. Confirm a Conditional Access failure.
1. Review blocked sign-ins.
1. Remove temporary exclusions when migration completes.
1. Disable unused legacy protocols in Exchange Online or the relevant service for defense in depth.

Blocking legacy authentication through Conditional Access doesn't replace service-level protocol controls. Use both where supported.
