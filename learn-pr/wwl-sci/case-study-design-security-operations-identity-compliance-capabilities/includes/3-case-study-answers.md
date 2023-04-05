This unit presents an analysis of the scenario and possible answers to the conceptual and technical questions from the case study.

## A summary of the architect's analysis of the background scenario

The current state of the customer's environment exemplifies the traditional, on-premises approach to authentication, authorization, and identity management. Contoso is operating entirely on-premises. Since the majority of its infrastructure is running Windows-based workloads, the majority of the servers are Active Directory domain joined. The Active Directory environment consists of a multi-domain forest with the domain controllers running Windows Server 2019 and the forest functional level set to Windows Server 2016. The majority of line-of-business applications are web-based. While some of them have been designed to support modern authentication, there are a few that rely on Kerberos to authenticate and authorize access to back-end resources. 

The existing, on-premises centric model impedes Contoso's plans to expand their business through partnerships with other financial institutions such as Fabrikam Banking, which has already integrated its AD DS environment with Azure Active Directory (Azure AD). Contoso intends to provide Fabrikam Banking with access to its internal Windows-based web applications that could supplement the existing Fabrikam Banking products. 

Another challenge that Contoso struggles with is increased mobility of its workforce. To accommodate the shift driven by the raising real estate costs and the impact of the pandemic, the company is planning to transition to a flexible work arrangement, allowing its employees to work remotely using corporate-owned or personal devices. The current operating model based on point-to-site VPN and DirectAccess technologies is considered as a security risk by Contoso’s Information Security (InfoSec) team, and must be replaced by a strategic solution which would adhere to the Zero Trust principles.

The strategy formulated by Contoso's Information Technology management team that involves transitioning its operations into a more internet-open model is expected to support a mobile workforce, enable integration with business partners, and enhancing existing security controls. Considering the significant presence of Microsoft technologies in the current environment, choosing Azure AD as the foundation of the future architecture offers the optimal path for the planned transition.

The choice of Azure AD will facilitate addressing the customer's requirements, including step-up authentication and per-application permissions, based not only on the properties of users' accounts but also on the state of these users' devices. Azure AD can also aid in implementing a range of Zero Trust principles, including restricting persistent assignments of privileged roles for identity and access management, as well as monitoring, auditing, and reviewing privileged account usage. In addition, it will provide a straightforward path toward integration with business partners such as Fabrikam Banking.

## A summary of the architect's analysis of the design requirements

### Ensure that remote users can sign in to their devices using their Active Directory credentials without relying on VPN or DirectAccess.

Contoso should integrate their on-premises AD DS environment with Azure AD and have remote users join their devices to Azure AD. Azure AD join supports hybrid environments, enabling access to both cloud and on-premises apps and resources. Users sign in to Azure AD joined devices by using their organizational Azure AD credentials. With the integration between on-premises AD DS and Azure AD, these credentials are identical in both environments. Access to resources can be controlled based on Azure AD account and Conditional Access policies applied to the device.

### Enforce user sign-in hours and password policies defined in on-premises AD DS domains.

The ability to enforce user sign-in hours and password policies defined in on-premises AD DS domains when authenticating to Azure AD in hybrid scenarios is determined by the authentication method setting of the Azure AD Connect component. This is one of the first decisions that Contoso will need to make when implementing Azure AD Connect. Authentication is critical, because it will validate user's identities to access apps and data in the cloud. 

Aside from federation, which requires additional infrastructure, Azure AD Connect supports two authentication options:

- Password hash synchronization (PHS), which replicates password hashes from AD DS domains to the corresponding Azure AD tenant, allowing users to use the same credentials that they use on-premises without having to deploy any additional infrastructure besides Azure AD Connect.
- Pass-through authentication (PTA) which eliminates the need to replicate password hashes, but instead validates users' credentials by forwarding authentication requests from Azure AD to on-premises software agents with direct connectivity to AD DS Domain Controllers. The on-premises agents request validation by contacting AD DS Domain Controllers and, once the validation is completed, send responses back to Azure AD. The communication between the agents and Azure AD is initiated outbound so it doesn't involve opening any inbound ports. 

