Windows Firewall, which includes Windows Firewall with Advanced Security, is a host-based firewall that controls inbound and outbound network traffic through configurable rules. A feature of the Windows Server and Client operating systems, Windows Firewall supports domain, private, and public profiles, IPsec connection security, traffic monitoring, logging, and centralized management through Group Policy. Advanced firewall rules can do more than open ports, they can evaluate direction, protocol, application, service, address, profile, user identity, computer identity, policy source, and connection protection. Windows Firewall also can record evidence for operations and incident response.

After this module, you'll be able to:

- Build precisely scoped firewall rules.
- Apply profile-specific policy.
- Design host-based segmentation.
- Explain Internet Protocol security protection.
- Authorize traffic by user and computer identity.
- Coordinate firewall rules with connection security rules.
- Control outbound traffic selectively.
- Collect firewall evidence.
- Troubleshoot effective policy and security associations.

> [!NOTE]
> In this module the names Windows Firewall and Windows Firewall with Advanced Security are used interchangeably. These are the same product with different management surfaces. Everything runs on the Windows Defender Firewall service (`MpsSvc`), which sits on top of the Base Filtering Engine (`BFE`) and the Windows Filtering Platform. Whichever UI you use, you're writing to the same policy store and the same filters get installed. This module focuses on what is traditionally the functionality exposed through the Windows Firewall with Advanced Security console.
