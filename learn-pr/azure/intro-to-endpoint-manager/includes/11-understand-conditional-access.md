Conditional Access makes sure that only trusted users can access organizational resources on trusted devices using trusted apps. It's built from scratch in the cloud. Whether you're managing devices with Intune or extending your Configuration Manager deployment with co-management, it works the same way.

With Conditional Access, you can control the devices and apps that can connect to your email and company resources. 

Enterprise Mobility + Security (EMS)  is not a standalone product. It's a solution that takes part on all services and products that are part of EMS. Conditional Access provides granular access control to keep your corporate data secure, while giving users an experience that allows them to do their best work from any device, and from any location.

You can define conditions that gate access to your corporate data based on location, device, user state, and application sensitivity.

## Use Conditional Access with Intune

Conditional Access is an Azure Active Directory capability that is included with an Azure Active Directory Premium license. Intune enhances this capability by adding mobile device compliance and mobile app management to the solution. 

![Intune and Conditional Access when using EMS](../media/intune-with-ca.png)

Ways to use Conditional Access with Intune:

- **Device-based Conditional Access**
  - Conditional Access for Exchange on-premises
  - Conditional Access based on network access control
  - Conditional Access based on device risk
  - Conditional Access for Windows PCs
    - Corporate-owned
    - Bring your own device (BYOD)
- **App-based Conditional Access**

<!--
https://docs.microsoft.com/mem/intune/protect/conditional-access
-->

With co-management, Intune evaluates every device in your network to determine how trustworthy it is. It does this evaluation in the following two ways:

1. Intune makes sure a device or app is managed and securely configured. This check depends on how you set your organization's compliance policies. For example, make sure all devices have encryption enabled and aren't jailbroken.  

    - This evaluation is pre-security breach and configuration-based  

    - For co-managed devices, Configuration Manager also does configuration-based evaluation. For example, required updates or apps compliance. Intune combines this evaluation along with its own assessment.  

2. Intune detects active security incidents on a device. It uses the intelligent security of Microsoft Defender Advanced Threat Protection (formerly Windows Defender ATP) and other mobile threat defense providers. These partners run ongoing behavioral analysis on devices. This analysis detects active incidents, and then passes this information to Intune for real-time compliance evaluation.  

    - This evaluation is post-security breach and incident-based  


By using Intune or Configuration Manager, you help ensure your organization is using proper credentials to access and share company data.

## Common ways to use conditional access

There are two types of conditional access with Intune: device-based conditional access and app-based conditional access. You need to configure the related compliance policies to drive conditional access compliance at your organization. Conditional access is commonly used to do things like allow or block access to Exchange, control access to the network, or integrate with a Mobile Threat Defense solution.
 
### Device-based Conditional Access

Intune and Azure Active Directory work together to make sure only managed and compliant devices can access email, Office 365 services, Software as a service (SaaS) apps, and [on-premises apps](https://docs.microsoft.com/azure/active-directory/active-directory-application-proxy-get-started). Additionally, you can set a policy in Azure Active Directory to only enable domain-joined computers or mobile devices that are enrolled in Intune to access Office 365 services.

Intune provides device compliance policy capabilities that evaluate the compliance status of the devices. The compliance status is reported to Azure Active Directory that uses it to enforce the Conditional Access policy created in Azure Active Directory when the user tries to access company resources.

### Conditional access based on network access control

Intune integrates with partners like Cisco ISE, Aruba Clear Pass, and Citrix NetScaler to provide access controls based on the Intune enrollment and the device compliance state.

Users can be allowed or denied access to corporate Wi-Fi or VPN resources based on whether the device they're using is managed and compliant with Intune device compliance policies.

### Conditional access based on device risk

Intune partners with Mobile Threat Defense vendors that provide a security solution to detect malware, Trojans, and other threats on mobile devices.

#### How the Intune and Mobile Threat Defense integration works

When mobile devices have the Mobile Threat Defense agent installed, the agent sends compliance state messages back to Intune reporting when a threat is found on the mobile device itself.

The Intune and mobile threat defense integration plays a factor in the conditional access decisions based on device risk.

### Conditional access for Windows PCs

Conditional access for PCs provides capabilities similar to those available for mobile devices. Let's talk about the ways you can use conditional access when managing PCs with Intune.

#### Corporate-owned

- **Hybrid Azure AD joined:** This option is commonly used by organizations that are reasonably comfortable with how they're already managing their PCs through AD group policies or Configuration Manager.

- **Azure AD domain joined and Intune management:** This scenario is for organizations that want to be cloud-first (that is, primarily use cloud services, with a goal to reduce use of an on-premises infrastructure) or cloud-only (no on-premises infrastructure). Azure AD Join works well in a hybrid environment, enabling access to both cloud and on-premises apps and resources. The device joins to the Azure AD and gets enrolled to Intune, which can be used as a conditional access criteria when accessing corporate resources.

#### Bring your own device (BYOD)

- **Workplace join and Intune management:** Here the user can join their personal devices to access corporate resources and services. You can use Workplace join and enroll devices into Intune MDM to receive device-level policies, which are another option to evaluate conditional access criteria.

## App-based conditional access

Intune and Azure Active Directory work together to make sure only managed apps can access corporate e-mail or other Office 365 services.

### Intune Conditional access for Exchange on-premises

Conditional access can be used to allow or block access to **Exchange on-premises** based on the device compliance policies and enrollment state. When conditional access is used in combination with a device compliance policy, only compliant devices are allowed access to Exchange on-premises.

You can configure advanced settings in conditional access for more granular control such as:

- Allow or block certain platforms.

- Immediately block devices that aren't managed by Intune.

Any device used to access Exchange on-premises is checked for compliance when device compliance and conditional access policies are applied.

When devices don't meet the conditions set, the end user is guided through the process of enrolling the device to fix the issue that is making the device noncompliant.

Conditional access for Exchange on-premises uses hybrid modern authentication from Microsoft 365, a method of identity management that offers secure user authentication and authorization.  

## Benefits of Conditional Access

Every IT team is obsessed with network security. It's mandatory to make sure that every device meets your security and business requirements before accessing your network. With Conditional Access, you can determine the following factors: 
- If every device is encrypted  
- If malware is installed  
- If its settings are updated  
- If it's jailbroken or rooted  

Conditional Access combines granular control over organizational data with a user experience that maximizes worker productivity on any device from any location.

The following video shows how conditional access is integrated into common scenarios that you regularly experience:

> [!VIDEO https://www.youtube.com/embed/A7IrxAH87wc?start=178]

With co-management, Intune can incorporate Configuration Manager's responsibilities for assessing your security standards compliance of required updates or apps. This behavior is important for any IT organization that wants to continue using Configuration Manager for complex app and patch management.

Conditional Access is also a critical part of developing your Zero Trust Network architecture. With Conditional Access, compliant device access controls cover the foundational layers of Zero Trust Network. This functionality is a large part of how you secure your organization in the future.

