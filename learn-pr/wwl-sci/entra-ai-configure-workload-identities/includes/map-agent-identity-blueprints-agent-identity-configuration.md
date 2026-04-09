Agent identity setup starts with the blueprint, not with the agent identity itself. Understanding what the blueprint governs leads to better decisions before agent creation.

> [!IMPORTANT]
> Microsoft Entra Agent ID is in preview. Administrative surfaces, permissions, and API details can change.

## How the blueprint governs agent identities

An agent identity blueprint is the governing template for one or more agent identities. It holds the shared configuration that agent identities inherit or depend on.

The blueprint governs these relationships:

- It defines the shared authentication foundations.
- It holds the credentials used to acquire tokens on behalf of agent identities.
- It's the container through which agent identities are created and managed.
- Policies and settings applied to it affect every agent identity created from it.

The blueprint isn't descriptive metadata. It's the management object that anchors the setup process.

## Recognize which configuration decisions live on the blueprint

Several decisions belong at the blueprint level because they affect every agent identity created from it.

These include:

- The credential type the blueprint uses.
- Authentication properties and protocol settings it exposes.
- Shared app roles or application settings the agent type needs.
- Sponsor and owner relationships established at creation.

Making these decisions separately for each agent identity undermines the consistency the blueprint is designed to enforce.

## Distinguish the blueprint from the agent identity

The blueprint and the agent identity are related, but they do different jobs.

| Object | Primary purpose | What you configure there |
| --- | --- | --- |
| Agent identity blueprint | Govern a class of agent identities | Shared credentials, authentication settings, and lifecycle foundation |
| Agent identity | Represent one AI agent instance | Instance-specific permissions and operational identity |
| Agent user account | Support scenarios that require a user object | User-account-specific access when the scenario requires it |

This distinction matters because agent identities don't carry their own credentials, and multiple identities are created and governed through a single blueprint.

:::image type="content" source="../media/agent-identity-blueprint.png" alt-text="Diagram showing one agent identity blueprint governing multiple agent identities." lightbox="../media/agent-identity-blueprint.png":::

## Map the blueprint to attended and unattended patterns

You also need to consider how the agent operates.

- In unattended scenarios, the blueprint acquires tokens so the agent can act under its own authority.
- In attended scenarios, the front end passes a user token that can be exchanged so the agent acts with both the agent identity and the user's delegated permissions.

The operating pattern changes which configuration decisions you make next. It affects whether you need a scope exposed on the blueprint, whether an agent user account is necessary, and how the token flow works.

## Prepare for creation

Before you create an agent identity, confirm you can answer these questions:

1. What class of agent does this blueprint represent?
1. Which credential pattern will the blueprint use?
1. Which shared authentication settings must all child agent identities inherit?
1. Which scenarios require an agent user account?
1. Which sponsor and owner relationships must exist from the start?

If those answers are clear, you're ready to move into the creation workflow.
