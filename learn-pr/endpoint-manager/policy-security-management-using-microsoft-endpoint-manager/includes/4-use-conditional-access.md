By using Intune or Configuration Manager, you help ensure your organization is using proper credentials to access and share company data. 

## Conditional Access with Intune

Intune provides the following types of Conditional Access:

- **Device-based Conditional Access**
  - Conditional Access for Exchange on-premises
  - Conditional Access based on network access control
  - Conditional Access based on device risk
  - Conditional Access for Windows PCs
    - Corporate-owned
    - Bring your own device (BYOD)
- **App-based Conditional Access**

## Conditional Access using co-management

With co-management, Intune evaluates every device in your network to determine how trustworthy it is. It does this evaluation in the following two ways:

1. Intune makes sure a device or app is managed and securely configured. This check depends on how you set your organization's compliance policies. For example, make sure all devices have encryption enabled and aren't jailbroken.  

   - This evaluation is pre-security breach and configuration-based.  

   - For co-managed devices, Configuration Manager also does configuration-based evaluation; for example, required updates or apps compliance. Intune combines this evaluation along with its own assessment.  

1. Intune detects active security incidents on a device. It uses the intelligent security of Microsoft Defender for Endpoint (formerly Microsoft Defender Advanced Threat Protection or Windows Defender ATP) and other mobile threat-defense providers. These partners run ongoing behavioral analysis on devices. This analysis detects active incidents, then passes this information to Intune for real-time compliance evaluation.  

   - This evaluation is post-security breach and incident-based.  

## Common ways to use Conditional Access

You need to configure the related compliance policies to drive Conditional Access compliance at your organization. Conditional Access is commonly used to do things like allow or block access to Exchange, control access to the network, or integrate with a Mobile Threat Defense solution.

### Device-based Conditional Access

Intune and Azure Active Directory work together to make sure only managed and compliant devices can access email, Office 365 services, Software as a service (SaaS) apps, and on-premises apps. Additionally, you can set a policy in Azure Active Directory to only enable domain-joined computers or mobile devices that are enrolled in Intune to access Office 365 services.

Intune provides device compliance policy capabilities that evaluate the compliance status of the devices. The compliance status is reported to Azure Active Directory that uses it to enforce the Conditional Access policy created in Azure Active Directory when the user tries to access company resources.

### Conditional Access based on network access control

Intune integrates with partners like Cisco ISE, Aruba Clear Pass, and Citrix NetScaler to provide access controls based on the Intune enrollment and the device-compliance state.

Users can be allowed or denied access to corporate Wi-Fi or VPN resources based on whether the device they're using is managed and compliant with Intune device compliance policies.

### Conditional Access based on device risk

Intune partners with Mobile Threat Defense vendors that provide a security solution to detect malware, Trojans, and other threats on mobile devices.

#### How the Intune and Mobile Threat Defense integration works

When mobile devices have the Mobile Threat Defense agent installed, the agent sends compliance state messages back to Intune, reporting when a threat is found on the mobile device itself.

The Intune and Mobile Threat Defense integration plays a factor in the Conditional Access decisions based on device risk.

### Conditional Access for Windows PCs

Conditional Access for PCs provides capabilities similar to those available for mobile devices. Let's talk about the ways you can use Conditional Access when managing PCs with Intune.

#### Corporate-owned

- **Hybrid Azure AD joined:** Organizations that are reasonably comfortable with how they're already managing their PCs through AD group policies or Configuration Manager commonly use this option.

- **Azure AD domain joined and Intune management:** This scenario is for organizations that want to be cloud-first (that is, primarily use cloud services, with a goal to reduce use of an on-premises infrastructure) or cloud-only (no on-premises infrastructure). Azure AD Join works well in a hybrid environment, enabling access to both cloud and on-premises apps and resources. The device joins to the Azure AD and gets enrolled to Intune, which can be used as a Conditional Access criteria when accessing corporate resources.

#### Bring your own device (BYOD)

- **Workplace join and Intune management:** Here the user can join their personal devices to access corporate resources and services. You can use Workplace join and enroll devices into Intune MDM to receive device-level policies, which are another option to evaluate Conditional Access criteria.

## App-based Conditional Access

Intune and Azure Active Directory work together to make sure only managed apps can access corporate e-mail or other Office 365 services.
