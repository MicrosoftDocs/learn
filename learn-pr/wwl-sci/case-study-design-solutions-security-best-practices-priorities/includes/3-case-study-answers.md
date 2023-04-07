This unit presents an analysis of the scenario and possible answers to the conceptual and technical questions from the case study.

## A summary of the architect's analysis of the background scenario

The current state of Contoso’s environment exemplifies the traditional, on-premises architecture, with file, messaging, and backup servers hosted within the customer's own datacenter. File servers store various business data, including confidential customer records and contracts, frequently updated marketing information, and large amounts of historical content that must be retained for compliance purposes. Customer records and contracts are created by using Microsoft Office products, marketing information is typically stored in the Adobe Acrobat format, and historical content is commonly compressed as ZIP-based archives.

All data is hosted on file servers running Windows Server 2016, using both local and iSCSI attached devices. Storage devices are close to reaching their capacity. Backups are implemented by using several tape libraries, which are approaching their end-of-life. The operational team handling backups found them to be relatively unreliable due to frequently failing restores and data corruption issues. To remediate these issues, users commonly maintain multiple copies of the same data across different file servers. Unfortunately, this further exacerbates the storage capacity issues.

Another challenge that negatively affects the security of Contoso’s digital assets is the use of personal devices for VPN connectivity to the main office by remote insurance sales staff. The lack of oversight of the remote devices has been assessed by the company's Information Security (InfoSec) team as a significant vulnerability. This assessment was proven fully justified by a recent incident that involved a malware transmitted through the company's on-premises Microsoft Exchange email. The malware managed to compromise one of the privileged Active Directory Domain Services (AD DS) accounts and attempted to encrypt data on one of the file servers. This attempt was detected and blocked by the Microsoft Defender Antivirus running on all of the company owned Windows computers, but prompted Contoso’s CIO to start considering a cloud-based strategy for data storage and protection.

Embracing the cloud-first approach is bound to significantly enhance the customer's security posture, providing a range of options that offer various ransomware protection measures, including short- and long-term data storage. It will also address the vulnerabilities associated with the use of unmanaged personal devices for remote access to on-premises file servers. Considering the significant presence of Microsoft technologies in the current environment, choosing Microsoft 365, Microsoft Azure, and Microsoft Azure Active Directory (Azure AD) as the foundation of the future architecture offers the optimal path for the planned transition.

However, besides addressing the technical aspects of the transition plan, it is equally important to align the data protection plan with business priorities. For this, Contoso’s information technology (IT) team needs to engage all relevant stakeholders and ensure their feedback is taken into account in the final design. This design must also adhere to the principles of Zero Trust and also, whenever applicable, incorporate guidance provided by Microsoft Cloud Adoption Framework for Azure and Microsoft Azure Well-Architected Framework.


## A summary of the architect's analysis of the design requirements

### Minimize the footprint of on-premises storage infrastructure.

Contoso deals primarily with three types of data:

- Confidential customer records and contracts in the Microsoft Office format
- Frequently updated marketing information in the Adobe Acrobat format
- Large amounts of historical content in the ZIP-based format that must be retained for compliance purposes

Contoso can mitigate losses resulting from ransomware attacks by having a backup of business-critical data in case other defenses fail. Ransomware attackers invest heavily into neutralizing backup applications and operating system features like volume shadow copy. Effectively, it's critical to have backups that are inaccessible to a malicious attacker. Microsoft offers many services that help with accomplishing this objective.

One approach would be to use SharePoint Online and OneDrive for confidential customer records and contracts in the Microsoft Office format, store frequently updated marketing information in the Adobe Acrobat format in Azure Files, and archive large amounts of historical content in the ZIP-based format. The historical content must be retained for compliance purposes in Azure Blob Storage.

### Minimize the footprint of on-premises backup infrastructure.

By taking advantage of Microsoft cloud services providing data storage functionality, Contoso is able to minimize or even eliminate the need for on-premises backup infrastructure. 

Microsoft 365 native data protection features combined with Azure Backup and Azure Blob Storage support for soft delete, versioning, and immutability could serve as a replacement for on-premises tape backups. 

### Ensure that the data protection solution addresses the need for short-term backups.

