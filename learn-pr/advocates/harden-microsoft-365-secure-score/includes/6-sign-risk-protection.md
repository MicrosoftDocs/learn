**Secure Score recommendation:** Configure sign-in risk protection.

Sign-in risk is the probability that a specific authentication request isn't performed by the legitimate account owner. It's evaluated for one sign-in. It's distinct from user risk, which represents likely identity compromise over time.

Full risk policy capability requires Microsoft Entra ID P2 or Microsoft Entra Suite. Risk detections can include unfamiliar sign-in properties, anonymous network addresses, malicious IP addresses, password spray, leaked credentials, and threat intelligence.

## Choose risk levels

Microsoft recommends requiring multifactor authentication for **Medium** and **High** sign-in risk. This balance interrupts credible threats while allowing legitimate users to self-remediate through strong authentication.

Selecting only **High** reduces prompts but leaves medium-risk sign-ins untreated. Selecting **Low** increases coverage and user interruption. Base any deviation on detection volume, false-positive analysis, threat tolerance, and support capacity.

Trusted locations can reduce some false positives. A trusted location isn't a blanket trust decision. Don't exclude trusted networks from all controls without a separate risk assessment.

## Keep risk policies separate

Don't combine sign-in risk and user risk in one Conditional Access policy. Separate policies produce predictable remediation:

- Sign-in risk requires strong authentication for one risky request.
- User risk requires identity remediation for a likely compromised account.

Separate policies also improve reporting, testing, ownership, and rollback.

## Create the policy in the portal

To create the sign-in risk protection policy in the portal, perform the following steps:

1. In the Microsoft Entra admin center, select **Entra ID** > **Conditional Access**.
1. Create `CA004-Require-MFA-Medium-High-SignIn-Risk`.
1. Include **All users**.
1. Exclude both emergency access accounts.
1. Include **All resources**.
1. Under **Conditions** > **Sign-in risk**, select **Medium** and **High**.
1. Under **Grant**, select **Require authentication strength**.
1. Select the built-in **Multifactor authentication** strength.
1. Under **Session**, set **Sign-in frequency** to **Every time**.
1. Set the policy to **Report-only**.
1. Create the policy.

Reauthentication for every risky sign-in prevents an existing session from satisfying a newly detected risky request without fresh proof.

## Create the policy with Microsoft Graph PowerShell

Use the following PowerShell script to create the sign-in risk policy:

```powershell
$params = @{
    displayName = 'CA004-Require-MFA-Medium-High-SignIn-Risk'
    state = 'enabledForReportingButNotEnforced'
    conditions = @{
        clientAppTypes = @('all')
        signInRiskLevels = @(
            'medium',
            'high'
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
        authenticationStrength = @{
            id = '00000000-0000-0000-0000-000000000002'
        }
    }
    sessionControls = @{
        signInFrequency = @{
            authenticationType = 'primaryAndSecondaryAuthentication'
            frequencyInterval = 'everyTime'
            isEnabled = $true
        }
    }
}

$signInRiskPolicy = New-MgIdentityConditionalAccessPolicy `
    -BodyParameter $params

$signInRiskPolicy |
    Select-Object Id, DisplayName, State
```

## Investigate before enforcement

To investigate risky sign-ins, perform the following steps:

Open **ID Protection** > **Risky activities** > **Risky sign-ins**. For each active risk:

- Confirm the user.
- Review location, device, application, client, network, and detection type.
- Check adjacent sign-ins.
- Determine whether the user recognizes the activity.
- Confirm method registration.
- Dismiss only a verified false positive.
- Confirm compromise when evidence supports it.

Don't use policy enforcement as a substitute for incident response. A malicious sign-in can indicate token theft, endpoint compromise, or broader credential exposure.

## Validate remediation

Use report-only data to confirm that medium-risk and high-risk sign-ins would require the intended strength. Verify that successful strong authentication changes the sign-in risk remediation state as expected.

Test passwordless users separately. If a passwordless population uses a stronger built-in authentication strength, scope a dedicated sign-in risk policy to that population and require **Passwordless MFA** or **Phishing-resistant MFA**.

Users must register a capable method before risk enforcement. An unregistered user can be blocked and require administrator intervention.
