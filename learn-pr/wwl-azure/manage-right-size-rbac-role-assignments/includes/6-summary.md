In this module, you assigned built-in Azure roles at the narrowest justified scope—choosing service-specific roles over Contributor, resource group scope over subscription scope, and managed identities over user accounts for workloads. You created custom Azure RBAC roles using JSON definitions with precise action and data action sets. You distinguished Azure roles from Microsoft Entra custom roles, which control directory operations in a separate system. You evaluated existing overprivilege using Defender for Cloud CSPM CIEM recommendations and Azure Advisor, then remediated through Microsoft Entra access reviews with automatic revocation for nonresponses.

For Contoso, 37 Owner assignments at subscription scope are now addressed: 12 dormant assignments removed, 18 downgraded to appropriate service-specific roles at resource group scope, and 7 retained with documented access review approval. The access review schedule runs quarterly for Owner and Contributor at subscription scope. Defender for Cloud CSPM identity recommendations is assigned to the IAM team with 30-day governance rule deadlines.

Least privilege for human identities and workloads is now governed. Module 5 turns to a different attack surface: backup infrastructure. Ransomware operators routinely target backup vaults before encrypting production systems—the next module configures the security controls that protect those recovery points.

## Learn more

- [Azure RBAC overview](/azure/role-based-access-control/overview)
- [Create custom Azure roles](/azure/role-based-access-control/custom-roles)
- [Microsoft Entra custom roles](/entra/identity/role-based-access-control/custom-create)
- [Microsoft Entra access reviews](/entra/id-governance/access-reviews-overview)
- [Defender for Cloud identity recommendations](/azure/defender-for-cloud/recommendations-reference-identity-access)
