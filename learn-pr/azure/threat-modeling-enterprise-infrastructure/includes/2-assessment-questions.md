The most effective way to find security gaps in the infrastructure is to create a threat model.

It begins with a set of assessment questions, which feed directly into the threat modeling creation process.

An infrastructure threat model helps you visualize how the enterprise is accessed, connected, and protected.

It makes it easier to identify which security controls to use to help reduce or eliminate risk.

This list of assessment questions is a great starting point. You may add more questions depending on your industry and technologies used.

> [!NOTE]
> Questions are grouped by their respective domains.

## Access control

![Access Control category](../media/AccessControl.svg)

These questions allow you to:

- Know who is authorized to access enterprise resources, like admins, vendors, or users.
- Understand what is required to restrict access, like Role-based Access Control (RBAC), Access Control Lists (ACL), or least-privilege access.
- Investigate identity management systems used, like Azure Active Directory (AAD).
- Learn what is used to authenticate, like Multi-Factor Authentication (MFA) and Single-Sign-On (SSO).

|Question|Areas to cover|
|--------|--------------|
|**Describe your physical and logical access controls.**|<ul><li>Usage of an Active Directory.</li><li>Process to grant access to assets and resources.</li><li>Federations used to help enable SSO experiences.</li><li>Trusts established between two or more separate domains to understand potential relationship risks.</li><li>Complete workflows for provisioning and de-provisioning of access.</li><li>People who manage access workflows.</li></ul>|
|**How do you establish and verify the identity of each person?**|<ul><li>Process to create and manage aliases for each user type.</li><li>Access controls used, like SSO, 2FA, and MFA.</li><li>Authentication factors used, like biometric scanning, phone authentication, smart cards, and Trusted Platform Modules (TPM).</li><li>People who manage identity and access controls.</li></ul>|
|**How do you know what people can and cannot access?**|<ul><li>Enforced permissions and access restrictions, like least-privilege, segregation of duties, RBAC, glass-break scenarios, vendor access restrictions, and group memberships.</li><li>People who manage access restrictions and permissions.</li></ul>|
|**Describe the password policy for each user type.**|<ul><li>Password requirements for each user type.</li><li>Password requirement differences between users, elevated users, smart cards, shared accounts, and service accounts.</li><li>Password lifecycle guidelines on creation, modification, and reset.</li><li>Logging and monitoring mechanisms used to track password actions.</li><li>Password expiration policies for each user type.</li><li>Unsuccessful password attempt limits.</li><li>Password sharing restrictions.</li></ul>|
|**How do you securely manage access to your online social presence?**|<ul><li>Prefix requirements used for social media branding.</li><li>People who manage social media accounts.</li><li>Social media access guidelines.</li><li>Access audit cadence.</li></ul>|
|**How do you manage elevated, shared, alternate, and system accounts?**|<ul><li>Approval process for each account type.</li><li>Expiration or deactivation dates.</li><li>People who manage these accounts.</li><li>Process used to monitor, log, and handle suspicious activity.</li><li>Accounts used for remote access.</li><li>Security controls used, like just-in-time access.</li><li>Local administrative account usage and security.</li><li>Administrative account usage restrictions, like secured environment use only.</li></ul>|
|**Describe the process used to approve, audit, and manage access requests.**|<ul><li>Initial request handling, review process, initial training requirements, and audits.</li><li>People who manage access requests.</li></ul>|

## Secure development

![Secure Development category](../media/SecureDevelopment.svg)

These questions allow you to:

- Understand how engineering teams enforce security throughout the development lifecycle, like security reviews, threat models, security tools, or code reviews.
- Learn the systems used to protect source code and security bugs.

|Question|Areas to cover|
|--------|--------------|
|**Describe your Security Development Lifecycle (SDL).**|<ul><li>Security trainings, design reviews, threat models, engineering security requirements, and other security processes.</li><li>Manual and automated tools used.</li><li>How engineering teams report and respond to issues in code.</li><li>Risk assessment management policies used to help distinguish between issue severities.</li></ul>|
|**How do you protect source code and bugs?**|<ul><li>Source code security classification.</li><li>Access controls used to secure source code.</li><li>Process to create, triage, fix, and store security bugs.</li><li>Dedicated workflow to manage security issues.</li><li>Bug severity baselines.</li></ul>|

## Business continuity

![Business Continuity category](../media/BusinessContinuity.svg)

These questions allow you to:

- Gauge enterprise resiliency against service outages.
- Learn how the enterprise identifies and protects critical services.
- Verify implementation and regular testing of backups and recovery techniques.

|Question|Areas to cover|
|--------|--------------|
|**Describe your business continuity and disaster recovery plans.**|<ul><li>Backup and recovery process for all critical assets.</li><li>Backup and recovery cadence.</li><li>Backup data retention timelines.</li><li>Process to identify what needs to be backed up.</li><li>Short-term and long-term backup options used.</li><li>Monitoring and reporting mechanisms used for all backup and recovery activities.</li><li>Availability and resiliency test cadence.</li><li>Encryption used to protect backups.</li><li>Recovery and restore audit cadence.</li></ul>|

