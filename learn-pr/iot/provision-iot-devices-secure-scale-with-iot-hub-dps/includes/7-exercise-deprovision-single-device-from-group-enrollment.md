There are many reasons why you might need to deprovision just a portion of the devices that are registered as part of a group enrollment. For example, a device may no longer be needed, a newer version of the device may have become available, or it may have been broken or compromised.

To deprovision a single device from an enrollment group, you must do two things:

* Create a disabled individual enrollment for the device's leaf (device) certificate.

    This revokes access to the provisioning service for that device while still permitting access for other devices that have the enrollment group's signing certificate in their chain. You shouldn't delete the disabled individual enrollment for the device, as doing so would allow the device to re-enroll through the enrollment group.

* Disable or delete the device from the IoT hub's identity registry.

    [!TIP]
    > If your solution includes multiple IoT hubs, you should use the list of provisioned devices for the enrollment group to find the IoT hub that the device was provisioned to. This is so that you can disable or delete the device. In this exercise you use a single IoT hub, so you don't need to look up which IoT hub was used.

In this exercise, you deprovision a single device from an enrollment group.

### Task 1: Create a disabled individual enrollment for the device

In this task, you configure an individual enrollment for the **sensor-thl-002** device.

1. In the Azure sandbox, create an individual enrollment that is disabled.

   ```azurecli
   az iot dps enrollment create --dps-name dps-$suffix --enrollment-id disallow-002 --attestation-type x509 --certificate-path ~/certificates/certs/sensor-thl-002-device.cert.pem --provisioning-status disabled
   ```

### Task 2: Deregister the device from IoT hub

1. In the Azure sandbox, delete the device from your IoT hub device registry.

   ```azurecli
   az iot hub device-identity delete --hub-name hub-$suffix --device-id sensor-thl-002
   ```

### Task 3: Confirm that the device is deprovisioned

1. Switch to the Visual Studio Code window containing your sensor-thl-002-device code project.

1. Open the **View** menu and select **Terminal**.

1. Ensure that the command prompt is located at the **sensor-thl-002-device** folder location.

1. Run the simulated device app.

    ```cmd/sh
    dotnet run
    ```

1. Notice the exceptions listed when the device attempts to provision.

   When a device attempts to connect and authenticate with Device Provisioning Service, the service first looks for an individual enrollment that matches the device's credentials before checking for enrollment groups to determine whether the device can be provisioned. If the service finds a disabled individual enrollment for the device, it prevents the device from connecting. The service prevents the connection even if an enabled enrollment group for an intermediate or root CA in the device's certificate chain exists.

   When the application attempts to use the configured X.509 certificate to connect to DPS, DPS reports that the device registration status is **NOT 'Assigned'**.

    ```txt
    Found certificate: 13F32448E03F451E897B681758BAC593A60BFBFA CN=sensor-thl-002; PrivateKey: True
    Using certificate 13F32448E03F451E897B681758BAC593A60BFBFA CN=sensor-thl-002
    ProvisioningClient AssignedHub: ; DeviceID:
    Unhandled exception. System.Exception: DeviceRegistrationResult.Status is NOT 'Assigned'
    at ContainerDevice.Program.ProvisionDevice(ProvisioningDeviceClient provisioningDeviceClient, SecurityProviderX509Certificate security) in C:\Users\howdc\Allfiles\Labs\06-Automatic Enrollment of Devices
    in DPS\Final\ContainerDevice2004\Program.cs:line 107
    at ContainerDevice.Program.Main(String[] args) in C:\Users\howdc\Allfiles\Labs\06-Automatic Enrollment of Devices in DPS\Final\ContainerDevice2004\Program.cs:line 49
    at ContainerDevice.Program.<Main>(String[] args)
    ```

    If you were to go back into DPS and either set the individual enrollment to **enabled** or delete the individual enrollment, the device will once again be able to authenticate with DPS and connect to IoT hub. If the individual enrollment is deleted, the device is automatically added back to the group enrollment.
