Over the course of this module, you explored the planning and deployment of Azure Arc-enabled servers at scale for customers like Wide World Importers. You learned how Azure Arc-enabled servers delivers Azure services, such as Microsoft Defender for Cloud, Azure Policy, Azure Monitor, and virtual machine (VM) extensions, to servers across on-premises, multicloud, and edge environments through the Connected Machine agent.

First, you explored how to easily simulate an Azure Arc-enabled server using an Azure VM. Next, you learned about the built-in and added security considerations around planning a large deployment. You also learned about the range of different deployment methods supported by Azure Arc-enabled servers. Finally, you learned about best practices with deploying Azure Arc-enabled servers.

The compute infrastructure of Wide World Importers is complex, global, and hybrid. Your testing and research found that using Azure Arc-enabled servers is a powerful way to streamline security, governance, and visibility across your firm's entire digital estate. While deploying at-scale across your enterprise can be daunting, Azure Arc-enabled servers offers the testing, security, and support guidance to help you realize Azure capabilities more easily.

## More Info

The following resources support the module's procedures and technical review. Source IDs are also used in the review reports.

### Overview and architecture

Use these resources for overview and architecture:

- **R08:** [Manage extensions on Azure Arc-enabled servers](/azure/azure-arc/servers/manage-vm-extensions)
- **R42:** [Azure Arc agent connection status](/azure/azure-arc/servers/overview#agent-status)
- **R51:** [Azure Arc overview](https://azure.microsoft.com/services/azure-arc/)
- **R52:** [Azure Arc-enabled servers overview](/azure/azure-arc/servers/overview)
- **R53:** [Azure Arc-enabled servers \| Azure Arc Jumpstart](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/)
- **R54:** [Connected Machine agent components](/azure/azure-arc/servers/agent-overview#agent-components)
- **R60:** [GitOps application deployment on Azure Arc-enabled Kubernetes](/azure/azure-arc/kubernetes/conceptual-gitops-flux2)

### Preparation and onboarding

Use these resources for preparation and onboarding:

- **R11:** [Supported operating systems for Arc-enabled servers](/azure/azure-arc/servers/prerequisites#supported-operating-systems)
- **R12:** [Evaluate Azure Arc-enabled servers on an Azure VM](/azure/azure-arc/servers/plan-evaluate-on-azure-virtual-machine)
- **R13:** [Azure VM evaluation prerequisites](/azure/azure-arc/servers/plan-evaluate-on-azure-virtual-machine#prerequisites)
- **R14:** [Azure Arc-enabled servers prerequisites](/azure/azure-arc/servers/prerequisites)
- **R17:** [Connect hybrid machines with a portal-generated script](/azure/azure-arc/servers/onboard-portal)
- **R18:** [azcmagent show command reference](/azure/azure-arc/servers/azcmagent-show)
- **R19:** [Verify the Azure Arc connection](/azure/azure-arc/servers/onboard-portal#verify-the-connection-with-azure-arc)
- **R20:** [Troubleshoot Connected Machine agent onboarding](/azure/azure-arc/servers/troubleshoot-agent-onboard)
- **R21:** [Disconnect and uninstall the Connected Machine agent](/azure/azure-arc/servers/uninstall-agent)
- **R23:** [Create a service principal for onboarding at scale](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale)
- **R37:** [Azure Arc-enabled servers deployment options](/azure/azure-arc/servers/deployment-options)
- **R38:** [Onboard Azure Arc-enabled servers with PowerShell](/azure/azure-arc/servers/onboard-powershell)
- **R39:** [Onboard Azure Arc-enabled servers with a service principal](/azure/azure-arc/servers/onboard-service-principal)
- **R40:** [Create and run scripts in Microsoft Configuration Manager](/mem/configmgr/apps/deploy-use/create-deploy-scripts)
- **R57:** [Connect-AzConnectedMachine command reference](/powershell/module/az.connectedmachine/connect-azconnectedmachine?view=azps-16.4.0&preserve-view=true)
- **R58:** [Onboard Azure Arc-enabled servers with Windows Admin Center](/azure/azure-arc/servers/onboard-windows-admin-center)

### Identity, governance, and configuration

Use these resources for identity, governance, and configuration:

- **R01:** [Azure Machine Configuration concepts and assignment modes](/azure/governance/machine-configuration/overview/01-overview-concepts)
- **R09:** [Azure Machine Configuration prerequisites](/azure/governance/machine-configuration/overview/02-setup-prerequisites)
- **R22:** [Azure Connected Machine Onboarding role](/azure/role-based-access-control/built-in-roles/management-and-governance#azure-connected-machine-onboarding)
- **R24:** [Protect an Arc server's Microsoft Entra ID managed identity](/azure/azure-arc/servers/security-identity-authorization#microsoft-entra-id-managed-identity)
- **R25:** [Microsoft cloud security benchmark](/security/benchmark/azure/overview-mcsb-v1)
- **R26:** [Azure Policy built-in initiatives](/azure/governance/policy/samples/built-in-initiatives)
- **R27:** [Azure Policy deployIfNotExists effect](/azure/governance/policy/concepts/effect-deploy-if-not-exists)
- **R28:** [Azure Policy modify effect](/azure/governance/policy/concepts/effect-modify)
- **R29:** [Remediate noncompliant resources with Azure Policy](/azure/governance/policy/how-to/remediate-resources)
- **R50:** [Migrate service configuration to Azure Policy](/azure/governance/policy/how-to/migrate-from-automanage-best-practices)
- **R55:** [Azure Connected Machine Resource Administrator role](/azure/role-based-access-control/built-in-roles/management-and-governance#azure-connected-machine-resource-administrator)
- **R56:** [Azure Arc identity and authorization](/azure/azure-arc/servers/security-identity-authorization)

### Networking

Use these resources for networking:

- **R15:** [Required Azure Arc endpoint URLs](/azure/azure-arc/servers/network-requirements#urls)
- **R16:** [Connected Machine agent network requirements](/azure/azure-arc/servers/network-requirements)
- **R30:** [Configure Connected Machine agent proxy settings](/azure/azure-arc/servers/manage-agent-proxy-settings)
- **R31:** [Azure Arc networking configuration](/azure/azure-arc/servers/network-requirements#networking-configuration)
- **R32:** [Configure Azure Arc Private Link](/azure/azure-arc/servers/private-link-security)
- **R33:** [Azure Monitor Private Link Scope](/azure/azure-monitor/fundamentals/private-link-security)
- **R34:** [Azure Monitor data collection endpoints](/azure/azure-monitor/data-collection/data-collection-endpoint-overview)
- **R35:** [Azure ExpressRoute overview](/azure/expressroute/expressroute-introduction)
- **R36:** [Azure VPN Gateway overview](/azure/vpn-gateway/vpn-gateway-about-vpngateways)

### Monitoring, protection, and maintenance

Use these resources for monitoring, protection, and maintenance:

- **R02:** [Install an extension-based Hybrid Runbook Worker](/azure/automation/extension-based-hybrid-runbook-worker-install)
- **R03:** [Azure Update Manager operations and update sources](/azure/update-manager/workflow-update-manager)
- **R04:** [Azure Update Manager frequently asked questions](/azure/update-manager/update-manager-faq)
- **R05:** [Change Tracking and Inventory with Azure Monitor Agent](/azure/azure-change-tracking-inventory/overview-monitoring-agent)
- **R06:** [Defender for Cloud agentless scanning](/azure/defender-for-cloud/concept-agentless-data-collection)
- **R07:** [Microsoft Defender Vulnerability Management assessment](/azure/defender-for-cloud/deploy-vulnerability-assessment-defender-vulnerability-management)
- **R10:** [VM insights Map and Dependency Agent retirement guidance](/azure/azure-monitor/vm/vminsights-maps-retirement)
- **R41:** [Deploy Azure Monitor Agent on Arc-enabled servers](/azure/azure-arc/servers/azure-monitor-agent-deployment)
- **R43:** [Azure Monitor roles and permissions](/azure/azure-monitor/fundamentals/roles-permissions-security)
- **R44:** [Create Azure Resource Health alerts](/azure/service-health/resource-health-alert-arm-template-guide)
- **R45:** [Create an Azure Monitor action group](/azure/azure-monitor/alerts/action-groups#create-in-the-azure-portal)
- **R46:** [Test an Azure Monitor action group](/azure/azure-monitor/alerts/action-groups#test-an-action-group-in-the-azure-portal)
- **R47:** [Create an Azure Advisor alert rule](/azure/advisor/advisor-alerts-portal#create-an-alert-rule)
- **R48:** [Manage and upgrade the Connected Machine agent](/azure/azure-arc/servers/manage-agent)
- **R49:** [Azure Automanage retirement notice for Arc-enabled servers](/azure/automanage/automanage-arc)
- **R59:** [Create Azure Advisor recommendation alerts](/azure/advisor/advisor-alerts-portal)
