Deploying a cloud-governance foundation accelerates your ability to govern your entire Azure environment. This unit outlines the considerations and implementations that are required to deploy a foundation that can achieve resource consistency and prepare you for other governance disciplines.

## What will you configure?

This unit assumes that you've already deployed assets to Azure. Now, you want to configure the environment to better organize, track, and govern those assets. When you finish this unit, you understand *why* and *how* to configure management groups, subscription design, resource groups, and tagging.

## Strategic considerations

Resource organization is based on what's important to your organization. Before you define a management group or subscription design, it's important to understand the priority of these competing priorities:

- **Cost transparency**: Every cloud adoption should be aligned to departments, business units, projects, or other cost-allocation mechanisms for chargeback and showback accounting requirements.
- **Compliance and security**: Every cloud adoption should map to specific compliance requirements that map cloud adoption to specific risk, security, and compliance organization structures.
- **Democratization (delegated responsibility)**: Every cloud adoption should map to teams, product groups, or projects for easier segmentation of responsibility by teams.

Understanding these strategic priorities can help you identify the best starting point for your management and subscription design.

## Resource organization in Azure

The basic foundation of all governance is consistent resource organization.

:::image type="content" source="../media/resource-consistency.png" alt-text="Image that demonstrates the Resource Consistency baseline as a hierarchy of resources." border="false":::

*Figure 1: Resource consistency.*

The three main components of resource organization are:

- *Management groups*, which reflect security, operations, and business or accounting hierarchies.
- *Subscriptions*, which group similar resources into logical boundaries.
- *Resource groups*, which further group applications or workloads into deployment and operations units.

## Governance design consideration

To accommodate long-term governance needs, design a high-level hierarchy, but implement only what you need. Add new nodes to the hierarchy as requirements dictate.

:::image type="content" source="../media/management-group-hierarchy.png" alt-text="Image that demonstrates management group hierarchy." border="false":::

*Figure 2: Management group hierarchy.*

The following components are in descending levels in the management group hierarchy shown in Figure 2:

- **Management group**: Business unit, geography, and environment
- **Subscription**: Per application category, preproduction, development environments, and production
- **Resource groups**: Per application

### Exercise: Configure your first management group hierarchy

Start with a smaller hierarchy so you can experiment and quickly overcome initial learning curves.

:::image type="content" source="../media/small-management-group-hierarchy.png" alt-text="Diagram of a reduced-size management group hierarchy." border="false":::

*Figure 3: Initial, smaller management group hierarchy.*

In this smaller version, attempt the following configuration steps:

- **Parent node**: Define a management group for corporate IT.
- **Child nodes**: Define child nodes for each production and nonproduction environment.

For guidance on creating these management groups, reference the [quickstart guide for creating a management group in the Azure portal](/azure/governance/management-groups/create-management-group-portal?azure-portal=true).

## Subscription design

A subscription is a logical container for all deployed assets. Subscriptions are used to group together common workloads based on billing, compliance, security, or access requirements. To maximize the effectiveness of governance, you should use as few subscriptions as possible.

:::image type="content" source="../media/initial-subscription-model.png" alt-text="Diagram of two separate subscriptions, one labeled production and one labeled nonproduction." border="false":::

*Figure 4: Production and nonproduction subscriptions.*

## Scaling with subscriptions

There are several technical and nontechnical reasons to scale with multiple subscriptions. Check out the [fundamental concepts article](/azure/cloud-adoption-framework/ready/azure-best-practices/scale-subscriptions?azure-portal=true) for an overview of common reasons to scale.

The following questions might help illustrate reasons for you to scale your subscriptions:

- Are there capacity or technical limitations?
- Do you need to clearly separate concerns? For example:
  - Separation of duties
  - Dev/test versus generic nonproduction
  - Different customers
  - Different departments or business units
  - Different projects
- Are you able to spread the cost of a shared infrastructure across application owners? (Often, a dedicated subscription is used for shared infrastructure, like Azure Active Directory, monitoring, or patching tools.)
- Do you need to create clearer separation of duties through shared service subscriptions for operations management, security, identity sync, connectivity, or DevOps teams?

### Exercise: Add subscriptions to your management groups

Add existing subscriptions in each of the environment nodes to create clarity between production, development, and QA resources.

:::image type="content" source="../media/add-context-sub.png" alt-text="Screenshot that shows adding a subscription to a management group in the Azure portal.":::

