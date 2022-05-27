### Secure Access to Cloud Resources

Cloud applications and the mobile workforce have redefined the security
perimeter. Employees are bringing their own devices and working
remotely. Data is accessed outside the corporate network and shared with
external collaborators such as partners and vendors. Corporate
applications and data are moving from on-premises to hybrid and cloud
environments. Organizations can no longer rely on traditional network
controls for security. Controls need to move to where the data is: on
devices, inside apps, and with partners.

Identities representing people, services, or IoT devices, are the common
dominator across today\'s
many [networks](https://aka.ms/ZTNetwork), [endpoints](https://aka.ms/ZTDevices),
and [applications](https://aka.ms/ZTApplications). In the Zero Trust
security model, they function as a powerful, flexible, and granular way
to control access to [data](https://aka.ms/ZTData).

Before an identity attempts to access a resource, organizations must:

-   Verify the identity with strong authentication.

-   Ensure access is compliant and typical for that identity.


-   Follows least privilege access principles.

Once the identity has been verified, we can control that identity\'s
access to resources based on organization policies, ongoing risk
analysis, and other tools.

**Identity Zero Trust deployment objectives**

Before most organizations start the Zero Trust journey, their approach
to identity is problematic in that the on-premises identity provider is
in use, no SSO is present between cloud and on-premises apps,
and [visibility](https://aka.ms/ZTCrossPillars) into identity risk is
very limited.
| When implementing an end-to-end Zero Trust framework for identity, we recommend to focus first on these initial deployment objectives: |                                                                                                                     |
|----------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
|                                                                                                                                       ![check](media\check.png) | [I. Cloud identity federates with on-premises identity systems](https://docs.microsoft.com/security/zero-trust/deploy/identity#i-cloud-identity-federates-with-on-premises-identity-systems).                                                      |
|                                                                                                                                       ![check](media\check.png) | [II. Conditional Access policies gate access and provide remediation activities](https://docs.microsoft.com/security/zero-trust/deploy/identity#ii-conditional-access-policies-gate-access-and-provide-remediation-activities).                                     |
|                                                                                                                                        ![check](media\check.png)| [III. Analytics improve visibility](https://docs.microsoft.com/security/zero-trust/deploy/identity#iii-analytics-improve-visibility).                                                                                  |
| After these are completed, focus on these additional deployment objectives:                                                            |                                                                                                                     |
|                                                                                                                                       ![check](media\check.png) | [IV. Identities and access privileges are managed with identity governance](https://docs.microsoft.com/security/zero-trust/deploy/identity#iv-identities-and-access-privileges-are-managed-with-identity-governance).                                          |
|                                                                                                                                       ![check](media\check.png) | [V. User, device, location, and behavior are analyzed in real time to determine risk and deliver ongoing protection](https://docs.microsoft.com/security/zero-trust/deploy/identity#v-user-device-location-and-behavior-is-analyzed-in-real-time-to-determine-risk-and-deliver-ongoing-protection). |
|                                                                                                                                       ![check](media\check.png) | [VI. Integrate threat signals from other security solutions to improve detection, protection, and response](https://docs.microsoft.com/security/zero-trust/deploy/identity#vi-integrate-threat-signals-from-other-security-solutions-to-improve-detection-protection-and-response).          |

**Identity Zero Trust deployment guide**

This guide walks through the steps required to manage identities
following the principles of a Zero Trust security framework.
|![check](media\check.png) | Initial deployment objectives |
|--|-------------------------------|

**I. Cloud identity federates with on-premises identity systems**

Azure Active Directory (AD) enables strong authentication, a point of
integration for endpoint security, and the core of your user-centric
policies to guarantee least-privileged access. Azure AD\'s Conditional
Access capabilities are the policy decision point for access to
resources based on user identity, environment, device health, and
risk---verified explicitly at the point of access. We will show how to
implement a Zero Trust identity strategy with Azure AD.

![Diagram of the steps within phase 1 of the initial deployment
objectives.](media\ZeroTrustwithAzureAD.png) 

**II. Conditional Access policies gate access and provide remediation
activities**

Azure AD Conditional Access (CA) analyzes signals such as user, device,
and location to automate decisions and enforce organizational access
policies for the resource. Use CA policies to apply access controls like
multi-factor authentication (MFA). CA policies allow for prompting users
for MFA when needed for security and stay out of users way when not
needed.

![Diagram of Conditional Access policies in Zero
Trust.](media\ConditionsControls.png) 

Planning your Conditional Access policies in advance and having a set of
active and fallback policies is a foundational pillar of your Access
Policy enforcement in a Zero Trust deployment. Take the time to
configure your trusted IP locations in your environment. Even if they
are not used in a Conditional Access policy, configuring these IPs
informs the risk of Identity Protection mentioned above.

**III. Analytics improve visibility**

As you build your estate in Azure AD with authentication, authorization,
and provisioning, it's important to have strong operational insights
into what is happening in the directory.

**Configure your logging and reporting to improve visibility**

Take this step:

-   [Plan an Azure AD reporting and monitoring
deployment](https://docs.microsoft.com/azure/active-directory/reports-monitoring/plan-monitoring-and-reporting) to
 be able to persist and analyze logs from Azure AD, either in Azure
or using a SIEM system of choice.

|![check](media\check.png) | Initial deployment objectives |
|--|-------------------------------|

**IV. Identities and access privileges are managed with identity
governance**

Once the initial three objectives are accomplished, focus on additional
objectives such as more robust identity governance.

![More robost identity governance](.//media\MoreRobostIdentityGovernance.png) 
**V. User, device, location, and behavior are analyzed in real time to
determine risk and deliver ongoing protection**

Real-time analysis is critical for determining risk and protection.

![Real time media analysis](media\realTimeAnalysis.png) 

**VI. Integrate threat signals from other security solutions to improve
detection, protection, and response**

Finally, other security solutions can be integrated for greater
effectiveness.

**Integrate Microsoft Defender for Identity with Microsoft Defender for
Cloud Apps**

Integration with Microsoft Defender for Identity enables Azure AD to
know that a user is indulging in risky behavior while accessing
on-premises, non-modern resources (like File Shares). This can then be
factored into overall user risk to block further access in the cloud.


