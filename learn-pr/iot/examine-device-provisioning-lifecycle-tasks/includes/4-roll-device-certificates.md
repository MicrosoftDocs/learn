During the lifecycle of your Azure IoT Hub solution, you need to roll certificates. Two of the main reasons for rolling certificates are a security breach and certificate expirations.

Rolling certificates is a security best practice to help secure your system in the event of a breach. As part of [Assume Breach Methodology](https://download.microsoft.com/download/C/1/9/C1990DBA-502F-4C2A-848D-392B93D9B9C3/Microsoft_Enterprise_Cloud_Red_Teaming.pdf), Microsoft advocates the need for having reactive security processes in place along with preventative measures. Rolling your device certificates should be included as part of these security processes. The frequency in which you roll your certificates depends on the security needs of your solution. Customers with solutions involving highly sensitive data may roll certificate daily, while others roll their certificates every couple years.

Rolling device certificates involves updating the certificate stored on the device and the Azure IoT hub. Afterwards, the device can reprovision itself with the Azure IoT hub using normal provisioning with the Device Provisioning Service (DPS).

## Obtain new certificates

There are many ways to obtain new certificates for your IoT devices. These include obtaining certificates from the device factory, generating your own certificates, and having a third party manage certificate creation for you.

Certificates are signed by each other to form a chain of trust from a root CA certificate to a leaf certificate. A signing certificate is the certificate used to sign the leaf certificate at the end of the chain of trust. A signing certificate can be a root CA certificate, or an intermediate certificate in chain of trust.

There are two different ways to obtain a signing certificate. The first way, which is recommended for production systems, is to purchase a signing certificate from a root certificate authority (CA). This way chains security down to a trusted source.

The second way is to create your own X.509 certificates using a tool like OpenSSL. This approach is great for testing X.509 certificates but provides few guarantees around security. We recommend you only use this approach for testing unless you are prepared to act as your own CA provider.

## Roll the certificate on the device

Certificates on a device should always be stored in a safe place like a hardware security module (HSM). The way you roll device certificates depends on how they were created and installed in the devices in the first place.

If you got your certificates from a third party, you must look into how they roll their certificates. The process may be included in your arrangement with them, or it may be a separate service they offer.

If you're managing your own device certificates, you have to build your own pipeline for updating certificates. Make sure both old and new leaf certificates have the same common name (CN). By having the same CN, the device can reprovision itself without creating a duplicate registration record.

The mechanics of installing a new certificate on a device often involve one of the following approaches:

* You can trigger affected devices to send a new certificate signing request (CSR) to your PKI Certificate Authority (CA). In this case, each device will likely be able to download its new device certificate directly from the CA.

* You can retain a CSR from each device and use that to get a new device certificate from the PKI CA. In this case, you need to push the new certificate to each device in a firmware update using a secure OTA update service like Device Update for IoT Hub.

## Roll the certificate in the Azure IoT hub

The device certificate can be manually added to an Azure IoT hub. The certificate can also be automated using a Device Provisioning service instance. We focus on this second case, where a Device Provisioning service instance is being used to support autoprovisioning.

When a device is initially provisioned through autoprovisioning, it boots-up, and contacts the provisioning service. The provisioning service responds by performing an identity check before creating a device identity in an Azure IoT hub using the device's leaf certificate as the credential. The provisioning service then tells the device which Azure IoT hub it's assigned to, and the device then uses its leaf certificate to authenticate and connect to the Azure IoT hub.

Once a new leaf certificate is rolled to the device, it can no longer connect to the Azure IoT hub because it's using a new certificate to connect. The Azure IoT hub only recognizes the device with the old certificate. The result of the device's connection attempt is an "unauthorized" connection error. To resolve this error, you must update the enrollment entry for the device to account for the device's new leaf certificate. Then the provisioning service can update the Azure IoT Hub device registry information as needed when the device is reprovisioned.

One possible exception to this connection failure would be a scenario where you've created an enrollment group for your device in the provisioning service. In this case, if you aren't rolling the root or intermediate certificates in the device's certificate chain of trust, then the device is recognized if the new certificate is part of the chain of trust defined in the enrollment group. If this scenario arises as a reaction to a security breach, you should at least disallow the specific device certificates in the group that are considered to be breached.

How you handle updating the enrollment entry depends on whether you're using individual enrollments, or group enrollments. Also the recommended procedures differ depending on whether you're rolling certificates because of a security breach, or certificate expiration. The following sections describe how to handle these updates.

### Roll certificates for individual enrollments

If you're rolling certificates in response to a security breach, you should delete any compromised certificates immediately.

If you're rolling certificates to handle certificate expirations, you should use the secondary certificate configuration as follows to reduce downtime for devices attempting to provision. Later when the secondary certificate also nears expiration, and needs to be rolled, you can rotate to using the primary configuration. Rotating between the primary and secondary certificates in this way reduces downtime for devices attempting to provision.

Updating enrollment entries for rolled certificates is accomplished on the **Manage enrollments** page. To access that page, follow these steps:

1. Sign in to the Azure portal and navigate to the Device Provisioning Service instance that has the enrollment entry for your device.

1. Select **Manage enrollments**.

1. Select the **Individual enrollments** tab, and select the registration ID entry from the list.

1. Check the **Remove or replace primary/secondary certificate** checkboxes if you want to delete an existing certificate. Select the file folder icon to browse for and upload the new certificates.

1. If any of your certificates were compromised, you should remove them as soon as possible.

1. If one of your certificates is nearing its expiration, you can keep it in place as long as the second certificate is still active after that date.

Select **Save** when finished.

If you removed a compromised certificate from the provisioning service, the certificate can still be used to make device connections to the Azure IoT hub as long as a device registration for it exists there. You can address this two ways:

* The first way would be to manually navigate to your Azure IoT hub and immediately remove the device registration associated with the compromised certificate. Then when the device provisions again with an updated certificate, a new device registration is created.

* The second way would be to use reprovisioning support to reprovision the device to the same Azure IoT hub. This approach can be used to replace the certificate for the device registration on the Azure IoT hub.

### Roll certificates for enrollment groups

To update a group enrollment in response to a security breach, you should delete the compromised root CA or intermediate certificate immediately.

If you are rolling certificates to handle certificate expirations, you should use the secondary certificate configuration to ensure no downtime for devices attempting to provision. Later, when the secondary certificate also nears expiration and needs to be rolled, you can rotate to using the primary configuration. Rotating between the primary and secondary certificates in this way ensures no downtime for devices attempting to provision.

## Reprovision the device

Once the certificate is rolled on both the device and the Device Provisioning Service, the device can reprovision itself by contacting the Device Provisioning Service.

One easy way of programming devices to reprovision is to program the device to contact the provisioning service to go through the provisioning flow if the device receives an "unauthorized" error from attempting to connect to the Azure IoT hub.

Another way is for both the old and the new certificates to be valid for a short overlap, and use the Azure IoT hub to send a command to devices to have them re-register via the provisioning service to update their Azure IoT Hub connection information. Because each device can process commands differently, you have to program your device to know what to do when the command is invoked. There are several ways you can command your device via Azure IoT Hub, and we recommend using direct methods or jobs to initiate the process.

Once reprovisioning is complete, devices are able to connect to Azure IoT Hub using their new certificates.

## Disallow certificates

In response to a security breach, you may need to disallow a device certificate. To disallow a device certificate, disable the enrollment entry for the target device/certificate.

Once a certificate is included as part of a disabled enrollment entry, any attempts to register with an Azure IoT hub using that certificates fails even if it is enabled as part of another enrollment entry.