For short-term data retention, Contoso can use the native features of SharePoint Online, OneDrive for Business, Exchange Online, Azure Blob Storage, and Azure Files. 
SharePoint Online and OneDrive offer built-in data protection through versioning, recycle bin, and Files Restore, which provide short-term backup functionality. 
Exchange Online emails are protected by single item recovery, mailbox retention, and retention policies.
Azure Blob Storage offers the soft delete functionality. Blob soft delete protects an individual blob, snapshot, or version from deletions or changes by retaining the deleted content for a specific period of time. During the retention period, Contoso is able to restore a soft-deleted blob to its previous state. After the retention period has expired, the object is permanently deleted. 
Blob soft delete is part of a comprehensive data protection strategy for blob data. For optimal protection of blob data, Contoso should enable all of the following data protection features:
- Container soft deletes to restore a container that has been deleted. 
- Blob versioning to automatically maintain previous versions of a blob. This allows Contoso to restore an earlier version of a blob to recover its data following a modification or deletion. 
 - Blob soft deletes to restore a blob, snapshot, or version that has been deleted. 

Azure Files support snapshots and soft delete for file shares. Snapshots are read-only, point-in-time copies of Azure Files shares. Soft delete transitions deleted shares to a soft deleted state instead of removing them permanently. Contoso has the option to configure the amount of time during which soft-deleted data is recoverable before it's permanently deleted. 

### Ensure that the data protection solution addresses the need for long-term backups supporting seven-year retention required due to compliance reasons.

For long-term data retention of Microsoft 365 content, Contoso can use Microsoft Purview retention policies that automatically retain a designated content. They can also use the Preservation Hold library and retention labels, for example, regulatory records. 

Exchange Online emails can be protected long-term by using retention policies.

Azure Storage offers the ability to protect its blobs long-term by using immutable storage. Immutable storage for Azure Blob Storage would allow Contoso to store its data that is subject to compliance-related retention requirements in the WORM (Write Once, Read Many) state. While in the WORM state, data can't be modified or deleted for a user-specified interval. By configuring immutability policies for blob data, Contoso would be able to protect it from overwrites and deletes. Immutable storage for Azure Blob Storage supports two types of immutability policies:
- Time-based retention policies retain data for a specified interval during which objects can be created and read, but not modified or deleted. After the retention period passes, objects can be deleted but not overwritten. 
- Legal hold policies retain immutable data until the legal hold is explicitly cleared. When a legal hold is set, objects can be created and read, but not modified or deleted. 

Azure Backup supports backups of Azure Files shares, which Contoso can use to host the marketing information. The retention period depends on the total number of recovery points, but the maximum retention with yearly recovery points is 10 years. 

### Deliver continuous security protection and monitoring of remote devices.

Device security is one of the essential components of an effective ransomware protection strategy. To maximize this security, Contoso should integrate their on-premises AD DS environment with Azure AD, have remote users join their devices to Azure AD, enroll the devices into Microsoft Intune, and onboard them to Microsoft Defender for Endpoint. 

Once these steps are completed, Contoso administrators are able to secure and further control Azure AD joined devices by using the Mobile Device Management (MDM) functionality of Microsoft Intune. The MDM functionality provides means to enforce organization-defined device configurations, including disk encryption, software installations, and software updates. 

### Control access to the company's assets based on a wide range of conditions, including the state of users' devices and dynamically evaluated risk, relying on heuristics and globally collected security-related telemetry.

By virtue of integrating remote devices with Azure AD and Intune, access to Contoso’s cloud and on-premises resources can be controlled based on Azure AD Conditional Access policies applied to the device and the authenticating user. These policies could ensure that access is granted only from Azure AD joined and fully compliant devices. They could also dynamically detect a risk associated with an authentication attempt. That risk is evaluated in real time by Azure AD Identity Protection. By using Microsoft Defender for Cloud Apps, Azure AD Conditional Access session policies can monitor, in real time, the flow of data between users and managed applications to thwart data exfiltration attempts.

### Protect backups against accidental or malicious deletions.

Contoso can enhance built-in ransomware protection of backups stored in Azure Recovery Services and Azure Backup vaults by adhering to the following practices: 

