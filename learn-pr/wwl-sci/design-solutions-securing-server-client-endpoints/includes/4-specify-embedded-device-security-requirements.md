IoT devices and embedded systems present security challenges that differ from traditional endpoints. These devices often run specialized firmware, have limited processing power, operate in physically exposed environments, and connect to networks that were historically isolated. As a security architect, you need to specify requirements that address the constraints of resource-limited devices while protecting the infrastructure they support.

## Understand the IoT threat landscape

Security requirements for IoT and embedded systems should begin with threat modeling. The STRIDE framework — spoofing, tampering, repudiation, information disclosure, denial of service, and elevation of privilege — provides a structured approach for identifying threats across an IoT architecture.

Microsoft's IoT security guidance organizes protection into four areas to scope your requirements:

- **Asset security**: Protect physical devices while deployed on premises, including tamper-resistant hardware, secure boot, and firmware integrity
- **Connection security**: Ensure all data in transit between devices, edge infrastructure, and cloud services is confidential and tamper-proof
- **Edge security**: Protect data as it moves through and is stored on edge gateways and local processing infrastructure
- **Cloud security**: Protect data as it moves through and is stored in cloud services such as Azure IoT Hub

Each area requires its own authentication, authorization, and data protection controls. Addressing security across all four areas helps isolate damage and limit the blast radius of a compromised component.

## Specify device identity and authentication requirements

Strong device identity is the foundation of IoT security. Unlike user authentication, device identity must operate autonomously without human interaction.

**Hardware root of trust**

Require devices to include hardware security modules (HSMs) or trusted platform modules (TPMs) that:

- Store cryptographic credentials in tamper-resistant hardware
- Provide an immutable onboarding identity tied to the physical device
- Support unique, per-device renewable operational credentials

**Authentication mechanisms**

Specify passwordless authentication using X.509 certificates, the most secure authentication type supported by Azure IoT Hub:

- Provision operational certificates from a trusted public key infrastructure (PKI)
- Configure automatic certificate renewal to prevent service disruption
- Support certificate revocation lists (CRLs) to disable compromised devices immediately
- Require TLS 1.2 or higher for all device-to-cloud communications

**Secure provisioning at scale**

Require Azure IoT Hub Device Provisioning Service (DPS) or an equivalent zero-touch provisioning solution that:

- Automates device registration without human intervention
- Assigns devices to the correct IoT hub based on allocation policies
- Supports both TPM attestation and X.509 certificate enrollment
- Enables reprovisioning and decommissioning at scale

**Device registry**

Use the Azure IoT Hub device identity store as a centralized registry to manage the device lifecycle from provisioning through decommissioning, track device health, and support query-based device grouping at scale.

## Specify gateway requirements for constrained devices

Many embedded systems and legacy IoT devices can't support modern authentication or encryption. For these devices, require gateway-based protection.

**Azure IoT Edge gateways**

Specify IoT Edge gateways to act as security enforcement points for less-capable devices. An IoT Edge gateway:

