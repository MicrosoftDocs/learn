You've successfully implemented Microsoft Defender for Servers across Contoso Manufacturing's server estate, transforming unmonitored virtual machines and Arc-connected servers into actively protected assets with comprehensive vulnerability visibility and threat detection capabilities.

You selected Defender for Servers Plan 2 to meet the organization's security requirements. Plan 2 provides agentless scanning for Arc-connected factory servers without agent deployment overhead, just-in-time VM access for securing management ports, and File Integrity Monitoring for detecting tampering with OT system files—capabilities essential for regulated manufacturing environments that Plan 1 doesn't include.

You configured vulnerability scanning using both agent-based and agentless methods. Agent-based scanning through the MDE sensor provides continuous, real-time detection with immediate visibility into newly disclosed vulnerabilities. Agentless scanning runs every 24 hours, analyzes disk snapshots offline with no performance challenge on VMs, and provides redundant coverage that persists even if an attacker disables the agent. When both methods are active, agent-based results take precedence in the Defender portal because they offer better freshness.

You managed the Microsoft Defender for Endpoint integration, which autoprovisions to all protected VMs and delivers endpoint detection and response capabilities including behavioral analytics and threat intelligence. You configured agentless scanning capabilities—software inventory, vulnerability assessment, secrets scanning, and malware scanning—that operate as a unified feature set during daily disk analysis.

Finally, you enabled File Integrity Monitoring to detect unauthorized changes to OS files, Windows registries, and application software files. FIM requires Plan 2, the MDE agent, and agentless scanning to provide both real-time change detection through the agent sensor and daily validation through agentless scans. This dual-source approach ensures resilient change detection that's difficult for attackers to evade.

## Learn more

- [Defender for Servers overview](/azure/defender-for-cloud/defender-for-servers-overview)
- [Enable agentless machine scanning](/azure/defender-for-cloud/enable-agentless-scanning-vms)
- [File Integrity Monitoring overview](/azure/defender-for-cloud/file-integrity-monitoring-overview)
- [Integration with Microsoft Defender for Endpoint](/azure/defender-for-cloud/integration-defender-for-endpoint)
