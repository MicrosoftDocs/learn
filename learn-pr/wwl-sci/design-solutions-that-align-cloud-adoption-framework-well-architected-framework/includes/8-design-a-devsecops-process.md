Security is a key part of DevOps. But how does a team know if a system is secure? Is it really possible to deliver a completely secure service?

Unfortunately, the answer is _no_. DevSecOps is a continuous and ongoing effort that requires the attention of everyone in both development and IT operations. While the job is never truly done, the practices that teams employ to prevent and handle breaches can help produce systems that are as secure and resilient as possible.

> "Fundamentally, if somebody wants to get in, they're getting in...accept that. What we tell clients is: number one, you're in the fight, whether you thought you were or not. Number two, you almost certainly are penetrated." -- Michael Hayden, Former Director of NSA and CIA

## The security conversation

Teams that don't have a formal DevSecOps strategy are encouraged to begin planning as soon as possible. At first there may be resistance from team members who don't fully appreciate the threats that exist. Others may not feel that the team is equipped to face the problem and that any special investment would be a wasteful distraction from shipping features. However, it's necessary to begin the conversation to build consensus as to the nature of the risks, how the team can mitigate them, and whether the team needs resources they don't currently have.

Expect skeptics to bring some common arguments, such as:

-   **How real is the threat?** Teams often don't appreciate the potential value of the services and data they're charged with protecting.
-   **Our team is good, right?** A security discussion may be perceived as doubt in the team's ability to build a secure system.
-   **I don't think that's possible.** This is a common argument from junior engineers. Those with experience usually know better.
-   **We've never been breached.** But how do you know? How _would_ you know?
-   **Endless debates about value.** DevSecOps is a serious commitment that may be perceived as a distraction from core feature work. While the security investment should be balanced with other needs, it can't be ignored.

## The mindset shift

DevSecOps culture requires an important shift in mindset. Not only do you need to _prevent_ breaches, but _assume_ them as well.

### Security strategy components

There are many techniques that can be applied in the quest for more secure systems.

- Preventing breaches
- Assuming breaches
- Threat models
- War game exercises
- Code reviews
- Central security monitors
- Security testing
- Live site penetration tests
- Security development lifecycle (SDL)

Every team should already have at least some practices in place for preventing breaches. Writing secure code has become more of a default, and there are many free and commercial tools to aid in static analysis and other security testing features.

However, many teams lack a strategy that assumes system breaches are inevitable. Assuming that you've been breached can be hard to admit, especially when having difficult conversations with management, but that assumption can help you answer questions about security on your own time. You don't want to figure it all out during a real security emergency.

Common questions to think through include:

-   How will you detect an attack?
-   How will you respond if there is an attack or penetration?
-   How will you recover from an attack, such as when data has been leaked or tampered with?

### Key DevSecOps practices

There are several common DevSecOps practices that apply to virtually any team.

First, focus on improving _mean time to detection_ and _mean time to recovery_. These metrics indicate how long it takes to detect a breach and how long it takes to recover, respectively. They can be tracked through ongoing live site testing of security response plans. When evaluating potential policies, improving these metrics should be an important consideration.

Practice _defense in depth_. When a breach happens, attackers can get access to internal networks and everything inside them. While it would be ideal to stop attackers before it gets that far, a policy of assuming breaches drives teams to minimize exposure from an attacker who has already gotten in.

Finally, perform periodic post-breach assessments of your practices and environments. After a breach has been resolved, your team should evaluate the performance of the policies, as well as their own adherence to them. Policies are most effective when teams actually follow them. Every breach, whether real or practiced, should be seen as an opportunity to improve.

## Strategies for mitigating threats

There are too many threats to enumerate them all. Some security holes are due to issues in dependencies like operating systems and libraries, so keeping them up-to-date is critical. Others are due to bugs in system code that require careful analysis to find and fix. Poor secret management is the cause of many breaches, as is social engineering. It's a good practice to think about the different kind of security holes and what they mean to the system.

### Attack vectors

Consider a scenario where an attacker has gained access to a developer's credentials. What can they do?

| Privilege | Attack |
|---|---|
| Can they send emails? | Phish colleagues |
| Can they access other machines? | Log on, mimikatz, repeat |
| Can they modify source | Inject code |
| Can they modify the build/release process? | Inject code, run scripts |
| Can they access a test environment? | If a production environment takes a dependency on the test environment, exploit it |
| Can they access the production environment? | So many options... |

How can your team defend against these vectors?

-   Store secrets in protected vaults
-   Remove local admin accounts
-   Restrict SAMR
-   Credential Guard
-   Remove dual-homed servers
-   Separate subscriptions
-   Multi-factor authentication
-   Privileged access workstations
-   Detect with ATP & Microsoft Defender for Cloud

### Secret management

All secrets must be stored in a protected vault. Secrets include:

-   Passwords, keys, and tokens
-   Storage account keys
-   Certificates
-   Credentials used in shared non-production environments, too

You should use a hierarchy of vaults to eliminate duplication of secrets. Also consider how and when secrets are accessed. Some are used at deploy-time when building environment configurations, whereas others are accessed at run-time. Deploy-time secrets typically require a new deployment in order to pick up new settings, whereas run-time secrets are accessed when needed and can be updated at any time.

