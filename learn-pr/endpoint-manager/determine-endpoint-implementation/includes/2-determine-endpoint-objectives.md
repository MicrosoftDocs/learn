Organizations use mobile device management (MDM) and mobile application management (MAM) to help control organization data securely, as well as help end users be as productive as possible. When evaluating an MDM/MAM solution such as Microsoft Intune and Configuration Manager, look at the goal and what you want to achieve.

Your objectives for the end users at your organization will likely focus on one or more of the following items:

- Access organizational apps and email
- Secure access on all devices
- Distribute IT
- Keep organization data inside the organization

## Access organizational apps and email

Users expect to work from devices using your organization's apps, including reading and responding to email, updating and sharing data, and more. You must determine the different types of apps your organization uses and needs. To accomplish this objective, start by making a list of the apps your end users regularly use. Also, review the [Microsoft Intune protected apps ](/mem/intune/apps/apps-supported-intune-apps?azure-portal=true). In addition, you can become more familiar with app management overall in [Intune](/mem/intune/apps/app-management?azure-portal=true) and 
[Configuration Manager](/mem/configmgr/apps/understand/introduction-to-application-management?azure-portal=true).

## Secure access on all devices

When data is stored on mobile devices, it should be protected from malicious activity. You must determine how you want to secure your devices and minimize the impact of malicious activity. To accomplish this objective, start by determining what antivirus (AV) and malware, Conditional Access protection, software updates, and authentication you plan to use for both cloud-based devices and on-premises devices.

## Distribute IT

Many organizations want to give different administrators control over locations, divisions, and so on. For example, the **Charlotte IT Administrators** group controls and monitors the policies in the Charlotte office. These Charlotte IT Administrators can only see and manage policies for the Charlotte location. They can't see and manage policies for the Redmond location. This approach is called *distributed IT*. You must determine how you want to distribute your rules and settings (policies and profiles). For related information, check out [Use role-based access control (RBAC) and scope tags for distributed IT](/mem/intune/fundamentals/scope-tags?azure-portal=true).

## Keep organization data inside the organization

When data is stored on mobile devices, the data should be protected from accidental loss or sharing. This objective includes wiping organization data from personal and organization-owned devices. You must create a plan to cover different scenarios that impact your organization. For related information, reference [App protection policies overview](/mem/intune/apps/app-protection-policy?azure-portal=true) in Intune and [Endpoint Protection](/mem/configmgr/protect/deploy-use/endpoint-protection?azure-portal=true) in Configuration Manager.

## Additional information

For more information about each of these objectives, check out [Microsoft Intune planning guide - Determine your objectives](/mem/intune/fundamentals/intune-planning-guide?azure-portal=true#task-1-determine-your-objectives). For specific information about protecting endpoints, reference [Manage endpoint security in Microsoft Intune](/mem/intune/protect/endpoint-security?azure-portal=true), [Endpoint Protection in Configuration Manager](/mem/configmgr/protect/deploy-use/endpoint-protection?azure-portal=true), and [What is Azure Active Directory authentication?](/azure/active-directory/authentication/overview-authentication?azure-portal=true)
