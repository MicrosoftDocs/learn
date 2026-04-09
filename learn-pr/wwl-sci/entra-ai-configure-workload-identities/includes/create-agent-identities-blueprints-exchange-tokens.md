After you understand the blueprint model, the next step is to create the blueprint, configure credentials, and create agent identities.

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
1. Create the agent identity blueprint object.
1. Assign at least one sponsor during creation. Without a sponsor, access review decisions for the agent identity have no designated business owner.
1. Assign an owner so credential rotation, configuration updates, and incident response have a responsible party.
1. Record the blueprint app ID because you need it in later steps.

## Configure credentials for the blueprint

The blueprint needs a client credential so it can request tokens on behalf of agent identities.

For production, use a managed identity as the federated credential when the scenario supports it. Certificates are a stronger fallback than client secrets when federation isn't available. Client secrets are supported for development and testing but aren't the preferred production pattern.

To configure the credential:

1. Choose the credential type that matches where the supporting service runs.
1. If the service runs on Azure and can use a managed identity, add that managed identity as a federated identity credential on the blueprint.
1. If federation isn't available, add a certificate credential.
1. Use a client secret only for limited development or test scenarios.
1. Validate that the blueprint can request a token before you create agent identities. If the blueprint can't acquire a token, every agent identity created from it fails to authenticate.

If the agent needs to receive incoming requests from users or other agents, also configure the identifier URI and OAuth scope on the blueprint.

## Create the agent identity and use token exchange

After the blueprint is ready, create the agent identity.

1. Request a token for the blueprint by using the configured credential.
1. Call the Microsoft Graph endpoint to create the agent identity and bind the required sponsor information.
1. Record the created agent identity so you can assign permissions and validate sign-in activity.
1. Use the blueprint token to request a token for the agent identity.
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

## Know where to stop

This module stays focused on identity infrastructure setup. It doesn't cover building the agent, writing agent code, or operational administration of Agent 365. The goal is to leave setup with a functioning blueprint, a created agent identity, and a working token exchange path.
