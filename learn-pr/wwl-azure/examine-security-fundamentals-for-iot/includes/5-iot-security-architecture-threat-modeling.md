Azure IoT Developers are not responsible for the architectural design of an IoT solution, but having an understanding of the threats to a solution is important.

## Solution architecture and security

When designing a system, it is important to understand the potential threats to that system, and add appropriate defenses accordingly, as the system is designed and architected. It is important to design the product from the start with security in mind because understanding how an attacker might be able to compromise a system helps make sure appropriate mitigations are in place from the beginning.

Design teams use threat modeling techniques to consider mitigations as the system is designed rather than after a system is deployed. This fact is critically important, because retrofitting security defenses to a myriad of devices in the field is infeasible, error prone and leaves customers at risk.

### Threat modeling

The objective of threat modeling is to understand how an attacker might be able to compromise a system and then make sure appropriate mitigations are in place.

#### What to consider for threat modeling

You should look at the solution as a whole and also focus on the following areas:

 -  The security and privacy features.
 -  The features whose failures are security relevant.
 -  The features that touch a trust boundary.

#### Who performs threat modeling

Threat modeling is a process like any other. It is a good idea to treat the threat model document like any other component of the solution and validate it as a team. Many development teams do an excellent job capturing the functional requirements for the system that benefit customers. However, identifying non-obvious ways that someone might misuse the system is more challenging. Threat modeling can help development teams understand what an attacker might do and why.

#### How to perform threat modeling

The threat modeling process is composed of four steps; the steps are:

 -  Model the application.
 -  Enumerate Threats.
 -  Mitigate threats.
 -  Validate the mitigations.

### Security in IoT

Connected special-purpose devices have a significant number of potential interaction surface areas and interaction patterns, all of which must be considered to provide a framework for securing digital access to those devices. The term “digital access” is used here to distinguish from any operations that are carried out through direct device interaction where access security is provided through physical access control. For example, putting the device into a room with a lock on the door. While physical access cannot be denied using software and hardware, measures can be taken to prevent physical access from leading to system interference.

In order to optimize security best practices, it is recommended that a typical IoT architecture is divided into several component/zones as part of the threat modeling exercise. These zones are:

 -  Device
 -  IoT Edge Gateway (an IoT Edge device used as a Field Gateway)
 -  Cloud gateways (IoT Hub)
 -  Services

Each zone is separated by a Trust Boundary that represents a transition of data/information from one source to another. During this transition, the data/information could be subject to Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service and Elevation of Privilege (STRIDE).

We can use the Azure IoT Reference Architecture to demonstrate how to think about threat modeling for IoT and how to address the threats identified. This approach identifies four main areas of focus:

 -  Devices and Data Sources.
 -  Data Transport.
 -  Device and Event Processing.
 -  Presentation.

## Common security threats and mitigations

For an Azure IoT solution, threats most commonly target the physical devices or one of the trust boundaries identified in the simplified threat model diagram above.

Consider the following STRIDE definitions:

 -  Spoofing (S): A spoofing attack occurs when an attacker pretends to be someone they're not. Spoofing attacks can happen locally. For example, an attacker may extract cryptographic key material from a device, either at the software or hardware level, and then access the system with a different physical using the identity of the device the key material was taken from.
 -  Tampering (T): Tampering attacks occur when the attacker modifies the data in transit (and for IoT may include compromising the physical device). For example, an attacker may compromise a physical device to obtain cryptographic key materials, then intercept and suppress data from the device on the communication path, and finally use extracted key material to replace the data with false data that is authenticated with the stolen key material.
 -  Repudiation (R): Repudiation occurs when someone performs an action and then claims that they didn't actually do it. Repudiation is typically associated with the ability to properly track and log user actions and for Azure IoT, this threat is mitigated by the Azure IoT Hub service. Repudiation does not apply to attacks against physical devices.
 -  Information Disclosure (I): Information Disclosure threats are straightforward - can the attacker view data that they're not supposed to view? For example, if you're transferring data from one computer to another and the attacker can sniff the data on the wire, then your component is subject to an information disclosure threat.
 -  Denial of Service (D): A denial of service threat occurs when an attacker can degrade or deny service to users. For IoT, this degradation includes rendering a device incapable of functioning or communicating. For example, a surveillance camera that had its power or network connection intentionally knocked out cannot report data.
 -  Elevation of Privilege (E): An elevation of privilege threat occurs when an attacker has the ability to gain privileges that they'd not normally have. For IoT, this threat may be forcing a device to do something other than the intended function. For example, a valve that is programmed to open half way can be tricked to open all the way.

