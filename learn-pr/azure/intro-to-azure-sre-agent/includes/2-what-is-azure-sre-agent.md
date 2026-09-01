Azure SRE Agent is an Azure service that supports operational work by connecting information and actions across your reliability engineering environment. It can work with Azure resources, observability tools, incident platforms, source code repositories, and communication systems.

Instead of treating each alert, dashboard, deployment, and runbook as a separate source of context, the agent can bring evidence together in a single investigation. It uses that context to answer operational questions, propose mitigations, and automate approved workflows.

## Operational problems it addresses

Azure SRE Agent is designed to reduce repetitive operational work, including:

- Gathering evidence from several systems during an incident.
- Correlating service symptoms with changes and deployment history.
- Running recurring health, compliance, or operational checks.
- Proposing and verifying mitigations based on investigation results.
- Preserving useful findings, resolution steps, and team context for later investigations.

The service complements your existing operational systems. It connects to supported systems and uses their data and capabilities rather than replacing your monitoring, incident management, or source control platforms.

## Three primary scenarios

Azure SRE Agent supports three broad scenarios:

- **Automate incidents.** The agent receives an alert, queries connected systems, correlates evidence, forms a likely root-cause hypothesis, and proposes a response.
- **Automate scheduled workflows.** The agent performs recurring work such as health checks, compliance reviews, deployment verification, and operational reporting.
- **Investigate and advise.** You ask natural-language questions about an environment and receive answers grounded in information from connected sources.

These scenarios can overlap. For example, an incident workflow can investigate an alert, propose a mitigation for approval, verify the result, update the incident record, and preserve the resolution as operational knowledge.
