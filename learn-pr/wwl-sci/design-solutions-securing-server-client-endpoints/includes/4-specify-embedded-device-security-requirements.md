IoT solutions have the challenge of securing diverse and heterogeneous device-based workloads with little or no direct interaction. IoT device builders, IoT application developers, and IoT solution operators share responsibility for security during the full IoT solution lifecycle. It's important to design the solution from the start with security in mind. Understand the potential threats, and add [defense in depth](https://csrc.nist.gov/glossary/term/defense_in_depth) as you design and architect the solution.

Security planning starts with a [threat model](/azure/iot-fundamentals/iot-security-architecture#security-starts-with-a-threat-model). Understanding how an attacker might be able to compromise a system helps you ensure appropriate mitigations from the start. Threat modeling offers the greatest value when you incorporate it into the design phase. As part of the threat modeling exercise, you can divide a typical IoT architecture into several components or zones: device, device gateway, cloud gateway, and services. Each zone can have its own authentication, authorization, and data requirements. You can use zones to isolate damage and restrict the impact of low-trust zones on higher-trust zones. For more information, see the [Internet of Things (IoT) security architecture](/azure/iot-fundamentals/iot-security-architecture#security-in-iot).

The following security guidance for IoT Workloads identifies key considerations and provides design and implementation recommendations.

## Assess security in your IoT workload

To assess your IoT workload through the lenses of the Well-Architected Framework Security pillar, complete the security questions for IoT workloads in the [Azure Well-Architected Review](/assessments/azure-architecture-review/). After the assessment identifies key security recommendations for your IoT solution, use the following content to help implement the recommendations.

## Design Principles

Five pillars of architectural excellence underpin the IoT workload design methodology. These pillars serve as a compass for subsequent design decisions across the key IoT design areas. The following design principles extend the quality pillar of the Azure Well-Architected Framework - Security.

|Design principle|Considerations|
|---|---|
|**Strong identity**|Use a strong identity to authenticate devices and users. Have a hardware root of trust for trusted identity, register devices, issue renewable credentials, and use passwordless or multi-factor authentication (MFA). Review general Azure identity and access management considerations.
|**Least privilege**|Automate and use **least-privileged access control** to limit impact from compromised devices or identities or unapproved workloads.
|**Device health**|Evaluate device health to gate device access or flag devices for remediation. Check security configuration, assess vulnerabilities and insecure passwords, monitor for threats and anomalies, and build ongoing risk profiles.
|**Device update**|Continuous updates to keep devices healthy. Use a centralized configuration and compliance management solution and a robust update mechanism to ensure devices are up-to-date and healthy.
|**Monitor system security, plan incident response**|Proactively monitor for unauthorized or compromised devices and respond to emerging threats.

## IoT architecture patterns

Most IoT systems use either a connected products or connected operations architecture pattern. There are key security differences between these patterns. Connected operations or *operational technology (OT)* solutions often have on-premises devices that monitor and control other physical devices. These OT devices add security challenges such as tampering, packet sniffing, and the need for out-of-band management and over-the-air (OTA) updates.

Factories and OT environments can be easy targets for malware and security breaches, because equipment can be old, physically vulnerable, and isolated from server-level security. For an end-to-end perspective, review the Azure Well-Architected Framework security pillar.

## IoT architecture layers

Security design principles help clarify considerations to ensure your IoT workload meets requirements across the foundational IoT architecture layers. 

All layers are subject to various threats that can be classified according to the [STRIDE categories](/azure/security/develop/threat-modeling-tool-threats#stride-model): *spoofing*, *tampering*, *repudiation*, *information disclosure*, *denial of service*, and *elevation of privilege*. Always follow [Microsoft Security Development Lifecycle (SDL)](https://www.microsoft.com/sdl) practices when you design and build IoT architectures.

:::image type="content" source="../media/architecture-layers.svg" alt-text="Diagram that shows the layers and cross-cutting activities in the IoT architecture." border="false":::

## Device and gateway layer

This architecture layer includes the immediate physical space around the device and gateway that allows physical access or peer-to-peer digital access. Many industrial companies use the [Purdue model](https://en.wikipedia.org/wiki/Purdue_Enterprise_Reference_Architecture) included in the ISA 95 standard to ensure their process control networks both protect their limited network bandwidth and provide real-time deterministic behavior. The Purdue model provides an extra layer of defense-in-depth methodology.

### Strong device identity

Tightly integrated capabilities of IoT devices and services provide strong device identity. These capabilities include:

- A hardware root of trust.
- Strong authentication using certificates, MFA, or passwordless authentication.
- Renewable credentials.
- Organizational IoT device registry.

A *hardware root of trust* has the following attributes:

- Secure credential storage that proves identity in dedicated, tamper-resistant hardware.
- Immutable onboarding identity tied to the physical device.
- Unique per-device renewable operational credentials for regular device access.

The *onboarding identity* represents and is inseparable from the physical device. This identity is typically created and installed during manufacturing, and can't be changed for the device's lifetime. Given its immutability and lifetime, you should use the device onboarding identity only to onboard the device into the IoT solution.

After onboarding, provision and use a renewable *operational identity* and *credentials* for authentication and authorization to the IoT application. Making this identity renewable lets you manage access and revocation of the device for operational access. You can apply policy-driven gates, such as attestation of device integrity and health, at renewal time.

The hardware root of trust also ensures that devices are built to security specifications and conform to required compliance regimes. Protect the supply chain of the hardware root of trust, or any other hardware components of an IoT device, to ensure that supply chain attacks don't compromise device integrity.

*Passwordless authentication*, usually using standard x509 certificates to prove a device's identity, offers greater protection than secrets such as passwords and symmetric tokens shared between both parties. *Certificates* are a strong, standardized mechanism that provides renewable passwordless authentication. To manage certificates:

- Provision operational certificates from a trusted public key infrastructure (PKI).
- Use a renewal lifetime appropriate for the business use, management overhead, and cost.
- Make renewal automatic, to minimize any potential access disruption due to manual rotation.
- Use standard, up-to-date cryptography techniques. For example, renew through certificate signing requests (CSR) instead of transmitting a private key.
- Grant access to devices based on their operational identity.
- Support credential revocation, such as a certificate revocation list (CRL) when using x509 certificates, to immediately remove device access, for example in response to compromise or theft.

Some legacy or resource-constrained IoT devices can't use a strong identity, passwordless authentication, or renewable credentials. Use IoT gateways as guardians to locally interface with these less-capable devices, bridging them to access IoT services with strong identity patterns. This practice lets you adopt zero trust today, while transitioning to use more capable devices over time.

Virtual machines (VMs), containers, or any service that embeds an IoT client can't use a hardware root of trust. Use available capabilities with these components. VMs and containers, which don't have hardware root of trust support, can use passwordless authentication and renewable credentials. A defense-in-depth solution provides redundancies where possible, and fills in gaps where necessary. For example, you could locate VMs and containers in an area with more physical security, such as a data center, compared to an IoT device in the field.

Use a centralized *organizational IoT device registry* to manage your organization's IoT device lifecycle and audit device access. This approach is similar to the way you secure the user identities of an organization's workforce to achieve zero-trust security. A cloud-based identity registry can handle the scale, management, and security of an IoT solution.

IoT device registry information onboards devices into an IoT solution by verifying that the device identity and credentials are known and authorized. After a device is onboarded, the device registry contains the core properties of the device, including its operational identity and the renewable credentials used to authenticate for everyday use.

You can use IoT device registry data to:

- View the inventory of an organization's IoT devices, including health, patch, and security state.
- Query and group devices for scaled operation, management, workload deployment, and access control.

Use network sensors to detect and inventory unmanaged IoT devices that don't connect to Azure IoT services, for awareness and monitoring.

### Least-privileged access 

Least-privileged access control helps limit impact from authenticated identities that might be compromised or running unapproved workloads. For IoT scenarios, grant operator, device, and workload access by using:

- Device and workload access control, for access only to scoped workloads on the device.
- Just-in-time access.
- Strong authentication mechanisms such as MFA and passwordless authentication.
- Conditional access based on a device's context, such as IP address or GPS location, system configuration, uniqueness, time of day, or network traffic patterns. Services can also use device context to conditionally deploy workloads.

To implement effective least-privileged access:

- Configure IoT cloud gateway access management to only grant appropriate access permissions for the functionality the backend requires.
- Limit access points to IoT devices and cloud applications by ensuring ports have minimum access.
- Build mechanisms to prevent and detect physical device tampering.
- Manage user access through an appropriate access control model, such as role-based or attribute-based access control.
- Layer least-privileged access for IoT devices by using network segmentation.

### Network micro-segmentation 

Network design and configuration provide opportunities to build defense in depth by segmenting IoT devices based on their traffic patterns and risk exposure. This segmentation minimizes the potential impact of compromised devices and adversaries pivoting to higher-value assets. Network segmentation typically uses next-generation firewalls.

Network micro-segmentation enables isolation of less-capable devices at the network layer, either behind a gateway or on a discrete network segment. Use network segmentation to group IoT devices, and use endpoint protection to mitigate the impact of potential compromise.

Implement a holistic firewall rule strategy that allows devices to access the network when required, and blocks access when not allowed. To support defense in depth, mature organizations can implement micro-segmentation policies at multiple layers of the Purdue model. If necessary, use firewalls on devices to restrict network access.

### Device health

Under the zero-trust principle, device health is a key factor to determine the risk profile, including trust level, of a device. Use the risk profile as an access gate to ensure only healthy devices can access IoT applications and services, or to identify devices in questionable health for remediation.

According to industry standards, device health evaluation should include:

- Security configuration assessment and attestation that the device is configured securely.
- Vulnerability assessment to determine whether device software is out of date or has known vulnerabilities.
- Insecure credential assessment to check device credentials, such as certificates, and protocols, such as Transport Layer Security (TLS) 1.2+.
- Active threats and threat alerts.
- Anomalous behavioral alerts, such as network pattern and usage deviation.

### Zero-trust criteria for devices

To support zero trust, IoT devices should:

- Contain a hardware root of trust to provide a strong device identity.
- Use renewable credentials for regular operation and access.
- Enforce least-privileged access control to local device resources such as cameras, storage, and sensors.
- Emit proper device health signals to enable enforcement of conditional access.
- Provide update agents and corresponding software updates for the usable lifetime of the device to ensure security updates can be applied.
- Include device management capabilities to enable cloud-driven device configuration and automated security response.
- Run security agents that integrate with security monitoring, detection, and response systems.
- Minimize physical attack footprint, for example by turning off or disabling any device features that aren't needed, such as physical USB or UART ports, or WiFi or Bluetooth connectivity. Use physical removal, covering, or blocking when necessary.
- Protect data on devices. If data at rest is stored on devices, use standard encryption algorithms to encrypt the data.

## Ingestion and communication layer 

Data that's ingested into the IoT solution should be protected with the guidance in the Azure Well-Architected Framework security pillar. Additionally, for IoT solutions it's critical to ensure that communication from the device to the cloud is secure and encrypted using the latest TLS standards.

## Device management and modeling layer

This architecture layer includes software components or modules running in the cloud that interface with devices and gateways for data collection and analysis, as well as for command and control.

### Zero-trust criteria for IoT services

Use IoT services that offer the following key zero-trust capabilities:

- Full support for zero-trust user access control, for example strong user identities, MFA, and conditional user access.
- Integration with user access control systems for least-privileged access and conditional controls.
- A central device registry for full device inventory and device management.
- Mutual authentication, offering renewable device credentials with strong identity verification.
- Least-privileged device access control with conditional access so only devices fulfilling criteria, such as health or known location, can connect.
- OTA updates to keep devices healthy.
- Security monitoring of both IoT services and connected IoT devices.
- Monitoring and access control for all public endpoints, and authentication and authorization for any calls to these endpoints.

## DevOps layer

An enterprise IoT solution should provide a strategy for operators to manage the system. DevOps methodologies that proactively focus on security include:

- Centralized configuration and compliance management, to securely apply policies and distribute and update certificates.
- Deployable updates, to update the full set of software on devices, firmware, drivers, base OS and host applications, and cloud-deployed workloads.

For more information, see [Enable DevSecOps with Azure and GitHub](/devops/devsecops/enable-devsecops-azure-github).

### Continuous updates

To control device access based on health, you must proactively maintain production devices in a working, healthy target state. Update mechanisms should:

- Have remote deployment capabilities.
- Be resilient to changes in environment, operating conditions, and authentication mechanism, such as certificate changes because of expiry or revocation.
- Support update rollout verification.
- Integrate with pervasive security monitoring to enable scheduled updates for security.

You should be able to defer updates that interfere with business continuity, but eventually complete them within a well-defined time interval after you detect a vulnerability. Devices that haven't been updated should be flagged as unhealthy.

### Security monitoring and response

An IoT solution needs to be able to perform monitoring and remediation at scale for all its connected devices. As a defense-in-depth strategy, monitoring adds an extra layer of protection for managed greenfield devices, and provides a compensating control for legacy, unmanaged brownfield devices that don't support agents and can't be patched or configured remotely.

You need to decide on logging levels, types of activities to monitor, and responses required for alerts. Logs should be stored securely and not contain any security details.

According to the [Cybersecurity and Infrastructure Security Agency (CISA)](https://us-cert.cisa.gov/ncas/alerts/aa20-205a), a security monitoring program should monitor and audit unauthorized changes to controllers, unusual behavior from devices, and access and authorization attempts. Security monitoring should include:

- Generating an as-is asset inventory and network map of all IoT and OT devices.
- Identifying all communication protocols used across IoT and OT networks.
- Cataloging all external connections to and from networks.
- Identifying vulnerabilities in IoT and OT devices and using a risk-based approach to mitigate them.
- Implementing a vigilant monitoring program with anomaly detection to detect malicious cyber tactics such as *living off the land* within IoT systems.

## Supporting Services

Several Azure products and services support IoT device security:

- [Azure Sphere guardian modules](/azure-sphere/hardware/guardian-modules) connect critical legacy devices to IoT services with zero-trust capabilities, including strong identity, end-to-end encryption, and regular security updates.

- [Azure IoT Edge](/azure/iot-edge) provides an edge runtime connection to IoT Hub and other Azure services, and supports certificates as strong device identities. IoT Edge supports the PKCS\#11 standard for device manufacturing identities and other secrets stored on a Trusted Platform Module (TPM) or Hardware Security Module (HSM).

- The [Edge Secured-core program (preview)](/azure/certification/program-requirements-edge-secured-core) validates whether devices meet security requirements for device identity, secure boot, operating system hardening, device updates, data protection, and vulnerability disclosures. The Edge Secured-core program requirements are distilled from various industry requirements and security engineering points of view.

- [Windows for IoT](https://developer.microsoft.com/windows/iot) helps ensure security across key pillars of the IoT security spectrum.

- [Microsoft Defender for IoT](/azure/defender-for-iot) is an agentless, network layer security platform that delivers continuous asset discovery, vulnerability management, and threat detection for IoT and OT devices. Defender for IoT continuously monitors network traffic using IoT-aware behavioral analytics to identify unauthorized or compromised components.

  Defender for IoT supports proprietary embedded OT devices and legacy Windows systems commonly found in OT environments. Defender for IoT can inventory all IoT devices, assess for vulnerabilities, provide risk-based mitigation recommendations, and continuously monitor devices for anomalous or unauthorized behavior.

- [Azure IoT Hub](https://azure.microsoft.com/services/iot-hub) provides an operational registry for IoT devices. IoT Hub accepts device operational certificates to enable strong identity, and can disable devices centrally to prevent unauthorized connections. IoT Hub supports provisioning of module identities that support IoT Edge workloads.