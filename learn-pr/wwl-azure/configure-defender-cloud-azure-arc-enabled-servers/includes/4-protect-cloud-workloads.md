Cloud workload protection plans add workload-specific threat detection and security capabilities to Defender for Cloud. For hybrid servers, use **Defender for Servers**.

## Compare Defender for Servers plans

Both plans support Azure virtual machines and supported Azure Arc-enabled Windows and Linux servers.

| Capability | Plan 1 | Plan 2 |
| --- | --- | --- |
| Microsoft Defender for Endpoint integration | Yes | Yes |
| Defender Vulnerability Management | Core capabilities | Core and premium capabilities |
| File integrity monitoring | No | Yes |
| Operating-system update assessment for Arc-enabled servers | No | Yes |
| Operating-system baseline misconfiguration assessment for Arc-enabled servers | No | Yes |
| 500-MB daily data-ingestion benefit for eligible data types | No | Yes |

Plan 2 includes additional capabilities, but availability depends on the machine environment. In particular, agentless vulnerability, malware, and secrets scanning supports Azure VMs and connected AWS and Google Cloud compute instances. It doesn't support on-premises Azure Arc-enabled servers. Just-in-time access and network-layer protections also have environment-specific limitations. Review the [Defender for Servers support matrix](/azure/defender-for-cloud/support-matrix-defender-for-servers) before selecting a plan.

Defender for Cloud also provides workload plans for containers, storage, databases, APIs, AI services, and other Azure resources. Those plans don't replace Defender for Servers protection for Azure Arc-enabled machines.
