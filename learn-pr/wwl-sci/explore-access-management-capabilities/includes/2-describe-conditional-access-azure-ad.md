
Conditional Access is a feature of Azure AD that provides an extra layer of security before allowing authenticated users to access data or other assets. Conditional Access is implemented through policies that are created and managed in Azure AD. A Conditional Access policy analyses signals including user, location, device, application, and risk to automate decisions for authorizing access to  resources (apps and data).

> [!NOTE]
> Conditional Access policies are enforced after first-factor authentication is completed. Conditional Access isn't intended to be an organization's first line of defense for scenarios like denial-of-service (DoS) attacks, but it can use signals from these events to determine access.

:::image type="content" source="../media/2-conditional-access-policies.png" alt-text="Conditional Access policies use signals to decide whether to allow or block access":::

A Conditional Access policy might state that *if* a user belongs to a certain group, then they're required to provide multi-factor authentication to sign in to an application.

Watch the video to see how Conditional Access policies work.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4INyI]

## Conditional Access signals

Some of the common signals that Conditional Access can take in to account when making a policy decision may include:

- **User or group membership**. Policies can be targeted to all users, specific groups of users, directory roles, or external guest users, giving administrators fine-grained control over access.
- **Named location information**. Named location information can be created using IP address ranges, and used when making policy decisions. Also, administrators can opt to block or allow traffic from an entire country/region's IP range.
- **Device**. Users with devices of specific platforms or marked with a specific state can be used.
- **Application**. Users attempting to access specific applications can trigger different Conditional Access policies.
- **Real-time sign-in risk detection**. Signals integration with Azure AD Identity Protection allows Conditional Access policies to identify risky sign-in behavior \- the probability that a given sign-in, or authentication request, isn't authorized by the identity owner. Policies can then force users to perform password changes or multi factor authentication to reduce their risk level or be blocked from access until an administrator takes manual action.
- **Cloud apps or user actions**. Conditional Access policies allow administrators to assign controls to all or specific applications or actions. For example, as part of user actions administrators can enforce a Conditional Access policy when users register or join devices to Azure AD.
- **User risk**. For customers with access to Identity Protection, user risk can be evaluated as part of a Conditional Access policy. User risk represents the probability that a given identity or account is compromised. User risk can be configured for high, medium, or low probability.

When creating a conditional access policy, admins can determine which signals to use through assignments. The assignments portion of the policy controls the who, what, and where of the Conditional Access policy.  All assignments are logically ANDed. If you have more than one assignment configured, all assignments must be satisfied to trigger a policy.

 
## Access controls

When the Conditional Access policy has been applied, an informed decision is reached on whether to grant access, block access, or require extra verification. The decision is referred to as the access controls portion of the Conditional Access policy and defines how a policy is enforced. Common decisions are:

- Block access
- Grant access
- Require one or more conditions to be met before granting access:

  - Require multi-factor authentication.
  - Require device to be marked as compliant.
  - Require hybrid Azure AD joined device.
  - Require approved client app.
  - Require app protection policy.
  - Require password change.
- Control user access based on session controls to enable limited experiences within specific cloud applications.  As an example, Conditional Access App Control uses signals from Microsoft Defender for Cloud Apps to block the download, cut, copy, and print capabilities for sensitive documents, or to require labeling of sensitive files.  Other session controls include sign-in frequency and application enforced restrictions that, for selected applications, use the device information to provide users with a limited or full experience, depending on the device state.

Conditional Access policies can be targeted to members of specific groups or guests. For example, you can create a policy to exclude all guest accounts from accessing sensitive resources.
Conditional Access is a feature of paid Azure AD editions.

## Interactive Guide

In this interactive guide, you'll create a Conditional Access policy for a group of users.

[![Interactive guide](../media/2-conditional-access-interactive.png)](https://edxinteractivepage.blob.core.windows.net/edxpages/sc-900/LP02M04-Create-a-Conditional-Access-Policy/index.html?azure-portal=true)
