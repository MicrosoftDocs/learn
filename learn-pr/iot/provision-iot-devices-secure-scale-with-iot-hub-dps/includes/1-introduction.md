This module will guide you through the steps required to generate an X.509 root certificate, run C# Azure IoT device SDK code samples that use the Azure IoT Hub Device Provisioning Service (DPS) to group enroll IoT devices securely using X.509 certificate authentication signed by the root certificate, and deprovision devices after use.

## Example scenario

Suppose you are working on an update to your company's cheese shipping container monitoring and tracking solution. The proposed system update will use IoT devices to reduce manual data entry and provide more advanced monitoring during the container shipping process. The IoT devices connect to an Azure IoT hub using vehicle-provided WiFi. The new system will provide continuous monitoring of the product environment and enable a variety of notification scenarios when issues are detected. The IoT devices are equiped with integrated sensors to track the location, temperature, and pressure of shipping containers during transit.

You have been tasked with validating the container IoT tracking device provisioning and deprovisioning process using Azure IoT Hub Device Provisioning Service (DPS) and X.509 certificate authentication. You need to demonstrate that DPS can be used to auto-provision large numbers of IoT tracking devices securely using this configuration. Container IoT tracking devices are auto-provisioned using DPS and X.509 certificate authentication when containers are loaded, and deprovisioned (disenrolled and deregistered) after each container is delivered for later reuse and reprovisioning.

> [!NOTE]
> This is a **_guided project_** module where you'll complete an end-to-end project by following step-by-step instructions.

## Learning objectives

In this module, you'll practice how to:

* Generate an X.509 root CA certificate using OpenSSL.
* Configure a group enrollment that uses X.509 certificate authentication within Device Provisioning Service.
* Generate device certificates signed by your root CA certificate.
* Run C# device samples that are provisioned via the enrollment group and connect to IoT Hub.
* Disenroll an individual device from the enrollment group, and then deprovision the entire group.
