
Keeping track of every user, device, and resource in a network—and deciding who can access what—requires a system for storing and managing identity information. That system is a *directory service*.

## What is a directory service?

A *directory* is a structured repository that stores information about objects in a network, such as users, devices, groups, policies, and applications. A *directory service* is the software that stores this directory data and makes it available to users, administrators, applications, and services. Directory services answer questions like "Who is this user?", "What groups do they belong to?", and "Which resources are they authorized to access?" They form the backbone of user authentication and authorization in an organization's network.

## Active Directory Domain Services

*Active Directory (AD)* is a set of directory services developed by Microsoft, first released as part of Windows 2000 Server. It was designed to help organizations manage on-premises, domain-based networks—giving administrators a centralized way to manage users, computers, and resources across the organization.

The most widely deployed component is *Active Directory Domain Services (AD DS)*. AD DS stores information about every member of a network domain, including users, devices, and groups. It verifies credentials during sign-in and defines each user's access rights to network resources. A server running AD DS is called a *domain controller (DC)*.

AD DS gives organizations the ability to:

- Manage multiple on-premises systems using a single identity per user
- Apply Group Policy settings to control device configurations across the organization
- Authenticate users to on-premises applications using established protocols like Kerberos and NTLM
- Organize users and computers into organizational units (OUs) for simplified administration

For years, AD DS was the foundation of identity and access management for most organizations. It served well when employees worked on organization-provided Windows devices connected to a corporate network, and when applications ran on on-premises servers.

## Limitations of Active Directory for a modern environment

Active Directory Domain Services was designed for an on-premises world. As organizations adopted cloud services, mobile devices, and remote work, AD DS began to show its limitations:

- **Cloud and SaaS applications**: AD DS doesn't natively authenticate users to cloud-based applications or SaaS services. Connecting AD DS to cloud applications typically requires additional synchronization tools or federation services.
- **Mobile devices**: AD DS doesn't natively support iOS, Android, or other non-Windows device management without additional solutions.
- **Modern authentication protocols**: Many cloud services and modern applications use authentication standards like OAuth 2.0 and OpenID Connect—protocols that AD DS doesn't natively support.
- **Remote access**: Users working away from the corporate network can't authenticate directly to AD DS without a VPN connection, adding friction and a potential security gap.

These limitations created the need for an identity solution built for cloud services, mobile devices, and remote work.

## Microsoft Entra ID

*Microsoft Entra ID* is Microsoft's cloud-based identity and access management service—the evolution of directory services for the cloud era. Where Active Directory Domain Services was designed for on-premises networks, Microsoft Entra ID is designed for the internet and the cloud. It provides an *Identity as a Service (IDaaS)* model, meaning Microsoft operates and maintains the underlying infrastructure while organizations use it to manage users, devices, and access policies.

Microsoft Entra ID addresses the limitations of AD DS by supporting modern, standards-based authentication, working across platforms and device types, and integrating with cloud and SaaS applications—without requiring a VPN or on-premises infrastructure. Organizations that already run AD DS can connect the two systems so identities are synchronized, a configuration known as *hybrid identity*, allowing users to access both on-premises and cloud resources with the same credentials.

A later learning path covers Microsoft Entra ID and its capabilities in detail.
