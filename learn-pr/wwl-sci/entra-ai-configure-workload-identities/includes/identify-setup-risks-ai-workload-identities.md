AI workload identity setup is where early decisions can create long-term security problems. Choosing weak credentials, granting broad access, or creating agent identities without accountability makes the infrastructure harder to govern and easier to abuse.

## Recognize where setup mistakes create risk

Three setup decisions drive most downstream risk:

- How the workload authenticates.
- What permissions the workload receives.
- Who is accountable for the identity after creation.

   :::image type="content" source="../media/ai-workload-identity-setup.png" alt-text="Diagram showing AI workload identity setup with three risk areas: authentication, permissions, and accountability." lightbox="../media/ai-workload-identity-setup.png":::

AI workloads amplify this risk because they often act without direct human sign-in. They can operate continuously and at scale without the checks that exist for human users.

If an AI workload identity is over-privileged or poorly governed, it can continue to operate without interruption. A compromised workload identity with broad permissions can access resources across the tenant without triggering the interactive sign-in detections designed for human accounts.

## Identify credential risks early

The credential choice determines how much secret management the setup requires.

For workloads hosted on Azure resources that support managed identities, managed identities are the preferred option because Azure manages the credential lifecycle. That reduces the chance of exposing or forgetting to rotate a secret.

Workloads that run outside Azure, or scenarios that require an application object, need a different credential pattern. Workload identity federation lets an application trust tokens issued by another identity provider instead of storing a secret. If federation isn't available for the scenario, certificate credentials are a stronger fallback than client secrets for production workloads.

The most common setup mistakes are:

- Keeping a client secret as the default choice when the workload could use a managed identity.
- Reusing a certificate or secret across unrelated workloads.
- Choosing a credential type without checking where the workload runs and how token exchange works in that environment.

Each of these mistakes widens the blast radius if a credential is compromised.

## Identify permission risks before you assign access

Least privilege isn't a single permission model. AI workload identities often need a combination of:

- Azure RBAC roles for Azure resources.
- Microsoft Graph application permissions for directory or Microsoft 365 tasks.
- App roles for custom applications or APIs.

Risk increases when these are treated as a single approval step with broad rights assigned to get the workload running. For example, a workload might only need read access to one resource group or one Graph scope, but the identity receives tenant-wide or write-capable permissions instead. If that identity is compromised, the attacker gains tenant-wide access rather than access to a single resource.

These signals indicate setup risk:

- The permission request is broader than the workload's actual task.
- The same identity is used for unrelated jobs.
- No one can explain why a specific role or permission was assigned.

If the identity is compromised, the attacker inherits every excess permission.

## Identify governance gaps in agent identity setup

Agent identities introduce a different kind of setup risk because they rely on both a blueprint model and an accountability model.

Treating an agent identity like a regular service principal overlooks the controls that Microsoft Entra Agent ID adds for AI agents. Agent identities still need technical administration and business accountability. Without those relationships, no one's clearly responsible for lifecycle decisions, access reviews, or incident response.

The highest-risk gaps are:

- Creating a blueprint or agent identity without a sponsor.
- Leaving ownership unclear after initial setup.
- Treating the blueprint as a one-time object instead of the governing container for future agent identities.

These gaps surface during access reviews and incident response, when decisions require a clear accountable party.

## Confirm four decisions before you configure anything

Before you start configuring, confirm these decisions:

- Which identity type you're setting up for the workload.
- Which credential pattern fits the hosting environment.
- Which minimum permissions the workload needs across RBAC, Graph, and app roles.
- Which owner and sponsor relationships must exist after setup, and whether a manager relationship is needed.

These checks keep setup work focused on secure operation, not just successful authentication.
