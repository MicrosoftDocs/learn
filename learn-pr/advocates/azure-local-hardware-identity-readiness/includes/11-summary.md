Readiness combines a qualified hardware configuration, deliberate Azure scope, a supported local identity model, nonoverlapping networks, and reproducible validation. Hardware minimums don't establish workload capacity. Azure rights don't confer local logon rights. Removing AD DS doesn't remove DNS, time, certificate, or recovery responsibilities.

Use evidence to identify the failing boundary, assign its owner, and make the smallest supported correction. Preserve reports before rerunning checks. Accept the final configuration only when mandatory requirements are met, findings have defensible dispositions, and lifecycle owners can maintain what's being deployed.

The next course module, **Azure Local network engineering**, develops the network design in more detail. Carry forward the approved node inventory, identity decision, address plan, endpoint dependencies, and readiness findings rather than collecting those inputs again during deployment.

## References

Use these Microsoft references for build-specific requirements and exact operational procedures. Where a summary page and a detailed workflow differ, confirm the selected architecture and version with the responsible support owner rather than inventing an exception.

| Topic | Reference |
| --- | --- |
| Release baseline | [Azure Local release information](/azure/azure-local/release-information-23h2?view=azloc-2610&preserve-view=true) |
| Deployment scope | [Find your Azure Local deployment type](/azure/azure-local/plan/find-your-deployment-type?view=azloc-2610&preserve-view=true) |
| Prerequisite checklist | [Azure Local deployment prerequisites](/azure/azure-local/deploy/deployment-prerequisites?view=azloc-2610&preserve-view=true) |
| Hardware and diagnosability | [System requirements](/azure/azure-local/concepts/system-requirements-23h2?view=azloc-2610&preserve-view=true) |
| Network adapters and drivers | [Host network requirements](/azure/azure-local/concepts/host-network-requirements?view=azloc-2610&preserve-view=true) |
| Azure roles and providers | [Registration and deployment permission requirements](/azure/azure-local/deploy/deployment-arc-register-server-permissions?view=azloc-2610&preserve-view=true) |
| AD DS preparation | [Prepare Active Directory](/azure/azure-local/deploy/deployment-prep-active-directory?view=azloc-2610&preserve-view=true) |
| Manual AD DS delegation | [Configure custom Active Directory settings](/azure/azure-local/plan/configure-custom-settings-active-directory?view=azloc-2610&preserve-view=true) |
| AD DS forests, domains, and OUs | [Understand the Active Directory logical model](/windows-server/identity/ad-ds/plan/understanding-the-active-directory-logical-model) |
| Forest design choices | [Forest design models](/windows-server/identity/ad-ds/plan/forest-design-models) |
| Domain and forest trust concepts | [How domain and forest trusts work (archived conceptual reference)](/previous-versions/windows/it-pro/windows-server-2003/cc773178(v=ws.10)) |
| Identity model and tools | [Local identity with Key Vault overview](/azure/azure-local/deploy/deployment-local-identity-with-key-vault-overview?view=azloc-2610&preserve-view=true) |
| Local identity and recovery | [Deploy with local identity and Key Vault](/azure/azure-local/deploy/deployment-local-identity-with-key-vault?view=azloc-2610&preserve-view=true) |
| Vault and portal workflow | [Deploy Azure Local through the Azure portal](/azure/azure-local/deploy/deploy-via-portal?view=azloc-2610&preserve-view=true) |
| Network allocation | [Network considerations for cloud deployment](/azure/azure-local/plan/cloud-deployment-network-considerations?view=azloc-2610&preserve-view=true) |
| Outbound endpoints | [Firewall requirements](/azure/azure-local/concepts/firewall-requirements?view=azloc-2610&preserve-view=true) |
| Proxy lifecycle | [Update proxy settings](/azure/azure-local/manage/update-proxy-settings?view=azloc-2610&preserve-view=true) |
| Witness concepts and access | [Deploy a quorum witness](/windows-server/failover-clustering/deploy-quorum-witness?pivots=cloud-witness) |
| Validator use and reports | [Use Environment Checker](/azure/azure-local/manage/use-environment-checker?view=azloc-2610&preserve-view=true) |
| Role inspection | [Get-AzRoleAssignment](/powershell/module/az.resources/get-azroleassignment) |
| DNS inspection | [Resolve-DnsName](/powershell/module/dnsclient/resolve-dnsname) |
