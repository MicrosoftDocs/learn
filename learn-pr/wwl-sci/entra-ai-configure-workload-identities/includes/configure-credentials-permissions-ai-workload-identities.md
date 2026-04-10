Now that you've identified the risks, you can configure the workload identity to fit where it runs and what it needs to access.

## Select the right credential pattern

Use the workload's hosting model to decide how it should authenticate.

| Workload scenario | Preferred credential pattern | Why it fits |
| --- | --- | --- |
| Azure-hosted AI workload that supports managed identity | Managed identity | Azure manages the credential lifecycle, so you avoid storing secrets. |
| Workload outside Azure or workload using an app registration with a trust relationship | Federated identity credential | The application can trust an external or managed identity token instead of storing a secret. |
| Scenario where federation is unavailable but strong app credentials are still required | Certificate credential | Certificates are a stronger production fallback than client secrets. |
| Local development or temporary test path only | Client secret | Simplest to configure for short-lived dev/test scenarios. Not recommended for production, and should only be used when managed identity or certificate-based authentication isn't possible. |

## Configure authentication for the workload

To configure the credential model:

1. Confirm where the AI workload runs and whether the host supports managed identity.
1. If the workload runs on a supported Azure resource, enable a system-assigned or user-assigned managed identity on that resource.
1. If the workload needs an application object or runs outside Azure, create or select the app registration or service principal that represents the workload.
1. If federation is supported for the scenario, add a federated identity credential on that application so it trusts the external or managed identity token.
1. If federation isn't available, configure a certificate credential. Use a client secret only for limited development or testing scenarios.
1. Test token acquisition for the chosen credential type before assigning permissions. A successful sign-in from the actual hosting environment confirms the credential model works as intended.

This approach keeps Azure-hosted workloads on managed identity and uses federation to avoid secrets when managed identity isn't available.

Configure the credential on the identity object the workload actually uses. For Azure-hosted resources, that usually means the managed identity on the resource itself. For external workloads or app-based patterns, that means the app registration or service principal that represents the workload.

> [!NOTE]
> Workload identity federation depends on case-sensitive exact matching of issuer, subject, and audience claims. If those values don't match the incoming token, token exchange fails.

## Assign least-privilege permissions

After authentication works, assign only the permissions required for the workload's task.

Use these permission planes deliberately:

- Azure RBAC for access to Azure resources such as storage accounts, Key Vault, or resource groups.
- Microsoft Graph application permissions on the workload application for directory and Microsoft 365 operations.
- App roles on downstream applications or APIs for application-specific functions.

Least privilege means scoping permissions to the workload's actual task, not the broadest role that makes the test succeed. For each assignment, identify the specific resource, operation, and boundary the workload needs.

## Right-size Azure RBAC, Graph permissions, and app roles

To right-size access:

1. List the exact tasks the workload must perform.
1. Map each task to the correct permission plane: Azure RBAC, Microsoft Graph application permission, or app role.
1. Choose the narrowest built-in role or permission that supports the task.
1. Scope the assignment to the smallest workable boundary, such as a specific resource, resource group, management group, or application.
1. Remove overlapping or inherited permissions that the workload doesn't need.
1. Record why each permission exists, which identity holds it, and what resource boundary it applies to. Future reviews depend on this record to confirm that the access is still justified.

## Apply the pattern to common AI workload cases

These examples show how the selection logic works in practice:

- An Azure-hosted orchestration service that reads from Key Vault and writes to one storage account should use a managed identity with narrowly scoped RBAC roles on those resources.
- A workload running outside Azure that needs app-only access to Microsoft Graph should use an app registration with workload identity federation when possible, then receive only the Graph application permissions needed for its tasks.
- A service principal used for a custom API should receive only the app roles required by that API, not general directory permissions that are unrelated to the workload.

## Verify the setup before moving on

Before you continue to agent identities, confirm that:

- The workload uses the most secure supported credential type for its environment.
- No unnecessary secret remains in the design.
- Each RBAC role, Graph permission, and app role has a clear task-level justification.
- The identity has only the access needed to perform its intended work.
- You can identify which object holds the credential and which object holds each permission assignment.

That step prevents a familiar mistake: treating successful sign-in as proof that the configuration is correct.
