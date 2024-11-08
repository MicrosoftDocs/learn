
The following table provides a summary of the recommendations provided in this document for securing an AD DS installation. Some best practices are strategic in nature and require comprehensive planning and implementation projects; others are tactical and focused on specific components of Active Directory and related infrastructure.

Practices are listed in approximate order of priority, that is, lower numbers indicate higher priority. Where applicable, best practices are identified as preventative or detective in nature. All of these recommendations should be thoroughly tested and modified as needed for your organization's characteristics and requirements.

| **Best Practice** | **Tactical or Strategic** | **Preventative or Detective** |
|--|--|--|
| Patch applications. | Tactical | Preventative |
| Patch operating systems. | Tactical | Preventative |
| Deploy and promptly update antivirus and antimalware software across all systems and monitor for attempts to remove or disable it. | Tactical | Both |
| Monitor sensitive Active Directory objects for modification attempts and Windows for events that may indicate attempted compromise. | Tactical | Detective |
| Protect and monitor accounts for users who have access to sensitive data | Tactical | Both |
| Prevent powerful accounts from being used on unauthorized systems. | Tactical | Preventative |
| Eliminate permanent membership in highly privileged groups. | Tactical | Preventative |
| Implement controls to grant temporary membership in privileged groups when needed. | Tactical | Preventative |
| Implement secure administrative hosts. | Tactical | Preventative |
| Use application allowlists on domain controllers, administrative hosts, and other sensitive systems. | Tactical | Preventative |
| Identify critical assets, and prioritize their security and monitoring. | Tactical | Both |
| Implement least-privilege, role-based access controls for administration of the directory, its supporting infrastructure, and domain-joined systems. | Strategic | Preventative |
| Isolate legacy systems and applications. | Tactical | Preventative |
| Decommission legacy systems and applications. | Strategic | Preventative |
| Implement secure development lifecycle programs for custom applications. | Strategic | Preventative |
| Implement configuration management, review compliance regularly, and evaluate settings with each new hardware or software version. | Strategic | Preventative |
| Migrate critical assets to pristine forests with stringent security and monitoring requirements. | Strategic | Both |
| Simplify security for end users. | Strategic | Preventative |
| Use host-based firewalls to control and secure communications. | Tactical | Preventative |
| Patch devices. | Tactical | Preventative |
| Implement business-centric lifecycle management for IT assets. | Strategic | N/A |
| Create or update incident recovery plans. | Strategic | N/A |

## Reducing the Active Directory Attack Surface

This section focuses on technical controls to reduce the attack surface of an Active Directory installation. Included in this section are the following subjects:

- The **Privileged Accounts and Groups in Active Directory** section discusses the highest privileged accounts and groups in Active Directory and the mechanisms by which privileged accounts are protected. Within Active Directory, three built-in groups are the highest privilege groups in the directory (Enterprise Admins, Domain Admins, and Administrators), although a number of additional groups and accounts should also be protected.

- The **Implementing Least-Privilege Administrative Models** section focuses on identifying the risk that the use of highly privileged accounts for day-to-day administration presents, in addition to providing recommendations to reduce that risk.

Excessive privilege isn't only found in Active Directory in compromised environments. When an organization has developed the habit of granting more privilege than is required, it is typically found throughout the infrastructure:

- In Active Directory
- On member servers
- On workstations
- In applications
- In data repositories

- The **Implementing Secure Administrative Hosts** section describes secure administrative hosts, which are computers that are configured to support administration of Active Directory and connected systems. These hosts are dedicated to administrative functionality and do not run software such as email applications, web browsers, or productivity software (such as Microsoft Office).

Included in this section are the following:

- **Principles for Creating Secure Administrative Hosts** - The general principles to keep in mind are:
  - Never administer a trusted system from a less-trusted host.
  - Do not rely on a single authentication factor when performing privileged activities.
  - Do not forget physical security when designing and implementing secure administrative hosts.

- **Securing Domain Controllers Against Attack** - If a malicious user obtains privileged access to a domain controller, that user can modify, corrupt, and destroy the Active Directory database, and by extension, all of the systems and accounts that are managed by Active Directory.

Included in this section are the following subjects:

- **Physical Security for Domain Controllers** - Contains recommendations for providing physical security for domain controllers in datacenters, branch offices, and remote locations.

- **Domain Controller Operating Systems** - Contains recommendations for securing the domain controller operating systems.

- **Secure Configuration of Domain Controllers** - Native and freely available configuration tools and settings can be used to create security configuration baselines for domain controllers that can subsequently be enforced by Group Policy Objects (GPOs).
