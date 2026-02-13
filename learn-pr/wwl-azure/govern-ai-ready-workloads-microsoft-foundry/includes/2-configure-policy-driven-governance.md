## Policy-driven governance fundamentals

When you deploy AI resources without governance controls, each team makes independent decisions about encryption, region selection, and naming conventions. This fragmentation creates security vulnerabilities and makes audit trails nearly impossible to reconstruct. Microsoft Foundry solves this problem by integrating with Azure Policy to enforce organizational standards before resources reach production.

At its core, policy-driven governance defines rules that Azure evaluates during resource deployment. If a team tries to create an Azure OpenAI instance in a restricted region, the deployment fails immediately with a clear explanation. This prevents violations rather than detecting them after the fact. With this approach, your compliance posture improves by 60% compared to reactive monitoring alone, because noncompliant resources never enter your environment.

## Policy assignment hierarchy

Microsoft Foundry organizes policies across three levels that mirror your organizational structure. Management groups enforce enterprise-wide requirements like encryption at rest for all AI workloads. Subscriptions apply environment-specific controls—for example, production subscriptions might restrict AI model deployment to approved regions while development subscriptions allow broader experimentation. Resource groups implement project-level constraints such as naming conventions that help finance teams track costs by business unit.

This hierarchy becomes powerful when combined with policy inheritance. Assign a data residency policy at the management group level, and every subscription and resource group beneath it automatically inherits that rule. Teams can't override inherited policies without explicit exemptions that trigger approval workflows. Building on this foundation, you can start with broad organizational policies and layer on increasingly specific controls as you move down the hierarchy.

## Policy evaluation and enforcement

Azure evaluates policies at two critical points in the resource lifecycle. During deployment, the platform checks each resource configuration against assigned policies before provisioning begins. If a policy violation occurs, the deployment stops and returns a detailed error message explaining which policy blocked the action. This immediate feedback loop helps developers correct configuration issues in minutes rather than hours.

After deployment, Microsoft Foundry continuously scans existing resources every 24 hours to detect configuration drift. When an administrator manually changes a setting that violates policy, the compliance dashboard flags the resource and triggers remediation workflows. You can configure automatic remediation for low-risk violations—like reapplying required tags—while routing high-risk issues like encryption changes to security team review queues. This combination of preventive and detective controls ensures your governance posture remains consistent as your AI infrastructure scales.

## Common policy patterns for AI workloads

AI infrastructure introduces governance challenges that traditional policies don't address. Data residency requirements become critical when training models on customer information—a policy violation could expose your organization to regional penalties exceeding 4% of annual revenue. Microsoft Foundry provides prebuilt policy definitions specifically for AI scenarios, including rules that restrict Azure OpenAI deployments to regions with data residency certifications.

Another essential pattern involves model access controls. You might define a policy requiring multifactor authentication for any identity accessing GPT-4 models, while allowing simpler authentication for nongenerative AI services. Cost management policies complement these security controls by capping token consumption per resource group, preventing runaway inference costs that can exceed $10,000 per day in misconfigured environments. By combining these patterns, you create a governance framework that balances innovation velocity with organizational risk tolerance.

:::image type="content" source="../media/microsoft-foundry-policy-enforcement.png" alt-text="Diagram showing the policy governance lifecycle and policy definitions assigned to scopes.":::

*Microsoft Foundry policy enforcement workflow showing how policies are evaluated during resource deployment and through continuous scanning, triggering remediation when violations occur*


