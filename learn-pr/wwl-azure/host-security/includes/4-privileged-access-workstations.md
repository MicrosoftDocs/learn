
Privileged Access Workstations (PAWs) provide a dedicated system for sensitive tasks that is protected from Internet attacks and threat vectors. Separating these sensitive tasks and accounts from the daily use workstations and devices provides very strong protection from phishing attacks, application and OS vulnerabilities, various impersonation attacks, and credential theft attacks such as keystroke logging, Pass-the-Hash, and Pass-The-Ticket.

## PAW workstations

PAW is a hardened and locked down workstation designed to provide high security assurances for sensitive accounts and tasks. PAWs are recommended for administration of identity systems, cloud services, and private cloud fabric as well as sensitive business functions. In order to provide the greatest security, PAWs should always run the most up-to-date and secure operating system available: Microsoft strongly recommends Windows 10 Enterprise, which includes several additional security features not available in other editions (in particular, Credential Guard and Device Guard).

The PAW security controls are focused on mitigating high impact and high probability risks of compromise. These include mitigating attacks on the environment and risks that can decrease the effectiveness of PAW controls over time:

 -  **Internet attacks** \- Isolating the PAW from the open internet is a key element to ensuring the PAW is not compromised.
 -  **Usability risk** \- If a PAW is too difficult to use for daily tasks, administrators will be motivated to create workarounds to make their jobs easier.
 -  **Environment risks** \- Minimizing the use of management tools and accounts that have access to the PAWs to secure and monitor these specialized workstations.
 -  **Supply chain tampering** \- Taking a few key actions can mitigate critical attack vectors that are readily available to attackers. This includes validating the integrity of all installation media (Clean Source Principle) and using a trusted and reputable supplier for hardware and software.
 -  **Physical attacks** \- Because PAWs can be physically mobile and used outside of physically secure facilities, they must be protected against attacks that leverage unauthorized physical access to the computer.

## Architecture overview

The diagram below depicts a separate "channel" for administration (a highly sensitive task) that is created by maintaining separate dedicated administrative accounts and workstations.

:::image type="content" source="../media/az500-privilege-access-workstation-4bb97cdf.png" alt-text="A separate channel for administration created by maintaining separate dedicated administrative accounts and workstations.":::


This architectural approach builds on the protections found in the Windows 10 Credential Guard and Device Guard features and goes beyond those protections for sensitive accounts and tasks.

This methodology is appropriate for accounts with access to high value assets:

 -  **Administrative Privileges** \- PAWs provide increased security for high impact IT administrative roles and tasks. This architecture can be applied to administration of many types of systems including Active Directory Domains and Forests, Microsoft Azure Active Directory tenants, Microsoft 365 tenants, Process Control Networks (PCN), Supervisory Control and Data Acquisition (SCADA) systems, Automated Teller Machines (ATMs), and Point of Sale (PoS) devices.
 -  **High Sensitivity Information workers** \- The approach used in a PAW can also provide protection for highly sensitive information worker tasks and personnel such as those involving pre-announcement Merger and Acquisition activity, pre-release financial reports, organizational social media presence, executive communications, unpatented trade secrets, sensitive research, or other proprietary or sensitive data. This guidance does not discuss the configuration of these information worker scenarios in depth or include this scenario in the technical instructions.

Securing privileged access is a critical first step to establishing security assurances for business assets in a modern organization. The security of most or all business assets in an IT organization depends on the integrity of the privileged accounts used to administer, manage, and develop.

### Jump Box

Administrative "Jump Box" architectures set up a small number administrative console servers and restrict personnel to using them for administrative tasks. This is typically based on remote desktop services, a 3rd-party presentation virtualization solution, or a Virtual Desktop Infrastructure (VDI) technology.

This approach is frequently proposed to mitigate risk to administration and does provide some security assurances, but the jump box approach by itself is vulnerable to certain attacks because it violates the **clean source** principle. The clean source principle requires all security dependencies to be as trustworthy as the object being secured.

:::image type="content" source="../media/az500-privilege-access-workstation-2-e52af184.jpg" alt-text="A simple control relationship between a subject and object.":::


This figure depicts a simple control relationship. Any subject in control of an object is a security dependency of that object. If an adversary can control a security dependency of a target object (subject), they can control that object.

The administrative session on the jump server relies on the integrity of the local computer accessing it. If this computer is a user workstation subject to phishing attacks and other internet-based attack vectors, then the administrative session is also subject to those risks.

While some advanced security controls like multifactor authentication can increase the difficulty of an attacker taking over this administrative session from the user workstation, no security feature can fully protect against technical attacks when an attacker has administrative access of the source computer (e.g. injecting illicit commands into a legitimate session, hijacking legitimate processes, and so on.)

The default configuration in this PAW guidance installs administrative tools on the PAW, but a jump server architecture can also be added if required.

:::image type="content" source="../media/az500-privilege-access-workstation-3-7cee61a2.png" alt-text="A jump box sits between an attacker and a protected workstation.":::


This above figure shows how reversing the control relationship and accessing user apps from an admin workstation gives the attacker no path to the targeted object. The user jump box is still exposed to risk so appropriate protective controls, detective controls, and response processes should still be applied for that internet-facing computer.
