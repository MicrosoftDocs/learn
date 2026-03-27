### Design extensibility of AI solutions — Summary and key takeaways

This module introduces solution architects to the principles and best practices for designing extensible AI solutions in enterprise environments by using Microsoft platforms. The module covers the use of custom models with Microsoft Foundry, agent design and operationalization in Microsoft 365 Copilot, extensibility strategies in Copilot Studio, and advanced integration by using the Model Context Protocol (MCP). It emphasizes the importance of scalability, security, compliance, and adaptability in architecting AI systems that address unique organizational needs.

### Key takeaways

#### Custom models in Microsoft Foundry

- Custom models are essential for scenarios requiring domain-specific reasoning, compliance, data sovereignty, unique workflows, and cost optimization.
- Foundry provides tools for data preparation, model training, evaluation, deployment, and governance, supporting full lifecycle management.
- Solution architects should follow a structured approach: define business objectives, assess data requirements, select the appropriate model path, integrate with enterprise systems, and validate results.
- Operationalizing custom models requires robust monitoring, governance, versioning, and deployment automation.

#### Designing agents in Microsoft 365 Copilot

- Copilot agents are modular, instruction-driven components that automate tasks, retrieve information, and collaborate within Microsoft 365 apps.
- Effective agent design centers on clear intent, strict guardrails, scoped permissions, and alignment with business goals and data boundaries.
- Collaborative agents can support sequential, parallel, and orchestrated workflows, improving cross-app productivity and user experience.
- Lifecycle management includes monitoring agent quality, updating instructions, enforcing access control, and versioning.

#### Agent extensibility in Copilot Studio

- Extensibility is implemented at four layers: instruction-level, skills/capabilities, integration, and pro-code customization through Visual Studio Code.
- Modular and reusable agent components enable faster updates, better compliance, and long-term maintainability.
- Multi-agent collaboration and domain-context patterns allow agents to specialize and adapt to different business environments.

#### Model Context Protocol (MCP) in Copilot Studio

- MCP provides a standardized contract for agents to retrieve and interpret structured business context, ensuring consistent reasoning and compliance.
- MCP is particularly valuable for Dynamics 365 Finance & Operations scenarios, enabling agents to access business entities, workflows, and domain models.
- MCP-enabled agents improve accuracy, reduce incorrect information, enhance auditability, and support policy-aligned actions across enterprise workflows.