When authenticating to cloud-based resources by using PHS, Azure AD handles the authentication requests. Since Azure AD does not natively support enforcing sign-in hours or enforcement of password policies defined in AD DS, these requirements imply the use of PTA.

### Simplify user sign-in experience by minimizing the number of sign-in prompts and limiting the use of passwords in lieu of more secure authentication methods.

Azure AD's seamless single sign-on (SSO) simplifies cloud-based authentication for users signed-in to their Azure AD-joined or hybrid Azure AD-joined devices connected to their corporate network. When enabled, users don't need to provide their passwords multiple times to access on-premises or cloud resources. Seamless SSO can be combined with either the PHS or PTA sign-in methods.

Azure AD-joined and hybrid Azure AD-joined devices also support passwordless authentication, which eliminates the need for the use of traditional, password-based credentials. Microsoft provides three passwordless authentication options that integrate with Azure AD:

- Microsoft Authenticator turns any iOS or Android phone into a strong, passwordless credential by allowing users to sign into any platform or browser.
- FIDO2-compliant security keys are useful for highly privileged identities, situations where use of phones is restricted, and users who sign in to shared machines such as kiosks.
- Windows Hello for Business is best for users working on dedicated Windows computers.

### In situations where passwords are required, promptly identify and remediate events of password misuse or exposure.

The Azure AD Premium Identity Protection includes support for detection, reporting, and remediation of leaked credentials. It is important to note that, in hybrid scenarios, this feature of Identity Protection requires PHS, regardless of the choice of the authentication method when configuring Azure AD Connect. This implies that Contoso will need to implement PTA as their authentication method and, at the same time, enable PHS.

### Allow designated members of the IT staff to temporarily elevate their privileges for delegated identity and resource management. All elevation events must be approved and audited. The list of designated members and their respective privileges must be reviewed on a regular basis. 

Contoso should implement Azure AD Privileged Identity Management (PIM) to manage, control, and monitor access to its organizational assets. These assets include Azure AD applications, Azure resources, and other Microsoft online services such as Microsoft 365 or Intune. 

PIM offers time-based and approval-based role activation to mitigate the risks of excessive, unnecessary, or misused access permissions on resources that you care about. Some of the key capabilities of PIM include:

- Providing just-in-time privileged access to Azure AD and Azure resources.
- Assigning time-bound access to resources.
- Requiring an approval to activate privileged roles.
- Enforcing multifactor authentication to activate any role.
- Including justifications as mandatory elements of an elevation request.
- Generating notifications when privileged roles are activated.
- Triggering access reviews to validate whether users still need the ability to use roles.
- Maintaining audit history for internal or external audit.

### Control access to applications and resources by relying on a combination of multiple conditions, including users' group membership, state of their devices, and dynamically evaluated risk based on heuristics and globally collected security-related telemetry.

In order to control access to applications and resources by relying on a combination of multiple conditions, including users' group membership, state of their devices, and dynamically evaluated risk based on heuristics and globally collected security-related telemetry, Contoso will need to implement Azure AD Conditional Access and Microsoft Intune. 

Azure AD Conditional Access is at the heart of the new identity-driven control plane. Its implementation involves creating a collection of policies. Each policy is a conditional if-then statement, which evaluates a condition you specify to decide whether access to an Azure AD-protected resources should be granted or denied. Conditions rely on so-called signals. The most common signals include:

- User or group membership
- IP location information
- Device state
- Application
- Real-time and calculated risk detection
- Microsoft Defender for Cloud Apps

The most common decisions include:

- Block access
- Grant access
- Grant access but make it contingent on additional provisions such as multifactor authentication, device compliance, the use of a hybrid Azure AD joined device, or requesting access to a specific application only.

For example, Contoso would be able to restrict cloud applications access to users signed-in to compliant Azure AD or hybrid Azure AD-joined devices. Device compliance would be determined by Intune policies controlled by the InfoSec team. 

### Provide Contoso's remote users with access to on-premises Windows-based web applications that rely on Kerberos authentication.

