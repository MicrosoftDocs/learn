As a security architect, you specify security requirements for IoT workloads that address the unique challenges of connected devices and operational technology (OT) networks. IoT and OT environments differ significantly from traditional IT infrastructure and require specialized security approaches.

## Understand IoT security challenges

IoT devices present security challenges that don't exist in traditional computing environments. When specifying security requirements, consider these factors:

- **Lack of visibility**: Unmanaged IoT devices create blind spots in your security monitoring. Many devices lack the capability to run security agents.
- **Limited computational capacity**: Resource-constrained devices can't implement standard security measures like encryption or endpoint protection agents.
- **Proprietary protocols**: Industrial devices use specialized protocols that traditional security tools don't understand.
- **Long operational lifecycles**: IoT devices often remain deployed for years without updates, creating permanent vulnerabilities.
- **Physical exposure**: Devices deployed in accessible locations are vulnerable to tampering and credential extraction.

## Specify device authentication requirements

Device authentication is the foundation of IoT security. Your security requirements should specify how devices prove their identity when connecting to cloud services.

### Certificate-based authentication

Require X.509 certificate-based authentication for production IoT deployments. X.509 certificates provide stronger security than symmetric keys because:

- Certificates can be stored in hardware security modules (HSMs) or Trusted Platform Modules (TPMs), protecting against extraction
- Certificate chains enable hierarchical trust models aligned with manufacturing supply chains
- Certificates can be revoked individually without affecting other devices
- Private keys never leave the device, eliminating key transmission risks

Configure Azure IoT Hub to enforce X.509 authentication by disabling SAS token authentication for devices. Use Azure IoT Hub Device Provisioning Service (DPS) for secure, zero-touch provisioning at scale.

### Credential management

Specify requirements for managing device credentials throughout their lifecycle:

- **Unique credentials per device**: Never share symmetric keys or certificates across multiple devices. Compromise of one device should not enable access to others.
- **Credential rotation**: Implement processes for rolling certificates before expiration. Devices must support remote certificate updates.
- **Hardware-based storage**: Require TPMs or HSMs to protect cryptographic keys from extraction.
- **Revocation procedures**: Define processes to immediately revoke access for compromised devices through DPS or IoT Hub.

## Specify network security requirements

Network security for IoT requires balancing connectivity needs with exposure reduction.

### IoT Hub network controls

Specify these network security requirements for Azure IoT Hub:

- **Private endpoints**: Deploy Azure Private Link endpoints to eliminate public internet exposure. Devices connect through your virtual network rather than public endpoints.
- **Disable public network access**: When private endpoints are configured, disable the public endpoint to prevent any internet-based connections.
- **IP filtering**: If public access is required, restrict connections to specific IP address ranges using IoT Hub's built-in IP filter.
- **TLS 1.2 enforcement**: Require TLS 1.2 with strong cipher suites for all device connections. Disable TLS 1.0 and 1.1.

### OT network segmentation

For operational technology environments, specify network segmentation requirements:

- Separate OT networks from IT networks with firewalls and access controls
- Implement zones based on functional areas (production lines, facilities)
- Monitor traffic between zones for unauthorized communication patterns
- Use jump servers or privileged access workstations for administrative access to OT systems

## Specify threat detection requirements

IoT environments require specialized threat detection capabilities. Traditional security tools miss many IoT-specific attacks.

### Microsoft Defender for IoT

Specify deployment of [Microsoft Defender for IoT](/azure/defender-for-iot/organizations/overview) to provide:

- **Device discovery**: Automatic identification of IoT and OT devices across your network without requiring agents
- **Vulnerability assessment**: Identification of unpatched devices, open ports, unauthorized applications, and insecure configurations
- **Behavioral analytics**: Detection of anomalous device behavior including unauthorized communication patterns and protocol violations
- **Threat intelligence**: Detection of known industrial malware like Stuxnet, Triton, and NotPetya

### Sensor deployment

Defender for IoT uses network sensors to monitor traffic. Specify requirements for sensor placement:

- Deploy OT network sensors connected to SPAN ports or network TAPs for passive traffic monitoring
- Configure sensors as cloud-connected for automatic threat intelligence updates and centralized management
- Use locally managed sensors in air-gapped environments where cloud connectivity isn't permitted
- Organize sensors into sites and zones that map to your physical and logical network architecture

### Integration requirements

Specify how IoT security data integrates with your broader security operations:

- Forward Defender for IoT alerts to Microsoft Sentinel for correlation with other security events
- Integrate with your SIEM and SOAR platforms through supported connectors
- Enable alerts to trigger automated response workflows for containment

## Specify device lifecycle security requirements

Security requirements must address devices throughout their operational lifecycle.

### Secure provisioning

Require secure provisioning processes that:

- Use Device Provisioning Service for automated, secure enrollment
- Validate device identity before granting IoT Hub access
- Assign devices to appropriate IoT hubs based on geography or function
- Configure initial device twin properties securely

### Firmware and software updates

Specify requirements for keeping devices secure over time:

- Deploy [Device Update for IoT Hub](/azure/iot-hub-device-update/understand-device-update) agents on devices
- Require devices to support over-the-air updates for security patches
- Test updates in staging environments before production deployment
- Maintain rollback capabilities for failed updates

### Decommissioning

Define secure decommissioning procedures:

- Revoke device credentials in IoT Hub and DPS before physical removal
- Wipe sensitive data and credentials from device storage
- Document device removal for compliance and audit purposes

## Specify monitoring and compliance requirements

### Logging requirements

Specify logging requirements for security investigation:

- Enable IoT Hub resource logs for connections, device telemetry, and operations
- Send logs to Azure Monitor for centralized analysis
- Define retention periods aligned with compliance requirements
- Create alerts for authentication failures and unusual connection patterns

### Compliance controls

Use Azure Policy to enforce security configurations:

- Audit IoT hubs for proper network security settings
- Require diagnostic settings to be enabled
- Enforce encryption and authentication requirements
- Monitor compliance using Microsoft Defender for Cloud's regulatory compliance dashboard

Apply the [Azure security baseline for IoT Hub](/security/benchmark/azure/baselines/iot-hub-security-baseline) to ensure your deployment meets Microsoft cloud security benchmark controls across all security domains.
