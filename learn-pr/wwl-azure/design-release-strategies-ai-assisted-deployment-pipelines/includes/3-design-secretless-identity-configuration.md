The deployment target is ready, but the pipeline still needs authority to install the application. Giving it a subscription-wide credential might make the first deployment work while also allowing changes unrelated to that deployment. Copying that credential into another environment spreads the same risk.

Design access around the operation, target, and execution context. For the illustrative EShopOnWeb release, the build job needs no Azure write access. Application deployment needs access to its approved target. The running application needs a different identity to access its dependencies. None of those requirements automatically includes permission to create identities or assign roles.

## Separate deployment identity from runtime identity

A **service principal** represents an application in a Microsoft Entra tenant. It can authenticate through different mechanisms; a client secret isn't an unavoidable requirement. **Workload identity federation** lets an external workload exchange a trusted identity token for access without storing a long-lived Azure password.

A **managed identity** is an Azure-managed workload identity. A system-assigned identity shares the lifecycle of its Azure resource. A user-assigned identity is a separate resource that can be associated with supported workloads. Choose deliberately: sharing a user-assigned identity also shares its effective permissions.

Use the distinction to separate three boundaries:

| Boundary | Required access | Access not implied |
| --- | --- | --- |
| Application deployment | Install the accepted package on the named target | Create role assignments or administer unrelated applications |
| Infrastructure maintenance, if required | Apply an independently approved resource change | Approve its own access expansion |
| Application runtime | Read required configuration and access permitted dependencies | Deploy a new version of itself |

Use different identities across environments where separation is required. Review the effective role assignments and resource scope rather than relying on an identity's descriptive name. A staging identity with production access isn't isolated just because its name contains "staging."

## Use platform-specific secretless connections

In Azure Pipelines, an Azure Resource Manager service connection binds pipeline tasks to an Azure authentication configuration and scope. Prefer workload identity federation with a supported app registration or managed identity. Authorize the specific pipelines that need the connection instead of treating connection availability as permission for every pipeline.

In GitHub Actions, configure Azure federation for the intended repository and deployment context, then use `azure/login` in the job that needs Azure access. That job needs `id-token: write` to request an OIDC token. This permission doesn't itself grant Azure resource access: federation establishes trust, and Azure role assignments determine the resulting authority.

An environment-based deployment can have different token subject claims from a branch-based workflow. Configure trust against the actual issuer, audience, and subject for the selected context; don't copy a branch example into an environment job and assume it matches. Keep environment branch restrictions and approval protections independently configured. The build job doesn't need OIDC permission merely because a later job authenticates to Azure.

Federation removes a stored credential, not the need to control executable code. A compromised deployment job can still use its identity during execution. Limit which revisions, templates, actions, and agents or runners can reach that job. Don't give untrusted PR execution access to a deployment connection.

## Keep secrets, configuration, and feature state distinct

The same artifact can run in several environments with different approved settings. Keep those settings outside the compiled package, but record which configuration accompanies each deployment.

- **Secrets and certificates:** Use a suitable secret-management service such as Azure Key Vault. Grant access to the identity that actually consumes the value.
- **Nonsecret settings:** Manage service endpoints, timeouts, and environment settings separately. Azure App Configuration can centralize application settings; pipeline variables can supply deployment inputs.
- **Feature state:** Record which cohorts can use a feature and which flag configuration enables it. A flag change can alter production behavior without changing the application binary.

For example, App Service Key Vault references let an application resolve a secret using its configured managed identity. The deployment identity doesn't automatically need to retrieve the secret value. The runtime identity still needs both authorization and network access to the vault.

Record configuration revisions, secret-reference/version policy, and flag state without copying secret values into the release record. Validate configuration compatibility before deployment and confirm that the application actually receives the intended settings. Secret rotation and configuration refresh can have propagation or caching delays; don't assume that changing a stored value updates every running instance immediately.

Treat access to deployment-time credentials as an exception where secretless authentication isn't supported. Give each exception an owner, narrow scope, expiry, rotation procedure, and removal plan. Tokens and secure files aren't interchangeable identity types: a repository token, signing certificate, and Azure access token authorize different operations. Protect any required certificate or secure-file download and prevent its contents from entering logs, artifacts, or Copilot context.

## Review the access and configuration contract

Before accepting deployment YAML, identify the caller, trusted execution context, target resource, effective permission, and approval owner. Confirm that deployment failure won't trigger an automatic permission increase. A missing role assignment or unresolved secret reference is a prerequisite failure to investigate, not a reason to grant broad access.

Copilot can help compare a proposed definition with an approved access matrix or identify unnecessary secret references. Supply resource identifiers and redacted configuration structure, not credential values. A proposed correction still needs normal review and independently authorized execution.

Carry forward the approved identities, connection names, configuration references, and boundaries on who can change them. The next unit uses that contract to control which users receive the change and what evidence permits broader exposure.

Learn more about [Azure workload identity service connections](/azure/devops/pipelines/library/connect-to-azure?view=azure-devops), [managed identities](/entra/identity/managed-identities-azure-resources/overview), [App Configuration](/azure/azure-app-configuration/overview), [App Service Key Vault references](/azure/app-service/app-service-key-vault-references), and [GitHub OIDC for Azure](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-azure).