Contoso should implement Azure AD Application Proxy, which provides secure remote access to on-premises web applications. After a SSO to Azure AD, users can access both cloud and on-premises applications through an external URL or an internal application portal. For example, Application Proxy can provide remote access and SSO to SharePoint, Teams, and line of business applications.

Application Proxy works with:

- Web applications that use Integrated Windows authentication for authentication.
- Web applications that use form-based or header-based access.
- Web APIs that you want to expose to rich applications on different devices.
- Applications hosted behind a Remote Desktop Gateway.
- Rich client apps that are integrated with the Microsoft Authentication Library (MSAL).

### Provide users of Fabrikam Banking with access to on-premises and cloud-based applications in a tightly controlled manner, with management delegated to the application owners.

Contoso should leverage Azure AD entitlement management to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration. Entitlement management facilitates management of access to groups, applications, and SharePoint online sites for both internal and external users. 

Some of the more important capabilities of entitlement management include:

- Controlling who can get access to applications, groups, Teams, and SharePoint sites, with multi-stage approvals.
- Ensuring that users don't retain access indefinitely by relying on time-limited assignments and recurring access reviews.
- Automating access assignments based on users' properties such as department or cost center, and automatically revoking access when those properties change.
- Delegating to non-administrative users the ability to create access packages. Such access packages contain resources that other users can request. Access package settings include policies with rules that determine eligible users who can submit access requests, the corresponding approvers, and the access expiration behavior.
- Selecting connected organizations which users can request access. When external users without guest accounts in the local tenant request access, and that request is approved, they're automatically invited into the local tenant and assigned access. When their access expires, if they have no other access package assignments, their guest accounts in the local tenant can be automatically removed.

## Answers to each conceptual question

### What is the mechanism for integrating AD DS and Azure AD?

Integration between AD DS and Azure AD is implemented by using Azure AD Connect, which is an application you install on a Windows server with direct connectivity to AD DS Domain Controllers and outbound access to Azure AD. The main component of Azure AD Connect is its synchronization service. Its purpose is to synchronize identity data between the two identity providers. 

It is important to note that Microsoft also offers Azure AD Connect Cloud Sync, which uses a different approach while providing a subset of features of Azure AD Connect. When using Azure AD Connect Cloud Sync, you install Azure AD Cloud provisioning agent on a Windows server with a direct connection to a domain controller. The synchronization service runs in Azure AD. 

### Which authentication methods are available when integrating AD DS and Azure AD?

As mentioned earlier, Azure AD Connect supports PHS, PTA and federated authentication. 

### What are primary Azure AD device identity options?

An Azure AD device identity is an object representing a physical or virtual device that has the ability to authenticate to Azure AD. This is conceptually equivalent to an Azure AD user object representing a person who can sign-in to Azure AD. A device identity allows administrators to control device access and configuration by leveraging cloud-based services.

There are three ways to implement a device identity:

- Azure AD registration
- Azure AD join
- Hybrid Azure AD join

Device identity is a prerequisite for scenarios such as device-based Conditional Access policies and MDM solutions such as Intune.

### Which Azure AD services contribute to enhanced security in hybrid scenarios?

Azure AD offers a range of services that contribute to enhanced security in hybrid scenarios, including:

- Azure AD Identity Protection - It includes support for detection, reporting, and remediation of leaked credentials, including those defined in AD DS, as long as PHS is enabled.
- Azure AD Application Proxy - It provides secure remote access to on-premises web applications. Effectively, users can access your on-premises applications the same way they access Microsoft 365 and other SaaS apps integrated with Azure AD. There is no need to change or update your applications to work with Application Proxy. On-premises applications can use Azure AD-based authorization controls and security analytics. For example, on-premises applications can use Conditional Access and two-step verification. Application Proxy doesn't require opening inbound connections on the firewalls on the corporate edge network.
- Azure AD Conditional Access - It can be applied to hybrid Azure AD joined devices in order to enforce device compliance-based conditions. It can also be applied to Azure AD joined and Azure AD registered devices when controlling access to on-premises applications by using Azure AD Application Proxy.

### What are the AD DS-specific benefits provided by Azure AD in hybrid scenarios?

