### Process

![Process](../media/elements/process-50.png)

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

<ul><li>O365</li><li>Open-source bug management service</li><li>SaaS offerings (grouped)</li><li>GitHub</li><li>Machine</li><li>Firewall service</li><li>VPN service</li><li>NAS file share service</li><li>Logging and monitoring service</li><li>NAS backup service</li><li>SQL server</li><li>Build servers (grouped)</li><li>Active directory service</li><li>Removable drive backup service</li><li>Azure Iaas</li></ul>

#### Process labeling example

**O365** - O365/SaaS/AADauth (user credentials, session token, request/response)