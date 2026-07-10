Apply these practices to keep service accounts secure, reliable, and manageable. They build on the account types covered earlier in this module.

## Choose and scope the account

Select an account that fits the workload and grants only what it needs:

- **Prefer managed accounts**: Use a virtual account, sMSA, gMSA, or dMSA before a standard user account, so Active Directory manages the password and SPNs.
- **Match the account to the topology**: Use a virtual account or sMSA for a single server, a gMSA for a farm, NLB, or cluster, and a dMSA for high-security or anti-Kerberoasting scenarios.
- **Apply least privilege**: Grant only the rights and resource permissions the workload needs. Avoid Domain Admins and LocalSystem; use LocalService or NetworkService when no domain identity is required.
- **Use one account per workload**: Don't share an account across unrelated services or servers. Isolation limits blast radius and keeps audit logs attributable.

## Protect the credentials

Reduce the chance that an account's secret is stolen or misused:

- **Automate and rotate secrets**: Let managed accounts generate and rotate passwords. Where a password is unavoidable, make it long and random, rotate it regularly, and never hard-code it in scripts or configuration files.
- **Restrict logon rights**: Grant *Log on as a service* only, and deny interactive, Remote Desktop, and (where possible) batch logon so a person can't use the account.
- **Manage SPNs correctly**: Keep SPNs unique and accurate, and let managed accounts register them. Duplicate SPNs break Kerberos.
- **Constrain delegation**: Avoid unconstrained delegation. Use constrained or resource-based constrained delegation, and enforce AES (disable RC4) for Kerberos.
- **Harden against theft**: Enable Credential Guard, and consider a dMSA to bind credentials to a device identity.

> [!NOTE]
> Don't enable Credential Guard on domain controllers. It provides no additional security on a domain controller and can cause application compatibility issues. Apply it to the member servers that run your services instead.

## Operate and audit

Keep accounts accountable and healthy throughout their lifecycle:

- **Govern the lifecycle**: Keep an inventory with an owner and purpose for each account, store accounts in a dedicated organizational unit (OU), and decommission unused accounts to prevent sprawl.
- **Monitor usage**: Audit service account logons and privileged actions, and alert on anomalous sign-ins and Kerberoasting indicators.
- **Validate before you enforce**: Confirm deployment with `Test-ADServiceAccount`. For a dMSA migration, verify that every host supports dMSA, and allow replication and ticket-lifetime windows before the old account is disabled.
