Deployment of a cloud governance foundation will acclerate you ability to govern your entire Azure environment. This unit will outline the considerations and implementations required to deploy a foundation that creates resource consistency & prepares you for other governance disciplines.

## What will you configure?

At the end of this unit, you will understand the why & how behind configuration of management groups, subscription design, resource groups, and tagging. This unit assumes that you have already deployed assets to Azure. Now you want to configure the environment to better organize, track, & govern all of those assets.

## Strategic considerations

Resource organization depends on what is important to your organization. Before defining a management group or subscription design, it is important to understand the priority of the following competing priorities:

- Cost Transparency: All cloud adoption should be aligned to departments, business units, projects, or other cost allocation mechanisms for chargeback/showback accounting requirements.
- Compliance / Security: All cloud adoption should map to specific compliance requirements which map cloud adoption to specific risk, security, and compliance organization structures.
- Democratization (delegated responsibility): All cloud adoption should map to teams, product groups, or projects which allows for easier segmentation of responsibility by teams.

Understanding these strategic priorities will help identify the best starting point for your management and subscription design.

## Resource organization in Azure

The basic foundation for all governance starts with consistent resource organization.

:::image type="content" source="../media/resource-consistency.png" alt-text="resource consistency" border="false":::

There are three main components to resource organization:

- Management Groups: To reflect security, operations and business/accounting hierarchies
- Subscriptions: To group similar resources into logical boundaries
- Resource Groups: To further group applications or workloads into deployment and operations units

## Governance design consideration

To accommodate long-term governance needs, design a high-level hierarchy but implement only what you need. Add as requirements dictate new nodes on the hierarchy.

:::image type="content" source="../media/management-group-hierarchy.png" alt-text="management group hierarchy" border="false":::

In the image above, the following would be the high-level design:

- Management Group Hierarchy: Business Unit, Geography, Environment.
- Subscription: Per Application Category; Pre-production, Dev environments, Production
- Resource Groups: Per Application

## Exercise: Initial governance foundation configuration

When you start configuring your first management group hierarchy, start with a smaller hierarchy to allow for experimentation & to quickly overcome initial learning curves.

:::image type="content" source="../media/small-management-group-hierarchy.png" alt-text="Initial, smaller management group hierarchy" border="false":::

In this smaller version, attempt the following configuration steps:

- Parent node: Define a management group for corporate IT
- Child nodes: Define child nodes per environment production and non-production

