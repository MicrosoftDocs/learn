Extensions on Arc-enabled servers grant code execution with elevated privileges. Any user who can deploy an extension can effectively run arbitrary code on the target server, making extension control a critical security boundary. A misconfigured role assignment or a compromised privileged account can expose your entire hybrid infrastructure to unauthorized software installation or malicious activity.

## Use RBAC to control Arc server management

Azure provides two specialized built-in roles for Arc-enabled server management. Understanding when to use each role prevents over-privileging accounts and reduces blast radius if credentials are compromised.

The **Azure Connected Machine Onboarding** role grants the minimum privilege needed to connect servers to Azure Arc. Users or service principals with this role can create new Arc server resources but can't reonboard, delete, or modify existing resources. Crucially, this role can't deploy extensions. Use this role for accounts dedicated solely to server enrollment, such as automation service principals running in your on-premises environment.

The **Azure Connected Machine Resource Administrator** role grants full control over Arc-enabled servers, including the ability to deploy and remove extensions. Because extensions run with elevated privileges on the target machine, this role effectively grants root or administrator access to the underlying server. Treat this role with the same sensitivity you would grant to local administrator credentials. Consider using Azure Privileged Identity Management (PIM) for just-in-time elevation rather than persistent assignments.

| Role | Can Enroll Servers | Can Modify Existing Servers | Can Deploy Extensions | Recommended Use |
|------|-------------------|----------------------------|----------------------|-----------------|
| Azure Connected Machine Onboarding | Yes | No | No | Enrollment-only automation |
| Azure Connected Machine Resource Administrator | Yes | Yes | Yes | Operational management (use PIM) |

For Contoso Manufacturing, enrollment automation uses the Onboarding role. Operations staff receives Resource Administrator access through PIM with approval workflows, ensuring every extension deployment is traceable and authorized.

## Configure extension allow and block lists

Azure RBAC controls who can request extension deployments, but it operates at the cloud layer where privileged users can modify role assignments and policies. For defense in depth against insider threats or account compromise, the Azure Connected Machine agent supports extension allow and block lists configured directly on the server.

Extension lists are configured using the `azcmagent config` command on the Arc-enabled server itself. The agent enforces these lists locally, and Azure users can't override them, regardless of permissions. This agent-level control provides a security boundary independent of cloud-based access management.

An **allow list** specifies which extensions are permitted to install. When an allow list is configured, any extension not explicitly listed is blocked, even if a privileged Azure user requests deployment. Extension identifiers use the format `Publisher/Type` with a forward slash separator—for example, `Microsoft.Azure.Monitor/AzureMonitorLinuxAgent`. The command `azcmagent config set extensions.allowlist "Microsoft.Azure.Monitor/AzureMonitorLinuxAgent,Microsoft.Azure.AzureDefenderForServers/MDE.Linux"` permits only the Azure Monitor Agent and Microsoft Defender for Endpoint extensions on a Linux server.

A **block list** specifies extensions that are explicitly prohibited. All other extensions remain permitted. Use a block list when you want to allow most extensions but prevent specific ones known to conflict with your environment or security requirements.

The special value `"Allow/None"` creates a zero-extension mode where the agent runs and maintains connectivity to Azure but refuses all extension installation requests. This configuration is useful when Arc enrollment serves only to deliver Extended Security Updates (ESU) for legacy Windows Server instances, with no need for other management capabilities.

Extension deletion requests are always honored, regardless of allow or block list configuration. This design ensures you can always remove unwanted extensions.

| Configuration | Command Example | Behavior |
|--------------|-----------------|----------|
| Allow list | `azcmagent config set extensions.allowlist "Microsoft.Azure.Monitor/AzureMonitorLinuxAgent"` | Only listed extensions can install |
| Block list | `azcmagent config set extensions.blocklist "Microsoft.EnterpriseCloud.Monitoring/OMSAgentForLinux"` | Listed extensions can't install; all others permitted |
| Zero-extension mode | `azcmagent config set extensions.allowlist "Allow/None"` | No extensions permitted (ESU-only mode) |

## Use monitor mode for monitoring and security scenarios

For servers that need only monitoring and security extensions—such as Azure Monitor Agent and Microsoft Defender for Cloud—the agent's built-in monitor mode provides a simpler alternative to manually maintained allow lists. Enable it with a single command:

```bash
azcmagent config set config.mode monitor
```

In monitor mode, Microsoft maintains the approved extension list and updates it automatically as new monitoring and security extensions become available. The agent blocks any extension capable of changing system configuration or running arbitrary scripts. To check the current mode and see which extensions are allowed, run `azcmagent config list`.

Monitor mode has two important limitations: you can't modify the extension allow or block list while in monitor mode, and the Guest Configuration policy agent is disabled—meaning machine configuration policies (covered in the next unit) won't run. If you need machine configuration policies alongside extension restrictions, use a custom allow list in full mode instead.

To return to full mode: `azcmagent config set config.mode full`

## Combine agent-level and cloud-level controls

Azure Policy provides cloud-based extension governance at the subscription or management group scope, making it ideal for standardizing configurations across large deployments. However, anyone with policy authoring permissions can modify these assignments. Use Azure Policy to establish baseline requirements and deploy extensions automatically, but rely on agent-level allow lists as an immutable control that protects against malicious or accidental policy changes.

For Contoso's factory servers, the security team configures an allow list that permits only the Microsoft Defender for Endpoint extension, the ChangeTracking extension for File Integrity Monitoring, and the Machine Configuration extension for baseline compliance checks. Any other extension installation attempt—even from an Azure administrator with Resource Administrator role—silently blocking with the agent. This layered approach ensures that even if an Azure account is compromised, the attacker can't deploy arbitrary software to production servers.

With RBAC scoping who can manage servers and extension controls limiting what can run on them, you're ready to enforce security policies at scale using Azure Policy.
