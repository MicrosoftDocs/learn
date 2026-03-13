As autonomy increases, risks do increase as well. An AI agent with the ability to read production telemetry and execute remediation actions against live (production) Azure resources represents both a powerful operational capability, and a significant responsibility. Trust in agentic systems must be **designed and engineered** through technical controls. This section establishes the governance foundation that makes agentic operations acceptable in real enterprises. Which could also include regulated industries where compliance, auditability, and human oversight are non-negotiable requirements.

## Safety by design

Azure SRE Agent enforces safety through multiple layers of technical mechanisms that operate independently and reinforce each other. By default, any action that modifies the Azure environment (slot swaps, restarts, scaling operations, configuration changes) **requires human authorization** before execution. The agent presents its reasoning, the proposed action, and the expected outcome. The human engineer / engineering team reviews and approves or rejects. Which forms the primary safety mechanism and also the one most visible to operators. Next, the SRE agents operate under a **system-assigned managed identity** with explicitly scoped RBAC permissions. The identity can be configured with read-only access for performing diagnostics. To then switch to limited write permissions, scoped to specific resource types or specific Resource Groups. **The agent cannot exceed** its granted permissions regardless of what it recommends. 
Also, agents always present the **complete reasoning chain** before proposing any action. Including the information that it gathered, details of the logic and reasoning it applied, and its recommendation. Engineers can verify the agent's analysis against their own understanding before making an approval decision.
Last, every action, proposal, reasoning step, and decision is logged with timestamps and identity attribution. These logs are immutable and available for audit, compliance review, security investigation, and continuous improvement.

## Identity and access management for agents

Agents are **identities in the Azure security model**. They must be governed with the same logic and governance oversight as human engineering teams. A few concepts:

- **Least privilege by default**: Only grant permissions the agent requires for its current monitoring and remediation scope. Start with read-only roles (`Reader`, `Monitoring Reader`, `Log Analytics Reader`) and add write permissions incrementally as the team builds confidence.
- **Read and write permissions separated**: Diagnostic capabilities (querying logs, examining resource configuration, viewing deployment history) require only read access. Remediation capabilities (slot swaps, restarts, configuration changes) require write access. Separating these allows organizations to deploy the agent in a diagnosis-only mode initially, with remediation capabilities enabled later.
- **Scoped to specific resources**: Assign RBAC at the resource group level to limit the agent's operational scope.
- **Regular access reviews**: Treat the agent's managed identity like any other privileged account. Conduct regular access reviews to ensure permissions remain aligned with the agent's current scope. Remove stale assignments when resource groups are decommissioned or monitoring scope changes.
- **The human-equivalence rule**: If a human engineer would need manager approval, a change review board sign-off, or an elevated access request to perform an action, the agent should require equivalent oversight.

## Data safety and boundary control

Here are a few **critical governance questions** that every organization must answer before deploying an agentic system such as Azure SRE Agent:

- What telemetry data can the agent read? Can it access secrets, encryption keys, or customer data stored in Key Vault or databases?
- Can the agent cross environment boundaries, for example accessing production resources from an agent deployed for non-production monitoring?
- How is sensitive data handled within the agent's reasoning pipeline? Are personally identifiable information (PII) or secret values exposed in reasoning logs or chat history?

As a summary, apply the same logic to agents as you do for your human engineering team. Don't overexpose permissions, as there's usually no need to do so. Rely on the knowledge and documentation you already have in place. Validate the responses from agents, instead of just accepting and trusting them. Remember AI are great assistants, not human replacements.