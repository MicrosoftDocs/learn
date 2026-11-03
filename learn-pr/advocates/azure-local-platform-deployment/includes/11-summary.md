In this module, you treated Azure Local deployment as three separate engineering responsibilities: readiness, orchestration, and acceptance. You mapped prerequisites to their owners, reviewed a versioned deployment contract, and distinguished a non-deploying template check from resource-changing readiness validation.

You examined the relationship between node registration, platform orchestration, and workload management. In the Contoso exercise, you identified contract defects, investigated the actual secret consumer behind a deployment failure, and selected a supported recovery boundary instead of repeating validation or replacing managed components.

Acceptance requires current, independent evidence from Azure, local infrastructure, and workload management, together with operational ownership and protected recovery procedures. Infrastructure-only provisioning can succeed while workload storage remains outstanding. Simplified machine provisioning also needs its own preview assessment: **Ready to cluster** completes node preparation, not platform commissioning or application acceptance.

## More info

Use these references to confirm release-specific requirements before performing a real deployment:

- [Azure Local deployment prerequisites](/azure/azure-local/deploy/deployment-prerequisites?view=azloc-2610&preserve-view=true).
- [Prepare Active Directory and the lifecycle deployment account](/azure/azure-local/deploy/deployment-prep-active-directory?view=azloc-2610&preserve-view=true).
- [Install and prepare the operating system, including optional domain join](/azure/azure-local/deploy/deployment-install-os?view=azloc-2610&preserve-view=true).
- [Azure Local ARM deployment and parameter reference](/azure/azure-local/deploy/deployment-azure-resource-manager-template?view=azloc-2610&preserve-view=true).
- [Azure Local deployment through the Azure portal](/azure/azure-local/deploy/deploy-via-portal?view=azloc-2610&preserve-view=true).
- [Azure Local node registration and deployment permissions](/azure/azure-local/deploy/deployment-arc-register-server-permissions?view=azloc-2610&preserve-view=true).
- [Local Identity with Azure Key Vault overview and compatibility](/azure/azure-local/deploy/deployment-local-identity-with-key-vault-overview?view=azloc-2610&preserve-view=true).
- [Local Identity deployment and DNS preparation](/azure/azure-local/deploy/deployment-local-identity-with-key-vault?view=azloc-2610&preserve-view=true).
- [Local Identity ARM deployment with external DNS](/azure/azure-local/deploy/deployment-local-identity-with-key-vault-template?view=azloc-2610&preserve-view=true).
- [Azure Arc gateway traffic, endpoints, and supported scenarios](/azure/azure-local/deploy/deployment-azure-arc-gateway-overview?view=azloc-2610&preserve-view=true).
- [Use Key Vault secrets in ARM deployment parameters](/azure/azure-resource-manager/templates/key-vault-parameter).
- [Use Environment Checker](/azure/azure-local/manage/use-environment-checker?view=azloc-2610&preserve-view=true).
- [Get support and collect diagnostics for deployment issues](/azure/azure-local/manage/get-support-for-deployment-issues?view=azloc-2610&preserve-view=true).
- [Simplified machine provisioning preview requirements and workflow](/azure/azure-local/deploy/simplified-machine-provisioning?view=azloc-2610&preserve-view=true).
- [Azure Local VM management architecture](/azure/azure-local/manage/azure-arc-vm-management-overview?view=azloc-2610&preserve-view=true).
- [Inspect recent solution health results](/azure/azure-local/manage/use-get-solution-health-summary-powershell-command?view=azloc-2610&preserve-view=true).
- [Interpret Storage Spaces health and operational states](/windows-server/storage/storage-spaces/storage-spaces-states).
- [Manage Network ATC](/windows-server/networking/network-atc/manage-network-atc).
- [Inspect the Azure Connected Machine agent](/azure/azure-arc/servers/azcmagent-show).
- [Test-AzResourceGroupDeployment reference](/powershell/module/az.resources/test-azresourcegroupdeployment).
