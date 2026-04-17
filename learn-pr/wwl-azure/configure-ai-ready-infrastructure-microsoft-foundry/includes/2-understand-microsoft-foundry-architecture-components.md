## The three-tier organizational model

When your organization deploys AI at scale, you need infrastructure that balances centralized governance with team autonomy. Microsoft Foundry addresses this challenge through a three-tier hierarchy that mirrors how enterprises actually organize work. At the top, the Microsoft Foundry Portal provides a unified management interface where IT leadership views all AI initiatives across departments. With this single pane of glass, your CTO can monitor spending, track project health, and identify underutilized resources without switching between multiple Azure services.

Beneath the Portal, hubs establish shared governance boundaries—typically aligned with departments, environments, or compliance requirements. Your organization might create a Production Hub for customer-facing applications that enforces strict network isolation and a Development Hub where data scientists experiment with public endpoints. Each hub contains configuration that automatically applies to every project within it: virtual network integration managed identities for authentication, and Azure Policy assignments that prevent teams from deploying noncompliant resources. This inheritance model reduces your operational overhead by 40-60% compared to configuring security settings separately for each AI project.

Projects sit at the bottom tier as isolated workspaces where teams build AI solutions. Think of projects as dedicated folders within a shared drive—each team has full autonomy to train models, manage datasets, and deploy applications while inheriting the hub's network and security settings. The Support Team's chatbot project and the Sales Team's forecasting project both live in the same Production Hub, sharing network rules and managed identities while maintaining separate code, data, and model repositories. This structure answers the common challenge: "How do we let teams move fast without creating security or compliance gaps?"

:::image type="content" source="../media/hub-level-policy-inheritance.png" alt-text="Diagram showing hub-level policy inheritance with three lanes.":::

## Connected resources and the sharing model

Now that you understand the three-tier hierarchy, consider how Azure services integrate with this architecture. Connected resources—like Azure AI Search, Azure OpenAI Service, Azure Storage, and Application Insights—attach at either the hub or project level depending on whether they're shared or dedicated. Hub-level connections make the most impact: when you connect Azure AI Search at the hub level, all projects within that hub can query the same search service without duplicating configuration or incurring separate costs. Your five AI projects share one Standard-tier search instance instead of each provisioning its own Basic tier, cutting your monthly search spend from **$1,250** to **$250**.

With this shared connection in place, project teams maintain logical isolation through separate search indexes. The E-commerce Bot Project queries the Product Catalog index containing 2 million product documents, while the Support Agent Project queries the Knowledge Base index with 500,000 troubleshooting articles. Both indexes live in the same hub-connected search service, yet each project only accesses its authorized data. At the same time, your centralized operations team monitors performance, manages capacity, and reviews audit logs from a single Azure AI Search resource instead of tracking metrics across multiple isolated instances.

Project-level connections serve scenarios requiring dedicated resources. If your healthcare application needs an isolated Azure OpenAI deployment with specific data residency guarantees, you connect that service directly to the Healthcare Project rather than sharing it hub-wide. This flexibility becomes essential when compliance, performance, or cost allocation requirements demand separation. However, most organizations start with hub-level connections for common services like search and storage, then add project-specific connections only when justified by regulatory or technical constraints.

## Identity, networking, and policy inheritance

Building on this foundation of shared and dedicated resources, examine how hubs enforce consistent security across projects. When you provision a hub, Azure creates a system-assigned managed identity that authenticates to connected services without storing credentials. This managed identity rotates automatically, eliminating the security risk of long-lived API keys scattered across project code. Your hub's managed identity receives the Search Index Data Reader role on the connected Azure AI Search service, and every project inheriting that connection uses the same identity—your security team audits one permission assignment instead of 15.

Network configuration follows the same inheritance pattern. Configure the hub with a virtual network integration and private endpoint to your on-premises data center, and all child projects automatically route traffic through that secure path. Developers building the Customer Insights Project never see network configuration options—they inherit the Production Hub's network topology and focus on training models. This becomes especially important when your compliance team requires network traffic logs: Azure Network Watcher captures packets at the hub level, providing unified visibility across all AI workloads instead of requiring per-project monitoring.

Azure Policy assignments applied at the hub scope cascade to projects, preventing teams from accidentally violating organizational standards. Assign a policy requiring specific tags on all resources (CostCenter, DataClassification, Owner), and every storage account or compute instance deployed in any project automatically inherits those requirements. If a developer attempts to create a resource without required tags, Azure blocks the deployment with a clear error message pointing to the policy definition. With this approach, your governance team defines rules once at the hub level and enforces them consistently across dozens of projects without manual audits.

:::image type="content" source="../media/azure-policy-hub-scope-cascade.png" alt-text="Diagram showing Azure Policy assignments applied at the hub scope cascade to projects.":::

## Practical organizational patterns

Consider what happens when your organization scales from three pilot projects to 20 production applications across five business units. Create separate hubs for Production, Staging, and Development environments provide clear promotion paths with appropriate security boundaries. Development hubs use public endpoints and relaxed policies to maximize experimentation velocity, while Production hubs enforce private endpoints, require multifactor authentication for administrative access, and log every API call to Azure Monitor. Projects move through this pipeline: data scientists build prototypes in Development, DevOps engineers validate configurations in Staging, and only approved applications graduate to Production.

Now that you understand how hubs, projects, and connected resources interact, you're ready to configure these components in your Azure subscription. The next unit walks through the specific settings and decisions you'll make when provisioning hubs and organizing projects to support your organization's AI initiatives.

:::image type="content" source="../media/foundry-three-tier-architecture.png" alt-text="Diagram showing the Microsoft Foundry three-tier architecture showing Portal managing multiple hubs.":::

*Microsoft Foundry three-tier architecture showing Portal managing multiple hubs, each hub containing projects with shared connections to Azure AI Search, Azure OpenAI Service, and Azure Storage at the hub level*


## More resources

- [Microsoft Foundry documentation](/azure/ai-studio/) - Official architecture overview and service limits
- [Managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/overview) - Authentication and credential rotation patterns


