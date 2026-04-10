Agent identity setup starts with the blueprint, not with the agent identity itself. The blueprint controls how agent identities authenticate, what configuration they share, and who is responsible for them.

> [!IMPORTANT]
> Microsoft Entra Agent ID is in preview. Administrative surfaces, permissions, and API details can change.

## What a blueprint is

An agent identity blueprint is an application object in Microsoft Entra that serves as the governing template for one or more agent identities. When you create a blueprint, Microsoft Entra also creates a blueprint principal. The blueprint principal is the service principal representation that acquires tokens, creates agent identities, and appears in audit logs.

The blueprint governs:

- The credentials used to acquire tokens on behalf of agent identities.
- Shared authentication settings and protocol properties.
- Shared app roles or application settings the agent type needs.
- Sponsor and owner relationships that establish accountability.
- Policies that affect every agent identity created from it.

The blueprint isn't descriptive metadata. It's the single object where shared credential configuration and accountability are managed for every agent identity created from it.

## Distinguish the blueprint from the agent identity

The blueprint and the agent identity are related, but they hold different configuration and serve different purposes.

| Object | What it is | What you configure there |
| --- | --- | --- |
| Agent identity blueprint | Application object that governs a class of agent identities | Shared credentials, authentication settings, sponsor and owner relationships, lifecycle foundation |
| Agent identity | Specialized service principal representing one AI agent instance | Instance-specific permissions and operational identity |
| Agent user account | User object paired 1:1 with an agent identity | User-account-specific access when the scenario requires a user object |

Agent identities don't carry their own credentials. They authenticate through the blueprint's credential, which means the blueprint is the single point of authentication control for every agent identity created from it.

:::image type="content" source="../media/agent-identity-blueprint.png" alt-text="Diagram showing one agent identity blueprint governing multiple agent identities." lightbox="../media/agent-identity-blueprint.png":::

## Recognize when an agent user account is needed

An agent user account is a user object paired with an agent identity. It's needed when the agent must interact with systems that require a user object. Examples include a mailbox, a Teams presence, or the ability to request access packages through a manager.

If the agent can operate with app-level credentials and permissions alone, skip the agent user account. Adding one means managing licensing, group memberships, and user-level policies that aren't necessary for agents that operate as service principals.

## Map the blueprint to attended and unattended patterns

How the agent operates determines which configuration decisions you make on the blueprint.

- In **unattended (autonomous)** scenarios, the blueprint acquires tokens using client credentials flow so the agent can act under its own authority. No user context is involved.
- In **attended (interactive)** scenarios, the front end acquires a user token and the agent backend exchanges it using on-behalf-of flow. The agent acts with both the agent identity and the user's delegated permissions.

The operating pattern affects which authentication properties the blueprint needs, whether an agent user account is necessary, and how the token exchange flow works in practice. Attended scenarios require additional authentication properties on the blueprint beyond the client credential. The next unit covers that configuration.

## Prepare for creation

Before you create an agent identity, confirm you can answer these questions:

1. What class of agent does this blueprint represent?
1. Which credential pattern will the blueprint use?
1. Which shared authentication settings must all agent identities created from this blueprint inherit?
1. Does the scenario require an agent user account?
1. Which sponsor and owner relationships must exist from the start?

If those answers are clear, you're ready to move into the creation workflow.
