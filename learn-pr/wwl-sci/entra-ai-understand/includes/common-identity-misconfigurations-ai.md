Strong authentication and well-defined roles don't guarantee secure AI workloads. Identity design decisions determine whether access boundaries hold under pressure.

Identity design failures cause most AI security incidents, not flaws in the model itself. Common drivers include misconfigured identities, excessive permissions, and weak enforcement controls.

Understanding common misconfigurations helps you recognize risk patterns early.

## Overprivileged application identities

Service principals and managed identities often receive broad permissions for convenience.

For example:

- Assigning contributor access at the subscription level
- Granting both management and data plane permissions when only one is required
- Reusing a single application identity across multiple workloads

Because application identities operate without human interaction, excessive permissions can enable automated misuse at scale.

When an overprivileged identity is compromised, the blast radius extends to every resource within its assigned scope.

## Broad scope assignments

Scope selection directly affects blast radius.

Assigning roles at the subscription level might simplify administration, but it broadens access beyond what's necessary. A compromised identity with subscription-level permissions can modify or access multiple AI resources across environments.

Limiting scope to a specific resource group or AI endpoint narrows the scope of access and aligns more closely with least-privilege principles.

Convenience shouldn't override scope discipline.

## Shared credentials and secret management

Application identities that rely on shared secrets introduce additional risk.

Embedding credentials in code, storing them in unsecured configuration files, or failing to rotate secrets increases the likelihood of compromise.

Managed identities reduce some of this risk by removing the need to manage credentials directly. However, they don't eliminate the need for proper role assignment and scope control.

Secret management failures often surface long after initial deployment, when credentials are reused across environments or teams.

## Mixing development and production identities

Using the same identity for development and production workloads expands the potential scope of a compromise.

Development environments often have broader permissions and less restrictive controls. If that identity also has production access, a compromise in development can affect production systems.

Separating identities by environment limits lateral movement and narrows the scope of a compromise.

Environment boundaries should be reflected in identity boundaries.

## Token handling and leakage risks

Access tokens represent authenticated identities. If tokens are logged, exposed in client-side code, or transmitted insecurely, they can be replayed until expiration.

Short token lifetimes and secure storage practices reduce this risk. Monitoring unusual token usage patterns also helps detect misuse.

Authentication doesn't eliminate risk. It defines the boundary of trust.

## Missing Conditional Access enforcement

Authentication alone doesn't guarantee secure access conditions.

If Conditional Access policies aren't applied to relevant identities, attackers might authenticate successfully without meeting device compliance, location, or multifactor requirements.

Conditional Access strengthens identity enforcement by evaluating context in addition to credentials.

Without it, identity security relies solely on credential protection.

Certain operational symptoms often point back to identity design decisions. Unexpected model deployments can indicate excessive management plane permissions, while unusual model invocation patterns or data access spikes might suggest overly broad data plane access. When investigating AI incidents, examining identity scope and role assignments is often more revealing than inspecting the model itself.

## Closing the loop

Identity architecture defines who can access AI resources, what they can do, and where that access applies.

Misconfigurations weaken those boundaries.

Designing identity intentionally means:

- Assigning only required permissions
- Limiting scope appropriately
- Separating environments
- Protecting credentials
- Enforcing contextual access controls

AI security depends on identity discipline. The tools that monitor posture and detect risk build on these foundations, but they don't replace them.
