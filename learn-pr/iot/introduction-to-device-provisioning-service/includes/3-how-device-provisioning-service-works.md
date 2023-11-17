The Device Provisioning Service (DPS) automates many of the manual steps that are traditionally involved in provisioning devices. This reduces the time to deploy IoT devices and lowers the risk of manual error.

The following information describes what goes on behind the scenes to get a device provisioned. The first step is manual, all of the other steps are automated.

:::image type="content" source="../media/m03-l01-device-provisioning-service-provisioning-flow-a8e493e4.png" alt-text="Diagram that shows what goes on behind the scenes to get a device provisioned.":::

1.  Device manufacturer adds the device registration information to the enrollment list in the Azure portal.
2.  Device contacts the provisioning service endpoint set at the factory. The device passes the identifying information to the provisioning service to prove its identity.
3.  The provisioning service validates the identity of the device by validating the registration ID and key against the enrollment list entry using either a nonce challenge (Trusted Platform Module) or standard X.509 verification (X.509).
4.  The provisioning service registers the device with an IoT hub and populates the device's desired twin state.
5.  The IoT hub returns device ID information to the provisioning service.
6.  The provisioning service returns the IoT hub connection information to the device. The device can now start sending data directly to the IoT hub.
7.  The device connects to IoT hub.
8.  The device gets the desired state from its device twin in IoT hub.






The Device Provisioning Service enables just-in-time provisioning of devices to an IoT hub, without requiring human intervention. After successful provisioning, devices connect directly with their designated IoT Hub. This process is referred to as autoprovisioning, and provides an out-of-the-box registration and initial configuration experience for devices.

## Three phases of autoprovisioning

Azure IoT autoprovisioning can be broken into three phases:

1. Service configuration - a one-time configuration of the Azure IoT Hub and IoT Hub Device Provisioning Service instances, establishing them and creating linkage between them.
2. Device enrollment - the process of making the Device Provisioning Service instance aware of the devices that will attempt to register in the future. Enrollment is accomplished by configuring device identity information in the provisioning service, as either an "individual enrollment" for a single device, or a "group enrollment" for multiple devices. Identity is based on the attestation mechanism the device is designed to use, which allows the provisioning service to attest to the device's authenticity during registration:
   - Trusted Platform Module (TPM): configured as an "individual enrollment", the device identity is based on the TPM registration ID and the public endorsement key. Given that TPM is a specification, the service only expects to attest per the specification, regardless of TPM implementation (hardware or software). TPM is a type of hardware security module (HSM).
   - X509: configured as either an "individual enrollment" or "group enrollment", the device identity is based on an X.509 digital certificate, which is uploaded to the enrollment as a .pem or .cer file.

   > [!NOTE]
   > Although not a prerequisite for using Device Provisioning Services, Microsoft strongly recommends that your device use a Hardware Security Module (HSM) to store sensitive device identity information, such as keys and X.509 certificates.

3. Device registration and configuration - initiated upon boot up by registration software, which is built using a Device Provisioning Service client SDK appropriate for the device and attestation mechanism. The software establishes a connection to the provisioning service for authentication of the device, and subsequent registration in the IoT Hub. Upon successful registration, the device is provided with its IoT Hub unique device ID and connection information, allowing it to pull its initial configuration and begin the telemetry process. In production environments, this phase can occur weeks or months after the previous two phases.

## Autoprovisioning operation

The following diagram summarizes the sequencing of operations during device autoprovisioning:

:::image type="content" source="../media/m03-l01-auto-provisioning-diagram-aac3c12a.png" alt-text="Diagram that shows the sequencing of operations during device autoprovisioning."  lightbox="../media/m03-l01-auto-provisioning-diagram-aac3c12a.png":::

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








## Service operations endpoint

The service operations endpoint is the endpoint for managing the service settings and maintaining the enrollment list. This endpoint is only used by the service administrator; it is not used by devices.

## Device provisioning endpoint

The device provisioning endpoint is the single endpoint all devices use for autoprovisioning. The URL is the same for all provisioning service instances, to eliminate the need to reflash devices with new connection information in supply chain scenarios. The ID scope ensures tenant isolation.

## Linked IoT hubs

The Device Provisioning Service can only provision devices to IoT hubs that have been linked to it. Linking an IoT hub to an instance of the Device Provisioning Service gives the service read/write permissions to the IoT hub's device registry; with the link, a Device Provisioning Service can register a device ID and set the initial configuration in the device twin. Linked IoT hubs may be in any Azure region. You may link hubs in other subscriptions to your provisioning service.

## Allocation policy

The service-level setting that determines how Device Provisioning Service assigns devices to an IoT hub. There are three supported allocation policies:

* Evenly weighted distribution: linked IoT hubs are equally likely to have devices provisioned to them. The default setting. If you are provisioning devices to only one IoT hub, you can keep this setting.
* Lowest latency: devices are provisioned to an IoT hub with the lowest latency to the device. If multiple linked IoT hubs would provide the same lowest latency, the provisioning service hashes devices across those hubs.
* Static configuration via the enrollment list: specification of the desired IoT hub in the enrollment list takes priority over the service-level allocation policy.
* Custom (Use Azure Function): A custom allocation policy gives you more control over how devices are assigned to an IoT hub. This is accomplished by using custom code in an Azure Function to assign devices to an IoT hub. The device provisioning service calls your Azure Function code providing all relevant information about the device and the enrollment to your code. Your function code is executed and returns the IoT hub information used to provisioning the device.

## Enrollment

An enrollment is the record of devices that may register through autoprovisioning. The two types of enrollments supported by Device Provisioning Service are *group enrollment* and *individual enrollment*.

* Group enrollment: An enrollment group is recommended for a large number of devices that share a desired initial configuration, or for devices all going to the same tenant.
* Individual enrollment: Individual enrollments are recommended for devices that require unique initial configurations, or for devices that can only authenticate using SAS tokens via TPM attestation.

The enrollment record contains information about the device or group of devices, including:

* The attestation mechanism used by the device
* The optional initial desired configuration
* Desired IoT hub
* The desired device ID

## Registration

A registration is the record of a device successfully registering/provisioning to an IoT Hub via the Device Provisioning Service. Registration records are created automatically; they can be deleted, but they cannot be updated.

## Operations

Operations are the billing unit of the Device Provisioning Service. One operation is the successful completion of one instruction to the service. Operations include device registrations and re-registrations; operations also include service-side changes such as adding enrollment list entries, and updating enrollment list entries.
