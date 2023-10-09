Translating compliance requirements into security solutions requires the following initiatives as part of cloud governance:

1. Define corporate policy that aligns to compliance requirements
1. Align design with policy

## Define corporate policy

After you've analyzed the known risks and related risk tolerances for your organization's cloud transformation journey, set up policy to clearly address those risks. Your policy also defines the necessary steps to remediate the risks where possible.

### How can corporate IT policy become cloud-ready?

In traditional governance and incremental governance, corporate policy creates the working definition of governance. Most IT governance actions seek to implement technology that monitors, enforces, operates, and automates corporate policies. Cloud governance is built on similar concepts.

![Diagram that shows corporate governance and governance disciplines.](../media/operational-transformation-govern-large.png)
*Figure 1: Corporate governance and governance disciplines.*

The image illustrates the relationship between business risk, policy and compliance, and monitoring and enforcement mechanisms that need to interact as part of your governance strategy. The Five Disciplines of Cloud Governance let you manage the interactions and realize your strategy.

Cloud governance is the product of an ongoing adoption effort, because lasting transformation doesn't happen overnight. If you attempt to deliver complete cloud governance before addressing key corporate policy changes, it seldom produces the desired results. Instead, use an incremental approach.

What's different about a Cloud Adoption Framework is the purchasing cycle that enables authentic transformation. Since it doesn't take large capital to acquire, engineers can begin their experimentation and adoption sooner. In most corporate cultures, eliminating the capital expense barrier to adoption leads to tighter feedback loops, organic growth, and incremental development.

The shift to cloud adoption requires a shift in governance. In many organizations, corporate policy transformation supports:

- Improved governance and higher rates of adherence through incremental policy changes
- Automated enforcement of those changes

The newly defined capabilities that you configure with your cloud service provider power the policy changes.

### Review existing policies

As governance is an ongoing process, regularly review your policy with IT staff and stakeholders. You want to ensure that your resources hosted in the cloud maintain compliance with overall corporate goals and requirements. Your understanding of new risks and acceptable tolerance can fuel your review of existing policies. Reviewing your existing policies helps determine the level of governance that's right for your organization.

### Create cloud policy statements

Cloud-based IT policies establish the requirements, standards, and goals that your IT staff and automated systems need to support. Policy decisions are a primary factor in your cloud architecture design and how you'll implement your policy adherence processes.

Individual cloud policy statements are guidelines for addressing the specific risks you identify during your risk assessment process. While you can integrate these policies into your wider corporate policy documentation, cloud policy statements explored in the Cloud Adoption Framework guidance tend to be a more concise summary of the risks, and plans to deal with them. Include these pieces of information in each definition:

- **Business risk:** A summary of the risk this policy addresses.
- **Policy statement:** A concise explanation of the policy requirements and goals.
- **Design or technical guidance:** Actionable recommendations, specifications, or other guidance to support and enforce this policy that IT teams and developers use when designing and building their cloud deployments.

If you need help with defining your policies, consult the governance disciplines introduced in the governance section overview. The articles for these disciplines include examples of common business risks encountered when moving to the cloud and sample policies to address the risks. For example, see the Cost Management discipline's sample policy definitions.

### Incremental governance and integrating with existing policy

Vet the planned additions to your cloud environment for compliance with existing policy. Update your policy to account for issues not already covered. You should also perform a regular cloud policy review to ensure your cloud policy is up-to-date and in sync with any new corporate policy.

The need to integrate cloud policy with your legacy IT policies depends largely on the maturity of your cloud governance processes and the size of your cloud estate.

## Align design with corporate policy - cloud governance design guides

After you've defined cloud policies based on your identified risks, you'll need to generate actionable guidance that aligns with these policies for your IT staff and developers to refer to. Drafting a cloud governance design guide allows you to specify specific structural, technological, and process choices based on the policy statements you generated for each of the five governance disciplines.

A cloud governance design guide should:

