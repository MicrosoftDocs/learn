You may find it necessary to deprovision devices that were previously autoprovisioned through the Device Provisioning Service. For example, a device may be sold or moved to a different Azure IoT hub, or it may be lost, stolen, or otherwise compromised.

In general, deprovisioning a device involves two steps:

* Disenroll the device from your Device Provisioning Service, to prevent future autoprovisioning. Depending on whether you want to revoke access temporarily or permanently, you may want to either disable or delete an enrollment entry. For devices that use X.509 attestation, you may want to disable/delete an entry in the hierarchy of your existing enrollment groups. Device disenrollment is described in more detail on the next unit page.
* Deregister the device from your Azure IoT Hub, to prevent future communications and data transfer. Again, you can temporarily disable or permanently delete the device's entry in the identity registry for the Azure IoT Hub where it was provisioned.

The exact steps you take to deprovision a device depend on its attestation mechanism and its applicable enrollment entry with your provisioning service.

The following sections provide an overview of the process, based on the enrollment and attestation type.

## Deprovision individual enrollments

Devices that use TPM attestation or X.509 attestation with a leaf certificate are provisioned through an individual enrollment entry.

To deprovision a device that has an individual enrollment:

1. Disenroll the device from your Device Provisioning Service:

   * For devices that use TPM attestation, delete the individual enrollment entry to permanently revoke the device's access to the Device Provisioning Service, or disable the entry to temporarily revoke its access.
   * For devices that use X.509 attestation, you can either delete or disable the entry. Be aware, though, if you delete an individual enrollment for a device that uses X.509 and an enabled enrollment group exists for a signing certificate in that device's certificate chain, the device can re-enroll. For such devices, it may be safer to disable the enrollment entry. Doing so prevents the device from re-enrolling, regardless of whether an enabled enrollment group exists for one of its signing certificates.

     Device disenrollment is described in more detail on the next unit page.

1. Disable or delete the device in the identity registry of the Azure IoT hub that it was provisioned to.

## Deprovision enrollments groups

With X.509 attestation, devices can also be provisioned through an enrollment group. Enrollment groups are configured with a signing certificate, either an intermediate or root CA certificate, and control access to the Device Provisioning Service for devices with that certificate in their certificate chain.

To see a list of devices that are provisioned through an enrollment group, you can view the enrollment group's details. This is an easy way to understand which Azure IoT hub each device is provisioned to. To view the device list:

1. Sign in to the Azure portal and navigate to your provisioning service.

1. Select **Manage enrollments**, then select the **Enrollment groups** tab.

1. Select the enrollment group to open its details.

1. Select **Details** to view the registration records for the enrollment group.

With enrollment groups, there are two scenarios to consider:

* To deprovision all of the devices that are provisioned through an enrollment group:

    1. Disable the enrollment group to disallow its signing certificate.
    1. Use the list of provisioned devices for that enrollment group to disable or delete each device from the identity registry of its respective Azure IoT hub.
    1. After disabling or deleting all devices from their respective Azure IoT hubs, you can optionally delete the enrollment group. Be aware, though, that if you delete the enrollment group and there's an enabled enrollment group for a signing certificate higher up in the certificate chain of one or more of the devices, those devices can re-enroll.

* To deprovision a single device from an enrollment group:
    1. Create a disabled individual enrollment for the device.

       * If you have the device (end-entity) certificate, you can create a disabled X.509 individual enrollment.
       * If you don't have the device certificate, you can create a disabled symmetric key individual enrollment based on the device ID in the registration record for that device.

       The presence of a disabled individual enrollment for a device revokes access to the provisioning service for that device while still permitting access for other devices that have the enrollment group's signing certificate in their chain. Don't delete the disabled individual enrollment for the device. Doing so allows the device to re-enroll through the enrollment group.

    1. Use the list of provisioned devices for that enrollment group to find the Azure IoT hub that the device was provisioned to and disable or delete it from that hub's identity registry.