## Cryptography

![Cryptography category](../media/Cryptography.svg)

These questions allow you to:

- Learn the cryptographic practices and baselines used to protect the enterprise.
- Know how cryptographic technologies are managed, like Public Key Infrastructure (PKI).
- Understand how Hardware Security Modules (HSM) are deployed, tracked, and administered.

|Question|Areas to cover|
|--------|--------------|
|**Describe the systems used to create, manage, and secure both cryptographic keys and certificates.**|<ul><li>PKI and HSM physical and logical deployment requirements.</li><li>PKI and HSM maintenance.</li><li>Key rotation guidelines.</li><li>Self-signed certificate guidelines.</li></ul>|

## Asset management

![Asset category](../media/Asset.svg)

These questions allow you to:

- Know how assets are identified, labeled, and classified.
- Meet who owns and manages asset labels and classifications.
- Learn the requirements that dictate how users should handle data.
- Verify how data is stored.

|Question|Areas to cover|
|--------|--------------|
|**Describe your data retention policy.**|<ul><li>How long documents are kept for.</li></ul>|
|**Describe how physical assets are handled, transported, and destroyed.**|<ul><li>Process to secure assets during transport or destruction.</li><li>Security controls used during handling, like encryption, locks, memory wipes, and trusted vendors.</li><li>Systems used to prevent accidental data leakage during asset handling.</li></ul>|
|**Describe the classification and labeling process for logical and physical assets.**|<ul><li>Asset labeling and classification process.</li><li>Label and classification review cadence.</li><li>Process used to assess risk or make classification level changes.</li><li>Employee training on data classification.</li><li>Process used to store classified data in assets of the same or higher classification levels.</li><li>Asset tracking systems used.</li><li>Asset groupings.</li><li>Security and privacy control implementations based on classification levels.</li><li>Requirements for everyone managing the process.</li></ul>|
|**How are confidential assets destroyed when they’re no longer needed?**|<ul><li>Security requirements for data destruction across all mediums, like hard drives, tapes, and disks.</li><li>Third-party system or company used to assist with asset destruction.</li></ul>|
|**What happens if an asset is lost, missing, or shipped outside of the enterprise?**|<ul><li>Workflow used for each scenario.</li><li>Data security process before and after each workflow is completed.</li></ul>|
|**Describe how data is encrypted across all stages.**|<ul><li>Data encryption at-rest, in-use, and in-transit.</li><li>Use of digital signatures, hashes, and HMACs.</li><li>Use of blockchain and off-chain encryption to prevent collusion.</li></ul>|
|**What are the mechanisms in place to prevent unauthorized sharing and downloading of data?**|<ul><li>Security controls used to prevent unauthorized data sharing and downloading, like notifications, logs, sharing review process, or other restrictions.</li></ul>|

## Legal

![Legal category](../media/Legal.svg)

These questions allow you to:

- Understand the enterprise's legal and regulatory obligations.
- Verify content of contracts and agreements signed by employees and vendors.

|Question|Areas to cover|
|--------|--------------|
|**Describe any limitations to global sales due to encryption capabilities that are part of the product.**|<ul><li>Markets that prohibit the sale of a product due to its encryption capabilities.</li></ul>|
|**How do employees and vendors adhere to security policies?**|<ul><li>Terms and conditions, NDAs, policies, agreements, and other contracts signed by employees and vendors.</li></ul>|
|**Describe the process used to meet all industry, legal, contractual, and regulatory compliance as it relates to enterprise assets.**|<ul><li>How the enterprise meets compliance requirements.<li><li>People responsible for meeting those requirements.</li><li>Compliance risk assessment reviews.</li><li>Logging and monitoring mechanisms in place.</li><li>Access controls used for each user type.</li><li>Asset security baselines used.</li><li>How each endpoint connecting to the network meets security compliance.</li><li>Detection and protection systems in place to enforce compliance.</li><li>Specialized facility operations to meet regulatory compliance.</li></ul>|

## Incident response

![Incident response category](../media/IncidentResponse.svg)

These questions allow you to:

- Know how the enterprise handles incidents against its infrastructure and product offerings.
- Learn strategies used to protect, detect, and respond to security incidents.
- Meet who manages these incidents.

|Question|Areas to cover|
|--------|--------------|
|**Describe the incident response process for both the enterprise and product.**|<ul><li>Strategies used to protect, detect, and respond to incidents for both the enterprise and product.</li><li>How the enterprise minimizes exposure to risk, including steps to avoid loss or destruction.</li><li>Trainings, table-top exercises, and other activities.</li></ul>|

## Network

![Network category](../media/Network.svg)

These questions allow you to:

- Learn how the network is segmented and protected.
- Know each detective and protective solution in place, like firewalls and Virtual Private Networks (VPN).
- Gauge existing monitoring capabilities.
- Verify how data is secured between internal and external endpoints.

