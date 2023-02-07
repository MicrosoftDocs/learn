---
uid: learn.wwl.design-identity-security-strategy.secure-access-to-cloud-resources
title: Secure access to cloud resources
description: Secure access to cloud resources
durationInMinutes: 10
---
Cloud applications and the mobile workforce have redefined the security
perimeter. Employees are bringing their own devices and working
remotely. Data is accessed outside the corporate network and shared with
external collaborators such as partners and vendors. Corporate
applications and data are moving from on-premises to hybrid and cloud
environments. Organizations can no longer rely on traditional network
controls for security. Controls need to move to where the data is: on
devices, inside apps, and with partners.

Identities representing people, services, or IoT devices, are the common dominator across today's many [networks](https://aka.ms/ZTNetwork), [endpoints](https://aka.ms/ZTDevices), and [applications](https://aka.ms/ZTApplications). In the Zero Trust security model, they function as a powerful, flexible, and granular way to control access to [data](https://aka.ms/ZTData).

Before an identity attempts to access a resource, organizations must:

- Verify the identity with strong authentication.
- Ensure access is compliant and typical for that identity.
- Follows least privilege access principles.

Once the identity has been verified, we can control that identity's access to resources based on organization policies, ongoing risk
analysis, and other tools.

## Modern access control

A good access control strategy goes beyond a single tactic or technology. It requires a pragmatic approach that embraces the right technology and tactics for each scenario.

Modern access control must meet the productivity needs of the organization, and also be:

* Secure: Explicitly validate the trust of users and devices during access requests, using all available data and telemetry. This configuration makes it more difficult for attackers to impersonate legitimate users without being detected. Also, the access control strategy should focus on eliminating unauthorized escalation of privilege, for example, granting a privilege that can be used to get higher privileges. For more information on protecting privileged access, see Securing privileged access.
* Consistent: Ensure that security assurances are applied consistently and seamlessly across the environment. This standard improves the user experience and removes opportunities for attackers to sneak in through weaknesses in a disjointed or highly complex access control implementation. You should have a single access control strategy that uses the fewest number of policy engines to avoid configuration inconsistencies and configuration drift.
* Comprehensive: Enforcement of access policy should be done as closely to the resources and access pathways as possible. This configuration improves security coverage, and helps security fit smoothly into scenarios and expectations of users. Take advantage of security controls for data, applications, identity, networks, and databases to drive policy enforcement closer to the business assets of value.
* Identity-centric: Prioritize the use of identity and related controls when available. Identity controls provide rich context into access requests, and application context that isn't available from raw network traffic. Networking controls are still important, and sometimes the only available option (such as in operational technology environments), but identity should always be the first choice if available. A failure dialog during application access from the identity layer will be more precise and informative than a network traffic block, making it more likely the user can correct the issue without a costly help desk call.

The enterprise access model shown below is a comprehensive access model based on zero trust. This model addresses all types of access by internal and external users, services, applications, and privileged accounts with administrative access to systems.

:::image type="content" source="../media/privileged-access-over-underlying-planes-popout.png" alt-text="Diagram showing an enterprise access model with privileged access, control plane, management plane and user access." lightbox="../media/privileged-access-over-underlying-planes-popout.png":::

## Identity Zero Trust deployment objectives

