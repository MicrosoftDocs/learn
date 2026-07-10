A *service account* is the security principal that provides the security context for a Windows service, scheduled task, or application. That context determines which local and network resources the process can access.

When a service starts, the Service Control Manager (SCM) signs in the configured account, builds an access token, and attaches it to the service process. Windows then evaluates that token against the security descriptor of every resource the service touches. Choosing the account is therefore a security decision: it sets privilege, isolates services from one another, and limits lateral movement if a service is compromised.

Services and scheduled tasks run unattended, with no interactive user signed in, yet they still need an identity to reach files, databases, and network services. A dedicated service account supplies that identity and lets you:

- **Apply least privilege**: Grant only the rights the workload needs, instead of borrowing a signed-in user's or an administrator's broad permissions.
- **Isolate and audit each service**: A distinct identity per service contains a compromise and makes security logs attributable to a single workload.
- **Authenticate to the network**: A domain identity with correct SPNs lets the service use Kerberos, mutual authentication, and delegation to reach remote resources.
- **Decouple from people**: The service keeps running when staff leave or change their passwords, because it doesn't depend on a human account.
- **Automate secrets**: Managed account types let Active Directory generate and rotate the password, which removes manual credential handling.

Service accounts replace two risky habits: 

- Running a service as a signed-in user
- Sharing one privileged account across many services 

Service accounts provide a controlled, auditable identity scoped to a single workload. While using service accounts is best practice, server administrators often face the following challenges when using them in their Windows Server environment:

- **Password lifecycle**: Manual rotation is error-prone, and an expired password stops the service from starting.
- **Over-privilege**: Running a service as Domain Admin or LocalSystem "to make it work" enlarges the blast radius of a compromise.
- **Shared or hard-coded credentials**: One account is reused across servers, with secrets embedded in scripts and configuration files.
- **SPN complexity**: Duplicate or missing service principal names (SPNs) break Kerberos authentication and the double-hop scenario.
- **Credential theft**: Kerberoasting, Pass-the-Hash, and credential harvesting target account secrets cached on member servers.
- **Sprawl**: Orphaned accounts are never decommissioned and are hard to audit.

## Learning objectives

By the end of this module, you're able to:

- Describe the purpose of service accounts and the common problems associated with them.
- Identify and configure the local service account types.
- Compare sMSA, gMSA, and dMSA, and select the correct managed account for a workload.
