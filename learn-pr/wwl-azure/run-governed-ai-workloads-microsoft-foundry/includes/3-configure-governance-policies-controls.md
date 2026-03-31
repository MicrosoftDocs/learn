Your organization's AI governance requirements vary dramatically across different contexts: the marketing team experimenting with sentiment analysis needs different controls than the finance team deploying fraud detection models in production. Microsoft Foundry addresses this complexity through hierarchical policy inheritance that balances consistency with flexibility.

## Establish base security policies

Start by defining organization-wide security policies that apply universally across all business units and environments. These base policies enforce non-negotiable requirements like mandating managed identities for all AI services, requiring encryption at rest and in transit, and enabling diagnostic logging to centralized workspaces. With this foundation in place, no team can accidentally deploy an Azure OpenAI endpoint with unencrypted data or anonymous access—the policy engine blocks such requests before provisioning begins. Base policies integrate directly with Azure Policy definitions, which means your existing security baselines automatically extend to AI workloads managed through Foundry.

Building on these universal controls, you can then layer environment-specific policies that adjust governance strictness based on risk profiles.

## Implement environment-specific controls

Development environments typically need relaxed quotas and broader service approval lists to enable rapid experimentation. For example, your development policy might allow any Azure AI service, set GPU quota limits at 10 vCPUs per project, and autoapprove all requests under **$500** monthly cost. 

Production environments require the opposite approach: 
- Strict service lists limited to validated AI models
- Mandatory approval workflows for any new deployment
- Cost thresholds requiring executive sign out above **$5,000** monthly spend

This differentiation happens through policy scopes—you assign development policies to subscriptions or resource groups tagged with `Environment: Dev`, while production policies target resources tagged `Environment: Prod`.
:::image type="content" source="../media/implement-environment-quotas-controls.png" alt-text="Diagram that illustrates business unit policies addressing organizational boundaries and budget ownership.":::

At the same time, business unit policies let you address organizational boundaries and budget ownership.

## Define business unit policies

Each business unit manages distinct budgets and faces different regulatory requirements. Your healthcare division might enforce policies requiring all customer data to remain in HIPAA-compliant regions, while your retail division prioritizes cost optimization over geographic restrictions. Business unit policies operate at the management group or subscription level, inheriting base security policies while adding unit-specific rules.

Consider a scenario where the finance team gets monthly Azure OpenAI budget allocation of **$50,000** and the marketing team receives **$20,000**. The quotas are in the business unit policies and the policy engine enforces them automatically. When finance attempts to deploy resources that would exceed their allocation, Foundry routes the request through an approval workflow to their VP rather than blocking it outright.

:::image type="content" source="../media/implement-environment-specific-controls.png" alt-text="Diagram that illustrates environment-specific controls.":::

This becomes especially important when you need to balance innovation velocity with compliance requirements across multiple jurisdictions.

## Configure data residency and compliance policies

Data residency policies ensure that AI workloads processing customer data deploy only to approved Azure regions. If your organization operates in the European Union, you might define a compliance policy requiring all production AI services to provision in `westeurope` or `northeurope` regions exclusively. The policy engine evaluates region specifications during request submission and rejects deployments targeting noncompliant regions before any resources are created. Unlike manual governance approaches that rely on post-deployment audits, this preventive enforcement eliminates compliance violations before they occur. Foundry also supports policy exemptions for specific scenarios—perhaps your data science team needs temporary access to a preview AI service available only in `eastus` for evaluation purposes. In such cases, the approval workflow routes the exemption request to your compliance officer for documented approval.

Now that you understand policy types and scopes, let's examine how these policies interact when multiple rules apply to a single request. The following diagram illustrates policy inheritance across organizational hierarchies:

:::image type="content" source="../media/data-resilience-policy-approval.png" alt-text="Diagram that illustrates policy inheritance across organizational hierarchies.":::

## Policy evaluation hierarchy

When a developer requests an Azure OpenAI deployment, Foundry evaluates policies in a specific order: base security policies first, then business unit policies, then environment-specific policies, and finally project-level overrides. This hierarchy ensures that universal security requirements always apply, while allowing appropriate flexibility at lower levels. Consider what happens when conflicting policies exist: if base policy requires managed identities (allowed: true) but a development environment policy attempts to disable this requirement (allowed: false), the more restrictive policy wins—in this case, the base policy enforcement. This fail-secure approach prevents accidental weakening of security postures through misconfigurations.

With this hierarchical understanding in place, you're ready to examine the specific policy types and their practical applications. The following table shows common governance scenarios and their corresponding policy implementations:

:::image type="content" source="../media/hierarchical-policy-structure-microsoft-foundry.png" alt-text="Diagram showing organization at top with base security policy applied universally.":::


*Hierarchical policy structure in Microsoft Foundry showing base policies inherited across organizational units with environment-specific customizations*