For guidance on creating these management groups, see the [Quickstart guide for creating a management group in the Azure portal](https://docs.microsoft.com/azure/governance/management-groups/create-management-group-portal).

## Subscription design

Subscriptions are the logical containers for all deployed assets. Subscriptions are used to group together common workloads based on billing, compliance, security, or access requirements. To maximize the effectiveness of governance, you should use as few subscriptions as possible.

:::image type="content" source="../media/initial-subscription-model.png" alt-text="Two subscriptions: Production and nonproduction" border="false":::

## Scaling with subscriptions

There are several technical and non-technical reasons to scale with multiple subscriptions. See the [fundamental concepts article](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/scale-subscriptions) for an overview of common reasons to scale.

The following questions may help illustrate reasons for you to scale your subscriptions:
- Are there any capacity / technical limitations?
- Do we want to ensure separation of concerns? In example:
    - Separation of duties
    - Dev/Test Vs. generic nonproduction
    - Different end customers
    - Different departments or business units
    - Different projects
- Use a dedicated subscription for shared infrastructure (i.e. Azure Active Directory, monitoring & patching tools…). You will be able to spread the cost of this shared infrastructure across app owners.
    - Do you need to create clearer separation of duty through shared service subscriptions for operations management, security, identity synchronization, connectivity, or DevOps teams?

## Exercise: Add subscriptions to your management groups

Add existing subscriptions in each of the environment nodes, to create clarity between production, development, and QA resources.

:::image type="content" source="../media/add_context_sub.png" alt-text="Add subscription to management group" border="false":::

For guidance on adding subscriptions to a management group, see the [how-to guide](https://docs.microsoft.com/azure/governance/management-groups/manage#move-subscriptions).

## Tagging

Management groups reflect your highest priority organization structure. Tagging reflects a number of additional organizing principles that are reflected through metadata. See the following for a list of suggested tags for all workloads:

- Workload (&/or application)
- Data sensitivity (See [data classification](https://docs.microsoft.com/azure/cloud-adoption-framework/govern/policy-compliance/data-classification) for examples)
- Mission criticality (See [workload criticality](https://docs.microsoft.com/azure/cloud-adoption-framework/manage/considerations/criticality) for examples)
- Owner
- Dept. (Cost Center)
- Environment

## Exercise: Assign a tagging policy

Azure policies can be applied to all subscriptions within a management group. To understand the role of policy in your governance foundation, apply a policy to one of your management groups in the hierarchy.

:::image type="content" source="../media/select-assign-policy.png" alt-text="Policy assignment in the Azure portal" border="false":::

For guidance on applying a policy, see the tutorial on [creating and maanaging policies](https://docs.microsoft.com/azure/governance/policy/tutorials/create-and-manage#assign-a-policy)

- Step 4 of the instructions for assigning a policy discusses scope. This is where you will select the management group to ensure that the policies are applied to all subscriptions in the management group.
- Step 6 & 7 discuss policy definition. From the list of *Built-in* policies, we suggest choosing one of the policies related to [tagging](https://docs.microsoft.com/azure/governance/policy/samples/built-in-policies#tags). Specifically, the policy that requires a [tag on all resources](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1e30110a-5ceb-460c-a204-c1c3969c6d62) will help establish a governance foundation.
> [!IMPORTANT]
> Step 9 illustrates the use of **Policy enforcement**. While learning about governance, be sure to set **Policy enforcement** to *Disabled*. Doing so will allow you to audit your environment, without making any changes or preventing future deployments.

## Exercise: Assign the CAF Foundation Blueprint

Azure blueprints package Azure Resource Manager templates, Azure Policies, and Role Based Access Control settings into a single package. The CAF Foundation blueprint provides an example and a starting point for the use of blueprints in cloud governance, including the following controls:

- Deploy Azure Key Vault
- Deploy Log Analytics
- Deploy Azure Security Center (standard version)
- The blueprint also defines and deploys Azure Policies, for 
    - Tagging (CostCenter) applied to resources groups
    - Append resources in resource group with the CostCenter Tag
    - Allowed Azure Region for Resources and Resource Groups
    - Allowed Storage Account SKUs (choose while deploying)
    - Allowed Azure VM SKUs (choose while deploying)
    - Require Network Watch to be deployed
    - Require Azure Storage Account Secure transfer Encryption
    - Deny resource types (choose while deploying)
- Initiatives
    - Enable Monitoring in Azure Security Center (89 Policies)

Follow the steps on this CAF Blueprint deployment article to [publish and assign this sample blueprint to your management group](https://docs.microsoft.com/azure/governance/blueprints/samples/caf-foundation/deploy).

## Exercise: Evaluate an existing environment

Customers commonly attempt to add governance to existing, mature adoption efforts across multiple subscriptions. As you mature your governance practices across a portfolio, the CAF Governance Visualizer can provide insights into your exiting governance configuration.

:::image type="content" source="../media/visualizer.png" alt-text="CAF governance visualizer" border="false":::

Deploy the [CAF governance visualizer](https://github.com/microsoft/CloudAdoptionFramework/tree/master/govern/AzureGovernanceVisualizer) to see how management groups, blueprints, policies, and other governance configurations have been applied across your environment.

These exercises help demonstrate a starting point or foundation for governance. In the next unit we will build on this foundation to establish a mature cost management discipline.