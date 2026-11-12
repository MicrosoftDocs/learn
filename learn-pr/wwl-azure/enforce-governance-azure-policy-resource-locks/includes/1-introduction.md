Configuring a security control once doesn't mean it stays enforced. A storage account deployed today with HTTPS-only enabled can coexist with a storage account deployed next week that allows HTTP traffic—unless you implement preventive governance controls. Azure Policy and resource locks transform security intentions into enforceable rules that apply automatically across your environment.

Contoso, a global financial services organization, faces this challenge before an external audit. A gap assessment revealed Azure resources deployed without required security configurations—SQL databases without TDE (Transparent Data Encryption), storage accounts allowing HTTP—and a critical virtual network accidentally deleted during maintenance. The security team needs preventive controls that enforce standards before incidents occur.

In this module, you learn how to assign built-in Azure Policy definitions at management group scope and select effects that each definition supports. Then you author a custom diagnostic policy, remediate existing noncompliant resources, manage approved exemptions, and apply management locks to protect critical resources from accidental control-plane deletion or modification.

## Requirements for following the procedures

You can read the module without deploying resources. To perform the walkthroughs, use an isolated test subscription or resource group, access to the management-group hierarchy used in the example, and permission to create the required policy definitions and assignments. **Resource Policy Contributor** is a relevant policy-management role. Contributor alone can't create or update policy definitions and assignments.

Permission to grant a managed identity roles is separate from permission to author policy. The assignment's identity also needs its own permissions to deploy or modify resources. Lock management requires the applicable `Microsoft.Authorization/locks/write` or `Microsoft.Authorization/locks/delete` action. If you use an existing user-assigned managed identity, you also need permission to read and assign that identity.

> [!IMPORTANT]
> Use least-privilege role assignments and test scopes before applying changes to production. A policy's `roleDefinitionIds` declaration isn't itself an RBAC grant. Confirm access to target resources and any destination outside the assignment scope before remediation. Diagnostic logging can incur ingestion and retention charges.

## Learning objectives

By the end of this module, you're able to:

- Assign built-in Azure Policy definitions and initiatives to enforce security configurations at subscription and management group scope.
- Explain how Deny, Audit, AuditIfNotExists, DeployIfNotExists, and Modify affect resource compliance.
- Select parameterized built-ins or author custom Azure Policy definitions when additional logic is required.
- Create policy remediation tasks, recover from unintended changes, and clean up test configuration.
- Grant scoped policy exemptions with appropriate approval, permissions, and expiration, and review their compliance substates.
- Configure management locks and explain their control-plane scope and operational limitations.

## More info

The following resources explain the permissions needed for the module's procedures:

- [Azure Policy permissions](/azure/governance/policy/overview#azure-rbac-permissions-in-azure-policy)
- [Remediation access control](/azure/governance/policy/how-to/remediate-resources)
- [Managed Identity Operator permissions](/azure/role-based-access-control/built-in-roles/identity#managed-identity-operator)
- [Management lock permissions](/azure/azure-resource-manager/management/lock-resources#who-can-create-or-delete-locks)
