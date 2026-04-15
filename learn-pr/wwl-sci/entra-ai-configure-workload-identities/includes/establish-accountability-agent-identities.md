Agent identities aren't fully set up until accountability is clear. Microsoft Entra Agent ID separates technical administration from business accountability so lifecycle and access decisions don't depend on a single role.

## Assign the right relationship to the right responsibility

Three relationships define accountability during setup:

- **Owners** manage technical configuration and credentials.
- **Sponsors** provide business accountability for lifecycle and access decisions.
- **Managers** apply to agent user accounts when the scenario requires a user object and organizational hierarchy matters.

   :::image type="content" source="../media/agent-identity-accountability-model.png" alt-text="Diagram showing agent identity accountability with owner, sponsor, and optional manager roles." lightbox="../media/agent-identity-accountability-model.png":::

These relationships are separate from broad directory roles. They define who's responsible for the agent identity itself.

## Establish owners for technical administration

Owners should be the people or services that can safely maintain the configuration.

Owners are the right relationship for tasks such as:

- Updating agent configuration.
- Managing credentials.
- Adding other owners or sponsors.
- Disabling, restoring, or deleting agent identities as part of administration.

Choose owners who can sustain the setup over time. Record owners on the blueprint and on the created agent identity when the operating model requires administration at both levels. If the identity will be managed programmatically, a service principal can also be an owner.

## Establish sponsors for business accountability

Sponsors answer a different question: who's accountable for why this agent exists and whether it should keep its access?

Sponsors are the right relationship for:

- Confirming that the agent still has a valid business purpose.
- Making lifecycle decisions such as renewal, extension, or removal.
- Leaving technical execution of deletion or restoration to an owner or administrator.
- Supporting incident response and access review decisions.

Because sponsorship is required for blueprint and agent identity creation, sponsor assignment isn't optional governance cleanup. It's part of secure setup, and it must be recorded on the relevant Agent ID object at creation time, or verified if the identity already exists in the tenant.

## Recognize when a manager is needed

Managers matter when the scenario includes an agent user account.

If the agent needs a user object for systems that require one, a manager can support access package requests. The manager relationship belongs on the agent user account, not on the blueprint or the agent identity itself. If the scenario doesn't require an agent user account, a manager relationship might not be needed.

## Apply accountability during setup

To establish accountability after creation:

1. Confirm which person or group will own technical administration of the blueprint and the created agent identity.
1. Confirm which person or group will act as sponsor for business accountability.
1. If the scenario uses an agent user account, decide whether a manager relationship is required.
1. Validate that these relationships are recorded on the correct Agent ID objects: owner and sponsor on the blueprint and agent identity as needed, and manager on the agent user account when one exists.
1. Document who will make renewal, review, incident, and removal decisions after setup.

Accountability is separate from broad directory administration. A directory admin can have the rights to configure the environment, but the owner, sponsor, and manager relationships define who is responsible for the specific agent and its lifecycle.

## Prepare for multitenant blueprint scenarios carefully

Multitenant-capable agent scenarios add another layer of accountability because a blueprint principal can be brought into a tenant with resources. In those cases, keep the accountability model explicit in each participating tenant. You still need to know who manages technical setup for the blueprint principal and who's accountable for lifecycle decisions in each participating organization.

The core rule still applies: establish accountability as part of setup, not after governance work begins.