* Establish the architecture choices and design patterns for each of the core infrastructure components of cloud deployments that best meet your policy requirements.
* Provide a high-level explanation of the technology, tools, and processes that will support these design decisions.
* Provide platform-specific implementation details that your IT and dev teams can use when creating and deploying cloud-based workloads
* Focus on the architecture, tools, and features of your chosen platform when making design decision and providing guidance.

While cloud design guides should take into account some of the technical details associated with each infrastructure component, they're not meant to be extensive technical documents or specifications. Make sure your guides address your policy statements and clearly state design decisions in a format easy for staff to understand and reference.

## Implementing resource governance MVP

A set of global policies and RBAC roles will provide a baseline level of governance enforcement. To meet the cloud governance team's policy requirements, implementing the governance MVP requires completing the following tasks:

1.  Identify the Azure Policy definitions needed to enforce business requirements. This might include using built-in definitions and creating new custom definitions. To keep up with the pace of newly released built-in definitions, there's an [Atom feed](https://github.com/Azure/azure-policy/commits/master/built-in-policies.atom) of all the commits for built-in policies, which you can use for an RSS feed. Alternatively, you can check [`AzAdvertizer`](https://www.azadvertizer.net/).
2.  Create a blueprint definition using these built-in and custom policy and the role assignments required by the governance MVP.
3.  Apply policies and configuration globally by assigning the blueprint definition to all subscriptions.

#### Identify policy definitions

Azure provides several built-in policies and role definitions that you can assign to any management group, subscription, or resource group. Many common governance requirements can be handled using built-in definitions. However, it's likely that you will also need to create custom policy definitions to handle your specific requirements.

Custom policy definitions are saved to either a management group or a subscription and are inherited through the management group hierarchy. If a policy definition's save location is a management group, that policy definition is available to assign to any of that group's child management groups or subscriptions.

Since the policies required to support the governance MVP are meant to apply to all current subscriptions, the following business requirements will be implemented using a combination of built-in definitions and custom definitions created in the root management group:

1.  Restrict the list of available role assignments to a set of built-in Azure roles authorized by your cloud governance team. This requires a custom policy definition.
2.  Require the following tags on all resources: _Department/Billing Unit_, _Geography_, _Data Classification_, _Criticality_, _SLA_, _Environment_, _Application Archetype_, _Application_, and _Application Owner_. This can be handled using the `Require specified tag` built-in definition.
3.  Require that the `Application` tag for resources should match the name of the relevant resource group. This can be handled using the `Require tag and its value` built-in definition.

#### Assign Azure Policy and RBAC roles using Azure Blueprints

Azure policies can be assigned at the resource group, subscription, and management group level, and can be included in Azure Blueprints definitions. Although the policy requirements defined in this governance MVP apply to all current subscriptions, it's very likely that future deployments will require exceptions or alternative policies. As a result, assigning policy using management groups, with all child subscriptions inheriting these assignments, may not be flexible enough to support these scenarios.

Azure Blueprints allows consistent assignment of policy and roles, application of Resource Manager templates, and deployment of resource groups across multiple subscriptions. Like policy definitions, blueprint definitions are saved to management groups or subscriptions. The policy definitions are available through inheritance to any children in the management group hierarchy.

The cloud governance team has decided that enforcement of required Azure Policy and RBAC assignments across subscriptions will be implemented through Azure Blueprints and associated artifacts:

1.  In the root management group, create a blueprint definition named `governance-baseline`.
2.  Add the following blueprint artifacts to the blueprint definition:
    1.  Policy assignments for the custom Azure Policy definitions defined at the management group root.
    2.  Resource group definitions for any groups required in subscriptions created or governed by the Governance MVP.
    3.  Standard role assignments required in subscriptions created or governed by the Governance MVP.
3.  Publish the blueprint definition.
4.  Assign the `governance-baseline` blueprint definition to all subscriptions.

See the [Azure Blueprints documentation](https://learn.microsoft.com/azure/governance/blueprints/overview) for more information on creating and using blueprint definitions.