Users often create passwords that use common local words such as a school, sports team, or famous person. These passwords are easy to guess and vulnerable to dictionary-based attacks. To enforce strong passwords in your organization, Azure AD Password Protection provides a global and custom banned password list. A password change request fails if there's a match in these banned password lists. 

Azure AD Password Protection detects and blocks known weak passwords and their variants, and can also block additional weak terms that are specific to your organization. On-premises deployment of Azure AD Password Protection uses the same global and custom banned password lists that are stored in Azure AD, and performs the same checks for on-premises password changes as Azure AD does for cloud-based changes. These checks take place during password changes and password reset events against on-premises Active Directory domain controllers.

### Are there any Microsoft 365 Defender services that help enhance identity protection in hybrid scenarios?

Microsoft Defender for Identity is a cloud-based security solution included in the Microsoft 365 Defender product suite that leverages AD DS signals to identify, detect, and investigate advanced threats, compromised identities, and malicious insider actions directed at your AD DS domain environments.

Defender for Identity enables SecOps analysts and security professionals struggling to detect advanced attacks in hybrid environments to:
- Monitor users, entity behavior, and activities with learning-based analytics.
- Protect user identities and credentials stored in Active Directory.
- Identify and investigate suspicious user activities and advanced attacks throughout the kill chain.
- Provide clear incident information on a simple timeline for fast triage.

 Defender for Identity integrates with Defender for Cloud Apps, which provides user entity behavioral analytics (UEBA) across a hybrid environment for both cloud and on-premises apps. After enabling the integration, you'll be able to use Defender for Cloud Apps to track on-premises activities for all the users in your organization. You will also gain access to advanced insights into your users that combine alerts and suspicious activities across your cloud and on-premises environments. 

In addition, Defender for Identity integrates with Microsoft Defender for Endpoint. Defender for Endpoint protects endpoints from cyber threats, detects advanced attacks and data breaches, automates security incidents, and improves security posture. The integration between the two products provides the flexibility of conducting cyber security investigation across activities and identities, delivering more insights into suspicious activities running in a user security context. 

### Is there a way to provide access to on-premises web-based applications that rely on Kerberos authentication without the need for allowing inbound connectivity? 

Azure AD Application Proxy provides secure remote access to on-premises web applications. You can provide SSO for on-premises applications published through Application Proxy that are secured with integrated Windows authentication. These applications require a Kerberos ticket for access. Application Proxy uses Kerberos Constrained Delegation (KCD) to support these applications. As with other Azure AD Application Proxy scenarios, this doesn't require opening inbound connections on the firewalls on the corporate edge network.

### Which Azure AD services provide secure delegated identity and resource management?

Azure AD Privileged Identity Management (PIM) offers the ability to manage, control, and monitor access to organizational assets. These assets include Azure AD applications, Azure resources, and other Microsoft Online services such as Microsoft 365 or Intune. Some of the key capabilities of Privileged Identity Management include:

- Providing just-in-time privileged access to Azure AD and Azure resources.
- Assigning time-bound access to resources.
- Requiring an approval to activate privileged roles.
- Enforcing multi-factor authentication to activate any role.
- Including justifications as mandatory elements of an elevation request.
- Generating notifications when privileged roles are activated.
- Triggering access reviews to validate whether users still need the ability to use roles.
- Maintaining audit history for internal or external audit.

### Which Azure AD services facilitate delegated access to Azure AD applications in business-to-business scenarios?

Azure AD entitlement management facilitates delegated access to Azure AD applications for both internal and external users. This is accomplished by automating access request workflows, access assignments, reviews, and expiration. Some of the more important capabilities of entitlement management include:

- Controlling who can get access to applications, groups, Teams and SharePoint sites, with multi-stage approvals.
- Ensuring that users don't retain access indefinitely by relying on time-limited assignments and recurring access reviews.
- Automating access assignments based on users' properties such as department or cost center, and automatically revoking access when those properties change.
- Delegating to non-administrative users the ability to create access packages. Such access packages contain resources that other users can request. Access package settings include policies with rules that determine eligible users who can submit access requests, the corresponding approvers, and the access expiration behavior.
- Selecting connected organizations to which users can request access. When external users without guest accounts in the local tenant request access, and that request is approved, they're automatically invited into the local tenant and assigned access. When their access expires, if they have no other access package assignments, their guest accounts in the local tenant can be automatically removed.

