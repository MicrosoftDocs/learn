Configuring a security control once doesn't mean it stays enforced. A storage account deployed today with HTTPS-only enabled can coexist with a storage account deployed next week that allows HTTP traffic—unless you implement preventive governance controls. Azure Policy and resource locks transform security intentions into enforceable rules that apply automatically across your environment.

Contoso, a global financial services organization, faces this challenge before an external audit. A gap assessment revealed Azure resources deployed without required security configurations—SQL databases without TDE (Transparent Data Encryption), storage accounts allowing HTTP—and a critical virtual network accidentally deleted during maintenance. The security team needs preventive controls that enforce standards before incidents occur.

In this module, you learn how to assign built-in Azure Policy definitions at management group scope. Then you explore authoring custom policy definitions with remediation tasks, and apply resource locks to prevent accidental deletion. You work with policies that enforce security configurations automatically and remediate noncompliant resources.

## Learning objectives

By the end of this module, you're able to:

- Assign built-in Azure Policy definitions and initiatives to enforce security configurations at subscription and management group scope.
- Understand how Azure Policy effects (Deny, Audit, DeployIfNotExists, Modify) control resource compliance behavior.
- Author custom Azure Policy definitions that enforce security requirements not covered by built-in definitions.
- Create policy remediation tasks to bring existing noncompliant resources into compliance.
- Configure Azure resource locks to protect critical resources from accidental deletion or modification.
