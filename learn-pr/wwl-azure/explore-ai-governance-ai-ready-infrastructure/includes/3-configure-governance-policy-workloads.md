## Selecting the right governance policies

Now that you understand how Microsoft Foundry integrates governance capabilities, you need to decide which policies your organization should implement and how strictly to enforce them. This decision balances three competing priorities: enabling rapid AI experimentation, maintaining compliance with regulatory requirements, and controlling infrastructure costs. Your approach varies depending on whether you're governing a development sandbox where teams test new models, a staging environment where solutions undergo validation, or a production deployment serving customers.

Start by identifying your organization's non-negotiable requirements—policies you must enforce immediately because they address legal obligations or critical security controls. Data residency regulations typically fall into this category: if your organization operates in the European Union and must comply with regulations, you need policies that prevent AI deployments in non-EU regions from day one. Similarly, if your security team mandates content filtering for all customer-facing AI endpoints, that policy should block noncompliant deployments rather than merely auditing them. With these critical policies defined, you can then layer on cost controls and operational standards that you initially enforce through audit mode, giving teams visibility into compliance status before switching to deny mode.

## Resource tagging for governance and cost allocation


Resource tagging is the foundation of effective AI infrastructure governance because it enables both policy enforcement and financial accountability. By requiring specific tags on every AI deployment—such as **CostCenter**, **Owner**, **Environment**, and **Project**—you create standardized metadata that supports multiple governance objectives at once. These tags ensure AI resources are traceable, auditable, and manageable across finance, operations, and compliance functions.

- **CostCenter** tags enable finance teams to generate chargeback and showback reports that clearly attribute AI spending to the correct department  
- **Owner** tags allow operations teams to quickly identify the responsible individual when issues such as Azure OpenAI throttling or quota limits occur  
- **Environment** tags help compliance teams distinguish between production workloads requiring strict controls and development environments that need greater flexibility  


Microsoft Foundry enforces these tagging requirements through Azure Policy using deny mode, preventing resource creation when required tags are missing. This approach embeds governance directly into the deployment process rather than relying on retroactive audits. When an engineer attempts to deploy an AI resource without mandatory tags, the deployment is blocked with immediate, actionable feedback.

- Azure Policy evaluates resource creation requests and denies deployments that don't include required tags such as **CostCenter**, **Owner**, or **Environment**  
- Engineers receive immediate error messages (for example, *"Deployment blocked: Resource missing required tag ‘CostCenter’"*), creating a built‑in learning moment  
- This enforcement model prevents untagged AI resources from entering the environment, reducing inventory sprawl and avoiding governance gaps discovered only during quarterly reviews  


## Regional restrictions and data residency

Regulatory frameworks like HIPAA and various national data protection laws often mandate that certain data remain within specific geographic boundaries. Microsoft Foundry implements these requirements through regional restriction policies that define approved Azure regions for AI workload deployment. Unlike resource tagging, which you might initially enforce through audit mode, regional restrictions typically use deny mode from implementation because data residency violations create legal liability that justifies strict enforcement.

When you configure a regional restriction policy in Foundry, you specify the allowed regions based on your compliance requirements and assign the policy at the management group level so it applies to all subscriptions your AI teams use. For a multinational organization, this might mean creating separate management groups for different geographic regions: one for EU operations restricted to West Europe and North Europe, another for US operations allowed to use East US and West US, and a third for Asia-Pacific workloads permitted in Southeast Asia and Australia East. This approach ensures that teams in each region can work efficiently within their approved boundaries while preventing cross-region deployments that would violate data residency requirements.

:::image type="content" source="../media/regulatory-frameworks-national-data-protection.png" alt-text="Diagram showing how Microsoft Foundry implements  requirements through regional restriction policies.":::

## SKU limitations and cost controls

Azure AI services offer multiple pricing tiers and model versions with dramatically different cost profiles. A GPT-4 deployment with high token throughput can consume thousands of dollars weekly, while a GPT-3.5 instance with moderate throughput might cost a few hundred. Microsoft Foundry helps you manage this cost variability through SKU limitation policies that restrict which service tiers and model versions teams can deploy. However, unlike data residency policies that require immediate strict enforcement, SKU limitations benefit from a phased approach that starts with visibility before imposing restrictions.

Begin by implementing SKU policies in audit mode, which logs when teams deploy premium AI services but doesn't block the deployments. This audit period—typically 30 to 60 days—reveals your organization's actual usage patterns: which teams need GPT-4 for production customer interactions versus those using it for development experimentation, which projects justify high-throughput instances based on user demand, and which deployments could use lower-cost alternatives without impacting results. With this baseline established, you transition the policy to deny mode for development and staging environments, requiring teams to submit exception requests that justify premium SKUs for nonproduction use. Production environments might maintain more flexible SKU policies but pair them with budget alerts that notify project managers when spending approaches approved thresholds.

## Responsible AI guardrails

Microsoft Foundry integrates responsible AI controls that help organizations deploy AI systems safely and ethically. These guardrails include content filtering that blocks harmful outputs, abuse monitoring that detects unusual usage patterns suggesting misuse, prompt injection protection that prevents attacks manipulating model behavior, and data logging requirements that maintain audit trails for investigation when issues occur. The appropriate enforcement approach for these controls varies by environment and use case.

For production AI endpoints serving customers, responsible AI guardrails should use deny mode because the reputational and legal risks of deploying an unprotected AI system outweigh any innovation velocity gains. Your policy might require that all customer-facing Azure OpenAI deployments enable content filtering for hate speech, violence, and self-harm at medium or high sensitivity levels. You might allow development and staging environments to operate in audit mode, giving data scientists flexibility to test content filtering configurations and understand how different sensitivity levels impact their specific use cases. A tiered approach balances safety in production with the experimentation necessary to optimize responsible AI settings before customer exposure.

## Policy inheritance and scope management

Microsoft Foundry uses Azure's resource hierarchy to simplify policy management through inheritance. When you assign a policy at the management group level, all subscriptions and resource groups beneath that management group inherit the policy automatically. This inheritance model means you configure governance requirements once at the appropriate organizational level, then allow exceptions only through documented exclusion processes that maintain your audit trail.

:::image type="content" source="../media/policies-assigned-management-group-level-cascade.png" alt-text="Diagram showing how policies assigned at management group level cascade to subscriptions, resource groups, and individual AI resources.":::

Consider how this works in practice for a large organization with multiple business units. You create a root management group representing your entire organization and assign core policies that apply universally: required resource tagging, responsible AI guardrails for production, and broad regional restrictions based on your global compliance posture. Beneath this root, you create management groups for each business unit—Sales, Marketing, Engineering—and assign unit-specific policies like budget limits reflecting each unit's AI investment approval. Individual subscriptions inherit both the organization-wide policies and their business unit policies, creating a layered governance framework that enforces consistent standards while accommodating unit-specific requirements. When an AI engineer deploys a resource, Foundry evaluates the complete policy stack from root to subscription, denying the deployment if any policy reports a violation.

With this understanding of policy types, enforcement modes, and inheritance patterns, you're ready to implement governance controls in a hands-on exercise that demonstrates how these concepts work together to balance AI innovation with organizational requirements.

:::image type="content" source="../media/policy-evaluation-flow-deploy-services.png" alt-text="Diagram showing an AI engineer requesting an Azure OpenAI deployment through Microsoft Foundry.":::

*Policy evaluation flow when deploying AI resources through Microsoft Foundry, showing approval and denial paths*


