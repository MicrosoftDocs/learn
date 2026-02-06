Azure Arc provides the foundation for extending Azure security capabilities to resources running outside Azure. As a security architect, your design for hybrid and multicloud security depends on how effectively you integrate non-Azure resources with Azure's security tools through Azure Arc.

## Understanding Azure Arc as the security foundation

Azure Arc projects resources from on-premises datacenters, other clouds (AWS, GCP), and edge locations into Azure Resource Manager. Once projected, these resources can use Azure's security services including Defender for Cloud, Azure Policy, and Microsoft Sentinel.

Azure Arc supports several resource types critical to security posture:

| Resource type | Arc capability | Security integration |
|--------------|----------------|---------------------|
| Physical and virtual servers | Arc-enabled servers | Defender for Servers, Azure Policy, VM extensions |
| Kubernetes clusters | Arc-enabled Kubernetes | Defender for Containers, Azure Policy for Kubernetes, GitOps |
| SQL Server instances | Arc-enabled SQL Server | Defender for SQL, Azure SQL best practices assessment |
| VMware vSphere VMs | Arc-enabled VMware | Unified inventory, guest management |
| AWS EC2, GCP VMs | Multicloud connector | Automated Arc onboarding, Defender integration |

**Design consideration**: Azure Arc is a prerequisite for Defender for Cloud protection on non-Azure resources. Plan Arc deployment as step 1 of your hybrid security strategy.

## Designing network connectivity for Arc

The Connected Machine agent requires outbound HTTPS connectivity to Azure. Your design must address how agents communicate while meeting security requirements:

**Direct connection**: Agents connect outbound over port 443 to Azure public endpoints. Suitable when internet access is available and proxy complexity isn't warranted. Configure required URLs in firewalls.

**Proxy server**: Route agent traffic through existing proxies. All connections remain outbound only. Ensure proxy allows the required Azure endpoints.

**Azure Arc gateway**: Reduces the number of required endpoints from many to eight for agent connectivity. Simplifies firewall rules and proxy configuration. Requires internet access but minimizes endpoint sprawl.

**Private Link**: For environments requiring private connectivity, Arc supports Azure Private Link. Agent traffic routes through ExpressRoute or VPN without traversing the public internet. Requires additional configuration for each extension's endpoints.

**Design consideration**: Don't use Log Analytics gateway as a proxy for the Connected Machine agent—it isn't supported. For monitoring-only scenarios, configure the agent in Monitor mode to restrict capabilities to Azure Monitor functionality.

## Planning at-scale deployment

Individual agent installation doesn't scale for enterprise deployments. Design your onboarding approach based on existing infrastructure:

| Environment | Recommended method |
|-------------|-------------------|
| Active Directory domain | Group Policy deployment with service principal |
| Configuration Manager managed | PowerShell scripts or custom task sequences |
| Ansible managed | Ansible playbooks |
| VMware vSphere | Arc-enabled VMware with guest management |
| AWS EC2 instances | Multicloud connector with autoprovisioning |
| GCP VMs | OS Configuration agent with autoprovisioning |

For at-scale deployment, use a service principal rather than interactive authentication. Create a dedicated service principal with the Azure Connected Machine Onboarding role and limit its scope to specific resource groups.

**Design consideration**: When connecting Windows or Linux servers with SQL Server installed, the SQL Server instances automatically connect to Arc as well. If this behavior isn't desired, tag servers with `ArcSQLServerExtensionDeployment: Disabled` during onboarding.

## Designing agent security controls

The Connected Machine agent supports several security configurations to limit functionality based on your requirements:

**Extension allowlist**: Restrict which extensions can deploy on Arc-enabled servers. Create an allow list of approved extensions to prevent unauthorized software installation.

**Monitor mode**: Configure agents for monitoring only by restricting to a Microsoft-managed extension allow list, disabling remote connectivity, and disabling the machine configuration agent. Use when Arc's purpose is purely observability.

**Local agent controls**: The `azcmagent` command-line tool allows local administrators to configure agent behavior, lock down connectivity options, and manage extensions.

## Integrating Arc with Defender for Cloud

Once resources connect through Arc, enable Defender for Cloud protection:

**Servers**: Arc-enabled servers appear in Defender for Cloud inventory alongside Azure VMs. Enable Defender for Servers to deploy Microsoft Defender for Endpoint, vulnerability assessment, and just-in-time access.

**Kubernetes**: Arc-enabled Kubernetes clusters integrate with Defender for Containers for runtime threat detection, vulnerability scanning, and security posture assessment. Deploy the Defender sensor and Azure Policy extension.

**SQL Server**: Arc-enabled SQL Server instances integrate with Defender for SQL for threat detection and vulnerability assessment. The Azure extension for SQL Server deploys automatically during Arc onboarding.

**Design consideration**: For multicloud scenarios (AWS, GCP), use Defender for Cloud's native connectors alongside Arc. The connectors autodiscover resources and can automatically provision Arc agents, simplifying deployment.

## Organizing Arc resources for governance

Design your resource hierarchy to support security governance:

**Resource groups**: Create dedicated resource groups for Arc-enabled resources, organized by environment (production, development), location, or business unit. This organization enables Azure Policy assignment at appropriate scope.

**Tagging strategy**: Apply consistent tags for owner, environment, compliance requirements, and cost center. Tags enable filtering in Defender for Cloud and organizing security recommendations.

**Azure Policy**: Assign policies to Arc-enabled servers just like Azure VMs. Use built-in policies for security baselines, or create custom policies for organization-specific requirements. Policies evaluate configuration and can deploy extensions automatically.

## Addressing common design challenges

**Disconnected scenarios**: Arc-enabled servers require periodic connectivity to Azure (at least every 30 days by default). For occasionally connected scenarios, plan for this requirement. Arc-enabled Kubernetes clusters support GitOps for configuration even during disconnection.

**Network segmentation**: If Arc resources exist in restricted network segments, aggregate traffic through proxies or deploy Arc gateway to minimize firewall openings.

**Identity and access**: Arc-enabled resources use managed identity for Azure authentication. The system-assigned managed identity enables secure access to Azure services without credential management.

**Compliance boundaries**: For data residency requirements, Arc metadata stores in the region you specify during onboarding. Ensure this aligns with compliance requirements.

Your Azure Arc design directly determines whether Defender for Cloud, Azure Policy, and Microsoft Sentinel can protect hybrid and multicloud workloads. Prioritize Arc onboarding coverage to maximize your unified security posture.
