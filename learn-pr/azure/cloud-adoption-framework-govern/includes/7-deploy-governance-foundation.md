Deploying a cloud governance foundation will accelerate your ability to govern your entire Azure environment. This unit outlines the considerations and implementations required to deploy a foundation for achieving resource consistency and prepare you for other governance disciplines.

## What will you configure?

At the end of this unit, you will understand the why and how behind configuration of management groups, subscription design, resource groups, and tagging. This unit assumes that you have already deployed assets to Azure. Now you want to configure the environment to better organize, track, and govern those assets.

## Strategic considerations

Resource organization depends on what is important to your organization. Before defining a management group or subscription design, it's important to understand the priority of the following competing priorities:

- **Cost transparency:** All cloud adoption should be aligned to departments, business units, projects, or other cost allocation mechanisms for chargeback and showback accounting requirements.
- **Compliance and security:** All cloud adoption should map to specific compliance requirements that map cloud adoption to specific risk, security, and compliance organization structures.
- **Democratization (delegated responsibility):** All cloud adoption should map to teams, product groups, or projects, which allows for easier segmentation of responsibility by teams.

Understanding these strategic priorities will help identify the best starting point for your management and subscription design.

## Resource organization in Azure

The basic foundation for all governance starts with consistent resource organization.

:::image type="content" source="../media/resource-consistency.png" alt-text="Resource consistency." border="false":::

*Figure 1: Resource consistency.*

The three main components of resource organization are:

- Management groups, which reflect security, operations, and business or accounting hierarchies.
- Subscriptions, which group similar resources into logical boundaries.
- Resource groups, which further group applications or workloads into deployment and operations units.

## Governance design consideration

To accommodate long-term governance needs, design a high-level hierarchy but implement only what you need. Add as requirements dictate new nodes on the hierarchy.

:::image type="content" source="../media/management-group-hierarchy.png" alt-text="management group hierarchy" border="false":::

*Figure 2: Management group hierarchy.*

The following components are high-level design in Figure 2:

- **Management group hierarchy:** Business unit, geography, environment
- **Subscription:** Per application category, pre-production, development environments, and production
- **Resource groups:** Per application

## Exercise: Configure your first management group hierarchy

Start with a smaller hierarchy to allow for experimentation and to quickly overcome initial learning curves.

:::image type="content" source="../media/small-management-group-hierarchy.png" alt-text="Initial, smaller management group hierarchy." border="false":::

*Figure 3: Initial, smaller management group hierarchy.*

In this smaller version, attempt the following configuration steps:

- Parent node: Define a management group for corporate IT.
- Child nodes: Define child nodes per production and nonproduction environment.

For guidance on creating these management groups, see the [quickstart guide for creating a management group in the Azure portal](/azure/governance/management-groups/create-management-group-portal?azure-portal=true).

## Subscription design

Subscriptions are the logical containers for all deployed assets. Subscriptions are used to group together common workloads based on billing, compliance, security, or access requirements. To maximize the effectiveness of governance, you should use as few subscriptions as possible.

:::image type="content" source="../media/initial-subscription-model.png" alt-text="Production and nonproduction subscriptions." border="false":::

*Figure 4: Production and nonproduction subscriptions.*

## Scaling with subscriptions

There are several technical and non-technical reasons to scale with multiple subscriptions. See the [fundamental concepts article](/azure/cloud-adoption-framework/ready/azure-best-practices/scale-subscriptions?azure-portal=true) for an overview of common reasons to scale.

The following questions may help illustrate reasons for you to scale your subscriptions:

- Are there capacity or technical limitations?
- Do we need to clearly separate concerns? For example:
  - Separation of duties
  - Dev/test versus generic nonproduction
  - Different end customers
  - Different departments or business units
  - Different projects
- Use a dedicated subscription for shared infrastructure (for example, Azure Active Directory, monitoring, and patching tools). You will be able to spread the cost of this shared infrastructure across application owners.
  - Do you need to create clearer separation of duties through shared service subscriptions for operations management, security, identity synchronization, connectivity, or DevOps teams?

## Exercise: Add subscriptions to your management groups

Add existing subscriptions in each of the environment nodes, to create clarity between production, development, and QA resources.