- Restricting access to backups by using Azure role-based access control (RBAC). Azure Backup supports segregation of duties based on granular, task-based permissions model. 
- Using Azure AD Privileged Identity Management to grant time-limited and approval-based role assignments. 
- Ensuring that soft delete is enabled to protect backups from accidental or malicious deletions. This feature is enabled by default on all newly created Recovery Services and Backup vaults. It retains backups for 14 days following their deletion. 
- Implementing multiuser authorization (MUA) for critical operations on Recovery Services and Backup vaults. MUA for Azure Backup uses the Resource Guard to ensure that critical operations, such as disabling soft delete, stopping and deleting backups, or reducing retention of backup policies, can be performed only when authorized by multiple users. 
- Providing Just-In-Time access on Resource Guard by using Azure AD Privileged Identity Management.
- Setting up alerts and notifications for critical backup operations. Azure Backup offers monitoring and notification capabilities for a wide range of scenarios. 
- Ensuring that network connectivity between backup services and workloads is secure. For Azure VM, data in transit traverses the Azure backbone network. For Azure Storage, you need to explicitly allow access to Azure services on the trusted services list. For on-premises workloads protected by using Microsoft Azure Recovery Services (MARS) agent or Microsoft Azure Backup Server (MABS), you can use Microsoft peering for ExpressRoute or Virtual Private Network (VPN) to connect to Azure. Private peering supports with private endpoints. 
- Regularly monitoring backups. Monitoring solutions, such as Backup Explorer, help identify systems that aren't protected by Azure Backup. They also facilitate monitoring backup items, backup jobs, and policies.


## Answers to each conceptual question

### What stakeholders should be involved in crafting a ransomware mitigation plan?

The overall protection of your data from ransomware is a collaborative effort that requires involvement of multiple stakeholders. In general, the division of responsibilities varies slightly depending on the objectives. However, usually the accountability and implementation role assignments remain the same.

When dealing with backup security:

- Executive sponsorship is in the hands of the central IT Operations team or CIO
- Driving results and cross-team collaboration is a responsibility of a program lead from the central IT infrastructure team.
- Enabling infrastructure backup is implemented by the central IT Infrastructure/Backup team.
- Enabling OneDrive backup can be implemented either by the central IT Productivity team or end users.
- The Security Architecture team advises on configuration and standards.
- The Security Policy and Standards team updates standards and policy documents.
- The Security Compliance Management team oversees the process to ensure compliance.

When dealing with data protection: 
	
- Executive sponsorship is in the hands of the central IT Operations team or CIO
- Driving results and cross-team collaboration is a responsibility of a program lead from the central IT infrastructure team
- Implementing changes to Microsoft 365 tenant for OneDrive and Protected Folders can be implemented either by the central IT Productivity team or end users
- Enabling infrastructure backup is implemented by the central IT Infrastructure/Backup team
- Identifying critical business assets is the responsibility of the corresponding business leads and application owners
- The Security Architecture team advises on configuration and standards
- The Security Policy and Standards team updates standards and policy documents
- The Security Compliance Management team oversees the process to ensure compliance
- The User Education team ensures that guidance for users reflects policy updates. 

### Alongside technical elements of backup and recovery, what process would you use to create an incident recovery plan for a major data breach?

The process to create an incident recovery plan for a major data breach should start by engaging all relevant business, information technology (IT), and security stakeholders, bringing them together, and gathering their feedback regarding the digital assets each of them owns and manages. All of these assets need to be categorized based on their sensitivity and business value. The resulting categories determine the level of assurance and the corresponding measures that should be applied to protect them from potential threats. In the context of ransomware, protection considerations should take into account backups. In particular, you should ensure that critical systems and their data are backed up and backups are protected against deletion or encryption by attackers.

### What methods would you recommend to mitigate the potential impact of ransomware that attempts to encrypt Microsoft 365-hosted content in place?

Files in SharePoint and OneDrive for Business are protected from malicious encryption in place by using versioning, File Restore, and Preservation Hold library.  Microsoft 365 retains a minimum of 500 versions of a file by default but that number can be increased. Microsoft 365 also provides a self-service recovery solution for SharePoint and OneDrive that allows administrators and end users to restore files from any point in time during the last 30 days. Users have the ability to use versioning and Files Restore on their own. Exchange Online emails are protected by retention policies. Retention policies allow retaining immutable copies of email for a configurable retention period.

