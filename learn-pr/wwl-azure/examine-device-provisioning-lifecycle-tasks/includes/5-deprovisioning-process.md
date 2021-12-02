You may find it necessary to deprovision devices that were previously autoprovisioned through the Device Provisioning Service. For example, a device may be sold or moved to a different IoT hub, or it may be lost, stolen, or otherwise compromised.

## Deprovisioning a device

In general, deprovisioning a device involves two steps:

 -  Disenroll the device from your provisioning service, to prevent future autoprovisioning. Depending on whether you want to revoke access temporarily or permanently, you may want to either disable or delete an enrollment entry. For devices that use X.509 attestation, you may want to disable/delete an entry in the hierarchy of your existing enrollment groups.
    
     -  To learn how to disenroll a device, see: [How to disenroll a device from Azure IoT Hub Device Provisioning Service](/azure/iot-dps/how-to-revoke-device-access-portal).
     -  To learn how to disenroll a device programmatically using one of the provisioning service SDKs, see: [Manage device enrollments with service SDKs](/azure/iot-dps/how-to-manage-enrollments-sdks).
 -  Deregister the device from your IoT Hub, to prevent future communications and data transfer. Again, you can temporarily disable or permanently delete the device's entry in the identity registry for the IoT Hub where it was provisioned.

The exact steps you take to deprovision a device depend on its attestation mechanism and its applicable enrollment entry with your provisioning service.

## Deprovisioning enrollments groups

With X.509 attestation, devices can also be provisioned through an enrollment group. Enrollment groups are configured with a signing certificate, either an intermediate or root CA certificate, and control access to the provisioning service for devices with that certificate in their certificate chain.

With enrollment groups, there are two scenarios to consider:

 -  To deprovision all of the devices that have been provisioned through an enrollment group:
    
    1.  Disable the enrollment group to blocklist its signing certificate.
    2.  Use the list of provisioned devices for that enrollment group to disable or delete each device from the identity registry of its respective IoT hub. After disabling or deleting all devices from their respective IoT hubs, you can optionally delete the enrollment group. Be aware, though, that, if you delete the enrollment group and there is an enabled enrollment group for a signing certificate higher up in the certificate chain of one or more of the devices, those devices can re-enroll.
 -  To deprovision a single device from an enrollment group:
    
    1.  Create a disabled individual enrollment for its leaf (device) certificate. This revokes access to the provisioning service for that device while still permitting access for other devices that have the enrollment group's signing certificate in their chain. Do not delete the disabled individual enrollment for the device. Doing so will allow the device to re-enroll through the enrollment group.
    2.  Use the list of provisioned devices for that enrollment group to find the IoT hub that the device was provisioned to and disable or delete it from that hub's identity registry.
