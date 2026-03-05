Security architects evaluating solutions for operational technology (OT) and industrial control systems (ICS) face unique challenges. Traditional security tools designed for IT environments often can't monitor specialized industrial protocols or deploy agents on embedded controllers. Microsoft Defender for IoT addresses these challenges through agentless network monitoring purpose-built for OT environments.

## Evaluate the solution architecture

Defender for IoT uses a distributed architecture with network sensors deployed at strategic points to monitor traffic. Understanding this architecture helps you evaluate whether the solution meets your organization's requirements.

**Core components**

| Component | Function | Deployment location |
| --- | --- | --- |
| OT network sensors | Monitor network traffic through SPAN ports or TAPs, detect devices, and identify threats | On-premises at each monitored site |
| Azure portal | Centralized management, cross-site visibility, integration with Azure services | Cloud |
| Device inventory | Comprehensive asset discovery across IT, IoT, and OT devices | Both sensor and portal |

**Sensor capabilities**

OT sensors perform deep packet inspection across 100+ industrial protocols including Modbus, OPC-UA, BACnet, DNP3, and proprietary SCADA protocols. The sensors use machine learning to establish behavioral baselines and detect anomalies without requiring signatures for every threat variant.

**Agentless monitoring**

Evaluate whether agentless monitoring addresses your security requirements. Defender for IoT monitors traffic passively—it requires no agents on endpoints, no changes to device configurations, and no impact on production systems. This approach is essential for environments with legacy programmable logic controllers (PLCs), remote terminal units (RTUs), and embedded controllers that can't support endpoint agents.

## Assess deployment model options

Your deployment architecture depends on connectivity requirements, compliance constraints, and operational needs.

**Cloud-connected deployment**

Sensors connect directly to Azure for centralized management and integration with Microsoft security services.

Benefits to evaluate:

- Single pane of glass across all sites in the Azure portal
- Automatic threat intelligence updates
- Integration with Microsoft Sentinel for unified SOC operations
- Microsoft Defender XDR integration for cross-domain correlation

Requirements:

- Network connectivity from sensors to Azure endpoints
- Azure subscription with Defender for IoT plan

**Air-gapped deployment**

For environments requiring complete isolation from external networks, sensors operate fully on-premises.

Benefits to evaluate:

- No data leaves the local environment
- Meets strict regulatory requirements (NERC CIP, nuclear facilities)
- Full functionality available through local sensor console

Requirements:

- Manual threat intelligence updates
- Local management and monitoring infrastructure
- Integration with on-premises SIEM through syslog or API

**Hybrid deployment**

Some sensors connect to Azure while others remain locally managed—appropriate for organizations with mixed connectivity requirements.

When evaluating deployment models, consider that the legacy on-premises management console is no longer supported. Current architecture guidance recommends integrating air-gapped sensors directly with existing IT infrastructure through APIs and syslog forwarding.

## Evaluate security operations integration

Defender for IoT provides value when integrated into your organization's security operations workflow. Evaluate integration capabilities based on your SOC tooling.

**Microsoft Sentinel integration**

The Defender for IoT data connector streams alerts to Microsoft Sentinel, enabling:

- Unified incident queue across IT and OT environments
- OT-specific analytics rules and workbooks
- SOAR playbooks for automated response
- Correlation with IT security events for comprehensive threat detection
- MITRE ATT&CK for ICS technique mapping

**Microsoft Defender XDR integration**

Enterprise IoT capabilities extend visibility to enterprise IoT devices (printers, smart TVs, conferencing systems) through Defender for Endpoint integration. This provides:

- Shared device inventory across Defender for IoT and Defender XDR
- Unified alerts and recommendations
- Cross-domain attack correlation

**Third-party SIEM integration**

For organizations using other SIEM platforms, evaluate:

- Syslog forwarding for real-time alert streaming
- API access for device inventory and vulnerability data
- Event hub integration through Azure for high-volume data export

## Assess threat detection capabilities

Evaluate whether the detection capabilities address your specific threat landscape.

**Asset discovery**

Continuous passive monitoring identifies all networked devices, including:

- PLCs, RTUs, HMIs, and engineering workstations
- Network infrastructure (switches, routers, firewalls)
- Device attributes (vendor, firmware version, protocols used)
- Communication patterns between devices

**Vulnerability assessment**

Risk-based prioritization helps focus remediation efforts on:

- Unpatched firmware and known CVEs
- Insecure protocols (Telnet, FTP, clear-text communications)
- Unauthorized network connections
- Configuration changes to controllers

**Threat detection**

Evaluate detection coverage for your threat scenarios:

- Unauthorized PLC code changes
- Reconnaissance and scanning activity
- Living-off-the-land attacks using legitimate OT protocols
- Malware indicators and command-and-control communications
- Policy violations (unauthorized connections, protocol misuse)

**Protocol support**

Verify coverage for your specific industrial protocols. Defender for IoT supports major protocols natively. For proprietary protocols, evaluate the Horizon Open Development Environment (ODE) SDK for custom dissector development.

## Plan sites and zones

Effective deployment requires mapping your OT architecture into logical segments.

**Sites**

Represent physical locations (facilities, plants, buildings). Each site can have multiple sensors for coverage across network segments.

**Zones**

Represent functional areas within a site (production lines, utility systems, safety systems). Zones enable:

- Granular access control based on user responsibilities
- Logical grouping for alerts and reporting
- Traffic monitoring across zone boundaries

**Sensor placement**

Position sensors to capture east-west traffic within zones and north-south traffic between zones. Common placement points include:

- Core switches in the control network
- Network boundaries between IT and OT (demilitarized zone)
- Connections between Purdue model levels

## Evaluate compliance support

Defender for IoT assists with compliance requirements common in industrial environments.

**Supported frameworks**

- IEC 62443 for industrial automation security
- NERC CIP for energy sector critical infrastructure
- NIST Cybersecurity Framework
- Industry-specific regulations (FDA for pharmaceuticals, TSA for pipelines)

**Compliance capabilities**

- Asset inventory for regulatory reporting
- Vulnerability tracking and risk scoring
- Audit trail for security events
- Network segmentation verification

## Design considerations

When evaluating Defender for IoT for your organization, consider:

**Sensor sizing**

Match sensor hardware or VM specifications to monitored bandwidth. Under-provisioned sensors may drop packets during traffic spikes.

**Network architecture**

Ensure traffic mirroring infrastructure (SPAN ports, network TAPs) can capture all relevant traffic without impacting production.

**Change management**

Plan for initial learning mode where sensors establish baselines. Alert tuning reduces false positives after deployment.

**Operational impact**

Validate that passive monitoring doesn't introduce latency or affect deterministic behavior of control systems.

**Licensing**

Defender for IoT licenses based on committed devices. Plan capacity based on expected device count across all sites.