|Question|Areas to cover|
|--------|--------------|
|**Describe the enterprise network setup.**|<ul><li>Network handling process of each data classification type.</li><li>Trust zone levels used.</li><li>Detection and protection systems in place.</li><li>Logging and monitoring capabilities.</li><li>Network access restrictions.</li><li>Network segregation strategies, like Demilitarized Zones (DMZ) and firewalls.</li><li>VPN configuration and usage.</li><li>Firewall inbound and outbound rules.</li><li>Network encryption.</li></ul>|
|**How is the enterprise network managed?**|<ul><li>VPN and remote network access management process.</li><li>Configuration of allow and deny rules for out-of-band connection points and endpoints.</li><li>Network identity verification.</li><li>Updated network diagrams.</li></ul>|

## Operations

![Operations category](../media/Operations.svg)

These questions allow you to:

- Learn about existing change control policies and procedures.
- Uncover important aspects of daily operations, like patch management, malicious code prevention, logging, and monitoring.
- Find out who can access administrative documents.
- Understand which tests are conducted to ensure smooth operations.

|Question|Areas to cover|
|--------|--------------|
|**Describe the process used to time out working sessions across assets and services.**|<ul><li>Automatically time out sessions designed to prevent unauthorized access.</li></ul>|
|**Describe how malicious activity is detected, prevented, and removed across all endpoints.**|<ul><li>Tools used by the enterprise, such as Antivirus (AV) software and Mobile Device Management (MDM) solutions.</li><li>Implementation and enforcement of each tool.</li><li>Security patch delivery process to all endpoints.</li><li>Vulnerability and penetration testing programs, including third-party vendors.</li><li>Security event identification, logging, and monitoring.</li><li>Intelligence platform usage and configuration to ingest security events.</li><li>Mobile Device Management (MDM) solutions configuration and usage.</li></ul>|
|**Describe your security operations processes as they relate to changes in the production environment.**|<ul><li>How changes to the production environment are documented, accessed, and updated.</li><li>Change management policy details.</li><li>How and when employees can access security operation policies.</li></ul>|

## Physical and environmental

![Physical category](../media/Physical.svg)

These questions allow you to:

- Learn existing physical security requirements to help keep employees, assets, and facilities safe.
- Understand the security controls are used to help prevent malicious attacks.
- Gauge how well the enterprise is prepared against natural disasters.

|Question|Areas to cover|
|--------|--------------|
|**Describe the physical security controls in place to protect people, assets, and buildings.**|<ul><li>How the company is physically protecting its employees, assets, and facilities.</li><li>Guidelines for assets left unattended.</li><li>Server room security and handling, especially in a disaster.</li><li>Visitor registration process.</li></ul>|

## Governance

![Governance category](../media/Governance.svg)

These questions allow you to:

- Learn how the enterprise includes security in its strategic direction.
- Understand how risks are validated and managed.
- Uncover high-level compliance requirements.

|Question|Areas to cover|
|--------|--------------|
|**Describe your information security policy and risk management program.**|<ul><li>How the information security policy is created, deployed, and maintained.</li><li>What is listed in the policy.</li><li>Process for tracking exceptions to these policies.</li><li>Types of employee security training available to enforce these policies.</li><li>Security risk management program.</li></ul>|

## Security architecture

![Security architecture category](../media/SecurityArchitecture.svg)

These questions allow you to:

- Learn how technologies are selected, implemented, and managed.
- Find out collaboration requirements designed to prevent external data sharing and limit social media interactions.
- Understand how resilience and security are achieved.
- Meet who creates and manages security baselines across platforms.

|Question|Areas to cover|
|--------|--------------|
|**Describe your on-premises and/or cloud infrastructure.**|<ul><li>Whether the infrastructure is all on-premises, cloud, or hybrid.</li><li>Access controls used to secure the on-premise, cloud, or hybrid infrastructures.</li><li>Tracking mechanisms used for hardware, like data-centers.</li><li>Backup requirements.</li><li>Network security requirements.</li><li>Testing and monitoring systems.</li><li>Data handling requirements.</li><li>Software usage restrictions.</li><li>Baselines used to provide acceptable levels of security across different platforms.</li></ul>|
|**Describe your container and/or IoT infrastructure.**|<ul><li>Use of IoT and/or containers.</li><li>Security controls used for network access, device configuration, and data handling.</li><li>Security requirements for containers as they relate to containerization and orchestrators.</li></ul>|

## Supplier

![Supplier category](../media/Supplier.svg)

These questions allow you to:

- Understand existing relationships with suppliers, vendors, and third-parties.
- Identify the process to identify supplier security risks and enforce service level agreements.

|Question|Areas to cover|
|--------|--------------|
|**Describe the third-party vetting process that helps you decide who to do business with.**|<ul><li>How the company handles third-party security risk.</li><li>Communication process of issues with the supplier.</li><li>Service level agreements in place for continuous support.</li></ul>|