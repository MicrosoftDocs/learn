During the lifecycle of your IoT solution, you'll need to roll certificates. Two of the main reasons for rolling certificates would be a security breach, and certificate expirations. For now, we will focus on rolling certificates due to expiration.

Rolling device certificates will involve updating the certificate stored on the device and the IoT hub. Afterwards, the device can reprovision itself with the IoT hub using normal autoprovisioning with the Device Provisioning Service.

## Obtain new certificates

There are many ways to obtain new certificates for your IoT devices. These include obtaining certificates from the device factory, generating your own certificates, and having a third party manage certificate creation for you.

Certificates are signed by each other to form a chain of trust from a root CA certificate to a leaf certificate. A signing certificate is the certificate used to sign the leaf certificate at the end of the chain of trust. A signing certificate can be a root CA certificate, or an intermediate certificate in chain of trust.

There are two different ways to obtain a signing certificate. The first way, which is recommended for production systems, is to purchase a signing certificate from a root certificate authority (CA). This way chains security down to a trusted source.

The second way is to create your own X.509 certificates using a tool like OpenSSL. This approach is great for testing X.509 certificates but provides few guarantees around security. We recommend you only use this approach for testing unless you are prepared to act as your own CA provider.

## Roll the certificate on the device

Certificates on a device should always be stored in a safe place like a hardware security module (HSM). The way you roll device certificates will depend on how they were created and installed in the devices in the first place.

If you got your certificates from a third party, you must look into how they roll their certificates. The process may be included in your arrangement with them, or it may be a separate service they offer.

If you're managing your own device certificates, you'll have to build your own pipeline for updating certificates. Make sure both old and new leaf certificates have the same common name (CN). By having the same CN, the device can reprovision itself without creating a duplicate registration record.

## Roll the certificate in the IoT hub

The device certificate can be manually added to an IoT hub. The certificate can also be automated using a Device Provisioning service instance. We will focus on this second case, where a Device Provisioning service instance is being used to support autoprovisioning.

When a device is initially provisioned through autoprovisioning, it boots-up, and contacts the provisioning service. The provisioning service responds by performing an identity check before creating a device identity in an IoT hub using the device’s leaf certificate as the credential. The provisioning service then tells the device which IoT hub it's assigned to, and the device then uses its leaf certificate to authenticate and connect to the IoT hub.

Once a new leaf certificate has been rolled to the device, it can no longer connect to the IoT hub because it’s using a new certificate to connect. The IoT hub only recognizes the device with the old certificate. The result of the device's connection attempt will be an "unauthorized" connection error. To resolve this error, you must update the enrollment entry for the device to account for the device's new leaf certificate. Then the provisioning service can update the IoT Hub device registry information as needed when the device is reprovisioned.

One possible exception to this connection failure would be a scenario where you've created an Enrollment Group for your device in the provisioning service. In this case, if you aren't rolling the root or intermediate certificates in the device's certificate chain of trust, then the device will be recognized if the new certificate is part of the chain of trust defined in the enrollment group. If this scenario arises as a reaction to a security breach, you should at least blocklist the specific device certificates in the group that are considered to be breached.

Updating enrollment entries for rolled certificates is accomplished on the Manage enrollments page of the Device Provisioning Service instance that has the enrollment entry for your device. How you handle updating the enrollment entry will depend on whether you're using individual enrollments, or group enrollments.

### Individual enrollments and certificate expiration

If you're rolling certificates to handle certificate expirations, you should use the secondary certificate configuration as follows to reduce downtime for devices attempting to provision.

Later when the secondary certificate also nears expiration, and needs to be rolled, you can rotate to using the primary configuration. Rotating between the primary and secondary certificates in this way reduces downtime for devices attempting to provision.

1.  Open the Manage enrollments page of the Device Provisioning Service instance that has the enrollment entry for your device.
2.  Select Individual Enrollments, and then select the registration ID entry in the list.
3.  Select Secondary Certificate and then, select the folder icon to choose the new certificate to be uploaded for the enrollment entry.
4.  Select Save.

:::image type="content" source="../media/m03-l03-manage-individual-enrollments-secondary-portal-b23afe8f.png" alt-text="Screenshot that shows where to configure secondary certificates when rolling certificates for a device.":::


### Enrollment groups and certificate expiration

If you are rolling certificates to handle certificate expirations, you should use the secondary certificate configuration as follows to ensure no downtime for devices attempting to provision.

Later when the secondary certificate also nears expiration, and needs to be rolled, you can rotate to using the primary configuration. Rotating between the primary and secondary certificates in this way ensures no downtime for devices attempting to provision.

For more information about rolling certificates for enrollments groups with expiring certificates, see: [https://docs.microsoft.com/azure/iot-dps/how-to-roll-certificates](/azure/iot-dps/how-to-roll-certificates).
