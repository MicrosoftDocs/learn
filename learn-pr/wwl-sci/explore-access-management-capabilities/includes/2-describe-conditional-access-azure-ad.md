
Conditional Access is a feature of Microsoft Entra ID that provides an extra layer of security before allowing authenticated users to access data or other assets. It's Microsoft's Zero Trust policy engine, taking signals from various sources into account when enforcing policy decisions. Conditional Access is implemented through policies that are created and managed in Microsoft Entra ID. At their simplest, Conditional Access policies are if-then statements: *if* a user wants to access a resource, *then* they must complete an action. For example, if a user wants to access Microsoft 365, then they must perform multifactor authentication.

> [!IMPORTANT]
> Conditional Access policies are enforced after first-factor authentication is completed. Conditional Access isn't intended to be an organization's frontline of defense for scenarios like denial-of-service (DoS) attacks, but it can use signals from these events to determine access.

:::image type="content" source="../media/conditional-access.png" alt-text="Screenshot showing Conditional Access policy flow. Signals are used to decide whether to allow or block access to apps and data.":::

### Conditional Access policy components

A Conditional Access policy in Microsoft Entra ID consists of two components: assignments and access controls.

:::image type="content" source="../media/conditional-access-policy-components-v3.png" alt-text="Screen capture showing the two components of a Conditional Access policy, the assignments and the access controls.":::

#### Assignments

Assignments define the who, what, where, and when of a Conditional Access policy. All assignments are logically ANDed—if more than one assignment is configured, all must be satisfied to trigger the policy.

- **Users**. Policies can target all users, specific users and groups, directory roles, external guests, and workload identities. Support for agent identities extends Zero Trust principles to AI workloads.
- **Target resources**. Administrators can target cloud applications (including Microsoft 365 and other Microsoft Entra registered applications), user actions (such as registering security information or registering/joining devices), Global Secure Access traffic profiles, or authentication context to further secure specific data and actions in applications.
- **Network**. Controls user access based on the user's network or physical location. Administrators can include or exclude trusted networks, trusted IP address ranges, named locations, and compliant networks made up of users and devices that comply with the organization's security policies.
- **Conditions**. Multiple conditions can be combined for fine-grained policies:
  - **Sign-in risk and user risk**—integration with Microsoft Entra ID Protection identifies suspicious sign-in activity or compromised accounts and triggers additional verification requirements.
  - **Insider risk**—incorporates risk signals from Microsoft Purview adaptive protection into policy decisions.
  - **Device platform**—targets policies based on the operating system running on the device.
  - **Client apps**—the software used to access cloud apps, including browsers, mobile apps, and desktop clients.
  - **Filters for devices**—targets specific devices based on their attributes, such as privileged access workstations.

#### Access controls

Access controls determine how a Conditional Access policy is enforced once assignments are satisfied. Common decisions include:

- **Block access**—the most restrictive decision, preventing access under the specified conditions.
- **Grant access**—administrators can grant access without additional controls, or require one or more of the following:
  - Require multifactor authentication
  - Require authentication strength
  - Require the device to be marked as compliant
  - Require a Microsoft Entra hybrid joined device
  - Require an approved client app or app protection policy
  - Require a password change
  - Require terms of use
- **Session controls**—enable limited experiences within specific cloud applications. For example, Conditional Access App Control uses signals from Microsoft Defender for Cloud Apps to block download, cut, copy, and print of sensitive documents, or to require labeling of sensitive files. Other session controls include sign-in frequency and application-enforced restrictions.

### Authentication strengths

Authentication strength is a Conditional Access grant control that specifies which combinations of authentication methods users can use to access a resource. Administrators can choose from three built-in authentication strengths or create custom strengths:

- **Multifactor authentication strength**—allows all combinations that satisfy MFA requirements, including a password combined with a secondary factor such as a text message, voice call, push notification, or software/hardware OATH token.
- **Passwordless MFA strength**—limits access to authentication methods that satisfy MFA without requiring a password, such as Microsoft Authenticator (phone sign-in), FIDO2 security keys, Windows Hello for Business, or platform credentials.
- **Phishing-resistant MFA strength**—restricts access to methods that require an interaction between the authentication method and the sign-in surface, including Windows Hello for Business, FIDO2 security keys, and certificate-based authentication (multifactor).

Authentication strengths allow administrators to enforce stronger authentication for sensitive resources while permitting less restrictive methods for everyday access. Administrators can also create custom authentication strengths to define the exact combination of methods allowed for their organization's requirements.

### Protecting AI services

As organizations adopt generative AI services like Microsoft 365 Copilot and Microsoft Security Copilot, Conditional Access policies can protect these services from misuse and unauthorized access. Administrators can create policies that:

- Require users of generative AI services to complete phishing-resistant MFA.
- Require access from a compliant device when insider risk is moderate.
- Block access to AI services when insider risk is elevated.

These protections can be applied through existing policies that target all resources or by targeting specific AI service principals directly, extending the same Zero Trust controls already applied to other enterprise applications.

### Licensing

Conditional Access requires Microsoft Entra ID P1 or P2 licenses. Organizations using the free tier of Microsoft Entra ID can use security defaults to get a baseline level of MFA protection. Security defaults are covered in more detail in the module, [Describe the authentication capabilities of Microsoft Entra ID](/training/modules/explore-authentication-capabilities/).
