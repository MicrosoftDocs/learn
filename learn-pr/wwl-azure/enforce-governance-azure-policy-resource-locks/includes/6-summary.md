In this module, you addressed Contoso's compliance audit gap by implementing Azure Policy definitions and resource locks. You assigned built-in policy definitions at management group scope, starting with the Audit effect to discover noncompliant resources like the 47 storage accounts without secure transfer and 12 SQL databases without Transparent Data Encryption (TDE). Then you switched to Deny to block future violations. You created custom policy definitions with parameters and used DeployIfNotExists to automatically deploy diagnostic settings through remediation tasks. Policy exemption with compensating controls documented the few justified exceptions.

You applied Delete locks on critical resource groups to prevent accidental deletion of core network and vault infrastructure. With separation of duties, Contributor role members can't remove these locks; only Owner or User Access Administrator can.

Contoso's governance controls now prevent noncompliant deployments automatically, not through documentation and manual reviews. Azure Policy definitions enforce security configuration standards on every new resource, regardless of who deploys it. Remediation tasks systematically address the existing backlog of noncompliant resources.

Now that governance controls prevent noncompliant deployments, the next module addresses the operational side: configuring Defender for Cloud security standards and systematically deploying security controls to remediate the recommendations that existing resources generate.

## Learn more

- [Azure Policy overview](/azure/governance/policy/overview)
- [Create a custom policy definition](/azure/governance/policy/tutorials/create-custom-policy-definition)
- [Remediation tasks](/azure/governance/policy/how-to/remediate-resources)
- [Resource locks](/azure/azure-resource-manager/management/lock-resources)
