**Identity administration** is how identity objects are managed over the lifetime of the identity’s existence. This administration can be manual or automated.  However, it has to be done.  Here's a simple example of what happens without governance and administration of your identities.

#### Story - the life of an identity
You have a user by the name of Juan.  Juan is given an account in your company and works for several years.  Over that time, the user is given admin access to deploy an application.  Later Juan leaves the company in good regard; however, the account is never removed from the system. A manager forgot to submit the paperwork to close the account. There's no governance system in place to notice the account is unused and that Juan is no longer listed in the HR systems.  A year later, Juan falls victim of a phishing email and has his personal username and password stolen.  Being like many people, Juan used a similar password for his personal life and his work accounts.  Guess what, you now have a scenario where your systems could be broken into. And the attack comes from what appears to be a valid account!

:::image type="content" source="../media/identity-lifecycle.png" alt-text="Diagram of life of an identity. Start, no access. Then job with access and identity created. Leave the company, then back to no access.":::

## Identity administration provides
- A system that is highly configurable around business processes
- The agility to scale resources according to demand
- Cost savings through the distribution and automation of management
- Flexibility around synchronization, proliferation, and change control

### Common identity administration tasks
There are many common tasks performed during identity administration.

**Identity Proliferation** - deals with the storage of identity objects within the environment.  Often, organizations have identities in places such as Active Directory, other directory services and application specific identity stores. 

**Provision and Deprovision** - are actually two separate capabilities. Provisioning speaks towards how identity objects are created within a system.  Deprovision focuses on the removal of an identity from having access (deletion, disablement of security principle or removal of access). 

**Identity Updates** - surrounds how identity information is updated throughout the environment. The idea is to move away from a manual effort to a more automated and streamlined approach.

**Synchronization** - is ensuring that identity systems within an environment are up to date with the latest identity information. This information is often crucial for determining access. The key things that influence this capability are how synchronization is performed whether it's manual, time-based or event driven.

**Password Management** - focuses on where and how passwords are set throughout the identity infrastructure.  In most organizations, the Service Desk is still the focal point for forgotten passwords.

**Group Management** - focuses on how an organization manages groups (for example, Active Directory and/or LDAP) within their environment.  Groups are one of the most common form for determining access permissions to resources and are expensive to manage and operate. 

**Application Entitlement Management** - defines on how identities are granted access to applications.  It focuses on providing coarse-grained application entitlements that are enforced as a capability contained within the Authorization pillar. On the other hand, fine-grained entitlements are managed as attributes relating to an identity.

**User Interface** - is how the end user is able to request, or make, updates to their identity information.  In many environments, users continue to contact the Service Desk for any updates to their identity information. 

**Change Control** - capability focuses on how changes flow through the environment whether manually completed by a Service Desk professional. There can be automation with or without workflow, which drives the change process. Some organizations still send emails to complete requests while others have rich and mature processes to execute the change.

## Identity management automation

| PowerShell | CLI (command line interface) |
| :--------------- | :--------------------------- |
| Cross-platform PowerShell runs on Windows, macOS, Linux | Cross-platform command-line interface, installable on Windows, macOS, Linux |
| Requires Windows PowerShell or PowerShell | Runs in Windows PowerShell, Command prompt, or Bash and other Unix shells |

| Scripting Language | Action | Command |
| :----------------- | :----- | :-----: |
| Azure CLI  | Create user  | `az ad user create --display-name "New User" --password  "Password" --user-principal-name NewUser@contoso.com` |
| Microsoft Graph | Create user | `New-MgUser -DisplayName "New User" -PasswordProfile Password -UserPrincipalName "NewUser@contoso.com" -AccountEnabled $true -MailNickName "Newuser“ `|

When picking the right tool, consider your past experience and current work environment. Azure CLI syntax is similar to that of Bash scripting. If you work primarily with Linux systems, Azure CLI feels more natural. PowerShell is the Microsoft scripting engine. If you work primarily with Windows systems, then PowerShell is a natural fit. Commands follow a verb-noun naming scheme and data is returned as objects.

### Microsoft Graph

:::image type="content" source="../media/graph-capabilities.png" alt-text="Diagram Microsoft Graph features.  Use graph to pull identity information from Microsoft Entra ID.":::

Microsoft Graph exposes REST APIs and client libraries to access data on the following Microsoft cloud services such as Microsoft Entra ID, Microsoft 365, devices, and many others.

- The Microsoft Graph API offers a single endpoint, `https://graph.microsoft.com`, to provide access to rich, people-centric data and insights in the Microsoft cloud, including Microsoft 365, Windows 10, and Enterprise Mobility + Security. You can use REST APIs or SDKs to access the endpoint and build apps that support Microsoft 365 scenarios. The access can span from productivity, to collaboration, to education. Microsoft Graph also includes a powerful set of services that manage user and device identity. You can determine and configure access, compliance, security, and help protect organizations from data leakage or loss.

- Microsoft Graph connectors work in the incoming direction, delivering data external to the Microsoft cloud into Microsoft Graph services and applications, to enhance Microsoft 365 experiences such as Microsoft Search. Connectors exist for many commonly used data sources such as Box, Google Drive, Jira, and Salesforce.

- Microsoft Graph Data Connect provides a set of tools to streamline secure and scalable delivery of Microsoft Graph data to popular Azure data stores. The cached data serves as data sources for Azure development tools that you can use to build intelligent applications.

Together, the Microsoft Graph API, connectors, and Data Connect power the Microsoft cloud services platform. With the ability to access Microsoft Graph data and other datasets, you can derive insights and analytics, extend Azure and Microsoft 365 by building unique, intelligent applications.
