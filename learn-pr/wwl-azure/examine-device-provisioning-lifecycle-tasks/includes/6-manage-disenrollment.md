Proper management of device credentials is crucial for high-profile systems like IoT solutions. A best practice for such systems is to have a clear plan of how to revoke access for devices when their credentials, whether a shared access signatures (SAS) token or an X.509 certificate, might be compromised.

Enrollment in the Device Provisioning Service enables a device to be autoprovisioned. A provisioned device is one that has been registered with IoT Hub, allowing it to receive its initial device twin state and begin reporting telemetry data.

## Blocklist devices by using an individual enrollment entry

Individual enrollments apply to a single device and can use either X.509 certificates or SAS tokens (in a real or virtual TPM) as the attestation mechanism. Devices that use SAS tokens as their attestation mechanism can be provisioned only through an individual enrollment. To blocklist a device that has an individual enrollment, you can either disable or delete its enrollment entry.

### Temporarily blocklist a device

To temporarily blocklist the device by disabling its enrollment entry:

1.  Sign in to the Azure portal and select All resources from the left menu.
2.  In the list of resources, select the provisioning service that you want to blocklist your device from.
3.  In your provisioning service, select Manage enrollments, and then select the Individual Enrollments tab.
4.  Select the enrollment entry for the device that you want to blocklist.
5.  On your enrollment page, scroll to the bottom, and select Disable for the Enable entry switch, and then select Save.

### Permanently blocklist a device

To permanently blocklist the device by deleting its enrollment entry:

1.  Sign in to the Azure portal and select All resources from the left menu.
2.  In the list of resources, select the provisioning service that you want to blocklist your device from.
3.  In your provisioning service, select Manage enrollments, and then select the Individual Enrollments tab.
4.  Select the check box next to the enrollment entry for the device that you want to blocklist.
5.  Select Delete at the top of the window, and then select Yes to confirm that you want to remove the enrollment.

After you finish the procedure, you should see your entry removed from the list of individual enrollments.

## Blocklist an X.509 intermediate or root CA certificate by using an enrollment group

X.509 certificates are typically arranged in a certificate chain of trust. If a certificate at any stage in a chain becomes compromised, trust is broken. The certificate must be blocklisted to prevent Device Provisioning Service from provisioning devices downstream in any chain that contains that certificate. To learn more about X.509 certificates and how they are used with the provisioning service, see X.509 certificates.

An enrollment group is an entry for devices that share a common attestation mechanism of X.509 certificates signed by the same intermediate or root CA. The enrollment group entry is configured with the X.509 certificate associated with the intermediate or root CA. The entry is also configured with any configuration values, such as twin state and IoT hub connection, that are shared by devices with that certificate in their certificate chain. To blocklist the certificate, you can either disable or delete its enrollment group.

## Blocklist specific devices in an enrollment group

Devices that implement the X.509 attestation mechanism use the device's certificate chain and private key to authenticate. When a device connects and authenticates with Device Provisioning Service, the service first looks for an individual enrollment that matches the device's credentials. The service then searches enrollment groups to determine whether the device can be provisioned. If the service finds a disabled individual enrollment for the device, it prevents the device from connecting. The service prevents the connection even if an enabled enrollment group for an intermediate or root CA in the device's certificate chain exists.
