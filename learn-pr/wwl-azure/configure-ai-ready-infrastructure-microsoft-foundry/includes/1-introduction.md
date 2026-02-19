Your retail organization plans to deploy three AI applications this quarter: a customer support chatbot, a product recommendation engine, and an inventory forecasting model. The team currently provisions separate Azure AI resources—duplicating Azure OpenAI deployments, creating isolated storage accounts, and deploying dedicated search services. This scattered approach creates four critical problems: security teams struggle to audit 15+ separate services, finance lacks visibility into AI spending across departments, developers waste time configuring the same network rules repeatedly, and your organization pays for underutilized search capacity that could be shared.

Microsoft Foundry solves these infrastructure challenges through a hub-and-project architecture. Hubs establish shared governance boundaries where you configure networking, managed identities, and policy enforcement once. Projects within each hub inherit those settings while providing isolated workspaces where teams build AI solutions independently. Hub-level connections to services like Azure AI Search enable multiple projects to share infrastructure, reducing your search costs by 50-70% compared to provisioning dedicated instances per team.

In this module, you configure a hub that enforces consistent security policies across all AI projects, establish a hub-level connection to Azure AI Search that eliminates resource duplication, create projects that inherit governance settings while maintaining team autonomy, and validate that your infrastructure supports enterprise-scale AI deployments. By the end, you have the architectural knowledge to provision scalable AI infrastructure that satisfies security, finance, and development stakeholders simultaneously.

## Learning objectives

By the end of this module, you're able to:

- Configure Microsoft Foundry hubs with appropriate governance and security settings
- Create and organize AI projects within hubs to support team collaboration
- Establish connected resources including Azure AI Search for shared infrastructure
- Implement hub-level shared connections to optimize resource utilization across projects

## Prerequisites

- Familiarity with Azure portal navigation and resource management
- Basic understanding of AI and machine learning concepts
- Experience with Azure resource groups and role-based access control (RBAC)
