There are many reasons why you might need to deprovision just a portion of the devices that are registered as part of a group enrollment. For example, a device might no longer be needed, a newer version of the device might be available, or it might be broken or compromised.

These steps explicitly disable a device certificate and deregister IoT hub entries for a single device, while allowing other devices whose individual certificates were signed by the CA to still function.

To deprovision a single device from a DPS enrollment group, you must do two things:

* Create a DPS disabled individual enrollment for the device's leaf (device) certificate.

    The two sensors you created for this module authenticate through the DPS enrollgroup-sensors enrollment group. This step explicitly revokes access to the DPS provisioning service for the disabled device, while still permitting DPS access for other devices that have the enrollment group's CA signing certificate in their chain. You shouldn't delete the disabled DPS individual enrollment for the device, as doing so would allow the device to re-enroll through the enrollment group.

* Disable or delete the device from the IoT hub's identity registry.

    sensor-thl-001 and sensor-thl-002 were registered with your IoT hub when you ran the two C# programs. This step disables or deletes an identity registration entry from your IoT hub.

    > [!TIP]
    > If your solution includes multiple IoT hubs, you should use the list of provisioned devices for the enrollment group to find the IoT hub that the device was provisioned to. This is so that you can disable or delete the device. In this exercise you use a single IoT hub, so you don't need to look up which IoT hub was used.

In this exercise, you deprovision a single device from an enrollment group.

### Task 1: Create a disabled individual enrollment for the device

In this task, you configure an individual enrollment for the **sensor-thl-002** device.

1. In the Azure sandbox, create an individual enrollment that is disabled for sensor-thl-002.

   ```azurecli
   az iot dps enrollment create --dps-name dps-$suffix --enrollment-id sensor-thl-002 --attestation-type x509 --certificate-path ~/certificates/certs/sensor-thl-002-device.cert.pem --provisioning-status disabled
   ```

    > [!NOTE]
    > The `--enrollment-id` parameter must match the device ID contained in the device certificate that is being uploaded. Recall that the device ID was set as the common name, or CN=, value of the device certificate using the `certGen.sh create_device_certificate sensor-thl-002` command in unit 4 of this module. If the device ID does not match the device certificate CN, the disabled enrollment record will not be recognized and the test program will still be able to connect to your IoT hub and send telemetry messages.

### Task 2: Deregister the device from IoT hub

1. In the Azure sandbox, delete the device from your IoT hub device registry.

   ```azurecli
   az iot hub device-identity delete --hub-name hub-$suffix --device-id sensor-thl-002
   ```

### Task 3: Confirm that the device is deprovisioned

1. Switch to the Visual Studio Code window containing your sensor-thl-002-device code project.

1. Ensure that the command prompt is located at the **sensor-thl-002-device** folder location.

1. Run the simulated device app.

    ```cmd/sh
    dotnet run
    ```

1. Notice the exceptions listed when the device attempts to provision.

   When a device attempts to connect and authenticate with Device Provisioning Service (DPS), the service first looks for an individual enrollment that matches the device ID credential before checking for enrollment groups to determine whether the device can be provisioned. If the service finds a disabled individual device ID enrollment for the device, it prevents the device from connecting. The service prevents the connection even if an enabled enrollment group for an intermediate or root CA in the device's certificate chain exists.

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

    If you were to go back into DPS and either set the individual device enrollment to **enabled** or delete the individual enrollment, the device will once again be able to authenticate with DPS and connect to IoT hub. If the individual enrollment is deleted, the device is automatically added back to the group enrollment.

## Verify your work

1. Verify that there is a DPS disabled individual enrollment for device sensor-thl-002.

   ```azurecli
   az iot dps enrollment show --dps-name dps-$suffix --enrollment-id sensor-thl-002
   ```

   Check the return status information. The `provisioningStatus` should be `disabled`.

   ```azurecli
   "provisioningStatus": "disabled"
   ```

2. Verify that the device was deregistered from IoT hub.

   ```azurecli
   az iot hub device-identity show --hub-name hub-$suffix --device-id sensor-thl-002
   ```

    You should see an `DeviceNotFound` error message similar to the following.

   ```azurecli
    {'Message': 'ErrorCode:DeviceNotFound;sensor-thl-002', 'ExceptionMessage': 'Tracking ID:06e0221675514160850421f0b3b787a9-G:0-TimeStamp:10/24/2023 16:53:16'}
    ```