Before most organizations start the Zero Trust journey, their approach to identity is problematic in that the on-premises identity provider is
in use, no SSO is present between cloud and on-premises apps, and [visibility](https://aka.ms/ZTCrossPillars) into identity risk is limited.

When implementing an end-to-end Zero Trust framework for identity, we recommend focusing first on these initial deployment objectives:

* [I. Cloud identity federates with on-premises identity systems](/security/zero-trust/deploy/identity#i-cloud-identity-federates-with-on-premises-identity-systems)
* [II. Conditional Access policies gate access and provide remediation activities](/security/zero-trust/deploy/identity#ii-conditional-access-policies-gate-access-and-provide-remediation-activities)
* [III. Analytics improve visibility](/security/zero-trust/deploy/identity#iii-analytics-improve-visibility)

After these are completed, focus on these other deployment objectives:

* [IV. Identities and access privileges are managed with identity governance](/security/zero-trust/deploy/identity#iv-identities-and-access-privileges-are-managed-with-identity-governance)
* [V. User, device, location, and behavior are analyzed in real time to determine risk and deliver ongoing protection](/security/zero-trust/deploy/identity#v-user-device-location-and-behavior-is-analyzed-in-real-time-to-determine-risk-and-deliver-ongoing-protection).
* [VI. Integrate threat signals from other security solutions to improve detection, protection, and response](/security/zero-trust/deploy/identity#vi-integrate-threat-signals-from-other-security-solutions-to-improve-detection-protection-and-response).

## Zero Trust transformation examples

### Typical flat network

:::image type="content" source="../media/zero-trust-azure-active-directory.png" alt-text="Diagram showing the steps within phase 1 of the initial deployment objectives." lightbox="../media/zero-trust-azure-active-directory.png":::

In the beginning most organizations have firewalls at their network ingress/egress points (and other supporting security elements like intrusion detection/prevention, proxies, etc.). Many start with limited (or zero) segmentation of internal traffic. 

This common configuration allowed for direct communication by any device connected to any other device on the network (regardless of trust level or asset sensitivity). While this provided no barriers to productivity, it created significant potential risk where a single compromised device (for example, from successful phishing attack) can readily attack any other resource (often with internal privileged credentials stolen from the compromised device)

The lateral traversal allowed by this de facto ‘architecture’ is frequently the cause for seemingly low impact initial attack vectors (phishing attack, user device compromise, etc.) rapidly become a major incident for many organizations. 

Some organizations (including Microsoft) have implemented dedicated security controls for privileged access – including separate accounts, privileged access workstations (PAWs – https://aka.ms/PAW), and Just in Time (JIT) solutions using privileged identity/access management (PIM/PAM).

### Client security

:::image type="content" source="../media/zero-trust-client-security-transformation.png" alt-text="Diagram showing a Zero Trust transformation with client security." lightbox="../media/zero-trust-client-security-transformation.png":::

The first priority of zero trust is to reduce risk by explicitly validating user and device trust before allowing access to resources.

This is a critically important shift to enable working from anywhere and contain damage of attacks.
Users and devices aren't trusted simply because they're connected to a network. They must prove they're safe (with minimal impact on user experience and productivity). 

The main change to access control architecture is that Managed Devices are given access to cloud and on-premises resources only after they've been explicitly validated (configuration is compliant, computer isn't infected, etc.). This validation against the organization’s policy is performed by conditional access as part of the user’s Azure AD authentication process. 

Other optional elements include:
* Managed Internet - a network that only has trusted and validated devices on it – which can be used for trusted peer to peer communications (for software patch distribution, collaboration tools, and more.) 
* Unmanaged internet - often provided by the organization to enable and increase security visibility into scenarios like guest access, BYOD/partner access, onboarding of new devices, and more. This is comparable to the open internet someone would get at their home, coffee shop, or anywhere else but allows the organization another opportunity to monitor for security activity.
* Privileged Access Workstations (PAWs) Change – Just like user devices shift to cloud management and security, PAWs also shift to this Zero Trust approach to enforce strict policy from Azure AD Conditional Access. These are used to manage business critical assets both in the cloud and on-premises. 

Unmanaged devices are a key security challenge as they make it difficult to assess and remediate security risk. These scenarios typically include employee personal devices, guest devices for customers and partners, and more).

Organizations frequently use a managed virtual desktop to increase security visibility and control for sessions coming through unmanaged devices by providing increased visibility and control. While not as secure as a managed device (which provides end-to-end session visibility), a managed virtual desktop provides significant security improvements. 

This virtual desktop can be provided by a cloud service like Azure Virtual Desktop or Windows 365 and includes endpoint detection and response (EDR) tooling for visibility and control in these scenarios. 

### Network segmentation

:::image type="content" source="../media/zero-trust-network-segment-transformation.png" alt-text="Diagram showing a Zero Trust transformation with network segmentation." lightbox="../media/zero-trust-network-segment-transformation.png":::

Another key element is to identify and isolate high risk devices, often called segmentation.

Segmenting devices into security zones helps reduce the ‘blast radius’ of a major attack (which today includes highly destructive/damaging ransomware attacks). Segmentation can be done in parallel to the other elements and requires restricting access with a complete and consistent set of controls spanning network, identity, application, and other control types.

Because of the high overhead to build and sustain this separation, segmentation is usually reserved for special cases where assets are business critical, difficult to maintain properly, or both. See the other slide for details. As microsegmentation technology matures, this approach will become more practical for more scenarios. 

Microsoft has found that these groupings are most conducive to isolation:
* High Impact IoT/OT – devices that have potential life/safety impact, which includes heating/ventilation/air conditioning (HVAC) systems and other computers that control physical machines or processes. Isolating these systems limits the potential life/safety damage of any given attack. 
* Low Impact IoT/OT – devices that have limited functions with predictable (or zero) access to the corporate IT environment like printers, phone systems, conference room display devices, and similar. Isolating these will severely limit the utility of these as a lateral traversal point during a multi-stage attack
*  Business Critical and/or Legacy Vulnerable Assets – These systems (and data on them) are often highly valued by the organization and attackers (who frequently target them). Isolating these systems makes more difficult for attackers to gain control of them and reduces your overall organizational risk. 

## Identity Zero Trust deployment guide

This guide walks through the steps required to manage identities following the principles of a Zero Trust security framework.

### Cloud identity federates with on-premises identity systems

Azure Active Directory (AD) enables strong authentication, a point of integration for endpoint security, and the core of your user-centric policies to guarantee least-privileged access. Azure AD's Conditional Access capabilities are the policy decision point for access to resources based on user identity, environment, device health, and risk. 

:::image type="content" source="../media/zero-trust-azure-active-directory.png" alt-text="Diagram showing the steps within phase 1 of the initial deployment objectives." lightbox="../media/zero-trust-azure-active-directory.png":::

### Conditional Access policies gate access and provide remediation activities

Azure AD Conditional Access (CA) analyzes signals such as user, device, and location to automate decisions and enforce organizational access policies for the resource. Use CA policies to apply access controls like multifactor authentication (MFA). CA policies allow for prompting users for MFA when needed for security and stay out of users way when not needed.

:::image type="content" source="../media/conditions-controls.png" alt-text="Diagram showing Conditional Access policies in Zero Trust." lightbox="../media/conditions-controls.png":::

Planning your Conditional Access policies in advance and having a set of active and fallback policies is a foundational pillar of your Access
Policy enforcement in a Zero Trust deployment. Take the time to configure your trusted IP locations in your environment. Even if they
are not used in a Conditional Access policy, configuring these IPs informs the risk of Identity Protection mentioned above.

### Analytics improve visibility

As you build your estate in Azure AD with authentication, authorization, and provisioning, it's important to have strong operational insights
into what is happening in the directory.

To configure your logging and reporting to improve visibility, take this step: [Plan an Azure AD reporting and monitoring deployment](/azure/active-directory/reports-monitoring/plan-monitoring-and-reporting) to be able to persist and analyze logs from Azure AD, either in Azure or using a SIEM system of choice.

### Identities and access privileges are managed with identity governance

Once the initial three objectives are accomplished, focus on additional
objectives such as more robust identity governance.

:::image type="content" source="../media/more-robost-identity-governance.png" alt-text="Diagram showing more robust identity governance." lightbox="../media/more-robost-identity-governance.png":::

### User, device, location, and behavior are analyzed in real time to determine risk and deliver ongoing protection

Real-time analysis is critical for determining risk and protection.

:::image type="content" source="../media/real-time-analysis.png" alt-text="Diagram showing real time media analysis." lightbox="../media/real-time-analysis.png":::

### Integrate threat signals from other security solutions to improve detection, protection, and response

Finally, other security solutions can be integrated for greater effectiveness.

Integration with Microsoft Defender for Identity enables Azure AD to know that a user is indulging in risky behavior while accessing on-premises, non-modern resources (like file shares). This can then be factored into overall user risk. High user risk might lead to blocking further access in the cloud.