## Answers to each design question

### Which hybrid authentication method or methods would you recommend to address the security needs of Contoso?

Contoso's InfoSec team's requirement regarding the ability to enforce on-premises Active Directory user account restrictions, such as allowed sign-in hours, combined with the need to detect leaked passwords will drive the choice of the hybrid authentication method. In hybrid scenarios that involve the use of Azure AD Connect, in order to ensure that Active Directory user account sign-in hours are honored, Contoso should implement PTA. However, the requirement to leverage the Identity Protection functionality which detects leaked passwords requires enabling PHS. Fortunately, these two options can be combined. In particular, PHS can be enabled while using PTA as the authentication method when configuring Azure AD Connect. In addition, Contoso should enable multi-factor authentication for all of its users and, whenever possible, implement passwordless authentication. Any external legacy authentication methods should be disabled by leveraging Conditional Access policies.

### Which device identity option or options would you recommend for Contoso's remote users?

Contoso should integrate their on-premises AD DS environment with Azure AD and have remote users join their devices to Azure AD. Azure AD join supports hybrid environments, enabling access to both cloud and on-premises apps and resources. Users sign in to Azure AD joined devices by using their organizational Azure AD credentials. With the integration between on-premises AD DS and Azure AD, these credentials are identical in both environments. Access to resources can be controlled based on Azure AD Conditional Access policies applied to the device and the authenticating user.

Contoso administrators can secure and further control Azure AD joined devices by using a Mobile Device Management (MDM) service, such as Intune. MDM services provide means to enforce organization-defined device configurations, including disk encryption, software installations, and software updates. Intune includes support for a wide range of policies that help apply and evaluate device compliance. It also offers integration with Defender for Endpoint as a Mobile Threat Defense solution. Integrating Intune with Defender for Endpoint will allow the customer to take advantage of the Threat & Vulnerability Management functionality of Defender for Endpoints, and use Intune to remediate detected vulnerabilities and threats.

### Which Azure AD services would allow Contoso to enhance security of their on-premises AD DS environment?

The InfoSec team of Contoso wants to leverage Azure AD capabilities to enhance Active Directory password policies by preventing the use of common terms within password values. To accomplish this, Contoso should implement Azure AD Password Protection for AD DS. Azure AD Password Protection detects and blocks known weak passwords and their variants, and can also block additional weak terms that are specific to your organization. On-premises deployment of Azure AD Password Protection uses the same global and custom banned password lists that are stored in Azure AD, and performs the same checks for on-premises password changes as Azure AD does for cloud-based changes. These checks take place during password changes and password reset events against on-premises Active Directory domain controllers.

In addition, when providing access to on-premises web applications to its remote users and Fabrikam Banking users, Contoso will be able to leverage Azure AD Application Proxy. With Azure AD Application Proxy, after a SSO to Azure AD, users and guests will be able to access on-premises applications through an external URL or an internal application portal. 

### Which Microsoft 365 Defender services would allow Contoso to enhance security of their on-premises AD DS environment? 

Contoso will be able to take advantage of Defender for Identity in order to enhance security of their on-premises AD DS environment. By installing Defender for Identity sensors on their on-premises domain controllers, they will be able to identify, detect, and investigate advanced threats, compromised identities, and malicious insider actions directed at their AD DS-based environment.

Defender for Identity will benefit the SecOps team of Contoso by assisting with the following tasks:

- Monitoring users, entity behavior, and activities, including machine learning-based analytics.
- Protecting identities hosted in the on-premises AD DS environment.
- Identifying and investigating suspicious user activities and advanced attacks throughout the kill chain.
- Providing clear incident information on a simple timeline for fast triage.

