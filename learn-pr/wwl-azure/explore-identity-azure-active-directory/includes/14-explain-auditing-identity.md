There's a need to understand the value and purpose of audits in your identity solution. Auditing provides a way for an administrator to detect an attack that has already occurred or is in progress. Also, auditing is a tool for compliance and tracking what identity did what. In addition, auditing can help a developer to debug security-related problems. For example, if an error in the configuration of the authorization or checking policy accidentally denies access to an authorized user, a developer can quickly discover and isolate the cause of this error by examining the event log.

Every activity from sign-in, to a password change to the configuration and usage of multifactor authentication can be logged, reported, and monitored.  These logs give the identity administrator a resource to review how the identity and access solution is running. Healthy auditing practices keep your identities safe, which in turn keep your data and solutions safe.  Some of the different logs you want to be aware of for auditing are Microsoft Entra activity logs, sign-in logs, provisioning logs, and audit logs.  You can use several tools from Azure Monitor to Microsoft Sentinel to report and monitor.

### Understand concept of governance
Merriam-Webster dictionary says governance is the act or process of overseeing the control and direction of a system.  That system could be a government, a budget, or an identity solution on Azure.  Governance has processes and controls in place to both operate the systems and to evaluate the accountable running of the system.
It's never enough to build a solution and then forget it.  You have to monitor its running, update the processes regularly, remove or replace outdated features, and so on.  If you don't, the system is slowly going to degrade and fail.  Governance is the same with an identity management solution you build on Azure.  You must monitor, assess, and update the system over time.

| Scenario | The simple but probably story |
| :----- | :----- |
| Juan the app developer | You have a user by the name of Juan.  Juan is given an account in your company and works for several years.  Over that time, the user is given admin access to deploy an application Juan helped to build.  Later Juan leaves the company in good regard; however, the user account is never removed from the system. Juan's manager forgot to submit the paperwork to close the account. There's no governance system in place to notice the account is unused and that Juan is no longer listed in the HR systems.  A year later, Juan falls victim of a phishing email and has a personal username and password stolen.  Being like many people, Juan used a similar password for personal life and work accounts.  Guess what, you now have a scenario where your systems could be broken into, by what appears to be a valid account. |

Why governance?  In this scenario, governance could help in many different areas:
- Checking with HR regularly to see if all the accounts still exist in the HR database as employees.
- Checking to see when the last time an account was logged into.
- Checking to see whether the account needs all the rights it currently has.
- Checking to ensure that passwords are changed regularly; or better yet that your employees use MFA.
- And many other ways.

### Understand concept of identity lifecycle management
Identity lifecycle management is the foundation for Identity Governance, and effective governance at scale requires modernizing the identity lifecycle management infrastructure for applications. Identity Lifecycle Management aims to automate and manage the entire digital identity lifecycle process.

Managing digital identities is a complex task.  You have to correlate real-world objects, such as a person and their relationship with an organization. Think of the user as an employee of the organization, with a digital representation. In small organizations, keeping the digital representation of individuals who require an identity can be a manual process. When someone is hired, or a contractor arrives, an IT specialist can create an account for them in a directory. Then they're assigned the access they need. However, in mid-size and large organizations, automation can enable the organization to scale. Automation enables IT to keep the identities accurate.

The typical process for establishing identity lifecycle management in an organization follows these steps:
1. Are there already systems of record: data sources, which the organization treats as authoritative. For example, the organization might have an HR system. That system is authoritative for providing the current list of employees, and some of their properties such as the employee's name or department.
2. Compare the system of record with one or more directories and databases used by applications, and resolve any inconsistencies between the directories and the systems of record.
3. Determine what processes can be used to supply authoritative information for visitors. It is necessary to find an alternate way to determine when a digital identity for a visitor is no longer needed.

#### Identity lifecycle management strategy
You have to plan for identity-lifecycle-management for employees, or other individuals with an organizational relationship. With each contractor or student, many organizations model the "join, move, and leave" process. Definition for join, move, and leave are:
- **Join** - when an individual comes into scope of needing access, an identity is needed by those applications, so a new digital identity might need to be created if one isn't already available.
- **Move** - when an individual moves between boundaries, extra access authorization is required to be added or removed to their digital identity.
- **Leave** - when an individual leaves the scope of needing access, access might need to be removed, and the identity is no longer be required by applications other than for audit or forensics purposes.

For example, if a new employee joins your organization, who has never been affiliated with your organization before, that employee requires a new digital identity, represented as a user account in Microsoft Entra ID. The creation of this account would fall into a "Join" process, which could be automated. Later, if your organization has an employee move from say, Sales to Marketing, they would fall into a "Move" process. A "Move" requires removing the access rights the user had in the Sales organization, which they no longer require. Then, granting them rights in the Marketing organization that they now require.

### Monitoring tools
Always think **Zero Trust**: Verify explicitly - Use least privilege access - Assume breach

Monitoring services:
- Azure Monitor
- Application Insights
- Azure Service Health
- Azure Resource Health
- Azure Resource Manager
- Azure Policy