*Figure 5: Add a subscription to a management group.*

For guidance on adding subscriptions to a management group, reference the [how-to guide](/azure/governance/management-groups/manage#move-subscriptions?azure-portal=true).

## Tagging

Management groups reflect your highest-priority organization structure. Tagging reflects various organizing principles that also are reflected in metadata. Here are suggested tags for all workloads:

- Workload (and/or application)
- Data sensitivity; reference [Data classification](/azure/cloud-adoption-framework/govern/policy-compliance/data-classification?azure-portal=true) for examples
- Mission criticality; reference [Workload criticality](/azure/cloud-adoption-framework/manage/considerations/criticality?azure-portal=true) for examples
- Owner
- Department (cost center)
- Environment

### Exercise: Assign a tagging policy

You can apply Azure policies to all subscriptions in a management group. To understand the role of policy in your governance foundation, apply a policy to one of your management groups in the hierarchy.

:::image type="content" source="../media/select-assign-policy.png" alt-text="Screenshot that shows assigning a policy in the Azure portal.":::

*Figure 6: Assign a policy in the Azure portal.*

For guidance on applying a policy, check out the tutorial on [creating and managing policies](/azure/governance/policy/tutorials/create-and-manage#assign-a-policy?azure-portal=true)

- Step 4 of the instructions for assigning a policy discusses scope. In this step, you select the management group to ensure that the policies are applied to all subscriptions in the management group.
- Steps 6 and 7 discuss policy definition. From the list of **Built-in** policies, we suggest selecting one of the policies related to [tagging](/azure/governance/policy/samples/built-in-policies#tags). Specifically, the policy that requires a [tag on all resources](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1e30110a-5ceb-460c-a204-c1c3969c6d62?azure-portal=true) helps establish a governance foundation.

> [!IMPORTANT]
> Step 9 in the [tutorial](/azure/governance/policy/tutorials/create-and-manage#assign-a-policy?azure-portal=true) illustrates **Policy enforcement**. As you learn about governance, be sure to set **Policy enforcement** to **Disabled**. When this setting is disabled, you can audit your environment without making any changes, and it won't prevent future deployments.

## Deployment acceleration

Packaging all the governance change in a blueprint accelerates deployments and creates consistent governance application. When we assign a blueprint in the next exercise, governance is consistently applied to all subscriptions in the assigned management group. It's also applied to all resource groups and assets in those subscriptions.

### Exercise: Assign the CAF Foundation blueprint

Use Azure Blueprints to package Azure Resource Manager templates, Azure policies, and role-based access control settings into a single package. The Cloud Adoption Framework for Azure (CAF) Foundation blueprint provides an example and a starting point for using blueprints in cloud governance to:

- Deploy Azure Key Vault
- Deploy Log Analytics in Azure Monitor Logs
- Deploy Microsoft Defender for Cloud (standard version)

The CAF Foundation blueprint also defines and deploys policies to:

- Apply `cost center` tags to resource groups
- Append resources in resource group with the `cost center` tag
- Permit an Azure region for resources and resource groups
- Permit storage account SKUs (choose when deploying)
- Permit Azure Virtual Machines SKUs (choose when deploying)
- Require Azure Network Watcher to be deployed
- Require secure transfer encryption for Azure Storage accounts
- Deny resource types (choose when deploying)
- Create an initiative to enable monitoring in Microsoft Defender for Cloud (89 policies)

Follow the prescribed steps to [publish and assign this sample blueprint to your management group](/azure/governance/blueprints/samples/caf-foundation/deploy?azure-portal=true).

### Exercise: Evaluate a current environment

Customers commonly attempt to add governance to existing, mature adoption efforts across multiple subscriptions. As you mature your governance practices across a portfolio, the [Azure governance visualizer](https://github.com/azure/azure-governance-visualizer?azure-portal=true) can provide insights about your current governance configuration.

:::image type="content" source="../media/visualizer.png" alt-text="Diagram of the Azure Governance Visualizer." border="false":::

*Figure 7: The Azure governance visualizer.*

Deploy the Azure governance visualizer to see how management groups, blueprints, policies, and other governance configurations have been applied across your environment.

These exercises help demonstrate a starting point or foundation for governance. In the next unit, you'll build on this foundation to establish a mature Cost Management discipline.
