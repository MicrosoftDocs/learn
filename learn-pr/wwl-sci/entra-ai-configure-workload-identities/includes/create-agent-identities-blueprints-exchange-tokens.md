Creating agent identities requires creating the blueprint first, configuring its credentials, and then instantiating identities from it.

> [!IMPORTANT]
> Microsoft Entra Agent ID is in preview. Verify current documentation before using these steps in production.

## Create the blueprint and agent identity in sequence

Creation follows a fixed order because the blueprint controls both identity creation and authentication. Each step depends on the previous one.

1. Create the agent identity blueprint.
1. Assign the required sponsor and, preferably, an owner.
1. Configure credentials on the blueprint.
1. Create the blueprint principal where explicit creation is required, for example, in multitenant scenarios.
1. Create agent identities from the blueprint.
1. Use the blueprint to acquire tokens that are then exchanged for the agent identity.

## Create the agent identity blueprint

To create the blueprint:

1. Confirm that the environment meets the prerequisites for Microsoft Entra Agent ID, including licensing, Frontier availability, and required roles.
1. Connect a client that has the required Microsoft Graph permissions for blueprint creation.
1. Create the agent identity blueprint by using Microsoft Graph or supported Microsoft Entra PowerShell cmdlets.
1. Assign at least one sponsor during creation. Without a sponsor, access review decisions for the agent identity have no designated business owner.
1. Assign an owner so credential rotation, configuration updates, and incident response have a responsible party.
1. Record the blueprint app ID because later credential configuration, blueprint principal creation, and token requests depend on that identifier.

## Configure credentials for the blueprint

The blueprint needs a client credential so it can request tokens on behalf of agent identities.

For production, use a managed identity as the federated credential when the scenario supports it. Certificates are a stronger fallback than client secrets when federation isn't available. Client secrets are supported for development and testing but aren't the preferred production pattern.

To configure the credential:

1. Choose the credential type that matches where the supporting service runs.
1. If the service runs on Azure and can use a managed identity, add that managed identity as a federated identity credential on the blueprint.
1. If federation isn't available, add a certificate credential on the blueprint.
1. Use a client secret only for limited development or test scenarios.
1. Validate that the blueprint can request a token before you create agent identities. If the blueprint can't acquire a token, every agent identity created from it fails to authenticate.

If the agent needs to receive incoming requests from users or other agents, the blueprint requires more configuration beyond the client credential. Attended scenarios, where the agent acts interactively on behalf of a user, need an identifier URI, an OAuth scope, a redirect URI, and consent settings on the blueprint. These settings allow the front end to request a user token that the agent backend later exchanges through the on-behalf-of flow after the blueprint authenticates.

Unattended scenarios where the agent acts autonomously use only the client credential configured in the previous steps.

In both patterns, the blueprint credential is the authentication foundation for the first token in the exchange sequence.

## Create the agent identity and use token exchange

After the blueprint is ready, create the agent identity.

1. Request a token for the blueprint by using the configured credential. This confirms that the blueprint can authenticate before you depend on it for agent operations.
1. Create the agent identity from the blueprint by using Microsoft Graph or supported Microsoft Entra PowerShell cmdlets, and bind the required sponsor information during creation.
1. If the scenario requires an explicit blueprint principal, create that principal after the blueprint exists and before you rely on tenant-side operations that require the blueprint's service principal representation.
1. Record the created agent identity ID so you can assign downstream permissions and validate sign-in activity separately from the blueprint.
1. Use the blueprint token to request a token for the agent identity. The agent identity doesn't authenticate with its own stored credential, so if the blueprint can't acquire a token, the agent identity can't either.
1. Use the resulting token when the agent accesses downstream resources.

The diagram shows how the blueprint authenticates first and then exchanges a token for the agent identity.

:::image type="content" source="../media/agent-autonomous-app-flow.png" alt-text="Diagram illustrating blueprint token acquisition and exchange for an agent identity access token." lightbox="../media/agent-autonomous-app-flow.png":::

This flow is different from a standard service principal pattern. The agent identity doesn't hold its own credential. The blueprint authenticates first, then exchanges context so the agent identity can act.

## Assign permissions to the new agent identity

After creation, assign only the permissions the agent needs for its scenario. Depending on the workload, that can include:

- Azure RBAC roles.
- Microsoft Graph permissions.
- App roles.
- Directory roles where the scenario genuinely requires them.

Don't assign broad permissions at the blueprint stage just to avoid later configuration effort. The agent identity should receive only the access required for the specific agent instance.