### What methods would you recommend to mitigate the potential impact of ransomware that copies Microsoft 365-hosted content, encrypts it, and deletes the original?

Microsoft 365 online services have many built-in capabilities and controls to protect customer data from ransomware attacks that copy Microsoft 365 data, encrypt it, and delete the original content. In particular, files in SharePoint and OneDrive for Business are protected from attacks that delete files or email by using versioning, recycle bin, and Files Restore. 
If the ransomware creates a new encrypted copy of the file and deletes the old file, customers have 93 days to restore it from the recycle bin. After 93 days, there's a 14-day window where Microsoft can still recover the data. In this case, users also have the ability to restore files from the recycle bin on their own. Exchange Online emails are protected by single item recovery, mailbox retention, and retention policies. Single item recovery and mailbox retention support recovering items in a mailbox. Users can roll back mail messages deleted within 14 days by default, configurable up to 30 days. Retention policies allow retaining immutable copies of email for a configurable retention period.

### What methods would you recommend to mitigate the potential impact of ransomware that attempts to copy data outside of a Microsoft 365 tenant?

To prevent a ransomware attacker from copying files outside of the Microsoft 365 tenant, customers can use Microsoft Purview Data Loss Prevention (DLP) policies, which detect, warn, and block risky, inadvertent, or inappropriate sharing of data containing personally identifying information (PII) and confidential organization information based on sensitivity labels. This can be supplemented by Microsoft Defender for Cloud Apps, which supports session monitoring as part of Conditional Access App Control. The monitoring applies to the flow of data between users and managed applications and can be used to block transfers of business sensitive content.

### Which are the data protection integration points between Microsoft 365 services and Microsoft 365 Defender products?

Microsoft 365 SharePoint Online, OneDrive for Business, and Exchange Online are closely integrated with Microsoft 365 Defender suite of products, including Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Microsoft Defender for Identity, and Microsoft Defender for Cloud Apps. 

### What are the endpoint protection integration points available in a Microsoft 365 environment?

Microsoft 365 is closely integrated with Microsoft Defender for Endpoint and Microsoft Defender for Cloud Apps. Microsoft Defender for Endpoint is an enterprise endpoint security platform designed to help enterprise networks prevent, detect, investigate, and respond to advanced threats. Microsoft Defender for Cloud Apps provides control over data travel and sophisticated analytics to identify and combat cyberthreats across Microsoft and third-party cloud services. Microsoft Defender for Endpoint integrates with Defender for Cloud Apps by collecting and forwarding all cloud app networking activities, delivering enhanced visibility into cloud app usage. 

### How would you enhance identity protection in Microsoft 365 and Microsoft Azure environments? 

Azure AD multifactor and passwordless authentication, including Azure AD Authenticator App and Windows Hello for Business, help mitigate ransomware risks by protecting identities against commonly seen password attacks, which account for 99.9% of the attacks targeting Azure AD. Eliminating this attack vector significantly lowers the ransomware attack risk to resources that rely on Azure AD for authentication and authorization. 

Azure AD Conditional Access policies can be applied to authenticating users and their devices. These policies could ensure that access is granted only from Azure AD joined and fully compliant devices. They could also dynamically detect a risk associated with an authentication attempt. That risk is evaluated in real time by Azure AD Identity Protection. Azure AD Identity Protection dynamically identifies potential threats and adjusts the corresponding risk levels. By using Microsoft Defender for Cloud Apps, Azure AD Conditional Access session policies can monitor, in real time, the flow of data between users and managed applications to thwart data exfiltration attempts.

Azure AD Privileged Identity Management provides time-based and approval-based role activation to mitigate the risks of excessive, unnecessary, or misused permissions. 

Microsoft Defender for Identity is a cloud-based security solution included in the Microsoft 365 Defender product suite that uses AD DS signals to identify, detect, and investigate advanced threats, compromised identities, and malicious insider actions directed at AD DS domain environments.

## Answers to each design question 

### How would you approach creating a business resiliency plan for Contoso based on the Cloud Adoption Framework? 

To follow the principles of Cloud Adoption Framework, Contoso needs to develop a comprehensive approach to ransomware protection. This entails building its business resiliency plan that takes into account two primary considerations: maintaining the optimal security posture and being able to respond to incidents in the most efficient and effective manner. These two considerations reflect the lifecycle of security risks, which consists of four stages: before the incident, during the incident, after an incident, and feedback loop. The security posture strategy incorporates the before the incident and feedback loop stages, while the response to incidents should take into account activities during an incident and after an incident.

