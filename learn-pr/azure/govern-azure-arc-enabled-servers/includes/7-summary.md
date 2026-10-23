In this module, you explored how Azure Arc-enabled servers extend Azure governance and management to hybrid and multicloud environments. Fabrikam Residences can use these capabilities to apply consistent standards while choosing the appropriate service for each operational task.

You learned how Azure Machine Configuration audits or configures operating system settings and how Azure Policy reports compliance. You assigned an audit-only security baseline and distinguished auditing from configuration enforcement. You then explored policy initiatives, managed identities, and remediation tasks for onboarding management services at scale.

You also learned how AMA-based Azure Change Tracking and Inventory records changes, Azure Update Manager assesses and installs operating system updates, and Azure Automation uses extension-based Hybrid Runbook Workers for operational tasks. Together, these services support consistent management without assuming that every policy automatically corrects settings or that one agent provides every capability.

## More info

Use these resources for the services and procedures covered in this module.

### Machine Configuration and Azure Arc

Use these sources for configuration behavior, prerequisites, connectivity, and service benefits:

- [Azure Machine Configuration overview](/azure/governance/machine-configuration/overview/01-overview-concepts)
- [Machine Configuration prerequisites](/azure/governance/machine-configuration/overview/02-setup-prerequisites)
- [Machine Configuration assignment resources](/azure/governance/machine-configuration/concepts/assignments)
- [Azure Policy built-in definitions for Azure Arc-enabled servers](/azure/azure-arc/servers/policy-reference)
- [Troubleshoot Arc connectivity](/azure/azure-arc/servers/troubleshoot-connectivity): Azure Arc-enabled servers in disconnected scenarios.
- [Windows Server management benefits](/azure/azure-arc/servers/windows-server-management-overview): Windows Server Management enabled by Azure Arc.
- [Azure verification benefits](/azure/azure-local/deploy/azure-verification): Azure verification requirements.
- [Azure Policy pricing](https://azure.microsoft.com/pricing/details/azure-policy/) and [Azure Policy pricing (US)](https://azure.microsoft.com/pricing/details/azure-policy/)

### Azure Policy assignments and initiatives

Use these sources for policy assignments, permissions, initiatives, and remediation:

- [Azure portal](https://portal.azure.com/)
- [Azure Policy RBAC](/azure/governance/policy/overview#azure-rbac-permissions-in-azure-policy): Azure RBAC permissions in Azure Policy.
- [Portal assignment procedure](/azure/governance/policy/assign-policy-portal)
- [Windows baseline definition](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Guest%20Configuration/AzureWindowsBaseline_AINE.json) on GitHub
- [Policy exemptions](/azure/governance/policy/concepts/exemption-structure)
- [Azure Policy remediation](/azure/governance/policy/how-to/remediate-resources): Remediate noncompliant resources with Azure Policy.
- [Initiative definition structure](/azure/governance/policy/concepts/initiative-definition-structure)
- [Management-service migration guidance](/azure/governance/policy/how-to/migrate-from-automanage-best-practices)

### Monitoring, security, and change tracking

Use these sources for monitoring, endpoint protection, and Change Tracking and Inventory:

- [Install and manage AMA with Azure Policy](/azure/azure-monitor/agents/azure-monitor-agent-policy): AMA policy and identity requirements.
- [Enable VM insights](/azure/azure-monitor/vm/vminsights-enable-overview)
- [Enable Defender for Endpoint integration](/azure/defender-for-cloud/enable-defender-for-endpoint)
- [Azure Change Tracking and Inventory overview](/azure/azure-change-tracking-inventory/overview-monitoring-agent)
- [Change Tracking and Inventory support matrix](/azure/azure-change-tracking-inventory/change-tracking-inventory-support-matrix)
- [Create a Change Tracking DCR](/azure/azure-change-tracking-inventory/create-data-collection-rule)
- [Official Arc initiative definition](https://github.com/Azure/azure-policy/blob/99313872e9f5095d5da76d22377f01b016da35a6/built-in-policies/policySetDefinitions/ChangeTrackingAndInventory/HybridVM.json): official Arc Change Tracking initiative definition on GitHub.
- [Enable Change Tracking and Inventory at scale](/azure/azure-change-tracking-inventory/enable-change-tracking-at-scale-policy)
- [Change Tracking and Inventory portal onboarding quickstart](/azure/azure-change-tracking-inventory/quickstart-monitor-changes-collect-inventory-azure-change-tracking-inventory)

### Azure Update Manager

Use these sources for update support, access, assessments, and scheduling:

- [Azure Update Manager overview](/azure/update-manager/overview)
- [Update Manager FAQ](/azure/update-manager/update-manager-faq)
- [Update Manager prerequisites](/azure/update-manager/prerequisites)
- [Update Manager supported operating systems](/azure/update-manager/support-matrix-updates)
- [Update Manager supported regions](/azure/update-manager/supported-regions)
- [Update Manager permissions](/azure/update-manager/roles-permissions)
- [Periodic assessment at scale](/azure/update-manager/periodic-assessment-at-scale)
- [Scheduled patching](/azure/update-manager/scheduled-patching)

### Azure Automation

Use these sources for Hybrid Runbook Worker setup and runbook execution:

- [Deploy an extension-based worker](/azure/automation/extension-based-hybrid-runbook-worker-install): Deploy an extension-based Hybrid Runbook Worker.
- [Permissions for Hybrid worker credentials](/azure/automation/extension-based-hybrid-runbook-worker-install#permissions-for-hybrid-worker-credentials)
- [Hybrid Runbook Worker operation](/azure/automation/automation-hybrid-runbook-worker)
- [Run runbooks on a hybrid worker](/azure/automation/automation-hrw-run-runbooks): Run runbooks on a Hybrid Runbook Worker.
