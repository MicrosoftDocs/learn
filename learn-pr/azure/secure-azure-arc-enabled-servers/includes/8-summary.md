Over the course of this module, you explored the security capabilities of Azure Arc-enabled servers. You explored security services including Microsoft Defender for Cloud, Microsoft Defender for Servers, and Microsoft Sentinel. These services offer improved visibility, threat intelligence, and help customers like Tailwind Traders to ensure regulatory compliance.

First, you explored the capabilities of Microsoft Defender for Cloud across continuous assessment, securing, and defending resources. Next, you learned about onboarding Azure Arc-enabled servers to Defender for Cloud. Additionally, you learned about Microsoft Defender for Servers' enhanced security features. Finally, you learned about Microsoft Sentinel's SIEM and SOAR functionalities.

Tailwind Traders' compute infrastructure is multicloud and hybrid. Azure Arc-enabled servers offer a powerful way to streamline and improve security across your organization's infrastructure. Microsoft's security solutions aren't limited to Azure. Through Azure Arc, you can extend them across your digital estate.  

## More info

Use these resources to review prerequisites, follow detailed procedures, and explore the security capabilities covered in this module.

### Azure Arc and portal access

Review Azure Arc deployment requirements and access the management portals:

- [Azure Arc overview](https://azure.microsoft.com/services/azure-arc/)
- [Azure Arc-enabled servers overview](/azure/azure-arc/servers/overview)
- [Azure Arc-enabled servers deployment](https://azurearcjumpstart.io/azure_arc_jumpstart/azure_arc_servers/)
- [Azure Connected Machine agent deployment options](/azure/azure-arc/servers/deployment-options)
- [Azure Arc supported operating systems](/azure/azure-arc/servers/prerequisites#supported-operating-systems)
- [Azure Arc network requirements](/azure/azure-arc/servers/network-requirements)
- [Azure portal](https://portal.azure.com)
- [Microsoft Defender portal](https://security.microsoft.com)

### Defender for Cloud configuration and compliance

Use this guidance to configure permissions, assess compliance, and connect multicloud resources:

- [Implement security recommendations](/azure/defender-for-cloud/implement-security-recommendations)
- [MCSB in Defender for Cloud](/azure/defender-for-cloud/concept-regulatory-compliance)
- [Regulatory compliance standards](/azure/defender-for-cloud/concept-regulatory-compliance-standards)
- [Default compliance standards](/azure/defender-for-cloud/concept-regulatory-compliance-standards#default-compliance-standards)
- [Defender for Cloud permissions](/azure/defender-for-cloud/permissions)
- [Security Admin role definition](/azure/role-based-access-control/built-in-roles/security#security-admin)
- [Connect your AWS account](/azure/defender-for-cloud/quickstart-onboard-aws)
- [Connect your GCP project](/azure/defender-for-cloud/quickstart-onboard-gcp)
- [Defender for Cloud release notes](/azure/defender-for-cloud/release-notes)
- [Manage plans in the Defender portal](/azure/defender-for-cloud/defender-portal/manage-plans-defender-portal)
- [Operating-system misconfiguration guidance](/azure/defender-for-cloud/operating-system-misconfiguration)
- [Defender for Containers support matrix](/azure/defender-for-cloud/support-matrix-defender-for-containers)

### Defender for Servers protections

Review plan coverage, enable endpoint protection, and configure server security features:

- [Defender for Servers overview and plan comparison](/azure/defender-for-cloud/defender-for-servers-overview)
- [Enable Defender for Servers](/azure/defender-for-cloud/tutorial-enable-servers-plan)
- [Defender for Servers support matrix](/azure/defender-for-cloud/support-matrix-defender-for-servers)
- [Enable Defender for Endpoint integration](/azure/defender-for-cloud/enable-defender-for-endpoint)
- [Defender for Endpoint integration prerequisites](/azure/defender-for-cloud/enable-defender-for-endpoint#prerequisites)
- [Defender for Endpoint deployment and verification by platform](/azure/defender-for-cloud/enable-defender-for-endpoint#deployment-and-verification-by-platform)
- [Vulnerability assessment collection methods](/azure/defender-for-cloud/auto-deploy-vulnerability-assessment)
- [Agentless collection architecture](/azure/defender-for-cloud/concept-agentless-data-collection)
- [Set up integrated vulnerability assessment](/azure/defender-for-cloud/deploy-vulnerability-assessment-defender-vulnerability-management)
- [Defender Vulnerability Management remediation requests](/defender-vulnerability-management/tvm-remediation)
- [Enable file integrity monitoring](/azure/defender-for-cloud/file-integrity-monitoring-enable-defender-endpoint)
- [Enable file integrity monitoring in the Azure portal](/azure/defender-for-cloud/file-integrity-monitoring-enable-defender-endpoint#enable-file-integrity-monitoring-in-the-azure-portal)
- [Review file integrity monitoring changes](/azure/defender-for-cloud/file-integrity-monitoring-review-changes)
- [Windows security alerts overview](/azure/defender-for-cloud/alerts-windows-machines)
- [Alerts for Windows machines](/azure/defender-for-cloud/alerts-windows-machines#windows-machines-alerts)
- [Azure Update Manager overview](/azure/update-manager/overview)
- [Microsoft Defender for Cloud pricing](https://azure.microsoft.com/pricing/details/defender-for-cloud/)

### Windows application security

Use these resources to plan application-control policies, attack surface reduction rules, and audit settings:

- [App Control for Business](/windows/security/application-security/application-control/app-control-for-business/appcontrol)
- [App Control for Business feature availability](/windows/security/application-security/application-control/app-control-for-business/feature-availability)
- [App Control for Business deployment guide](/windows/security/application-security/application-control/app-control-for-business/deployment/appcontrol-deployment-guide)
- [Use audit events to create App Control policy rules](/windows/security/application-security/application-control/app-control-for-business/deployment/audit-appcontrol-policies)
- [Attack surface reduction overview](/defender-endpoint/attack-surface-reduction-overview)
- [Attack surface reduction rules overview](/defender-endpoint/attack-surface-reduction-rules-overview)
- [Windows audit-policy guidance](/windows-server/identity/ad-ds/plan/security-best-practices/audit-policy-recommendations)

### Microsoft Sentinel setup and operations

Review Sentinel prerequisites, configure connectors, and prepare for the Defender portal experience:

- [Microsoft Sentinel overview](/azure/sentinel/overview)
- [Microsoft Sentinel Azure portal retirement timeline](/azure/sentinel/overview#microsoft-sentinel-in-the-azure-portal-retirement-timeline)
- [Microsoft Sentinel onboarding](/azure/sentinel/quickstart-onboard)
- [Microsoft Sentinel prerequisites](/azure/sentinel/quickstart-onboard#prerequisites)
- [Microsoft Sentinel workspace requirements](/azure/sentinel/prerequisites#workspace-requirements)
- [Microsoft Sentinel roles](/azure/sentinel/roles)
- [Microsoft Sentinel roles for specific tasks](/azure/sentinel/roles#additional-roles-for-specific-tasks)
- [Onboard Microsoft Sentinel to the Defender portal](/azure/sentinel/microsoft-sentinel-onboard)
- [Microsoft Sentinel transition guide](/azure/sentinel/move-to-defender)
- [Analytics changes in the Defender portal](/azure/sentinel/move-to-defender#configure-analytics-rules)
- [Connector changes after moving to Defender](/azure/sentinel/move-to-defender#confirm-and-configure-data-collection)
- [What's new in Microsoft Sentinel](/azure/sentinel/whats-new)
- [Collect Windows security events](/azure/sentinel/connect-services-windows-based)
- [Windows security event sets](/azure/sentinel/windows-security-event-id-reference)
- [Configure Syslog and CEF ingestion](/azure/sentinel/connect-cef-syslog-ama)
- [Cross-workspace queries](/azure/sentinel/extend-sentinel-across-workspaces-tenants#query-multiple-workspaces)
- [Microsoft Defender ATP connector](/connectors/wdatp/)
- [Microsoft Sentinel pricing](https://azure.microsoft.com/pricing/details/microsoft-sentinel/)

### Azure Monitor Agent and data collection

Use these references to configure agents and collection rules, verify ingestion, and interpret query results:

- [Azure Monitor Agent requirements](/azure/azure-monitor/agents/azure-monitor-agent-requirements)
- [Azure Monitor Agent supported operating systems](/azure/azure-monitor/agents/azure-monitor-agent-supported-operating-systems)
- [Azure Monitor Agent network configuration](/azure/azure-monitor/agents/azure-monitor-agent-network-configuration)
- [Verify AMA installation](/azure/azure-monitor/agents/azure-monitor-agent-manage#verify-installation)
- [Create and edit data collection rules](/azure/azure-monitor/data-collection/data-collection-rule-create-edit)
- [Windows event collection with Azure Monitor Agent](/azure/azure-monitor/vm/data-collection-windows-events)
- [Local Syslog collection with Azure Monitor Agent](/azure/azure-monitor/vm/data-collection-syslog)
- [Standard log columns](/azure/azure-monitor/logs/log-standard-columns#_resourceid)
- [Syslog table schema](/azure/azure-monitor/reference/tables/syslog)