In regard to security posture, Contoso should start by building a comprehensive inventory of all the technology and business assets, identifying the level of risk associated with each of them, and evaluating their current protection status. This serves as the basis for applying the Zero Trust principles, with the goal of devising optimal protection from cyberthreats. The resulting strategy should take into account a wide range of security provisions, covering such areas as authentication and authorization, identity management, endpoint protection, data storage, applications usage, network segmentation, monitoring, auditing, and governance, representing core components of the defense-in-depth cybersecurity paradigm. 

To enhance its current authentication model, Contoso should integrate the on-premises Active Directory Domain Services (AD DS) with Azure AD and apply the native capabilities of the latter to implement passwordless authentication for its remote users. Implementing endpoint protection should involve enrolling remote devices into Intune and taking advantage of its integration with Microsoft Defender for Endpoint. In parallel, Contoso should onboard its digital assets into other Microsoft 365 Defender products, including Defender for Identity, Defender for Cloud Apps, and Defender for Office 365. The first of them would facilitate detection of threats within the AD DS environment. The second one would provide an extra layer of security for cloud-based applications, including Office 365 services. Defender for Cloud Apps is capable of detecting anomalous behavior, which might be indicative of a ransomware attack. The third one implements email filtering that provides other protection against specific types of advanced threats, including malware and viruses. 

With Azure AD Conditional Access, Contoso could validate that only properly authorized users on devices configured according to centrally controlled policies are granted access to the organization’s digital assets. Integration between Azure AD Conditional Access and Defender for Cloud Apps will allow Contoso to apply session-level controls that block data exfiltration attempts. By implementing Azure AD Identity Protection, Contoso would be able to enforce dynamically evaluated and risk-based authorization criteria. Azure AD Privileged Identity Management would ensure compliance with the principle of least privilege. Combining all of these features would generate comprehensive telemetry, yielding full visibility of the entire managed environment, allowing Contoso’s SecOps team to quickly identify and thwart any emerging threats. That visibility could be further enhanced by implementing Microsoft Sentinel.

From the data protection standpoint, Contoso should address the current deficiencies by replacing its on-premises data storage and backups technologies with cloud-based services. That allows Contoso to benefit from the data protection and recovery capabilities built into Microsoft 365 and Azure. It would also provide immediate and automatic insights of the security posture based on the cloud platform-generated Secure Score metrics.

In regard to incident response, Contoso should have a well-defined plan to execute during and after an incident. During an incident, the primary objective is to ensure that the business remains operational. This might require accepting a service degradation or limiting the scope of service availability to critical systems only. To make such decisions, Contoso must fully identify its technology assets, their significance to business, and the extent of risk (both operational and reputational) associated with each of them. In the context of ransomware attacks, the built-in capabilities available in Microsoft 365 and Azure will allow Contoso to clearly label business-sensitive content according to its criticality. These labels can then be used to apply a wide range of protection methods, such as retention policies, versioning, immutability, or soft delete to facilitate data preservation and recovery. 

In addition to protecting critical business operations, it's also essential to prevent further damage. This is one of the core responsibilities of members of Contoso SecOps team, who will need to promptly assess the extent of access gained by the attackers and evict them from the managed environment. The information derived by the team from Microsoft 365 Defender and Microsoft Sentinel will considerably simplify discovery of the kill chain that led to an exploit. That discovery determines the most efficient approach to eradicating the threat and might involve blocking the use of compromised user accounts, isolating attacker control points, or removing malware from infected endpoints.

After an incident, it's essential to restore business operations to their original status. With data assets hosted by Microsoft cloud services, it becomes easier for Contoso to implement this objective. That’s where features such as Azure Backup, Microsoft 365 Preservation Hold Library might prove to be valuable.
Finally, to validate the effectiveness and efficiency of its incident response procedures, Contoso should develop a playbook that clearly defines the roles and responsibilities to assign as well as procedures to follow during an incident. That playbook should be tested and updated through routine internal drill exercises, simulating ransomware cyberattacks. 

