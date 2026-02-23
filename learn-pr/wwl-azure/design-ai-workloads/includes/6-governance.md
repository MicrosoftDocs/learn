Governing AI is about making sure your organization uses AI safely, responsibly, and in alignment with your existing risk, security, and privacy practices. 

### Apply AI principles

Begin by assessing risks across your organization. Microsoft recommends evaluating risks through [Responsible AI principles](https://www.microsoft.com/ai/principles-and-approach). These principles include accountability, fairness, reliability, privacy, inclusiveness, and transparency.

:::image type="content" source="../media/principles.png" alt-text="Diagram of the basic artificial intelligence principles.":::

These principles act like a checklist for spotting vulnerabilities such as how an AI model might leak sensitive data, produce biased results, behave unpredictably, or create unclear accountability. 

### Implement governance in every area

After identifying your AI risks, shift your focus to the actions you can take in each area to minimize those risks. 

:::image type="content" source="../media/governance-areas.png" alt-text="Diagram of the governance action areas.":::

 
**Security & Access Control**

Secure your AI environment by limiting access to only what’s necessary. Use role-based access control and managed identities so users and services get just the permissions they need—without relying on stored credentials. Keep AI resources private by disabling public access and implementing private endpoints. Enforce Microsoft Entra ID for authentication, and protect data at rest with customer-managed encryption keys.

**Cost Management**

Keep AI spending predictable by setting budgets and alerts in [Cost Management](/azure/cost-management-billing/costs/reporting-get-started). Optimize resources with autoscaling, virtual machine (VM) autoshutdown, and approved VM SKUs, and control model costs by choosing the right pricing approach—whether that’s pay-as-you-go, PTUs, or reservations.

> [!TIP]
> To learn more, consider the [Introduction to cost management for AI workloads](/training/modules/understand-cost-management-ai/) training module.

**Data Governance & Privacy**

Strong data governance starts with clear standards. Decide what data can be used for training and RAG. Protect privacy with techniques like anonymization and data residency controls, and make sure you have solid retention and deletion policies in place. Enable logging and diagnostics so you always have visibility into how data is accessed and used.

**Policy & Compliance**

Use [Azure Policy](/azure/governance/policy/overview) to consistently enforce deployment and configuration standards across your AI environment. Apply structured tagging for cost tracking and ownership. Use [Microsoft Purview ](/purview/purview)to help secure and govern all your data.

> [!TIP]
> To learn more, consider the [Govern AI Services with Azure Policy](/training/modules/govern-ai-azure-policy/) training module. 

**Operations**

Running AI responsibly means being transparent and proactive. Document what your AI systems can, and can’t do, monitor model behavior over time, and set triggers for retraining as data or performance changes. Clear user guidelines help ensure AI is used appropriately and consistently across the organization.

