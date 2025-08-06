It's important that you prevent being accidentally locked out of your Microsoft Entra ID. With Microsoft Entra ID, you can't sign in or activate another user's account as an administrator. You can mitigate the chance of accidental lack of administrative access. The secret, create two or more *emergency access accounts* in your organization.

Emergency access accounts are highly privileged, and they aren't assigned to specific individuals. Emergency access accounts are limited to emergency or "break glass"' scenarios where normal administrative accounts can't be used. We recommend that you restrict access to emergency account. Use the accounts only when it's necessary.

This article provides guidelines for managing emergency access accounts in Microsoft Entra ID.

## Why use an emergency access account

An organization might need to use an emergency access account in the following situations:

 -  The user accounts are federated, and federation is currently unavailable because of a cell-network break or an identity-provider outage. For example, if the identity provider host in your environment has gone down, users might be unable to sign in when Microsoft Entra ID redirects to their identity provider.
 -  The administrators are registered through Microsoft Entra Multifactor Authentication. All their individual devices are unavailable or the service is unavailable. Users might be unable to complete multifactor authentication to activate a role. For example, a cell network outage is preventing them from answering phone calls or receiving text messages. Especially when these authentication-methods are the only two authentication mechanisms that they registered.
 -  The person with the most recent Global Administrator access has left the organization. Microsoft Entra ID prevents the last Global Administrator account from being deleted, but it doesn't prevent the account from being deleted or disabled on-premises. Either situation might make the organization unable to recover the account.
 -  Unforeseen circumstances such as a natural disaster emergency, during which a mobile phone or other networks might be unavailable.

## Create emergency access accounts

Create two or more emergency access accounts. These accounts should be cloud-only accounts that use the .onmicrosoft.com domain and that aren't federated or synchronized from an on-premises environment.

When an admin configures emergency accounts, the following requirements must be met:

 -  The emergency access accounts shouldn't be associated with any individual user in the organization. Make sure that your accounts aren't connected with any employee-supplied mobile phones, hardware tokens that travel with individual employees, or other employee-specific credentials. This precaution covers instances where an individual employee is unreachable when the credential is needed. Any registered devices need to be kept in known, secure location. These locations need multiple means of communicating with Microsoft Entra ID.
 -  The authentication mechanism used for an emergency access account should be distinct. Keep it separate from that used by your other administrative accounts, including other emergency-access accounts. For example, if your normal administrator sign-in is via on-premises MFA, then multifactor authentication would be a different mechanism. However, if multifactor authentication is your primary part of authentication for your administrative accounts, then consider a different approach for emergency-accounts. Try things such as using Conditional Access with a third-party MFA provider via Custom controls.
 -  The device or credential must not expire or be in scope of automated cleanup due to lack of use.
 -  You should make the Global Administrator role assignment permanent for your emergency access accounts.

### Exclude at least one account from phone-based multifactor authentication

To reduce the risk of an attack resulting from a compromised password, Microsoft Entra ID recommends that you require multifactor authentication for all individual users. This group includes administrators and all others (for example, financial officers) whose compromised account would have a significant opportunity to cause harm.

However, at least one of your emergency access accounts shouldn't have the same multifactor authentication mechanism as your other non-emergency accounts. This includes third-party multifactor authentication solutions. If you have a Conditional Access policy to require multifactor authentication for every administrator for Microsoft Entra ID and other connected software as a service (SaaS) apps, you should exclude emergency access accounts from this requirement, and configure a different mechanism instead. Additionally, you should make sure the accounts don't have a per-user multifactor authentication policy.

### Exclude at least one account from Conditional Access policies

During an emergency, you don't want a policy to potentially block your access to fix an issue. At least one emergency access account should be excluded from all Conditional Access policies.

## Federation guidance

Another option for organizations that use AD Domain Services and ADFS or similar identity provider to federate to Microsoft Entra ID, is to configure an emergency access account whose MFA claim could be supplied by that identity provider. For example, the emergency access account could be backed by a certificate and key pair such as one stored on a smartcard. When that user is authenticated to AD, ADFS can supply a claim to Microsoft Entra ID indicating that the user has met MFA requirements. Even with this approach, organizations must still have cloud-based emergency access accounts in case federation can't be established.

## Monitor sign in and audit logs

Organizations should monitor sign in and audit log activity from the emergency accounts and trigger notifications to other administrators. When you monitor the activity on break-glass accounts, you can verify these accounts are only used for testing or actual emergencies. You can use Azure Log Analytics to monitor the sign-in logs and trigger email and SMS alerts to your admins whenever break-glass accounts sign in.

## Validate accounts regularly

When you train staff members to use emergency access accounts and validate the emergency access accounts, at minimum do the following steps at regular intervals:

 -  Ensure that security-monitoring staff is aware that the account-check activity is ongoing.
 -  Ensure that the emergency break-glass process to use these accounts is documented and current.
 -  Ensure that administrators and security officers who might need to perform these steps during an emergency are trained on the process.
 -  Update the account credentials, in particular any passwords, for your emergency access accounts, and then validate that the emergency access accounts can sign in and perform administrative tasks.
 -  Ensure that users haven't registered multifactor authentication or self-service password reset (SSPR) to any individual user’s device or personal details.
 -  If the accounts are registered for multifactor authentication to a device, for use during sign-in or role activation, ensure that the device is accessible to all administrators who might need to use it during an emergency. Also verify that the device can communicate through at least two network paths that don't share a common failure mode. For example, the device can communicate to the internet through both a facility's wireless network and a cell provider network.

These steps should be performed at regular intervals and for key changes:

 -  At least every 90 days
 -  When there has been a recent change in IT staff, such as a job change, a departure, or a new hire
 -  When the Microsoft Entra subscriptions in the organization have changed
