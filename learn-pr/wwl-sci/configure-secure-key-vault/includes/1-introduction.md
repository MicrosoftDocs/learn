Contoso Health stores patient data encrypted with customer-managed keys, and Azure Key Vault is at the center of that security model—holding the encryption keys, application secrets, and certificates that services across the platform depend on. A recent security audit examined the production vaults and found three control gaps evolved since initial deployment. Vaults were created without purge protection enabled, leaving no barrier against permanent key deletion. Several developers held permanent Key Vault Administrator assignments with no expiration or approval requirement. The vaults were accessible from any public IP address because network isolation was never set up. None of these failures produce an error or alert on their own—they're silent until a key is destroyed, a credential is misused, or a breach investigation reveals there was no network boundary to breach.

## Recognize the deployment and access gaps

Purge protection isn't a feature you can retrofit easily after a vault reaches production. Soft delete recovers accidentally deleted objects; purge protection removes the ability to permanently destroy them before the retention period ends. Without it, anyone with sufficient privilege can permanently destroy an encryption key—and patient records encrypted with that key become unreadable with no recovery path.

The access control gap is subtler but operationally more dangerous. Permanent role assignments mean that every day a developer holds Key Vault Administrator, they're a credential theft away from unrestricted vault access, with no activation event logged in the audit trail. Just-in-time activation through Privileged Identity Management changes that calculus: access exists only when approved, and every activation is logged.

Network exposure compounds both problems. A vault reachable from any public IP is reachable from any attacker who obtains valid credentials. Private endpoint or firewall-restricted access doesn't eliminate credential risk, but it eliminates the attack surface available to someone trying to exploit those credentials remotely.

## Explore what this module covers

This module addresses each of the three audit findings. In this module, you:

- Deploy Azure Key Vault with soft delete, purge protection, and SKU selection enforced at creation time
- Configure RBAC-based access control, managed identity authentication, and just-in-time privilege activation using Privileged Identity Management
- Secure Key Vault network access using firewall rules, virtual network service endpoints, and private endpoints
- Choose the right network isolation model for your architecture and understand the security trade-offs of each option
