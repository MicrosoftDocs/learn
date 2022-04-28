The Azure IoT Hub Device Provisioning Service supports device provisioning and deprovisioning at scale by using enrollment groups.

Suppose you have joined a team that is implementing an Azure IoT solution for the company. The company will be provisioning thousands of devices using the Azure IoT Hub Device Provisioning Service. You decide to gain experience implementing aspects of a scaled deployment by implementing group enrollment and disenrollment tasks in a test environment.

In this module, you will complete a lab that includes the following activities:

 -  Generate an X.509 root CA Certificate using OpenSSL within the Azure Cloud Shell, and then use the root certificate to configure a group enrollment within the Device Provisioning Service.
 -  Generate a device certificate and use it to provision a device to IoT hub.
 -  Review the code used to access to the device twin properties and perform initial configuration of the device.
 -  Deprovision an individual device from the enrollment group and then deprovision the entire group enrollment.

By the end of this module, you will be able to provision and deprovision devices using a group enrollment process.
