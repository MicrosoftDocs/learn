Traditional virtual private network (VPN) access creates a dangerous assumption: if you're connected to the network, you're authorized to reach everything on it. Organizations often configure point-to-site and site-to-site VPN gateways with shared certificate authentication or outdated protocols like Internet Key Exchange version 1 (IKEv1), granting broad network-level access once the initial connection succeeds. When an attacker compromises credentials or a user loses a device, every application and resource within the virtual network becomes accessible—regardless of whether the user actually needs that access.

Contoso faces this exact challenge. Their 3,000 remote employees connect through point-to-site VPN using shared certificate authentication, and branch offices use site-to-site VPN with IKEv1. After a credential compromise incident, the security team discovered that any employee with VPN access could reach all Azure-hosted applications, creating significant risk. The chief information security officer (CISO) now requires both hardened connectivity configurations and a Zero Trust replacement that enforces per-application access controls.

In this module, you assess security risks in hybrid connectivity patterns, harden VPN gateway settings to reduce attack surface, and deploy Microsoft Entra Private Access to replace broad VPN access with granular, identity-based application access. You learn how to shift from network-level trust to application-level authorization. The switch ensures users can only reach the resources they need.

## Learning objectives

After completing this module, you'll be able to:

- Identify security risks in VPN gateway configurations for site-to-site and point-to-site connections
- Configure VPN gateway settings to reduce attack surface through stronger authentication and encryption
- Deploy Microsoft Entra Private Access to enforce Zero Trust application-level access for remote users
