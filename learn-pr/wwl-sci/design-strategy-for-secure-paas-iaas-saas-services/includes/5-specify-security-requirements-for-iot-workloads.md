
The Internet of Things (IoT) supports billions of connected devices that
use operational technology (OT) networks. IoT/OT devices and networks
are often designed without security in priority, and therefore can't be
protected by traditional systems. With each new wave of innovation, the
risk to IoT devices and OT networks increases the possible attack
surfaces.

Securing an Internet of Things (IoT) infrastructure requires a rigorous
security-in-depth strategy. This strategy requires you to secure data in
the cloud, protect data integrity while in transit over the public
internet, and securely provision devices. Each layer builds greater
security assurance in the overall infrastructure.

This security-in-depth strategy can be developed and executed with
active participation of various players involved with the manufacturing,
development, and deployment of IoT devices and infrastructure. Here is a
high-level description of these roles and security requirements:

| Role                                 | Role Description                                                                                                                                                                                                                                                                                                                              | Security Requirements                          |
|--------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------|
| IoT hardware manufacturer/integrator | Typically, these players are the manufacturers of IoT hardware being deployed, integrators assembling hardware from various manufacturers, or suppliers providing hardware for an IoT deployment manufactured or integrated by other suppliers.                                                                                               | Scope hardware to minimum requirements:        |
|                                      |                                                                                                                                                                                                                                                                                                                                               | Make hardware tamper proof                     |
|                                      |                                                                       | Make upgrades secure                           |
| IoT solution developer               | The development of an IoT solution is typically done by a solution developer. This developer may part of an in-house team or a system integrator (SI) specializing in this activity. The IoT solution developer can develop various components of the IoT solution from scratch or integrate various off-the-shelf or open-source components. | Follow secure software development methodology |
|                                      |                                                                                                                                                                                                                                                                                                                                               | Choose open-source software with care          |
|                                      |                                                                                                                                                                                                                                                                                                                                               | Integrate to avoid security flows              |
| IoT solution deployer                | After an IoT solution is developed, it needs to be deployed in the field. This process involves deployment of hardware, interconnection of devices, and deployment of solutions in hardware devices or the cloud.                                                                                                                             | Deploy hardware securely                       |
|                                      |                                                                                                                                                                                                                                                                                                                                               | Keep authentication keys safe                  |
| IoT solution operator                | After the IoT solution is deployed, it requires long-term operations, monitoring, upgrades, and maintenance. These tasks can be done by an in-house team that comprises information technology specialists, hardware operations and maintenance teams, and domain specialists who monitor the correct behavior of overall IoT infrastructure. | Keep the system up-to-date                     |
|                                      |                                                                                                                                                                                                                                                                                                                                               | Protect against malicious activity             |
|                                      |                                                                                                                                                                                                                                                                                                                                               | Audit frequently                               |
|                                      |                                                                                                                                                                                                                                                                                                                                               | Audit frequently                               |
|                                      |                                                                                                                                                                                                                                                                                                                                               | Protect cloud credentials                      |

Connected special-purpose devices have a significant number of potential
interaction surface areas and interaction patterns, all of which must be
considered to provide a framework for securing digital access to those
devices. The term "digital access" is used here to distinguish from any
operations that are carried out through direct device interaction where
access security is provided through physical access control. For
example, putting the device into a room with a lock on the door. While
physical access can't be denied using software and hardware, measures
can be taken to prevent physical access from leading to system
interference.

As you explore the interaction patterns, look at "device control" and
"device data" with the same level of attention. "Device control" can be
classified as any information that is provided to a device by any party
with the goal of changing or influencing its behavior towards its state
or the state of its environment. "Device data" can be classified as any
information that a device emits to any other party about its state and
the observed state of its environment.

In order to optimize security best practices, it's recommended that a
typical IoT architecture is divided into several component/zones as part
of the threat modeling exercise. These zones are:

-   Device

-   Field Gateway

-   Cloud gateways

-   Services

Zones are a broad way to segment a solution; each zone often has its own
data and authentication and authorization requirements. Zones can also
be used to isolation damage and restrict the impact of low trust zones
on higher trust zones. Each zone is separated by a Trust Boundary, and
it represents a transition of data/information from one source to
another. During this transition, the data/information could be subject
to Spoofing, Tampering, Repudiation, Information Disclosure, Denial of
Service and Elevation of Privilege (STRIDE).

#### Security posture management and threat detection

Just like any other cloud workload, IoT workloads need to have an
ongoing security assessment to improve the overall security posture. In
addition, you need threat detection in place to better understand
current attack vectors and how to respond. An important part of the
security requirements for IoT is to adopt a solution that can provide
both: security posture management and threat detection.

Microsoft Defender for IoT is a unified security solution for
identifying IoT devices, vulnerabilities, and threats and managing them
through a central interface.

:::image type="content" source="../media/security-posture-management.png" alt-text="Diagram that shows unified posture management in Defender for I o T." lightbox="../media/security-posture-management.png":::

Defender for IoT connects to both cloud and on-premises components and
is built for scalability in large and geographically distributed
environments. Defender for IoT systems includes the following components:

-   The Azure portal, for cloud management and integration to other
    Microsoft services, such as Microsoft Sentinel

-   Network sensors, deployed on either a virtual machine or a physical
    appliance. You can configure your OT sensors as cloud-connected
    sensors, or fully on-premises sensors.

-   An on-premises management console for cloud-connected or local,
    air-gapped site management.

-   An embedded security agent (optional).

Security recommendations triggered by Defender for IoT will be surfaced
in Defender for Cloud dashboard, as shown in the example below:

:::image type="content" source="../media/defender-iot.png" alt-text="Screenshot showing security recommendations in Microsoft Defender for Cloud dashboard." lightbox="../media/defender-iot.png":::

It's also important that you can integrate the threat detection
generated by your security IoT solution with your SIEM solution.
Microsoft Sentinel and Microsoft Defender for IoT help to bridge the gap
between IT and OT security challenges, and to empower SOC teams with
out-of-the-box capabilities to detect and respond to OT threats
efficiently and effectively. The integration between Microsoft Defender
for IoT and Microsoft Sentinel helps organizations to quickly detect
multistage attacks, which often cross IT and OT boundaries.

