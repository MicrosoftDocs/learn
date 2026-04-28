If you've managed service principals or app registrations, you've seen these problems before. A secret that nobody remembers creating. A Contributor role assigned at a scope nobody can justify. An identity with no listed owner. These problems are common across all workload identities.

What changes with AI workloads is how many services a single identity touches. A workload that runs inference might authenticate to an Azure OpenAI endpoint, retrieve connection strings from Key Vault, pull grounding data from a storage account, and query user profiles from Microsoft Graph. That's four service boundaries behind one identity. If the credential is compromised or the permissions are too broad, the exposure spans every service in that chain, and the workload processes requests continuously without a human reviewing each call.

## Why set up decisions persist after production

Once an AI workload is running in production, every identity choice becomes the baseline that teams are reluctant to change:

- Switching a credential type requires coordinated updates to the workload, the app registration, and whatever automation deploys the workload.
- Narrowing permissions risks breaking the workload if someone removes access the workload actually uses.
- Assigning an owner requires finding someone who understands what the identity does and is willing to accept accountability for it.

Each change requires deliberate intervention that competes with other priorities. Setup decisions made in five minutes during initial configuration persist for the life of the workload.

## Why these risks don't surface on their own

A workload with a stored secret, broad permissions, no owner, and no validation functions identically to one that's set up correctly. Sign-in succeeds. API calls return data. Nothing in the workload's behavior signals that the identity configuration is wrong.

These configuration gaps surface only during incident response or an access review. At that point, someone needs a clear record of what was granted, why, and whether it's still justified. But the setup decisions have been in production for months, the person who made them might have moved on, and the documentation that would explain the reasoning was never created.

## The four decisions and how they compound

Every workload identity requires four setup decisions:

- **Credential type.** Secrets, certificates, managed identities, or federated credentials. The hosting environment constrains the options, but the choice sets the operational burden for the life of the workload.
- **Permission scope.** Azure RBAC roles, Microsoft Graph application permissions, and app roles each have different scoping models. Broad defaults are easy to grant and difficult to narrow later.
- **Role selection at each dependent service.** Key Vault, Azure AI services, storage accounts, and downstream APIs each have their own role definitions. Over-permissioned identities usually originate here, where someone picks a familiar role instead of the narrowest one that works.
- **Pre-production validation.** Testing sign-in from the actual hosting environment, confirming permissions match the documented intent, and establishing a rotation plan. Without this step, gaps from the first three decisions persist undetected.

These decisions compound each other. A weak credential is worse when permissions are broad, and broad permissions are harder to fix when nobody validated them before production. That interaction is why each decision deserves deliberate attention.