:::image type="content" source="../media/add-context-sub.png" alt-text="Adding a subscription to a management group." border="false":::

*Figure 5: Adding a subscription to a management group.*

For guidance on adding subscriptions to a management group, see the [how-to guide](/azure/governance/management-groups/manage#move-subscriptions?azure-portal=true).

## Tagging

Management groups reflect your highest priority organization structure. Tagging reflects a number of additional organizing principles that are also reflected through metadata. Suggested tags for all workloads are:

- Workload (and/or application)
- Data sensitivity; see [Data classification](/azure/cloud-adoption-framework/govern/policy-compliance/data-classification?azure-portal=true) for examples
- Mission criticality; see [Workload criticality](/azure/cloud-adoption-framework/manage/considerations/criticality?azure-portal=true)for examples
- Owner
- Department (cost center)
- Environment

## Exercise: Assign a tagging policy

Azure policies can be applied to all subscriptions within a management group. To understand the role of policy in your governance foundation, apply a policy to one of your management groups in the hierarchy.

:::image type="content" source="../media/select-assign-policy.png" alt-text="Assigning a policy in the Azure portal." border="false":::

*Figure 6: Assigning a policy in the Azure portal.*

For guidance on applying a policy, see the tutorial on [creating and managing policies](/azure/governance/policy/tutorials/create-and-manage#assign-a-policy?azure-portal=true)

- Step 4 of the instructions for assigning a policy discusses scope. This is where you will select the management group to ensure that the policies are applied to all subscriptions in the management group.
- Steps 6 and 7 discuss policy definition. From the list of **Built-in** policies, we suggest selecting one of the policies related to [tagging](/azure/governance/policy/samples/built-in-policies#tags?azure-portal=ture). Specifically the policy that requires a [tag on all resources](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1e30110a-5ceb-460c-a204-c1c3969c6d62?azure-portal=true) will help establish a governance foundation.

> [!IMPORTANT]
> Step 9 illustrates **Policy enforcement**. While learning about governance, be sure to set **Policy enforcement** to **Disabled**. This allows you to audit your environment without making any changes or preventing future deployments.

## Deployment acceleration

Packaging all of the governance change into a blueprint accelerates deployments and creates consistent governance application. When we assign a blueprint in the next exercise, governance will be consistently applied to all subscriptions in the assigned management group and all resource groups and assets within those subscriptions.

## Exercise: Assign the CAF Foundation blueprint

Azure Blueprints lets you package Azure Resource Manager templates, Azure policies, and role-based access control settings into a single package. The CAF Foundation blueprint provides an example and a starting point for using blueprints in cloud governance to:

- Deploy Azure Key Vault.
- Deploy Log Analytics.
- Deploy Azure Security Center (standard version).

The CAF Foundation blueprint also defines and deploys policies for:

- Applying `cost center` tags to resource groups.
- Appending resources in resource group with the `cost center` tag.
- Permitting an Azure region for resources and resource groups.
- Permitting storage account SKUs (choose while deploying).
- Permitting Azure VM SKUs (choose while deploying).
- Requiring Network Watcher to be deployed.
- Requiring secure transfer encryption for Azure Storage accounts.
- Denying resource types (choose while deploying).
- Initiative:
  - Enabling monitoring in Azure Security Center (89 policies).

Follow the prescribed steps to [publish and assign this sample blueprint to your management group](/azure/governance/blueprints/samples/caf-foundation/deploy?azure-portal=true).

## Exercise: Evaluate a current environment

Customers commonly attempt to add governance to existing, mature adoption efforts across multiple subscriptions. As you mature your governance practices across a portfolio, the [Azure governance visualizer](https://github.com/microsoft/CloudAdoptionFramework/tree/master/govern/AzureGovernanceVisualizer?azure-portal=true) can provide insights about your current governance configuration.

:::image type="content" source="../media/visualizer.png" alt-text="The Azure Governance Visualizer." border="false":::

*Figure 7: The Azure governance Visualizer.*

Deploy the Azure governance visualizer to see how management groups, blueprints, policies, and other governance configurations have been applied across your environment.

These exercises help to demonstrate a starting point or foundation for governance. In the next unit, we will build on this foundation to establish a mature Cost Management discipline.