### Common threats against physical devices

:::row:::
  :::column:::
    **Component**
  :::column-end:::
  :::column:::
    **Threat**
  :::column-end:::
  :::column:::
    **Mitigation**
  :::column-end:::
  :::column:::
    **Risk**
  :::column-end:::
  :::column:::
    **Implementation**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device
  :::column-end:::
  :::column:::
    S
  :::column-end:::
  :::column:::
    Assigning identity to the device and authenticating the device.
  :::column-end:::
  :::column:::
    Replacing device or part of the device with some other device. How do you know you are talking to the right device?
  :::column-end:::
  :::column:::
    Authenticating the device, using Transport Layer Security (TLS) or IPSec. Infrastructure should support using pre-shared key (PSK) on those devices that cannot handle full asymmetric cryptography. Use Microsoft Entra ID or OAuth.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device
  :::column-end:::
  :::column:::
    TID
  :::column-end:::
  :::column:::
    Apply tamperproof mechanisms to the device, for example, by making it hard to impossible to extract keys and other cryptographic material from the device.
  :::column-end:::
  :::column:::
    The risk is if someone is tampering the device (physical interference). How are you sure, that device has not been tampered with.
  :::column-end:::
  :::column:::
    The most effective mitigation is a trusted platform module (TPM) capability that allows storing keys in special on-chip circuitry from which the keys cannot be read, but can only be used for cryptographic operations that use the key but never disclose the key. Memory encryption of the device. Key management for the device. Signing the code.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device
  :::column-end:::
  :::column:::
    E
  :::column-end:::
  :::column:::
    Having access control of the device. Authorization scheme.
  :::column-end:::
  :::column:::
    If the device allows for individual actions to be performed based on commands from an outside source, or even compromised sensors, it allows the attack to perform operations not otherwise accessible.
  :::column-end:::
  :::column:::
    Having authorization scheme for the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Edge Gateway
(Field Gateway)
  :::column-end:::
  :::column:::
    S
  :::column-end:::
  :::column:::
    Authenticating the Field gateway to Cloud Gateway (such as cert based, PSK, or Claim based).
  :::column-end:::
  :::column:::
    If someone can spoof Field Gateway, then it can present itself as any device.
  :::column-end:::
  :::column:::
    TLS RSA/PSK, IPSec, RFC 4279. All the same key storage and attestation concerns of devices in general – best case is use TPM. 6LowPAN extension for IPSec to support Wireless Sensor Networks (WSN).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Edge Gateway
(Field Gateway)
  :::column-end:::
  :::column:::
    TID
  :::column-end:::
  :::column:::
    Protect the Field Gateway against tampering (TPM?)
  :::column-end:::
  :::column:::
    Spoofing attacks that trick the cloud gateway thinking it is talking to field gateway could result in information disclosure and data tampering.
  :::column-end:::
  :::column:::
    Memory encryption, TPM’s, authentication.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Edge Gateway
(Field Gateway)
  :::column-end:::
  :::column:::
    E
  :::column-end:::
  :::column:::
    Access control mechanism for Field Gateway.
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::


Here are some examples of threats to physical devices:

 -  Spoofing: An attacker may extract cryptographic key material from a device, either at the software or hardware level, and later access the system with a different physical or virtual device under the identity of the device the key material has been taken from.
 -  Denial of Service: A device can be rendered incapable of functioning or communicating by interfering with radio frequencies or cutting wires. For example, a surveillance camera that had its power or network connection intentionally knocked out cannot report data, at all.
 -  Tampering: An attacker may partially or wholly replace the software running on the device, potentially allowing the replaced software to use the genuine identity of the device if the key material or the cryptographic facilities holding key materials were available to the illicit program.
 -  Tampering: A surveillance camera that’s showing a visible-spectrum picture of an empty hallway could be aimed at a photograph of such a hallway. A smoke or fire sensor could be reporting someone holding a lighter under it. In either case, the device may be technically fully trustworthy towards the system, but it reports manipulated information.
 -  Tampering: An attacker may use extracted key material to intercept and suppress data from the device on the communication path and replace it with false data that is authenticated with the stolen key material.
 -  Tampering: An attacker may partially or completely replace the software running on the device, potentially allowing the replaced software to use the genuine identity of the device if the key material or the cryptographic facilities holding key materials were available to the illicit program.
 -  Information Disclosure: If the device is running manipulated software, such manipulated software could potentially leak data to unauthorized parties.
 -  Information Disclosure: An attacker may use extracted key material to inject itself into the communication path between the device and a controller or field gateway or cloud gateway to siphon off information.
 -  Denial of Service: The device can be turned off or turned into a mode where communication is not possible (which is intentional in many industrial machines).
 -  Tampering: The device can be reconfigured to operate in a state unknown to the control system (outside of known calibration parameters) and thus provide data that can be misinterpreted.
 -  Elevation of Privilege: A device that does specific function can be forced to do something else. For example, a valve that is programmed to open half way can be tricked to open all the way.

