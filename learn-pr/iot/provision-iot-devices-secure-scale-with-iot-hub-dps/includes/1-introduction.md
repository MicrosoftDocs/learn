Experience implementing group enrollments using X.509 certificates, using code that accesses device twin properties to initialize a device, and deprovisioning enrollments groups or individual devices from an enrollment group.

## Example scenario

Suppose you are working on an update for your company's cheese shipping container monitoring and tracking solution. The proposed system update uses IoT devices to reduce manual data entry and provide more advanced monitoring during the container shipping process. The IoT devices connect to an Azure IoT hub using vehicle-installed Wi-Fi. The proposed system provides continuous monitoring of the product environment and enables various notification scenarios when issues are detected. The IoT devices are equipped with integrated sensors to track the location, temperature, and pressure of shipping containers during transit.

You are tasked with validating the container IoT tracking device provisioning and deprovisioning process using Azure IoT Hub Device Provisioning Service (DPS) and X.509 certificate authentication. You need to demonstrate that DPS can be used to auto provision large numbers of IoT tracking devices securely using this configuration. Container IoT tracking devices are auto provisioned using DPS and X.509 certificate authentication when containers are loaded, and deprovisioned after each container is delivered for later reuse and reprovisioning.

> [!NOTE]
> This is a **_guided project_** module where you'll complete an end-to-end project by following step-by-step instructions.

## Learning objectives

In this module, you practice how to:

* Generate an X.509 root CA certificate using OpenSSL.
* Configure a group enrollment that uses X.509 certificate authentication within Device Provisioning Service (DPS).
* Generate device certificates signed by your root CA certificate.
* Run C# device telemetry generation samples that are provisioned via a DPS enrollment group and connect to IoT Hub.
* Disenroll an individual device from the DPS enrollment group, and then deprovision the entire group.
