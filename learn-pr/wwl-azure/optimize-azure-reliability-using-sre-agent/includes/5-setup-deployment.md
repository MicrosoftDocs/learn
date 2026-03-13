Deploying Azure SRE Agent requires readiness in identity, permissions, connectivity, and telemetry. This unit outlines a practical setup path for first deployment.

## Prerequisites

To deploy Azure SRE Agent, the following prerequisites must be in place before you begin the creation process:

- An **active Azure subscription** with sufficient permissions to create resources and assign roles.
- Permissions to assign RBAC roles at the subscription or resource group level (`Microsoft.Authorization/roleAssignments/write`). This is typically held by users with the **Owner** or **User Access Administrator** role.
- Network access to the `*.azuresre.ai` domain. If your organization uses network security groups, firewalls, or proxy servers, ensure that outbound connectivity to this domain is allowed. The agent communicates with Microsoft-hosted services over this endpoint.
- Deployment in a **supported region**. At the time of writing, Azure SRE Agent is available in a limited set of regions. For example, **Sweden Central**, **East US 2** and **Australia East** to provide global coverage.
- **Azure Monitor and Application Insights** should be configured for the resources you want the agent to monitor. While the agent can function with basic Azure platform metrics, its diagnostic capabilities are enhanced when Application Insights is enabled for application-level telemetry (request traces, dependency tracking, exception logging).

## Creating an Azure SRE Agent

The deployment process is straightforward and takes place entirely within the Azure portal:

1. In the **Azure portal**, search for **Azure SRE Agent** in the top search bar.
2. Select **Create Agent** from the service landing page.
3. Create or select a **dedicated Resource Group** for the agent itself. It is a best practice to keep the agent's own resources separate from the application resources it monitors. This separation simplifies RBAC management and prevents accidental deletion of the agent during application resource group cleanup operations.
4. Choose a **supported region**. The agent's region doesn't need to match the region of the resources it monitors.
5. **Associate one or more Resource Groups to monitor.** The agent automatically gains visibility into all resources within the associated Resource Groups. You can associate more Resource Groups after initial deployment.
6. Complete the deployment and wait for the agent to initialize. Initialization typically takes a few minutes as the agent establishes connections to telemetry sources and builds its initial understanding of resource topology.

Once deployed, the agent's **chat interface** becomes available directly in the Azure portal. You can begin interacting with the agent immediately. Asking diagnostic questions, investigating recent alerts, or reviewing the health of monitored resources.

## Connecting a code repository

Azure SRE Agent can be linked to source code repositories to enable **code-aware diagnosis** and **automated work item creation**. Repository connection transforms the agent from a purely infrastructure-focused tool into one that understands the relationship between code changes and production behavior. To also meet the requirements of DevOps teams, within the broader organization's SRE scope.

Both **GitHub** (Cloud) and **Azure DevOps Organizations** are supported.

## Connecting to other sources

Apart from source code integration, **Azure SRE Agent Connectors** are available to extend reach to external systems, such as Kusto clusters, collaboration tools, custom APIs, and MCP Servers. Connectors give your agent access to data and actions, such as querying logs, sending notifications, and reading code.

Some common examples for SRE teams:
- Database queries to Azure Data Explorer
- Integration with GitHub MCP Server tools to reach wiki knowledge and documentation
- Collaboration connectors to Outlook or Teams for sending notifications
- Generic MCP Server support to connect your agent to any system (for example your on-premises databases, multi-cloud application information, third-party platforms such as DataDog, Splunk, Grafana and other).

## Identity, permissions, and security

The SRE Agent operates under a **system-assigned managed identity** that is automatically created during deployment. This identity is the sole mechanism through which the agent accesses Azure resources—it never uses shared keys, connection strings, or personal access tokens.

Key considerations for configuring the agent's identity:

- **Grant least privilege by default.** Start with read-only permissions (`Reader`, `Monitoring Reader`, `Log Analytics Reader`) and only add write permissions (`Contributor`, `Website Contributor`) when you're ready to enable approval-gated remediation actions.
- **Separate read and write permissions explicitly.** Diagnostic capabilities (querying logs, examining configuration) require read access. Remediation capabilities (slot swaps, restarts, scaling) require write access. Granting these permissions separately gives you fine-grained control over the agent's operational scope.
- **Scope permissions to specific resource groups or resources.** Avoid granting subscription-level write permissions. Scope the agent's identity to the specific resource groups it monitors, following the principle of least privilege.
- **Apply the human-equivalence rule:** If a human engineer would need manager approval for an action (for example, modifying production configuration), the agent should require the same approval. Azure SRE Agent's approval gates enforce this by default for all write operations.
- **Review permissions regularly.** As more resource groups are onboarded or removed from the agent's monitoring scope, review and update RBAC assignments to prevent permission creep.