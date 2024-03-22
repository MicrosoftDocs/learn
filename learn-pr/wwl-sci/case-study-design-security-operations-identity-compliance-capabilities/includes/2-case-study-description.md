This unit presents the case study scenario, design requirements, conceptual and technical questions.

## Background scenario

Contoso is a medium-sized financial services company with its headquarters in New York and a branch office in San Francisco. It's currently operating entirely on-premises, with most of its infrastructure running Windows-based workloads. Most of its servers are joined to a multi-domain Active Directory Domain Services (AD DS) forest with the domain controllers running Windows Server 2019 and the forest functional level set to Windows Server 2016. Most line-of-business applications are web-based. While some of them have been designed to support modern authentication, there are a few that rely on Kerberos to authenticate and authorize access to back-end resources. 

Contoso plans to expand its business through partnerships with other financial institutions. As part of this effort, Contoso established a business relationship with Fabrikam, a company that manages an extensive portfolio of mortgage-related products. Contoso intends to provide Fabrikam access to its internal Windows-based web applications that could supplement the existing Fabrikam products. Fabrikam is also operating primarily on-premises, but has already integrated its AD DS environment with Microsoft Entra ID. 

While the expansion is one of the primary business priorities, the technology organization of Contoso is facing challenges related to increased mobility of its workforce. The recent pandemic, combined with high costs of office space in the major US financial hubs, prompted the company's CIO to revisit the existing approach, which has been severely restricting the option to work from home. As a result, Contoso's legal and compliance teams started drafting a flexible work arrangement policy, which would allow its employees to work on designated days from home, using either corporate-owned or personal devices. This, however, triggered a swift reaction from  Contoso's Information Security (InfoSec) team, concerned about the lack of sufficient controls to prevent access from unauthorized or noncompliant systems. During the pandemic, the team reluctantly approved the use of point-to-site VPN and DirectAccess technologies as a stopgap measure. It has, however, insisted from the beginning that a strategic solution, which would prevent excessive levels of access to the on-premises infrastructure, is needed. 

In search for that strategic solution and to facilitate its business expansion plans, Contoso's Information Technology (IT) management team started exploring the option of transitioning its operations into a more internet-open model. This would facilitate support for a mobile workforce and integration with business partners, simultaneously enhancing the existing security controls. Given its current environment, which is heavily dependent on Active Directory, Contoso wants to assess the role of Microsoft Entra ID, which is part of Microsoft Entra, as the identity and access foundation of its future architecture.

The new architecture should facilitate step-up authentication and per-application permissions, based not only on the properties of users' accounts, but also on the state of these users' devices. To maximize security, Contoso wants to minimize persistent assignments of privileged roles for identity and access management. In addition, the usage of privileged accounts needs to be closely monitored, audited, and reviewed regularly.

Similar measures should be incorporated into the solution for providing Fabrikam users with access to Contoso's applications. While the InfoSec team wants full transparency of the authorization process, access control and reviews should be delegated to the application owners.
 
Another information security concern is the protection of users' passwords. Contoso aims to minimize their use in lieu of more secure authentication methods. In situations where passwords are required, any indication of password misuse or exposure should be promptly identified and remediated. Furthermore, any on-premises Active Directory user account restrictions, such as allowed sign-in hours, must be honored. Similarly, the existing Active Directory password policies must apply, although the head of Information Security would like to enhance them by preventing the use of common terms within password values.

## Initial architecture

:::image type="content" source="../media/initial-architecture.png" alt-text="Diagram showing Contoso's initial architecture." lightbox="../media/initial-architecture.png":::

## Design requirements

The CIO of Contoso defined the following set of requirements that the technology team must address in its design of a Microsoft Entra ID-based architecture for identity and access:

- Ensure that remote users can sign in to their devices using their Active Directory credentials without relying on VPN or DirectAccess.
- Enforce user sign-in hours and password policies defined in on-premises AD DS domains.
- Simplify user sign-in experience by minimizing the number of sign-in prompts and limiting the use of passwords in lieu of more secure authentication methods.
- In situations where passwords are required, promptly identify and remediate events of password misuse or exposure.
- Allow designated members of the IT staff to temporarily elevate their privileges for delegated identity and resource management. All elevation events must be approved and audited. The list of designated members and their respective privileges must be reviewed regularly.
- Control access to applications and resources by relying on a combination of multiple conditions, including users' group membership, state of their devices, and dynamically evaluated risk based on heuristics and globally collected security-related telemetry.
- Provide Contoso's remote users with access to on-premises Windows-based web applications that rely on Kerberos authentication.
- Provide users of Fabrikam with access to on-premises and cloud-based applications in a tightly controlled manner, with management delegated to the application owners. 

## High level conceptual questions

Before you start designing the solution based on Contoso's requirements, consider the following high-level conceptual questions:

- What is the mechanism for integrating AD DS and Microsoft Entra ID?
- Which authentication methods are available when integrating AD DS and Microsoft Entra ID?
- What are primary Microsoft Entra device identity options?
- Which Microsoft Entra services contribute to enhanced security in hybrid scenarios?
- What are the AD DS-specific benefits provided by Microsoft Entra ID in hybrid scenarios?
- Are there any Microsoft Defender XDR services that help enhance identity protection in hybrid scenarios?
- Is there a way to provide access to on-premises web-based applications that rely on Kerberos authentication without the need for allowing inbound connectivity? 
- Which Microsoft Entra services provide secure delegated identity and resource management?
- Which Microsoft Entra services facilitate delegated access to Microsoft Entra applications in business-to-business scenarios?

## Design questions

As you're architecting the solution based on the requirements of Contoso, answer the following design questions:

- Which hybrid authentication method or methods would you recommend to address the security needs of Contoso?
- Which device identity option or options would you recommend for remote Contoso's users?
- Which Microsoft Entra services would allow Contoso to enhance security of their on-premises AD DS environment? 
- Which Microsoft Defender XDR services would allow Contoso to enhance security of their on-premises AD DS environment? 
- How would you use Microsoft Entra capabilities to provide access to the on-premises web-based applications?
- What mechanism would you use for delegated identity and resource management?
- How does the proposed solution reflect the use of the Zero Trust principles of verify explicitly, use least privilege access, and assume breach?