- Authenticates to cloud services on behalf of downstream devices using strong identity (X.509 certificates with PKCS#11 or TPM support)
- Enforces security policies locally, including data filtering and protocol translation
- Provides encrypted communication between the gateway and cloud, even when downstream devices use unencrypted protocols
- Runs local workloads for scenarios with intermittent connectivity

**Azure Sphere guardian modules for legacy systems**

For existing devices that can't support trusted connectivity, specify Azure Sphere guardian modules that interface through Ethernet, serial, or Bluetooth Low Energy (BLE). These modules provide secure connectivity without exposing legacy devices directly to the network.

## Define network security requirements

Network design for IoT environments should assume compromise. Specify requirements that limit lateral movement.

**Network segmentation**

Require segmentation that isolates IoT devices from enterprise IT resources. Group devices based on:

- Risk level and criticality of connected systems
- Communication patterns and required data flows
- Trust level and security capabilities of the devices

Use micro-segmentation with next-generation firewalls to enforce policies between IoT device groups and corporate networks. Keep IoT devices on dedicated network segments — separate from endpoints that your workforce accesses, such as workstations or file servers.

**Firewall and access controls**

Specify firewall rules that:

- Allow only required device-to-cloud communications on approved ports and protocols
- Block unauthorized lateral traffic between device segments
- Monitor for anomalous traffic patterns that indicate compromise

**Air-gapped and isolated environments**

Some IoT deployments require complete network isolation — for example, medical device networks, critical infrastructure sensors, or classified environments. For these scenarios, specify:

- Physical separation from enterprise and internet-connected networks
- Local sensor deployment for threat detection and asset inventory (Defender for IoT supports fully on-premises, air-gapped sensor management)
- Secure, manual processes for applying firmware updates and threat intelligence packages without network connectivity
- Local management consoles for monitoring and incident response when cloud connectivity isn't available

## Specify monitoring and threat detection requirements

Continuous monitoring is essential for detecting threats across IoT environments. Many embedded devices can't run endpoint agents, so your requirements must account for both agent-based and agentless monitoring approaches.

**Microsoft Defender for IoT**

Specify Microsoft Defender for IoT as the unified security solution for discovering and protecting IoT and embedded devices. Defender for IoT provides agentless, network-layer monitoring that identifies devices, assesses vulnerabilities, and detects threats — all without installing agents on endpoints. Key capabilities:

- Continuous asset discovery across your IoT environment
- Vulnerability management with risk-based mitigation recommendations
- Behavioral analytics and threat detection using machine learning
- Integration with Microsoft Sentinel for unified SOC operations and Microsoft Defender XDR for cross-domain correlation

**Enterprise IoT monitoring**

For enterprise IoT devices such as printers, smart TVs, VoIP phones, and conferencing systems, specify integration with Microsoft Defender for Endpoint. Enterprise IoT security extends Defender for Endpoint to discover IoT devices and surface alerts, vulnerabilities, and recommendations in Defender XDR.

**Agentless network monitoring**

For constrained devices that can't support agents, require agentless monitoring through Defender for IoT network sensors. These sensors connect to SPAN ports or network TAPs and use deep packet inspection to monitor traffic passively — no changes to device configurations and no impact on production systems. The next unit covers Defender for IoT deployment models and OT-specific evaluation in detail.

**Device health evaluation**

Specify ongoing assessment that includes:

- Security configuration verification against established baselines (such as CIS benchmarks)
- Vulnerability scanning tied to a real-time software bill of materials (SBoM)
- Credential strength evaluation, including certificate validity and TLS version compliance
- Behavioral anomaly detection for unauthorized connections or configuration changes

**Integration requirements**

Require that all IoT threat data integrates with your centralized security operations through Microsoft Sentinel or another SIEM, security orchestration and automated response (SOAR) platforms, and conditional access policies for automated remediation.

## Define update and lifecycle management requirements

Devices that can't receive security updates become permanent vulnerabilities. Specify update mechanisms that support the full device lifecycle.

**Update capabilities**

Require all new devices to support:

- Over-the-air (OTA) firmware updates with cryptographic signature verification
- Rollback capability to recover from failed updates
- Staged rollout with validation before broad deployment

For Azure-connected devices, evaluate Device Update for IoT Hub, which provides A/B update support, detailed deployment tracking, and compliance reporting.

**End-of-support planning**

Require documentation of supported device lifetimes with committed security updates, decommissioning procedures, and replacement timelines for unpatched devices. Use IoT Hub automatic device management to enforce compliance policies across device fleets. Restrict network access for devices that exceed defined vulnerability thresholds.

## Apply zero-trust principles to IoT devices

Zero-trust principles assume breach and verify every access request. Apply these principles to IoT with adaptations for device constraints.

| Principle | IoT requirement |
| --- | --- |
| Verify explicitly | Hardware root of trust with renewable credentials |
| Least-privileged access | Limit device permissions to only required cloud endpoints and services |
| Assume breach | Segment networks, encrypt all communications, and emit device health signals for conditional access |

Require Microsoft Entra conditional access policies that evaluate device compliance status, risk signals from Defender for IoT, and network context before granting access. For device and gateway administration, enforce just-in-time access with multifactor authentication.

## Design considerations for security architects

Consider the following factors:

- **Device constraints**: Many IoT devices have limited memory, processing power, and storage. Tailor requirements to account for devices that can't run full security agents or perform complex cryptography. Use gateways to compensate.
- **Operational continuity**: IoT environments, especially in industrial settings, prioritize availability. Security controls must not disrupt critical processes. Plan for maintenance windows and gradual rollouts.
- **Legacy and brownfield devices**: Many organizations have existing devices designed before current security standards. Compensating controls through network monitoring, gateway-based protection, and device isolation are often necessary.
- **Supply chain security**: Require verification of device integrity from manufacturing through deployment, following DPS device manufacturer security practices. Specify secure boot, firmware signing, and tamper-evident packaging.
- **Compliance alignment**: Map requirements to relevant standards including IEC 62443 for industrial automation and NIST SP 800-183 for IoT security.