### Common threats against communication

:::row:::
  :::column:::
    **Component**
  :::column-end:::
  :::column:::
    **Threat**
  :::column-end:::
  :::column:::
    **Mitigation**
  :::column-end:::
  :::column:::
    **Risk**
  :::column-end:::
  :::column:::
    **Implementation**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device to IoT Hub
  :::column-end:::
  :::column:::
    TID
  :::column-end:::
  :::column:::
    (D)TLS (PSK/RSA) to encrypt the traffic.
  :::column-end:::
  :::column:::
    Eavesdropping or interfering with the communication between the device and the gateway.
  :::column-end:::
  :::column:::
    Security on the protocol level. With custom protocols, you need to figure out how to protect them. In most cases, the communication takes place from the device to the IoT Hub (device initiates the connection).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device to Device
  :::column-end:::
  :::column:::
    TID
  :::column-end:::
  :::column:::
    (D)TLS (PSK/RSA) to encrypt the traffic.
  :::column-end:::
  :::column:::
    Reading data in transit between devices. Tampering with the data. Overloading the device with new connections.
  :::column-end:::
  :::column:::
    Security on the protocol level (MQTT/AMQP/HTTP/CoAP. With custom protocols, you need to figure out how to protect them. The mitigation for the DoS threat is to peer devices through a cloud or field gateway and have them only act as clients towards the network. The peering may result in a direct connection between the peers after having been brokered by the gateway.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    External Entity to Device
  :::column-end:::
  :::column:::
    TID
  :::column-end:::
  :::column:::
    Strong pairing of the external entity to the device
  :::column-end:::
  :::column:::
    Eavesdropping the connection to the device. Interfering the communication with the device.
  :::column-end:::
  :::column:::
    Securely pairing the external entity to the device NFC/Bluetooth LE. Controlling the operational panel of the device (Physical).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Edge Gateway to Cloud Gateway
  :::column-end:::
  :::column:::
    TID
  :::column-end:::
  :::column:::
    TLS (PSK/RSA) to encrypt the traffic.
  :::column-end:::
  :::column:::
    Eavesdropping or interfering the communication between the device and the gateway.
  :::column-end:::
  :::column:::
    Security on the protocol level (MQTT/AMQP/HTTP/CoAP). With custom protocols, you need to figure out how to protect them.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device to Cloud Gateway
  :::column-end:::
  :::column:::
    TID
  :::column-end:::
  :::column:::
    TLS (PSK/RSA) to encrypt the traffic.
  :::column-end:::
  :::column:::
    Eavesdropping or interfering the communication between the device and the gateway.
  :::column-end:::
  :::column:::
    Security on the protocol level (MQTT/AMQP/HTTP/CoAP). With custom protocols, you need to figure out how to protect them.
  :::column-end:::
:::row-end:::


Here are some examples of threats to communication:

 -  Denial of Service: Constrained devices are generally under DoS threat when they actively listen for inbound connections or unsolicited datagrams on a network, because an attacker can open many connections in parallel and not service them or service them slowly, or the device can be flooded with unsolicited traffic. In both cases, the device can effectively be rendered inoperable on the network.
 -  Spoofing, Information Disclosure: Constrained devices and special-purpose devices often have one-for-all security facilities like password or PIN protection, or they wholly rely on trusting the network, meaning they grant access to information when a device is on the same network, and that network is often only protected by a shared key. That means that when the shared secret to device or network is disclosed, it is possible to control the device or observe data emitted from the device.
 -  Spoofing: an attacker may intercept or partially override the broadcast and spoof the originator.
 -  Tampering: an attacker may intercept or partially override the broadcast and send false information.
 -  Information Disclosure: an attacker may eavesdrop on a broadcast and obtain information without authorization.
 -  Denial of Service: an attacker may jam the broadcast signal and deny information distribution.
