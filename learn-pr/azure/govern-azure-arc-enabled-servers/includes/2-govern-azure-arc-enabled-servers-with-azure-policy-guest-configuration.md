Fabrikam Residences needs to audit and manage operating system settings across its Azure Arc-enabled servers. Azure Machine Configuration provides this capability. Its agent is included in the Azure Connected Machine agent on Arc-enabled servers. On Azure virtual machines (VMs), Machine Configuration uses a separate VM extension.

## Audit and configure machine settings

Azure Machine Configuration audits or configures operating system, application, and environment settings as code. You can assign configurations to individual machines or use Azure Policy to assign them at scale. For details, see Azure Machine Configuration overview in More Info in the Summary unit.

Azure Policy determines which resources are in scope and reports compliance. Machine Configuration evaluates the settings inside the operating system. This distinction lets Fabrikam apply the same configuration requirements to existing servers and to new servers that enter a policy assignment's scope.

Machine Configuration supports the following behaviors when the configuration package and policy support them:

| Mode | Behavior |
| --- | --- |
| Audit | Evaluates settings and reports compliance without changing the machine. |
| Apply and monitor | Applies the configuration, then reports subsequent drift without automatically correcting it. |
| Apply and autocorrect | Applies the configuration and corrects subsequent drift to maintain the desired settings. |

For example, Fabrikam can audit its current configuration before choosing a configuration-capable policy to apply an approved setting. Check the policy's supported operating systems, parameters, and effect before assignment. Test configuration changes on a small group of machines before expanding the scope.

> [!NOTE]
> Not every built-in policy can change settings. The **Windows machines should meet requirements of the Azure compute security baseline** policy used in the next unit is audit-only. Selecting enforcement for an Azure Policy assignment doesn't turn an audit-only policy into a configuration-enforcement policy.

For configuration management beyond built-in definitions, you can author a custom configuration package and assign it through Azure Policy. See Machine Configuration assignment resources in More Info in the Summary unit.

## Use built-in policies

Built-in policies for Arc-enabled servers include scenarios such as auditing security baseline settings, checking Windows security options, and configuring the Windows time zone. The policy definition determines whether a scenario audits settings or applies configuration.

Start with Azure Policy built-in definitions for Azure Arc-enabled servers in More Info in the Summary unit. Review the definition rather than assuming that all policies in an initiative have the same effect or remediation behavior.

## Understand disconnected behavior

Azure Arc-enabled servers require connectivity for cloud management. When a machine disconnects, its Azure Policy assignments remain in place, but local configuration assignments have a limited lifetime:

- Local configuration assignments are retained for 14 days.
- If the Connected Machine agent reconnects within that period, policy assignments are reapplied.
- After 14 days, local assignments are deleted and aren't automatically reassigned to the machine.

Don't design a disconnected configuration-management solution around this temporary retention. Restore connectivity and review assignments and compliance. See Troubleshoot Arc connectivity in More Info in the Summary unit.

## Plan for service costs

Azure Policy resource-governance capabilities don't incur an additional service charge. Machine Configuration is available at no additional charge for Azure VMs. For Arc-enabled servers, billable Machine Configuration usage is charged per managed server, prorated hourly, rather than per policy. Review Azure Policy pricing in More Info in the Summary unit for current rates and exclusions.

Benefits can reduce service charges for qualifying machines. For example, Windows Server Management enabled by Azure Arc includes Machine Configuration for eligible licenses after the required enrollment or attestation. Eligible VMs on Azure Local can also use Machine Configuration at no additional cost when they meet the Azure verification requirements. See Windows Server management benefits and Azure verification benefits in More Info in the Summary unit. Simply connecting a server to Azure Arc doesn't establish eligibility for every benefit.

Review the costs of the other services you enable, including data ingestion and retention in Log Analytics workspaces.
