AI agents introduce interaction patterns that traditional information protection policies weren't designed to cover. Agents generate prompts, receive responses, call external tools, and access organizational data through connectors. These interactions create data security surfaces that require deliberate coverage decisions.

Agents introduce problems you won't encounter with users alone:

- **Policies don't cover new interaction surfaces.** Agents process prompts containing sensitive data and return responses that include classified information. Those interactions don't flow through the same channels that data loss prevention (DLP) and sensitivity label policies cover. Unless agent instances are explicitly scoped into those policies, the interactions are ungoverned.

- **Coverage varies across agent types.** Not all agents receive the same Microsoft Purview capabilities. A Copilot Studio agent gets DLP support. A Security Copilot agent doesn't. The assumption that "if it's in our tenant, our policies cover it" doesn't hold for agents.

- **New agent instances don't inherit policies.** When a new user is added, existing policies apply through group membership and scoping rules. When someone creates a new agent instance, nothing equivalent happens. The agent exists. Existing policies don't see it. That gap persists until the instance is explicitly included in each relevant policy.

## How Purview categorizes AI agents

Microsoft Purview groups AI apps and their agents into three categories. The category determines which data security and compliance capabilities are available.

- **Copilot experiences and agents** includes Microsoft 365 Copilot, Security Copilot, Copilot in Fabric, Copilot Studio, Microsoft Facilitator, and Channel Agent in Teams. These agents are built within or extending Microsoft's Copilot ecosystem.

- **Enterprise AI apps** includes apps and agents connected to your organization through Microsoft Entra registration, data connectors, or Microsoft Foundry. This category covers Entra-registered AI apps, Microsoft Foundry agents, ChatGPT Enterprise, and Anthropic Claude (Enterprise).

- **Other AI apps** includes AI apps detected through browser activity and categorized as "Generative AI" in the Defender for Cloud Apps catalog. This category includes consumer versions of ChatGPT, Google Gemini, DeepSeek, and others. Coverage for this category is limited to communication compliance and browser-based detection through Defender for Cloud Apps. You can't apply DLP, sensitivity labels, or IRM to these apps.

These category names appear throughout Data Security Posture Management (DSPM), communication compliance, and other Purview solutions. Check the category first. It determines which capabilities are available for that agent.

## How agents inherit coverage

Agents inherit the security and compliance capabilities of their parent AI app. A Copilot Studio agent receives whatever Purview capabilities Microsoft Copilot Studio supports. An Entra-registered agent gets the capabilities available to Entra-registered AI apps. The parent app sets the boundary for what you can configure.
