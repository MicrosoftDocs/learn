AI endpoints don't distinguish between human and application requests at runtime. They validate tokens and evaluate permissions based on the identity presented.

For security design, the type of identity matters.

Understanding the differences between **human**, **application**, and **managed identities** helps you assign permissions correctly and reduce risk.

## Human identities

Human identities represent individual users authenticated through Microsoft Entra ID.

These identities are used when a person directly interacts with AI resources. Examples include:

- A developer deploying or updating a model
- An administrator configuring resource settings
- A security analyst reviewing posture or activity

Human identities are typically authenticated through interactive sign-in. Conditional Access, multifactor authentication, and device compliance policies commonly apply to these sessions.

Because human identities represent real individuals, their permissions should reflect job responsibilities and follow least-privilege principles.

Overassigning permissions to user accounts increases risk, particularly in the management plane.

## Application identities

Application identities represent software rather than people. In Microsoft Entra ID, these are typically implemented as service principals associated with application registrations. An application registration defines the application globally, while a service principal represents that application as a security identity within a specific tenant.

They're used when software calls an AI endpoint directly. Examples include:

- A web application submitting prompts
- A backend service retrieving embeddings
- An automation workflow deploying updates

Authentication occurs through non-interactive flows. The application presents credentials, and Microsoft Entra ID issues an access token for that identity.

Application identities shouldn't use shared secrets embedded in code or configuration without proper protection. Excessive permissions assigned to a service principal can allow broad, automated misuse of AI resources.

## Managed identities

Managed identities are a specialized type of application identity. They're designed to reduce credential management overhead.

When you enable a managed identity on an Azure resource, Microsoft Entra ID automatically creates and manages the associated identity. The platform handles credential rotation and lifecycle management.

Managed identities are appropriate when:

- An Azure-hosted resource needs to access an AI endpoint
- You want to avoid storing credentials in application code
- You want tighter integration with Azure role assignments

Managed identities reduce the risk associated with secret management. However, they still require careful role assignment and scope control.

## Choosing the appropriate identity model

The appropriate identity type depends on who or what is accessing the AI resource.

Use a human identity when a person is directly performing administrative or development tasks.

Use an application identity when software must authenticate independently.

Use a managed identity when the workload runs in Azure and can rely on platform-managed credentials.

Each identity type introduces different security considerations:

- Human identities require strong authentication controls.
- Application identities require strict permission boundaries.
- Managed identities require careful scope assignment.

The identity type you choose affects the potential blast radius if that identity is compromised.

Understanding these distinctions allows you to design access intentionally rather than defaulting to broad or convenient configurations. The next step is defining what those identities are actually permitted to do and where those permissions apply.