In addition, Contoso will be able to take advantage of the integration between Defender for Identity and Defender for Cloud Apps and Defender for Endpoint. 
The integration with Defender for Cloud Apps provides user entity behavioral analytics across a hybrid environment for both cloud and on-premises apps. The SecOps team will be able to use Defender for Cloud Apps to track on-premises activities for all Contoso users. They will also gain access to advanced insights into their users’ behavior through a combined view of alerts and suspicious activities across the cloud and on-premises environments. 
The integration with Defender for Endpoint will provide the ability to conduct cyber security investigation across activities and identities, delivering more insights into suspicious activities running in a user security context.

### How would you leverage Azure AD capabilities to provide access to the on-premises web-based applications?

To provide access to their on-premises web-based applications, Contoso should implement Azure AD Application Proxy. After a SSO to Azure AD, users can access both cloud and on-premises applications through an external URL or an internal application portal. This approach eliminates the need to change or update applications. In addition, access to on-premises applications involves the use of Azure AD-based authorization controls and security analytics. In particular, Contoso will be able to enforce the use of Conditional Access and two-step verification. In addition, access can be further restricted based on the user's device compliance state, as determined by Intune policies controlled by the InfoSec team. 

### What mechanism would you use for delegated identity and resource management?

Azure AD entitlement management will allow Contoso to facilitate management of access to applications for both internal and external users, including such features as:

- Controlling who can get access to web applications, with multi-stage approvals.
- Ensuring that internal and external users don't retain access indefinitely by relying on time-limited assignments and recurring access reviews.
- Automating access assignments based on users' properties such as department or cost center, and automatically revoking access when those properties change.
- Delegating to non-administrative users the ability to create access packages. Such access packages contain resources that other users can request. Access package settings include policies with rules that determine eligible users who can submit access request, the corresponding approvers, and the access expiration behavior.
- Selecting Fabrikam Banking users that can request access to internal applications. When Fabrikam Banking users without guest accounts in Contoso tenant request access, and that request is approved, they will be automatically invited into Contoso tenant and assigned access. When their access expires, if they have no other access package assignments, their guest accounts in Contoso tenant can be automatically removed.

### How does the proposed solution reflect the use of the Zero Trust principles of verify explicitly, use least privilege access, and assume breach?

The proposed solution reflects the use of the foundational Zero Trust principles, including verify explicitly, use least privilege access, and assume breach. 

The verify explicitly principle is implemented by enforcing strong authentication through Azure AD Conditional Access with gated and session-based policies. Azure AD multifactor and passwordless authentication methods serve in this case as the essential components of identity-based protection strategy, minimizing or eliminating the risk of phishing and password attacks. As users appear on new devices or from new locations, they will be forced to validate their identity based on the policies Contoso defines. This approach should be supplemented by blocking legacy authentication for all access. One of the most common attack vectors for malicious actors is to use stolen/replayed credentials against legacy protocols, such as SMTP, that don't support modern security challenges. In situations where the use of Active Directory passwords-based credentials is still required, Azure AD Password Protection can help enforce their complexity, minimizing the potential impact of spray attacks. 

The use least privilege access principle is implemented by ensuring that access is required as defined by each individual user's roles. To accomplish this, Contoso relies on Azure AD PIM and Azure AD entitlement management. Contoso can take advantage of entitlement management access packages to allow internal and external users to request permissions to Azure AD-protected resources on an as-needed basis. 

The assume breach principle is delivered by a combination of integrated security-focused services, including Intune, Defender for Endpoint, Defender for Identity, and Defender for Cloud Apps. Intune targets Azure AD-joined remote devices in order to ensure their compliance with the organization's security standards. Its integration with Defender for Endpoint delivers Mobile Threat Defense functionality. Defender for Cloud Apps integrates natively with Defender for Endpoint. This integration facilitates device-based investigations. These investigations are further aided by Azure AD sign-in and audit logs, which collect and store all relevant authentication and identity management-related events. Azure AD Identity Protection helps identify emerging risks through its integration with Conditional Access. This includes the ability to apply session controls through integration between Azure AD Identity Protection and Defender for Cloud Apps. Integration between Defender for Cloud Apps and Defender for Identity enables Azure AD to detect when a user is engaging in a risky behavior while accessing on-premises resources such as file shares. This can serve as a factor when deciding whether that user should be granted access to cloud-based resources.