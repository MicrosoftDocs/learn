Data security is crucial for AI because AI systems amplify existing challenges with data classification, permissions, and governance. AI makes data discovery easy—which means any problems with data handling are magnified, leading to potential data leakage, and unauthorized access. AI not only relies on data but also creates new data that gains value over time, making it a target for attackers. Although data security isn't a new discipline, AI makes getting data security right even more critical.

A fundamental principle of AI data security is that **access control decisions should never be devolved to the AI system**. The AI should only have access to the same data as the user it's acting on behalf of.

:::image type="content" source="../media/challenges-governance-security.png" alt-text="Screenshot of the challenges of AI governance and security, showing how AI amplifies existing data security concerns.":::

## Understand the data landscape of AI systems

Generative AI systems interact with a wide range of data types that all require protection:

- **Training data**: The datasets used to build and fine-tune models, which may contain proprietary information, personal data, or copyrighted material
- **Grounding data**: Documents, databases, and knowledge bases that the AI retrieves at runtime through techniques like retrieval-augmented generation (RAG)
- **Interaction data**: User prompts, model responses, conversation histories, and tool-call payloads generated during use
- **Generated outputs**: Summaries, code, reports, and other artifacts the AI creates, which may combine information from multiple sensitive sources

Each data type has different security requirements, access patterns, and regulatory implications. A comprehensive AI data security strategy addresses all of them.

:::image type="content" source="../media/generative-ai-data.png" alt-text="Screenshot of the types of data used by generative AI, showing consumed, created, and accessed data categories.":::

## Implement access control with agent identities

The principle that AI should only access the same data as the user it acts on behalf of is straightforward to state, but implementing it requires purpose-built identity management. Agent identity frameworks provide standardized ways to govern, authenticate, and authorize AI agents.

Agent identity frameworks typically support two authentication modes:

- **Delegated access (on behalf of user)**: The agent operates under the signed-in user's identity using an on-behalf-of flow. The agent inherits only the permissions the user has consented to and is authorized for. This directly enforces the principle that the AI can't access data the user can't access.
- **Application-only access**: The agent acts under its own dedicated identity, governed by its own role assignments. This mode is used for background or unattended workflows where no user is involved.

When you create an agent on a modern AI platform, the service can automatically provision an agent identity. Administrators then assign roles to that identity using role-based access control (RBAC), applying least-privilege access at the agent level—separate from the permissions of the human developers who built it.

This separation matters for auditability: operations performed by the AI agent appear in logs under the agent's identity, not a human user's account, making it possible to detect and investigate unexpected agent behavior.

For example, Microsoft Entra Agent ID provides this capability by issuing dedicated identities for AI agents that support both delegated and application-only access modes, with role assignments managed through Azure RBAC.

:::image type="content" source="../media/agent-identity-access-modes.png" alt-text="Diagram comparing delegated and application-only access modes for AI agent identities." lightbox="../media/agent-identity-access-modes.png":::

## Data classification and governance

Effective AI data security also requires strong data governance practices:

- **Classify data before AI accesses it**: Ensure that data accessed by AI systems is classified and labeled according to its sensitivity level. AI can only enforce access controls that exist—if data isn't properly classified, the AI may surface sensitive information to unauthorized users.
- **Apply data loss prevention (DLP) policies**: Extend existing DLP policies to cover AI interaction channels. Monitor for sensitive data appearing in AI prompts, responses, and tool-call payloads.
- **Enforce retention and deletion policies**: Define how long interaction data (conversation logs, prompt histories) is retained. Minimize the window of exposure by automatically purging data that's no longer needed.
- **Audit data access patterns**: Monitor which data the AI accesses, when, and on whose behalf. Anomalous access patterns—such as an agent suddenly querying large volumes of data outside its normal scope—can indicate a compromise.