### Given identified risks from the scenario, are there any opportunities to achieve better security integration with business processes using the Cloud Adoption Framework?

In general, Cloud Adoption Framework provides guidance regarding integration with business processes in three distinct areas: risk insights, security integration, and operational resiliency.

In the area of risk insights, the intention is to ensure an alignment between business initiatives and both security insights and risk signals. To accomplish this, Contoso should ensure that all stakeholders have the full awareness of and a proper visibility into ransomware protection mechanisms applied to all business-sensitive content residing on-premises, in Microsoft 365, and in Microsoft Azure. That should start with reviewing all current and planned business initiatives that deal directly or indirectly with data assets that could be a potential target of ransomware. Any such assets should be categorized based on their business value and marked using methods such as Microsoft Purview sensitivity labels or Microsoft Azure resource tags. The categorization drives the choice of the storage protection methodology. Once Contoso IT organization learns what assets and data are important to business, they should adjust how they spend their time, attention, and budget in the manner that reflects the business priorities. 

The longer-term objectives would involve aligning the business strategy with the Zero Trust principles of assuming breach, least privilege, and explicit verification with the goal of reducing risk within Contoso. That strategy should also promote the Microsoft recommended security practices in such areas of endpoint and identity protection. In the case of Contoso, this would involve transitioning to a cloud-based model, starting with integration of its Active Directory environment with Azure Active Directory, implementing passwordless authentication, enrolling remote devices into Intune, and onboarding them into Microsoft 365 Defender.

In addition, every business initiative should be subject to a thorough security review, with focus on ransomware protection. The review should apply a holistic approach based on the Zero Trust principles, in order to properly assess security-related implications of business changes. 

In the area of security integration, the intention is to ensure that daily business operations take security considerations into account. One of the more prominent indicators of the state of this integration is the security update process. When operating in their on-premises environment, Contoso's IT team must constantly negotiate with the business stakeholders to agree on a schedule for update deployments that is acceptable to both sides. Migrating data to managed cloud services in Microsoft 365 and Azure will automatically resolve this challenge on the storage side. On the client side, implementing Intune will provide the least intrusive, automated process of deploying security updates on users’ devices. At the same time, Azure AD Conditional Access will enforce device compliance verification before users are allowed to access data assets.
Operational resiliency focuses on the ability of the business to remain operational following a successful security exploit and the ability to remediate any potential impact from such exploits in a timely manner. That’s determined to a large extent by Contoso’s implementation of the previously described business resiliency plan.

Ultimately, these changes should help Contoso establish a new security-focused organization-wide culture that promotes collaboration between business, security, and IT teams. 

### Which Microsoft 365 services would allow Contoso to increase their visibility into and traceability of cyberattacks affecting on-premises and cloud assets?

As Contoso gradually transitions to the cloud-first operational model, its SecOps team is able to gain increasingly more insights into the security posture of its environment along with the continuously enhanced visibility and traceability of any cyberattacks affecting on-premises and cloud assets.

These capabilities are derived from the functionality provided by Azure security-focused services such as Microsoft Defender for Cloud and Microsoft Sentinel, Microsoft 365 Defender products, and their synergy resulting from multiple integration points. 

Microsoft 365 Defender offers a unified pre- and post-breach enterprise defense suite of products that help coordinate detection, prevention, investigation, and response across endpoints, identities, email, and applications to provide integrated protection against sophisticated attacks. These products include Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Microsoft Defender for Identity, and Microsoft Defender for Cloud Apps. 

### Which Microsoft Azure services would allow Contoso to increase visibility into and traceability of cyberattacks affecting on-premises and cloud assets?

Considering that Contoso will also utilize Azure services, they should incorporate Microsoft Defender for Cloud as part of their target architecture. Microsoft Defender for Cloud provides tools to detect and block ransomware, advanced malware and threats for workloads hosted in Azure, third party clouds, and on-premises. Its threat protection includes fusion kill-chain analysis, which automatically correlates alerts in managed environments based on cyber kill-chain analysis. When Microsoft Defender for Cloud detects a threat in the managed environment, it generates a security alert. These alerts describe details of the affected resources, suggested remediation steps, and, in some cases, an option to trigger a logic app in response.

