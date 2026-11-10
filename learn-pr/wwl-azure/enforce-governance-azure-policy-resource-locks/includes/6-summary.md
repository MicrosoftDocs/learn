In this module, you learned how Contoso can address its compliance audit gap with Azure Policy and management locks. You reviewed built-in policy assignments at management group scope, using supported audit effects to discover 47 storage accounts without secure transfer and 12 SQL databases without Transparent Data Encryption (TDE). The secure-transfer definition supports a later transition from Audit to Deny. The SQL TDE audit definition doesn't support Deny, so Contoso enables TDE separately, for example with the Deploy SQL DB transparent data encryption definition and a remediation task.

You first considered parameterized built-ins, then created a custom definition to audit or deploy an enabled allLogs diagnostic setting to an approved workspace for production-tagged Key Vaults. Its embedded template and assignment identity support DeployIfNotExists remediation. Successful create/update requests can trigger deployment after the configured delay, while background scans only identify noncompliance. Existing resources require a remediation task, and log delivery must be confirmed separately from configuration compliance.

You distinguished the operator's permission to attach a user-assigned identity from the identity's deployment permissions. You also planned remediation recovery and test cleanup. Canceling a task isn't rollback, and deleting a managed identity doesn't automatically remove its Azure RBAC role assignments.

You also learned how scoped exemptions record approved waivers or mitigations without exempting unrelated controls. Exemptions remain visible in compliance reporting, while assignment exclusions are outside the compliance count. Compliance substate shows the state an exempt resource would have without its exemption and supports exception reviews. Neither a high aggregate percentage nor an exemption is proof that every technical control is implemented.

Delete locks protect critical resources and their descendants from accidental control-plane deletion. ReadOnly locks also restrict updates and some operations that use POST. Neither lock protects data-plane operations. Locks can't be applied to management groups and don't block subscription cancellation. Contributor alone can't remove locks, but principals with the required lock-delete permission can, including through Owner, User Access Administrator, or another applicable role. Test operational workflows before applying locks broadly.

Together, carefully scoped assignments, authorized remediation, documented exceptions, and management locks provide complementary governance controls. The next module addresses configuring Defender for Cloud security standards and deploying controls to remediate recommendations.

## More info

The following resources provide more detail about the governance controls covered in this module:

- [Azure Policy overview](/azure/governance/policy/overview)
- [Create a custom policy definition](/azure/governance/policy/tutorials/create-custom-policy-definition)
- [Remediation tasks](/azure/governance/policy/how-to/remediate-resources)
- [Managed identity lifecycle and role-assignment cleanup](/entra/identity/managed-identities-azure-resources/managed-identity-best-practice-recommendations#maintenance)
- [Policy exemptions](/azure/governance/policy/concepts/exemption-structure)
- [Compliance states and rollup](/azure/governance/policy/concepts/compliance-states)
- [Resource locks](/azure/azure-resource-manager/management/lock-resources)
