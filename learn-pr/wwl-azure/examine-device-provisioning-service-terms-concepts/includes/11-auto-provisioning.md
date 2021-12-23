The Device Provisioning Service enables just-in-time provisioning of devices to an IoT hub, without requiring human intervention. After successful provisioning, devices connect directly with their designated IoT Hub. This process is referred to as autoprovisioning, and provides an out-of-the-box registration and initial configuration experience for devices.

## Three phases of autoprovisioning

Azure IoT autoprovisioning can be broken into three phases:

1.  Service configuration - a one-time configuration of the Azure IoT Hub and IoT Hub Device Provisioning Service instances, establishing them and creating linkage between them.
2.  Device enrollment - the process of making the Device Provisioning Service instance aware of the devices that will attempt to register in the future. Enrollment is accomplished by configuring device identity information in the provisioning service, as either an "individual enrollment" for a single device, or a "group enrollment" for multiple devices. Identity is based on the attestation mechanism the device is designed to use, which allows the provisioning service to attest to the device's authenticity during registration:
    
     -  Trusted Platform Module (TPM): configured as an "individual enrollment", the device identity is based on the TPM registration ID and the public endorsement key. Given that TPM is a specification, the service only expects to attest per the specification, regardless of TPM implementation (hardware or software). TPM is a type of hardware security module (HSM).
     -  X509: configured as either an "individual enrollment" or "group enrollment", the device identity is based on an X.509 digital certificate, which is uploaded to the enrollment as a .pem or .cer file.
    
    > [!NOTE]
    > Although not a prerequisite for using Device Provisioning Services, Microsoft strongly recommends that your device use a Hardware Security Module (HSM) to store sensitive device identity information, such as keys and X.509 certificates.
3.  Device registration and configuration - initiated upon boot up by registration software, which is built using a Device Provisioning Service client SDK appropriate for the device and attestation mechanism. The software establishes a connection to the provisioning service for authentication of the device, and subsequent registration in the IoT Hub. Upon successful registration, the device is provided with its IoT Hub unique device ID and connection information, allowing it to pull its initial configuration and begin the telemetry process. In production environments, this phase can occur weeks or months after the previous two phases.

## Autoprovisioning operation

The following diagram summarizes the sequencing of operations during device autoprovisioning:

:::image type="content" source="../media/m03-l01-auto-provisioning-diagram-aac3c12a.png" alt-text="Diagram that shows the sequencing of operations during device autoprovisioning." lightbox="../media/m03-l01-auto-provisioning-diagram-aac3c12a.png":::


:::row:::
  :::column:::
    **Operation**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encode identity and registration URL.
  :::column-end:::
  :::column:::
    Based on the attestation mechanism used, the manufacturer is responsible for encoding the device identity info, and the Device Provisioning Service registration URL.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Provide device identity.
  :::column-end:::
  :::column:::
    As the originator of the device identity info, the manufacturer is responsible for communicating it to the operator (or a designated agent), or directly enrolling it to the Device Provisioning Service via APIs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configure autoprovisioning.
  :::column-end:::
  :::column:::
    This operation corresponds with the first phase of autoprovisioning.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Enroll device identity.
  :::column-end:::
  :::column:::
    This operation corresponds with the second phase of autoprovisioning.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Build/Deploy registration software.
  :::column-end:::
  :::column:::
    This operation corresponds with the third phase of autoprovisioning. The Developer is responsible for building and deploying the registration software to the device, using the appropriate SDK.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bootup and register.
  :::column-end:::
  :::column:::
    This operation corresponds with the third phase of autoprovisioning, fulfilled by the device registration software built by the Developer.
  :::column-end:::
:::row-end:::