Platforms have secure storage features for managing secrets in CI/CD pipelines and cloud environments, such as [Azure Key Vault](https://azure.microsoft.com/services/key-vault/) and [GitHub Actions](https://docs.github.com/actions/reference/encrypted-secrets).

### Helpful tools

-   [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) is great for generic infrastructure alerts, such as for malware, suspicious processes, etc.
-   [Source code analysis tools](https://owasp.org/www-community/Source_Code_Analysis_Tools) for static application security testing (SAST).
-   [GitHub advanced security](https://docs.github.com/github/getting-started-with-github/about-github-advanced-security) for analysis and monitoring of repos.
-   [mimikatz](https://github.com/gentilkiwi/mimikatz) extracts passwords, keys, pin codes, tickets, and more from the memory of `lsass.exe`, the Local Security Authority Subsystem Service on Windows. It only requires administrative access to the machine, or an account with the debug privilege enabled.
-   [BloodHound](https://bloodhound.readthedocs.io/) builds a graph of the relationships within an Active Directory environment. It can be used the red team to easily identify attack vectors that are difficult to quickly identify.

# Enable DevSecOps with Azure and GitHub

DevSecOps, sometimes called Secure DevOps, builds on the principles of [DevOps](https://azure.microsoft.com/overview/what-is-devops/) but puts security at the center of the entire application lifecycle. This concept is called “shift-left security”: it moves security upstream from a production-only concern to encompass the early stages of planning and development. Every team and person that works on an application is required to consider security.

Microsoft and GitHub offer solutions to build confidence in the code that you run in production. These solutions inspect your code and allow its traceability down to the work items and insights on the third-party components that are in use.

## Secure your code with GitHub

Developers can use code scanning tools that quickly and automatically analyze the code in a GitHub repository to find security vulnerabilities and coding errors.

You can scan code to find, triage, and prioritize fixes for existing problems. Code scanning also prevents developers from introducing new problems. You can schedule scans for specific days and times, or trigger scans when a specific event occurs in the repository, such as a push. You can also track your repository's dependencies and receive security alerts when GitHub detects vulnerable dependencies.

## Track your work with Azure Boards

Teams can use Azure Boards web service to manage software projects. Azure Boards provides a rich set of capabilities, including native support for Scrum and Kanban, customizable dashboards, and integrated reporting.

## Build and deploy containers with Azure Pipelines

Integrate Azure Pipelines and Kubernetes clusters with ease. You can use the same YAML documents to build multi-stage pipelines-as-code for both continuous integration and continuous delivery.

Azure Pipelines integrates metadata tracing into your container images, including commit hashes and issue numbers from Azure Boards, so that you can inspect your applications with confidence.

The ability to create deployment pipelines with YAML files and store them in source control helps drive a tighter feedback loop between development and operation teams who rely on clear, readable documents.

## Run and debug containers with Bridge to Kubernetes

Developing a Kubernetes application can be challenging. You need Docker and Kubernetes configuration files. You need to figure out how to test your application locally and interact with other dependent services. You might need to develop and test multiple services at once and with a team of developers.

Bridge to Kubernetes allows you to run and debug code on your development computer, while still connected to your Kubernetes cluster with the rest of your application or services. You can test your code end-to-end, hit breakpoints on code running in the cluster, and share a development cluster between team members without interference.

## Enforce container security with Microsoft Defender for Containers and Azure Policy

Microsoft Defender for Containers is the cloud-native solution for securing your containers.

## Manage identities and access with the Microsoft identity platform

The Microsoft identity platform is an evolution of the Azure Active Directory (Azure AD) developer platform. It allows developers to build applications that sign in all Microsoft identities and get tokens to call Microsoft APIs, such as Microsoft Graph, or APIs that developers have built.

Azure AD B2C provides business-to-customer identity as a service. Your customers use their preferred social, enterprise, or local account identities to get single sign-on access to your applications and APIs.

Access management for cloud resources is a critical function for any organization that uses the cloud. Azure role-based access control (Azure RBAC) helps you manage who has access to Azure resources, what they can do with those resources, and what areas they can access.

You can use the Microsoft identity platform to authenticate with the rest of your DevOps tools, including native support within Azure DevOps and integrations with GitHub Enterprise.

Currently, an Azure Kubernetes Service (AKS) cluster (specifically, the Kubernetes cloud provider) requires an identity to create additional resources like load balancers and managed disks in Azure. This identity can be either a managed identity or a service principal. If you use a service principal, you must either provide one or AKS creates one on your behalf. If you use managed identity, one will be created for you by AKS automatically. For clusters that use service principals, the service principal must be renewed eventually to keep the cluster working. Managing service principals adds complexity, which is why it's easier to use managed identities instead. The same permission requirements apply for both service principals and managed identities.

Managed identities are essentially a wrapper around service principals, and make their management simpler.

## Manage keys and secrets with Azure Key Vault

Azure Key Vault can be used to securely store and control access to tokens, passwords, certificates, API keys, and other secrets. Centralizing storage of application secrets in Key Vault allows you to control their distribution. Key Vault greatly reduces the chances that secrets may be accidentally leaked. When you use Key Vault, application developers no longer need to store security information in their application, which eliminates the need to make this information part of the code. For example, an application may need to connect to a database. Instead of storing the connection string in the app's code, you can store it securely in Key Vault.

## Monitor your applications

With Azure Monitor, you can monitor both your application and infrastructure in real-time, identifying issues with your code and potential suspicious activities and anomalies. Azure Monitor integrates with release pipelines in Azure Pipelines to enable automatic approval of quality gates or release rollback based on monitoring data.

Learn how to monitor your applications and infrastructure using Azure Application Insights and Azure Monitor.