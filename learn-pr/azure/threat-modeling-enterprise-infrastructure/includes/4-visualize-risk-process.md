### Process

![Process element.](../media/elements/process-50.png)

#### What is process?

Process is a task that receives, modifies, or redirects input to output.

#### Process context to include

|Context|Questions|
|-------|---------|
|Code|Is this process running in C#, C++, Objective C, Java, or a scripting language?|
|Permission level|Does this process need kernel, local, or administration level permissions to run?|
|Service isolation|Is the process running in a sandbox?|
|Input|Can this process accept input from everyone, local accounts, or just administrators?|
|Validation|How does the process parse, handle and accept input?|
|Authentication|Does the process rely on Azure Active Directory for authentication? If not, what does it rely on?|
|Authorization|Does it rely on Access Control Lists (ACL) for authorization? If not, what does it rely on?|

#### Woodgrove process elements

- Microsoft 365
- Open-source bug management service
- SaaS offerings (grouped)
- GitHub
- Machine
- Firewall service
- VPN service
- NAS file share service
- Logging and monitoring service
- NAS backup service
- SQL server
- Build servers (grouped)
- Active directory service
- Removable drive backup service
- Azure Iaas

#### Process labeling example

**Microsoft 365** - Microsoft 365/SaaS/Azure ADauth (user credentials, session token, request/response)