Another Azure service that Contoso should take advantage of is Microsoft Sentinel. Microsoft Sentinel is a managed, cloud-native solution that provides security information and event management (SIEM) security orchestration, automation, and response (SOAR) functionality. With Sentinel, Contoso is able to use built-in connectors to collect telemetry and logs from a wide range of security resources, and then take advantage of artificial intelligence to correlate multiple low fidelity signals spanning multiple sources, and create a complete view of a ransomware kill chain and prioritized alerts, effectively reducing the corresponding impact and the time to evict attackers. 

### What changes in the operational procedures would you recommend to Contoso to mitigate the potential impact of ransomware?

As part of standard operating procedures, Contoso should consider the following actions:

- Ensure their backups are encrypted. By default, Azure Backup data at rest is encrypted using platform-managed keys or customer-managed keys (CMK). Additionally, customers can configure infrastructure-level encryption, which, along with CMK encryption, provides double encryption of data at rest. MARS and MABS rely on a customer-set passphrase to implement end-to-end encryption of data. This passphrase should be securely stored in an alternate location, other than the original data location, preferably in the Azure Key Vault. 
- Regularly monitor their backups. Contoso should use the monitoring solutions, such as Backup Explorer, to identify systems that aren't protected by Azure Backup, and to monitor backup items, backup jobs, and policies.
- Validate backups periodically by performing test restores. Contoso should periodically perform data recovery tests of their backups to verify that the backup configurations and availability of the backup data meet your organization's recovery needs, along with expected Recovery Point Objective (RPO) and Recovery Time Objective (RTO) requirements. They should also define a backup recovery test strategy to include the scope of test recovery and frequency for performing a test recovery.

In case of a successful exploit, if backup was enabled on the source system, then Contoso should review the incident timeline, identify the most recent clean recovery point created before the exploit, restore data to an isolated and secure network, scan the restored data to ensure it's not compromised, and, assuming that’s the case, perform a restore to a production environment. 

Any issues discovered during this process should serve as an opportunity to improve it. For example, if more time is required to complete restores, then retention duration in the backup policy should be extended. 

### What would you recommend to Contoso to implement endpoint protection?

To build effective endpoint protection against ransomware, Contoso should use a range of Microsoft products, including Microsoft Defender for Endpoint, Microsoft Intune, Microsoft Defender for Cloud, and Azure Firewall.

Microsoft Intune support for a wide range of policies that help apply and evaluate device compliance with the organizational endpoint security policies. It also offers integration with Microsoft Defender for Endpoint as its Mobile Threat Defense solution. Integrating Intune with Microsoft Defender for Endpoint allows Contoso to take advantage of the Threat & Vulnerability Management functionality of Microsoft Defender for Endpoints. They can use Intune to remediate detected vulnerabilities and threats, minimizing the possibility of a successful ransomware attack.

Microsoft Defender for Cloud provides tools to detect and block ransomware, advanced malware and threats for workloads hosted in Azure, third party clouds, and on-premises. Its capabilities are enhanced through integration with Microsoft Defender for Endpoint.

Azure Firewall Premium includes signature-based intrusion detection and prevention system (IDPS), which identifies malicious activities and prevent them from affecting internal resources. Azure Firewall Premium also offers remediations in cases where a ransomware manages to reach protected resources. In particular, in cases where ransomware attempts to contact its Command and Control systems to obtain an encryption key, Azure Firewall Premium is capable of blocking that communication, effectively preventing attackers from initiating data encryption.

### What infrastructure elements would you prioritize for system hardening in order to mitigate the ransomware risk for Contoso?

Contoso should adhere to the Cloud Adoption Framework principle and follow implementation of the security practices geared towards mitigating ransomware risks by focusing first on access control. This involves implementing network and identity access boundaries and segmentation. Next, Contoso should turn its attention to enhancing security operations to maximize the ability to detect, respond to, and recover from a breach. Asset protection, geared towards maximizing security of all digital assets, including infrastructure, devices, data, applications, networks, and identities should follow.  Another item in Contoso’s environment hardening should be governance, helping enforce security standards across the entire managed environment. Last, but not least, is innovation security, which drives the adoption of the DevOps model for changes in technology.

## Proposed solution architecture

:::image type="content" source="../media/final-architecture.png" alt-text="Diagram of the final architecture of Contoso." lightbox="../media/final-architecture.png":::